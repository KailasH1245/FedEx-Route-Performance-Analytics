# 📦 FedEx Route Performance Analytics

**A SQL-driven analytics project uncovering delivery delays, route inefficiencies, and performance gaps across a simulated FedEx logistics network.**

![SQL](https://img.shields.io/badge/SQL-Analytics-blue) ![Status](https://img.shields.io/badge/status-active-brightgreen) 
---

## 📖 Overview

FedEx moves millions of shipments a day across 220+ countries. At that scale, even small inefficiencies — a congested warehouse, an underperforming agent, a slow route — compound into real cost and customer-experience problems.

This project simulates that environment with a five-table relational dataset (orders, routes, warehouses, delivery agents, and shipments) and uses pure SQL to answer the questions a logistics operations team would actually ask:

- Which routes are chronically delayed, and why?
- Which warehouses and agents are underperforming relative to the network average?
- Where should volume be shifted to cut delay hours?
- What does a network-wide, on-time KPI dashboard look like?

The result is a complete pipeline — from raw, messy data to a cleaned schema to a set of decision-ready KPIs — built entirely with SQL window functions, CTEs, and aggregation.

---

## 🗂️ Dataset

Five interconnected CSV tables simulate the core operational data of a logistics network:

| Table | Description | Key Columns |
|---|---|---|
| **orders** | Order-level details including payment and routing | `Order_ID`, `Customer_ID`, `Order_Date`, `Route_ID`, `Warehouse_ID`, `Order_Amount` |
| **routes** | Transportation details between cities and countries | `Route_ID`, `Source_City`, `Destination_City`, `Distance_KM`, `Avg_Transit_Time_Hours` |
| **warehouses** | Hub and sortation center data | `Warehouse_ID`, `City`, `Country`, `Capacity_per_day`, `Manager_Name` |
| **delivery_agents** | Agent performance and demographic data | `Agent_ID`, `Agent_Name`, `Zone`, `Experience_Years`, `Avg_Rating` |
| **shipments** | Tracking, timestamps, delay duration, and feedback | `Shipment_ID`, `Order_ID`, `Agent_ID`, `Pickup_Date`, `Delivery_Date`, `Delay_Hours`, `Delivery_Status` |

---

## 🛠️ Methodology

The analysis is organized into seven sequential SQL scripts, each building on the cleaned schema from the previous step.

| Script | Focus | Highlights |
|---|---|---|
| `Task1.sql` | **Data Cleaning** | Deduplicates `Order_ID`/`Shipment_ID`, imputes null `Delay_Hours` with route-level averages, standardizes date formats, validates referential integrity |
| `Task2.sql` | **Delay Analysis** | Top 10 delayed routes, window functions ranking shipments by delay per warehouse, Express vs. Standard comparison |
| `Task3.sql` | **Route Optimization** | Distance-to-time efficiency ratio, worst 3 routes, flags routes with >20% transit overruns |
| `Task4.sql` | **Warehouse Performance** | On-time delivery % ranking, CTEs identifying above-average-delay warehouses |
| `Task5.sql` | **Agent Performance** | On-time % per agent per route, sub-85% performers, experience/rating breakdowns |
| `Task6.sql` | **Shipment Tracking** | Latest status per shipment, high in-transit/returned routes, flags for delays >120 hours |
| `Task7.sql` | **KPI Reporting** | Avg. delay by source country, network-wide on-time %, warehouse utilization %, route efficiency |

**Techniques used:** window functions (`RANK`, `ROW_NUMBER`), CTEs, multi-table joins, conditional aggregation, and date/time standardization.

---

## 📈 Key Findings

> Populate this section with your actual query outputs once Tasks 1–7 have been run against the dataset. Suggested format:

- **Critical bottlenecks:** *[e.g., Routes originating from Dubai show a 25% higher delay rate, largely tied to customs processing.]*
- **Agent insights:** *[e.g., Agents with under 2 years of experience have an on-time rate ~15% lower than the network average.]*
- **Operational wins:** *[e.g., Reallocating 15% of volume from Warehouse A to Warehouse B could cut average delay by ~4 hours.]*

---

## 📁 Project Structure

```
FedEx-Route-Performance-Analytics/
│
├── Data/
│   ├── orders.csv
│   ├── routes.csv
│   ├── warehouses.csv
│   ├── delivery_agents.csv
│   └── shipments.csv
│
├── SQL_Scripts/
│   ├── Task1.sql   # Data Cleaning
│   ├── Task2.sql   # Delay Analysis
│   ├── Task3.sql   # Route Optimization
│   ├── Task4.sql   # Warehouse Performance
│   ├── Task5.sql   # Agent Performance
│   ├── Task6.sql   # Shipment Tracking
│   └── Task7.sql   # KPI Reporting
│
├── C3 Problem Statement.pdf
├── SQL_Project_Queries.pptx
└── README.md
```

---

## 🧰 Tech Stack

- **SQL** (window functions, CTEs, joins, aggregation)
- **CSV** as the raw data interchange format
- **PowerPoint** for stakeholder-facing reporting

---

## 🤝 Contributing

Issues and pull requests are welcome — particularly around extending the KPI set, adding a BI-tool integration (Power BI/Tableau), or parameterizing the scripts for other SQL dialects.

---

*Built with SQL for data analytics.*
