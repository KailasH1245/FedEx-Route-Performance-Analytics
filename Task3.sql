-- Comprehensive Route Metrics
SELECT 
    r.Route_ID,
    AVG(DATEDIFF(SECOND, s.Pickup_Date, s.Delivery_Date) / 3600.0) as Avg_Actual_Transit_Time,
    AVG(s.Delay_Hours) as Avg_Route_Delay,
    (r.Distance_KM / NULLIF(AVG(DATEDIFF(SECOND, s.Pickup_Date, s.Delivery_Date) / 3600.0), 0)) as Efficiency_Ratio
FROM Routes r
JOIN Shipments s ON r.Route_ID = s.Route_ID
GROUP BY r.Route_ID, r.Distance_KM
ORDER BY Efficiency_Ratio ASC; -- Lowest ratio = worst efficiency


-- Routes with >20% shipments delayed beyond expected transit time
SELECT Route_ID
FROM (
    SELECT s.Route_ID,
           COUNT(*) as Total_Shipments,
           SUM(CASE WHEN (DATEDIFF(SECOND, s.Pickup_Date, s.Delivery_Date) / 3600.0) > r.Avg_Transit_Time_Hours THEN 1 ELSE 0 END) as Delayed_Count
    FROM Shipments s
    JOIN Routes r ON s.Route_ID = r.Route_ID
    GROUP BY s.Route_ID
) t
WHERE (CAST(Delayed_Count AS FLOAT) / Total_Shipments) > 0.20;