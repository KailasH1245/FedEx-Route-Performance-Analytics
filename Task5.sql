-- Rank delivery agents (per route) by on‑time delivery percentage
SELECT Agent_ID, Route_ID,
       SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 AS OnTime_Percentage,
       RANK() OVER (PARTITION BY Route_ID 
                    ORDER BY SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) DESC) AS Agent_Rank
FROM Shipments
GROUP BY Agent_ID, Route_ID;

-- Find agents whose on‑time % is below 85%
SELECT Agent_ID,
       SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 AS OnTime_Percentage
FROM Shipments
GROUP BY Agent_ID
HAVING SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 < 85;

-- Compare average rating & experience of top 5 vs bottom 5 agents
WITH AgentPerformance AS (
    SELECT Agent_ID,
           SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 AS OnTime_Percentage
    FROM Shipments
    GROUP BY Agent_ID
)
-- Top 5 agents
SELECT 'Top 5' AS Category,
       AVG(d.Avg_Rating) AS Avg_Rating,
       AVG(d.Experience_Years) AS Avg_Experience
FROM delivery_agents d
JOIN (SELECT TOP 5 Agent_ID 
      FROM AgentPerformance 
      ORDER BY OnTime_Percentage DESC) t ON d.Agent_ID = t.Agent_ID
UNION
-- Bottom 5 agents
SELECT 'Bottom 5',
       AVG(d.Avg_Rating),
       AVG(d.Experience_Years)
FROM delivery_agents d
JOIN (SELECT TOP 5 Agent_ID 
      FROM AgentPerformance 
      ORDER BY OnTime_Percentage ASC) b ON d.Agent_ID = b.Agent_ID;

-- Suggest training candidates (low on‑time %, low experience)
WITH AgentPerformance AS (
    SELECT Agent_ID,
           SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 AS OnTime_Percentage
    FROM Shipments
    GROUP BY Agent_ID
)
SELECT d.Agent_ID, d.Agent_Name, d.Avg_Rating, d.Experience_Years, ap.OnTime_Percentage
FROM Delivery_agents d
JOIN AgentPerformance ap ON d.Agent_ID = ap.Agent_ID
WHERE ap.OnTime_Percentage < 85
  AND d.Experience_Years < 3;

