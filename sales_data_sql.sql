create database sales_analysis;
use sales_analysis;
select * from sales_data;

-- Total Orders
select count(distinct order_id) Total_orders from sales_data;

-- Total Number of Manufactory
select  count(distinct manufactory) Total_manufactory from sales_data;

-- Total Number of Product
select count(distinct product_name) as Total_product from sales_data;

-- Total Number of Customer
select count(distinct customer) Total_customer from sales_data;

-- Total Sales by each region

select region,round(sum(sales),2) Total_sales 
from sales_data
group by region
order by round(sum(sales),2) desc;

-- Total Sales by category
select category , round(sum(sales),2) total_sales
from sales_data
group by category
order by round(sum(sales),2) desc;

-- Total sales by segment

select segment , round(sum(sales),2) total_sales
from sales_data
group by segment
order by round(sum(sales),2) desc;

-- Total profit by each region

select region,round(sum(profit),2) Total_sales 
from sales_data
group by region
order by round(sum(profit),2) desc;

-- Total profit by category
select category , round(sum(profit),2) total_sales
from sales_data
group by category
order by round(sum(profit),2) desc;

-- Total profit by segment

select segment , round(sum(profit),2) total_sales
from sales_data
group by segment
order by round(sum(profit),2) desc;

-- Top 10 profitable products
select product_name, round(sum(profit),2) as profit
from sales_data
group by product_name
order by round(sum(profit),2) desc limit 10;

-- Least Profitable Products
SELECT product_name,round(sum(profit),2) AS total_profit
FROM sales_data
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 10;


-- Statewise profit 
select state, round(sum(profit),2) as profit
from sales_data
group by state
order by round(sum(profit),2) desc;

-- Most profitable year

select  
	YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS year,
    round(sum(profit),2) as profit
    
from sales_data
group by year
order by round(sum(profit),2) desc;

-- Average Order Value by Customer
with cte as (
	select customer, order_id, sum(sales) as sales
    from sales_data 
    group by customer,order_id
    
)
select customer, round(avg(sales),2) as average from cte
group by customer
order by customer;

-- Most saleing product 

select product_name, sum(quantity) num_quantity
from sales_data 
group by product_name
order by sum(quantity) desc;

-- Profit Margin Analysis

SELECT product_name, AVG(profit_margin) AS avg_margin
FROM sales_data
GROUP BY product_name
ORDER BY avg_margin DESC;

-- Customer Segment Performance
SELECT segment, round(SUM(sales),2) AS segment_sales, round(SUM(profit),2) AS segment_profit
FROM sales_data
GROUP BY segment
ORDER BY segment_sales DESC;

-- Discount & Quantity Analysis
SELECT *
FROM sales_data
WHERE discount > 0.20;

-- Average Discount by Category
SELECT category, round(AVG(discount),2) AS avg_discount
FROM sales_data
GROUP BY category;

-- Quantity Sold by Subcategory
SELECT subcategory, SUM(quantity) AS total_qty
FROM sales_data
GROUP BY subcategory
ORDER BY total_qty DESC;

-- Monthly Sales Trend

SELECT monthname(STR_TO_DATE(order_date, '%m/%d/%Y')) AS month, round(SUM(sales),2) AS total_sales
FROM sales_data
GROUP BY month
ORDER BY month desc;

-- Top 10 Manufacturer by Sales
SELECT manufactory, round(SUM(sales),2) AS total_sales
FROM sales_data
GROUP BY manufactory
ORDER BY total_sales DESC limit 10;


-- Revenue Contribution by Region (%)

SELECT region,
       ROUND((SUM(sales) / (SELECT SUM(sales) FROM sales_data)) * 100, 2) AS contribution_percent
FROM sales_data
GROUP BY region
ORDER BY contribution_percent DESC;










