-- Dropping the schema "pizza_sales_schema" if already exists in order to get rid of error.
DROP SCHEMA IF EXISTS PIZZA_SALES_SCHEMA;

-- Creating a Schema named "pizza_sales_schema"
CREATE SCHEMA PIZZA_SALES_SCHEMA;

-- Making use of pizza_sales_schema as the default schema for the further queries.
USE PIZZA_SALES_SCHEMA;

-- Viewing the data in the pizza_sales table.
SELECT * FROM pizza_sales;

-- KPI's
-- 1) Total Revenue : Sum of Total Price of all pizza orders.
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- 2) Average Order Value : The average amount spent per order, calculated by dividing total revenue by total number of orders.
SELECT (SUM(total_price) / COUNT(DISTINCT(order_id))) AS Average_Order_Value FROM pizza_sales;

-- 3) Total Pizzas Sold : Sum of the quantities of all pizzas sold.
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

-- 4) Total Orders : Total number of orders placed.
SELECT COUNT(DISTINCT(order_id)) AS Total_Orders FROM pizza_sales;

-- 5) Average Pizzas Per Order : Average number of pizzas sold per order, calculated by dividing total_pizzas_sold by total number of orders.
SELECT (SUM(quantity) / COUNT(DISTINCT(order_id)) ) AS Average_Pizzas_Per_Order FROM pizza_sales;

-- CHART Requirements
-- 1) Daily Trend For Total Orders
SELECT 
	DATE_FORMAT(order_date, '%a') AS order_day, 
    COUNT(DISTINCT order_id) AS num_of_orders 
FROM pizza_sales 
GROUP BY 1;

-- 2) Monthly Trends For Total Orders
SELECT 
	DATE_FORMAT(order_date, '%b') AS Month_abbr, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY 1
ORDER BY 2 DESC;

-- 3) Percentage of Sales by Pizza Category
SELECT 
    Pizza_Category,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 2) AS Sales_Percentage
FROM 
    pizza_sales
GROUP BY 
    Pizza_Category;

-- 4) Percentage of Sales by Pizza Size
SELECT 
	pizza_size, 
    ROUND(SUM(total_price), 2) AS Total_Sales,
	ROUND((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 2) AS Sales_Percentage
FROM pizza_sales
GROUP BY 1;

-- 5) Total Pizzas sold by Pizza Category
SELECT 
	pizza_category,
    COUNT(pizza_id) AS total_pizzas_sold
FROM pizza_sales
GROUP BY 1;

-- 6) Top 5 Best Sellers based on revenue
SELECT 
	pizza_name,
    SUM(total_price) AS total_sales
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 7) Bottom 5 Worst Sellers based on revenue
SELECT 
	pizza_name,
    SUM(total_price) AS total_sales
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 
LIMIT 5;

-- 8) Top 5 Best Sellers based on Total Quantity
SELECT 
	pizza_name,
    SUM(quantity) AS total_quantity
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 9) Bottom 5 Worst Sellers based on Total Quantity
SELECT 
	pizza_name,
    SUM(quantity) AS total_quantity
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 
LIMIT 5;

-- 10) Top 5 Best Sellers based on Total Orders
SELECT 
	pizza_name,
    COUNT(DISTINCT order_id)  AS total_orders
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 11) Bottom 5 Worst Sellers based on Total Orders
SELECT 
	pizza_name,
    COUNT(DISTINCT order_id)  AS total_orders
FROM pizza_sales 
GROUP BY 1
ORDER BY 2
LIMIT 5;