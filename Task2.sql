-- 1. Calculate actual delivery duration in hours
SELECT Shipment_ID, DATEDIFF(SECOND, Pickup_Date, Delivery_Date) / 3600.0 AS Actual_Transit_Hours
FROM Shipments;

-- 2. Top 10 delayed routes based on average delay hours
SELECT TOP 10 Route_ID, AVG(Delay_Hours) as Avg_Delay
FROM Shipments
GROUP BY Route_ID
ORDER BY Avg_Delay DESC;

-- 3. Rank shipments by delay within each Warehouse_ID
SELECT TOP 10 Shipment_ID, Warehouse_ID, Delay_Hours,
       RANK() OVER (PARTITION BY Warehouse_ID ORDER BY Delay_Hours DESC) as Delay_Rank
FROM Shipments;

-- 4. Average delay per Delivery_Type (Express vs Standard)
SELECT o.Delivery_Type, AVG(s.Delay_Hours) as Avg_Delay
FROM Shipments s
JOIN Orders o ON s.Order_ID = o.Order_ID
GROUP BY o.Delivery_Type;