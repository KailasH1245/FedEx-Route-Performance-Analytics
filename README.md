# FedEx Logistics Optimization: SQL Analytics Project

## 📖 Project Overview
**Logistics Optimization for Delivery Routes – FedEx**

FedEx operates a massive global network connecting over 220 countries, handling millions of daily shipments. However, surging e-commerce volumes, flight delays, and last-mile congestion have created operational bottlenecks.

This project transforms raw logistics data into actionable insights. By building a **SQL-driven analytics system**, we analyze shipment performance, identify root causes of delays, and optimize routes to enhance on-time delivery rates and cost efficiency across the global network.

> **The Plot:** In data storytelling, the business challenge is the narrative. Here, the "plot" revolves around a logistics giant struggling with transit delays and route inefficiencies. The "resolution" is a data-driven strategy to reclaim operational excellence, optimize hub utilization, and improve agent performance.

## 📊 Dataset Description
The analysis utilizes five interconnected relational tables stored in a SQL database:

| Table | Description | Key Columns |
| :--- | :--- | :--- |
| **Orders** | Order-level details including payment and routing. | `Order_ID`, `Customer_ID`, `Order_Date`, `Route_ID`, `Warehouse_ID`, `Order_Amount` |
| **Routes** | Transportation details between cities and countries. | `Route_ID`, `Source_City`, `Destination_City`, `Distance_KM`, `Avg_Transit_Time_Hours` |
| **Warehouses** | Hub and sortation center location data. | `Warehouse_ID`, `City`, `Country`, `Capacity_per_day`, `Manager_Name` |
| **Delivery Agents** | Agent performance and demographic data. | `Agent_ID`, `Agent_Name`, `Zone`, `Experience_Years`, `Avg_Rating` |
| **Shipments** | Tracking info, timestamps, delay duration, and feedback. | `Shipment_ID`, `Order_ID`, `Agent_ID`, `Pickup_Date`, `Delivery_Date`, `Delay_Hours`, `Delivery_Status` |

## 🛠️ Methodology & Tasks Executed

### 1. Data Cleaning & Preparation
*   **Deduplication:** Removed duplicate `Order_ID` and `Shipment_ID` records to ensure data integrity.
*   **Imputation:** Replaced null `Delay_Hours` with the route-specific average delay.
*   **Standardization:** Converted all date columns to `YYYY-MM-DD HH:MM:SS` format.
*   **Validation:** Flagged logical errors (e.g., `Delivery_Date` before `Pickup_Date`) and verified referential integrity across all tables.

### 2. Delivery Delay Analysis
*   Calculated actual delivery delay (hours) for every shipment.
*   Identified the **Top 10 Delayed Routes** using aggregation.
*   Utilized **SQL Window Functions** to rank shipments by delay within each warehouse.
*   Compared efficiency between *Express* and *Standard* delivery types.

### 3. Route Optimization Insights
*   Computed the **Distance-to-Time Efficiency Ratio** (`Distance_KM / Avg_Transit_Time_Hours`) for all routes.
*   Isolated the **3 worst-performing routes** based on efficiency.
*   Flagged routes where >20% of shipments exceeded expected transit times.
*   **Outcome:** Provided specific recommendations for hub pair optimization.

### 4. Warehouse Performance
*   Ranked warehouses by **On-Time Delivery %**.
*   Used **CTEs (Common Table Expressions)** to identify warehouses exceeding the global average delay.
*   Analyzed the ratio of total vs. delayed shipments per hub.

### 5. Delivery Agent Performance
*   Ranked agents per route by on-time delivery percentage.
*   Identified agents performing below the **85% threshold**.
*   Compared average ratings and experience levels between top and bottom performers to suggest training strategies.

### 6. Shipment Tracking Analytics
*   Determined the latest status for every shipment.
*   Identified routes with high volumes of "In Transit" or "Returned" items.
*   Flagged orders with exceptional delays (>120 hours) for bottleneck investigation.

### 7. Advanced KPI Reporting
Generated a summary dashboard of key metrics:
*   **Average Delivery Delay** per Source Country.
*   **On-Time Delivery %** across the network.
*   **Warehouse Utilization %** relative to daily capacity.
*   **Route Efficiency** metrics.

## 📈 Key Findings & Recommendations
*(Note: Update this section with your specific SQL results)*

*   **Critical Bottlenecks:** [e.g., Routes originating from Dubai showed a 25% higher delay rate due to customs bottlenecks.]
*   **Agent Insights:** [e.g., Agents with <2 years experience had a 15% lower on-time rate, suggesting a need for targeted onboarding.]
*   **Operational Wins:** [e.g., Shifting 15% of volume from Warehouse A to Warehouse B could reduce average delay by 4 hours.]

## 🚀 How to Run
1.  **Environment:** Ensure you have a SQL environment (PostgreSQL, MySQL, or SQL Server).
2.  **Schema Setup:** Run the `Task1.sql` script to create tables and load the CSV data.
3.  **Analysis:** Execute scripts `Task2.sql` through `Task7.sql` sequentially to generate insights.
4.  **Reporting:** Results are designed to be exported directly to the final presentation deck.

## 📁 Project Structure
