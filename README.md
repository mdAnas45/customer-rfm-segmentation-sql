📊 Customer RFM Segmentation Analysis (SQL)
📌 Overview

This project presents a Customer RFM Segmentation Analysis performed using PostgreSQL.

RFM stands for Recency, Frequency, and Monetary, which are key metrics used to analyze customer purchasing behavior.

The analysis transforms raw transactional data into structured customer segments to help businesses identify high-value customers, loyal buyers, and churned customers.

The results are visualized in a Power BI dashboard for clear and actionable insights.

🎯 Project Purpose

The purpose of this analysis is to help businesses:

Identify high-value customers

Understand customer purchasing behavior

Detect churned or inactive customers

Segment customers for targeted marketing

Improve customer retention strategies

🛠 Tech Stack

PostgreSQL – Data processing and RFM computation

CTEs (Common Table Expressions) – Structured query building

Window Functions (NTILE) – RFM scoring

Aggregation Functions – Customer purchase metrics

Power BI – Data visualization and dashboard creation

📂 Data Source

Online Retail Transactional Dataset (Portfolio demonstration)

Dataset includes:

Customer ID

Invoice Number

Invoice Date

Quantity

Unit Price

⚠️ Note: Dataset used for learning and portfolio purposes only.

🧠 Business Problem

Businesses often struggle to understand which customers are most valuable and which are at risk of leaving.

Without proper segmentation, it becomes difficult to:

Identify loyal customers

Detect declining customer engagement

Design effective marketing strategies

Focus retention efforts on high-value customers

RFM segmentation helps solve this problem by grouping customers based on purchase recency, purchase frequency, and spending behavior.

📊 Analysis Approach
1️⃣ Data Cleaning

The dataset was cleaned to remove:

Missing customer IDs

Invalid transactions

Negative quantities

Revenue per transaction was calculated as:

quantity * unit_price
2️⃣ RFM Metric Calculation
Recency

Recency measures how recently a customer made a purchase.

(max_date - last_purchase_date) + 1

Lower recency values indicate more recent activity.

Frequency

Frequency measures how often a customer makes purchases.

COUNT(DISTINCT invoice_no)

Higher frequency indicates more engaged customers.

Monetary

Monetary measures how much money a customer spends.

SUM(revenue)

Higher monetary values indicate high-value customers.

3️⃣ RFM Scoring

Customers are scored using quartile ranking with window functions:

NTILE(4) OVER (ORDER BY recency DESC) AS R
NTILE(4) OVER (ORDER BY frequency) AS F
NTILE(4) OVER (ORDER BY monetary) AS M

These scores are combined into a three-digit RFM score:

RFM_Score = CONCAT(R, F, M)

Example:

Recency	Frequency	Monetary	RFM Score
4	4	4	444
3	4	4	344
1	1	1	111
4️⃣ Customer Segmentation

Customers are grouped into segments based on their RFM score patterns.

Example segments:

Segment	Description
Champions	Recently purchased, frequent buyers, high spenders
Loyal Customers	Consistent repeat buyers
Active Customers	Regular customers with moderate spending
Potential Customers	Customers with potential to become loyal
At Risk Customers	Previously active but declining activity
Lost Customers	Inactive customers with low engagement
Others	Customers not fitting specific segment patterns
📊 Dashboard Visualization

The results are visualized using Power BI, including:

Customer segment distribution

KPI metrics for each segment

Customer activity overview

The dashboard focuses on clear and minimal visuals to highlight key insights.

🔍 Key Insights

A small portion of customers generates high revenue

Some customers show declining engagement

Customer segments vary significantly in purchase behavior

Identifying Champions and At-Risk customers is critical for retention strategy

💡 Business Value

RFM segmentation helps businesses:

Identify high-value customers

Personalize marketing campaigns

Reduce customer churn

Improve customer lifetime value

Focus resources on most profitable segments

📌 Key SQL Concepts Demonstrated

CTE chaining

Revenue calculation

Customer-level aggregation

Window functions (NTILE)

RFM score generation

Customer segmentation logic

🚀 Conclusion

This project demonstrates how advanced SQL techniques can be used to perform full RFM customer segmentation analysis.

By transforming raw transactional data into meaningful customer segments, businesses can better understand their customers and make data-driven marketing and retention decisions.

👤 Author

Anas
Aspiring Data Analyst

Skills:
Excel | Power BI | SQL | Python
