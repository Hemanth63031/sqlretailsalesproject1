# sql_retailsales_project1
🛒 Retail Sales Analysis using SQL
📌 Project Description

This project analyzes retail sales transaction data using SQL to answer 10 real-world business questions.
It focuses on data cleaning, exploration, and analytical querying, demonstrating strong SQL fundamentals required for Data Analyst / SQL Developer fresher roles.

🧰 Tools & Skills Used

SQL

PostgreSQL / MySQL

Data Cleaning

Aggregate Functions

Date & Time Functions

Window Functions

CTE (Common Table Expressions)

📂 Database Schema
Table: retailsales
transactions_id	Unique transaction ID
sale_date	Date of sale
sale_time	Time of sale
customer_id	Customer identifier
gender	Customer gender
age	Customer age
category	Product category
quantiy	Quantity sold
price_per_unit	Price per unit
cogs	Cost of goods sold
total_sale	Total sales amount
🧹 Data Cleaning

Before analysis, records with NULL values in critical columns were identified and removed to ensure data accuracy.

Purpose:
To avoid incorrect aggregations and misleading insights.

🔍 Data Analysis – Business Questions & Explanations
Q1. Retrieve all sales made on 2022-11-05

Purpose:
To analyze all transactions that occurred on a specific day.

SELECT * 
FROM retailsales
WHERE sale_date = '2022-11-05';

Q2. Retrieve all Clothing transactions with quantity ≥ 4 in November 2022

Purpose:
To identify bulk clothing purchases during a specific month.

SELECT * 
FROM retailsales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

Q3. Calculate total sales and total orders for each category

Purpose:
To measure category-wise revenue performance and order volume.

SELECT category,
       SUM(total_sale) AS net_sale,
       COUNT(*) AS total_orders
FROM retailsales
GROUP BY category;

Q4. Find the average age of customers who purchased Beauty products

Purpose:
To understand the target age group for the Beauty category.

SELECT ROUND(AVG(age), 2)
FROM retailsales
WHERE category = 'Beauty';

Q5. Retrieve transactions where total sales exceed 1000

Purpose:
To identify high-value transactions.

SELECT *
FROM retailsales
WHERE total_sale > 1000;

Q6. Find total number of transactions by gender in each category

Purpose:
To analyze purchasing behavior across genders and product categories.

SELECT category,
       gender,
       COUNT(*) AS total_trans
FROM retailsales
GROUP BY category, gender
ORDER BY category;

Q7. Find the best-selling month (highest average sales) for each year

Purpose:
To identify peak-performing months annually.

SELECT year, month, avg_sale
FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (
               PARTITION BY EXTRACT(YEAR FROM sale_date)
               ORDER BY AVG(total_sale) DESC
           ) AS rank
    FROM retailsales
    GROUP BY 1,2
) t
WHERE rank = 1;

Q8. Find the top 5 customers based on highest total sales

Purpose:
To identify the most valuable customers.

SELECT customer_id,
       SUM(total_sale) AS total_sale
FROM retailsales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

Q9. Count unique customers for each category

Purpose:
To measure customer reach across product categories.

SELECT category,
       COUNT(DISTINCT customer_id)
FROM retailsales
GROUP BY category;

Q10. Create sales shifts and count orders per shift

Shift Logic:

Morning: Before 12 PM

Afternoon: 12 PM – 5 PM

Evening: After 5 PM

Purpose:
To understand order distribution across different times of the day.

WITH hourly_sale AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retailsales
)
SELECT shift,
       COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

🎯 Project Outcome

Improved understanding of customer behavior

Identified top categories and customers

Analyzed time-based sales patterns

Demonstrated strong SQL analytical skills

👤 Author

Hemu Hemanth
Aspiring Data Analyst | SQL Developer
