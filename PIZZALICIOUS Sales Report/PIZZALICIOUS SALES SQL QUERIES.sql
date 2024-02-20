/*

PIZZALICIOUS SALES SQL QUERIES

*/


--------------------------------------------------------------------------------------------------------------------------

-- A. KPI’s:

--1. Total Revenue

SELECT sum(total_price) AS Total_Revenue  FROM pizza_sales

--2. Average Order Value

SELECT SUM(total_price)/ COUNT(DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales

--3. Total Pizzas Sold

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

--4. Total Orders

SELECT COUNT(DISTINCT [order_id]) AS Total_Orders FROM pizza_sales
          
--5. Average Pizzas Per Order

SELECT CAST(CAST(SUM([quantity])AS DECIMAL(10,2))/ CAST(COUNT(DISTINCT [order_id]) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order FROM pizza_sales


--------------------------------------------------------------------------------------------------------------------------

-- B. Daily Trend for Total Orders


SELECT DATENAME(DW,[order_date])AS Order_Day , COUNT(DISTINCT [order_id]) AS Total_Orders FROM pizza_sales 
GROUP BY DATENAME(DW,[order_date])


--------------------------------------------------------------------------------------------------------------------------

-- C. Monthly Trend for Orders


SELECT DATENAME(MONTH,[order_date])AS MONTH_NAME  , COUNT(DISTINCT [order_id]) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH,[order_date])
ORDER BY Total_Orders DESC 


--------------------------------------------------------------------------------------------------------------------------

-- D. % of Sales by Pizza Category


SELECT [pizza_category], SUM([total_price]) AS Total_Sales ,SUM([total_price])*100/ (SELECT SUM([total_price]) FROM pizza_sales)AS PCT
FROM pizza_sales 
GROUP BY [pizza_category]

SELECT [pizza_category], SUM([total_price]) AS Total_Sales ,SUM([total_price])*100/ (SELECT SUM([total_price]) FROM pizza_sales WHERE MONTH([order_date]) =1)AS PCT
FROM pizza_sales 
WHERE MONTH([order_date]) =1
GROUP BY [pizza_category] 


--------------------------------------------------------------------------------------------------------------------------

-- E. % of Sales by Pizza Size

SELECT [pizza_size], CAST(SUM([total_price])AS DECIMAL(10,2)) AS Total_Sales ,CAST(SUM([total_price])*100/ (SELECT SUM([total_price]) FROM pizza_sales WHERE DATEPART(quarter ,[order_date]) = 1)AS DECIMAL(10,2)) AS PCT
FROM pizza_sales 
WHERE DATEPART(quarter ,[order_date]) = 1
GROUP BY [pizza_size]
ORDER BY PCT DESC

--------------------------------------------------------------------------------------------------------------------------

-- F. Top & Bottom 5 Pizzas by Revenue

SELECT TOP 5 [pizza_name], SUM([total_price]) AS Total_Revenue FROM pizza_sales
GROUP BY [pizza_name]
ORDER BY Total_Revenue DESC

SELECT TOP 5 [pizza_name], SUM([total_price]) AS Total_Revenue FROM pizza_sales
GROUP BY [pizza_name]
ORDER BY Total_Revenue ASC


-- F. Top & Bottom 5 Pizzas by Quantity

SELECT TOP 5 [pizza_name], SUM([quantity]) AS Total_Quantity FROM pizza_sales
GROUP BY [pizza_name]
ORDER BY Total_Quantity DESC

SELECT TOP 5 [pizza_name], SUM([quantity]) AS Total_Quantity FROM pizza_sales
GROUP BY [pizza_name]
ORDER BY Total_Quantity ASC


-- F. Top & Bottom 5 Pizzas by Total Orders

SELECT TOP 5 [pizza_name], COUNT(DISTINCT [order_id]) AS Total_Orders FROM pizza_sales
GROUP BY [pizza_name]
ORDER BY Total_Orders DESC

SELECT TOP 5 [pizza_name], COUNT(DISTINCT [order_id]) AS Total_Orders FROM pizza_sales
GROUP BY [pizza_name]
ORDER BY Total_Orders ASC
