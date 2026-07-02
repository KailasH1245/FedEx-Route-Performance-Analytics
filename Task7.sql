-- Average Delivery Delay per Source_Country
SELECT r.Source_Country,
       AVG(s.Delay_Hours) AS Avg_Delay_Hours
FROM Shipments s
JOIN Routes r ON s.Route_ID = r.Route_ID
GROUP BY r.Source_Country;

-- On-Time Delivery %
SELECT SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 AS OnTime_Percentage
FROM Shipments;

-- Average Delay (hours) per Route_ID
SELECT Route_ID,
       AVG(Delay_Hours) AS Avg_Delay_Hours
FROM Shipments
GROUP BY Route_ID ORDER BY Avg_Delay_Hours DESC;

-- Warehouse Utilization %
SELECT w.Warehouse_ID,
       COUNT(s.Shipment_ID) * 1.0 / w.Capacity_per_day * 100 AS Utilization_Percentage
FROM Warehouses w
JOIN Shipments s ON w.Warehouse_ID = s.Warehouse_ID
GROUP BY w.Warehouse_ID, w.Capacity_per_day;

