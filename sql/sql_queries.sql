-- Step 1: Create the database
CREATE DATABASE superstore_db;

CREATE SCHEMA IF NOT EXISTS public;

-- Step 4: Verify database is created
SELECT current_database();


CREATE TABLE superstore (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(150),
    segment VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    product_name TEXT,
    sales NUMERIC(12,2),
	order_year NUMERIC,
	order_month NUMERIC
);

SET DateStyle = 'DMY';


-- 1. Data Validation 

-- Check total rows
SELECT COUNT(*) AS total_rows
FROM superstore;

-- Check date range
SELECT MIN(order_date) AS earliest_order_date,
       MAX(order_date) AS latest_order_date
FROM superstore;

-- Detect duplicate transactions
SELECT order_id, product_id, COUNT(*) AS duplicate_count
FROM superstore
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

-- Check missing values
SELECT COUNT(*) FROM superstore WHERE order_date IS NULL;
SELECT COUNT(*) FROM superstore WHERE ship_date IS NULL;
SELECT COUNT(*) FROM superstore WHERE sales IS NULL;

-- Check invalid shipping dates
SELECT * FROM superstore WHERE ship_date < order_date;


--2. Bussiness KPI's 
-- Total sales revenue
SELECT SUM(sales) AS total_sales
FROM superstore;

-- Total number of orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM superstore;

-- Total number of customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM superstore;

-- Average order value
SELECT SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM superstore;

-- 3. Product Performance
-- Sales by category
SELECT category, SUM(sales) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Sales by sub-category
SELECT sub_category, SUM(sales) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Top 10 products
SELECT product_name, SUM(sales) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- * Geographical Analysis 
-- Sales by region
SELECT region, SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- Sales by state
SELECT state, SUM(sales) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC;

-- Sales by city 
SELECT city,SUM(sales) as total_sales
FROM superstore
GROUP BY city
ORDER BY total_sales DESC;

-- * Customer Segment An

Select * from superstore