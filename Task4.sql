-- Top 3 warehouses with the highest average delay in shipments dispatched
SELECT TOP 3 Warehouse_ID,
       AVG(Delay_Hours) AS Avg_Delay
FROM Shipments
GROUP BY Warehouse_ID
ORDER BY Avg_Delay DESC;

-- Total shipments vs delayed shipments for each warehouse
SELECT Warehouse_ID,
       COUNT(*) AS Total_Shipments,
       SUM(CASE WHEN Delay_Hours > 0 THEN 1 ELSE 0 END) AS Delayed_Shipments
FROM Shipments
GROUP BY Warehouse_ID;

-- Warehouses where average delay exceeds the global average delay
WITH GlobalAvg AS (
    SELECT AVG(Delay_Hours) AS Global_Avg
    FROM Shipments
)
SELECT Warehouse_ID,
       AVG(Delay_Hours) AS Avg_Delay
FROM Shipments, GlobalAvg
GROUP BY Warehouse_ID, Global_Avg
HAVING AVG(Delay_Hours) > Global_Avg;

-- Rank warehouses by on‑time delivery percentage
SELECT Warehouse_ID,
       SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 AS OnTime_Percentage,
       RANK() OVER (ORDER BY SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) DESC) AS Rank_OnTime
FROM Shipments
GROUP BY Warehouse_ID;