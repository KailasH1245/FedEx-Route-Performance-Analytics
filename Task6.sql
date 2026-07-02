-- Latest status per shipment (Delivered, In Transit, Returned)
SELECT Shipment_ID,
       MAX(Delivery_Date) AS Latest_Delivery_Date,
       MAX(Delivery_Status) AS Latest_Status
FROM Shipments
GROUP BY Shipment_ID;


-- !! routes where majority of shipments are still “In Transit” or “Returned”
SELECT Route_ID,
       SUM(CASE WHEN Delivery_Status IN ('In Transit','Returned') THEN 1 ELSE 0 END) * 1.0 / COUNT(*) * 100 AS Problematic_Percentage
FROM Shipments
GROUP BY Route_ID
HAVING SUM(CASE WHEN Delivery_Status IN ('In Transit','Returned') THEN 1 ELSE 0 END) * 1.0 / COUNT(*) > COUNT(*) / 2;



-- Find most frequent delay reasons
SELECT Delay_Reason,
       COUNT(*) AS Frequency
FROM Shipments
WHERE Delay_Reason IS NOT NULL
GROUP BY Delay_Reason
ORDER BY Frequency DESC;

-- Identify orders with exceptionally high delay (>120 hours)
SELECT Order_ID, Shipment_ID, Delay_Hours
FROM Shipments
WHERE Delay_Hours > 120
ORDER BY Delay_Hours DESC;
