# Fleet Risk Analytics

### Big Data Analytics | Hadoop | Hive | Apache Pig | Power BI

## 📌 Project Overview

This project analyzes fleet telematics and operational data to identify risky driving behaviors, high-risk drivers, and geographic risk patterns.

Using a fictitious trucking company as the business scenario, the analysis demonstrates how big data technologies and business intelligence can be used to support fleet safety, risk management, and operational decision-making.

The solution processes driver, vehicle, mileage, fuel consumption, geolocation, and driving-event data using Hadoop, Hive, and Apache Pig, with Power BI used to visualize the resulting risk patterns and business insights.

## 🎯 Business Problem

Fleet managers need to identify unsafe driving behavior before it leads to accidents, regulatory issues, or increased insurance exposure.

The analysis focuses on four key questions:

1. Which drivers have the highest risk factors?
2. Which unsafe driving behaviors occur most frequently?
3. Where are risky driving events geographically concentrated?
4. Do particular truck models show higher concentrations of risky driving events?

## 🛠️ Technologies Used

- Hadoop / HDFS
- Apache Hive
- Apache Pig
- Pig Latin
- HCatalog
- Power BI
- DAX
- CSV / Telematics Data

## 📊 Dataset

The analysis combines fleet operational and telematics data, including:

- Driver and truck identifiers
- Geolocation data
- Driving-event classifications
- Vehicle speed
- Mileage
- Fuel consumption
- Truck model
- City and state
- Latitude and longitude

The project analyzed **8,000 driving-event observations**, including **457 unsafe events**.

## ⚙️ Data Processing Workflow

The analytical workflow consisted of:

1. Loading fleet datasets into the Hadoop environment.
2. Creating structured tables using Hive.
3. Transforming historical truck mileage and fuel data.
4. Aggregating total mileage by driver.
5. Using Apache Pig to isolate abnormal driving events.
6. Joining event data with driver mileage.
7. Calculating a normalized driver risk factor.
8. Visualizing risk patterns and operational insights in Power BI.

### Risk Factor

Driver risk was normalized based on the number of unsafe events relative to total miles driven:

**Risk Factor = (Unsafe Driving Events / Total Miles Driven) × 1,000,000**

This allows drivers with different mileage levels to be compared more fairly.

## 🔎 Key Findings

- **457 of 8,000 observations** were classified as unsafe driving events.
- Lane departure and unsafe following distance accounted for a substantial portion of unsafe events.
- Risk events showed geographic concentration in several California locations and along major driving corridors.
- Santa Rosa and Willits represented notable concentrations of risk events.
- Driver **A97** recorded the highest cumulative risk factor in the analysis.
- High-risk drivers substantially outnumbered low-risk drivers.
- The analysis did not establish a causal relationship between truck model and driver risk.

## 💡 Business Recommendations

- Prioritize targeted coaching for drivers with consistently high normalized risk factors.
- Focus driver training on lane discipline, following distance, and speed management.
- Use telematics monitoring to identify emerging geographic and behavioral risk patterns.
- Consider driver-assistance technologies such as dash cameras and lane-drift alerts.
- Recognize consistently safe drivers through incentive programs.
- Monitor high-risk routes and locations to support proactive fleet safety decisions.

## 📈 Dashboard

Power BI was used to develop visualizations covering:

- Driver risk levels
- Unsafe event distribution
- Geographic risk hotspots
- Risk patterns by truck model
- Driver-level outlier analysis

> Dashboard screenshots will be added here.

## 📁 Repository Structure

```text
fleet-risk-analytics/
├── README.md
├── data/
├── hive/
├── pig/
├── dashboard/
├── images/
└── presentation/
```

## 📌 Case Study Context

This portfolio case study uses a fictitious trucking company scenario to show how big data analytics can improve fleet safety, reduce operational risk, and support data-driven decision-making.

## 👤 Author

**Edith Kafui Agbexornu**

Business & System Analyst | Data Analytics | Business Intelligence  
M.S. Business Analytics & Artificial Intelligence | MBA | CBAP

🔗 [LinkedIn](https://www.linkedin.com/in/edith-agbexornu/)  
💻 [GitHub](https://github.com/edithagbexornu)
