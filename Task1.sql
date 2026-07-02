-- 1. Remove duplicate Orders (keep earliest Order_Date)
WITH CTE_Orders AS (
    SELECT Order_ID,
           ROW_NUMBER() OVER (PARTITION BY Order_ID ORDER BY Order_Date) AS rn
    FROM Orders
)
DELETE FROM CTE_Orders WHERE rn > 1;


-- 2. Remove duplicate Shipments (keep earliest Pickup_Date)
WITH CTE_Shipments AS (
    SELECT Shipment_ID,
           ROW_NUMBER() OVER (PARTITION BY Shipment_ID ORDER BY Pickup_Date) AS rn
    FROM Shipments
)
DELETE FROM CTE_Shipments WHERE rn > 1;


-- 3. Replace NULL Delay_Hours with route average
UPDATE s
SET Delay_Hours = r.AvgDelay
FROM Shipments s
JOIN (
    SELECT Route_ID, AVG(Delay_Hours) AS AvgDelay
    FROM Shipments
    GROUP BY Route_ID
) r ON s.Route_ID = r.Route_ID
WHERE s.Delay_Hours IS NULL;

-- 4. Flag invalid records
SELECT Shipment_ID, Pickup_Date, Delivery_Date
FROM Shipments
WHERE Delivery_Date < Pickup_Date;

-- 5. Referential integrity check
SELECT o.Order_ID
FROM Orders o
LEFT JOIN Routes r ON o.Route_ID = r.Route_ID
LEFT JOIN Warehouses w ON o.Warehouse_ID = w.Warehouse_ID
WHERE r.Route_ID IS NULL OR w.Warehouse_ID IS NULL;
