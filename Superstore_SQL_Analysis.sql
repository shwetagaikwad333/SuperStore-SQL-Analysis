
-- =====================================================
-- SuperStore Sales Analysis Project
-- SQL Data Cleaning & Business Analysis
-- =====================================================


-- =====================================================
-- Step 1: Create Database
-- =====================================================

CREATE DATABASE SuperStore;

USE SuperStore;

-- =====================================================
-- Step 2: Create Orders Table
-- =====================================================

CREATE TABLE orders (

    Row_ID INT,
    Order_ID VARCHAR(30),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),

    Customer_ID VARCHAR(30),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),

    Postal_Code VARCHAR(20),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),

    Region VARCHAR(100),
    Market VARCHAR(50),

    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(100),
    Product_Name VARCHAR(255),

    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),

    Shipping_Cost DECIMAL(10,2),
    Order_Priority VARCHAR(30)

);

-- =====================================================
-- Step 3: Import CSV Data
-- Import the cleaned SuperStore CSV file after creating
-- the table using MySQL Workbench Import Wizard
-- =====================================================


-- =====================================================
-- Step 4: Data Validation & Cleaning Checks
-- =====================================================


-- Check total records

SELECT COUNT(*) AS Total_Records
FROM orders;

ALTER TABLE orders
RENAME COLUMN `ï»¿Row ID` TO Row_ID,
RENAME COLUMN `Order ID` TO Order_ID,
RENAME COLUMN `Order Date` TO Order_Date,
RENAME COLUMN `Ship Date` TO Ship_Date,
RENAME COLUMN `Product ID` TO Product_ID,
RENAME COLUMN `Shipping Cost` TO Shipping_Cost,
RENAME COLUMN `Customer Name` TO Customer_Name,
RENAME COLUMN `Customer ID` TO Customer_ID,
RENAME COLUMN `Product Name` TO Product_Name,
RENAME COLUMN `Ship Mode` TO Ship_Mode,
RENAME COLUMN `Order Priority` TO Order_Priority;

 UPDATE orders
SET 
Sales_Clean = REPLACE(REPLACE(Sales, '$', ''), ',', ''),
Profit_Clean = CASE
    WHEN TRIM(Profit) = '-' THEN 0
    WHEN Profit LIKE '%(%' THEN 
        -1 * REPLACE(REPLACE(REPLACE(TRIM(Profit), '(', ''), ')', ''), '$', '')
    ELSE REPLACE(REPLACE(REPLACE(Profit, '$', ''), ',', ''), ' ', '')
END;


-- Check duplicate orders

SELECT Order_ID, Product_ID, COUNT(*) AS Duplicate_Count
FROM orders GROUP BY Order_ID, Product_ID
HAVING COUNT(*) > 1;


-- Check missing values

SELECT * FROM orders
WHERE Sales_Clean IS NULL
OR Profit_Clean IS NULL
OR Customer_Name IS NULL;


-- Check negative profits

SELECT * FROM orders
WHERE Profit_Clean < 0;

-- =====================================================
-- Step 5: Business Analysis Queries
-- =====================================================

-- 1. Total Sales

SELECT ROUND(SUM(Sales_Clean),2) AS Total_Sales
FROM orders;

-- 2. Total Profit

SELECT ROUND(SUM(Profit_Clean),2) AS Total_Profit
FROM orders;

-- 3. Number of Customers

SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM orders;

-- 4. Sales by Category

SELECT Category,
ROUND(SUM(Sales_Clean),2) AS Total_Sales
FROM orders GROUP BY Category
ORDER BY Total_Sales DESC;

-- 5. Profit by Category

SELECT Category, ROUND(SUM(Profit_Clean),2) AS Total_Profit
FROM orders GROUP BY Category
ORDER BY Total_Profit DESC;

-- 6. Top 10 Customers by Sales

SELECT Customer_Name, ROUND(SUM(Sales_Clean),2) AS Total_Sales
FROM orders GROUP BY Customer_Name
ORDER BY Total_Sales DESC LIMIT 10;

-- 7. Top States by Sales

SELECT State, ROUND(SUM(Sales_Clean),2) AS Total_Sales
FROM orders GROUP BY State
ORDER BY Total_Sales DESC;

-- 8. Most Profitable Cities

SELECT City, ROUND(SUM(Profit_Clean),2) AS Total_Profit
FROM orders GROUP BY City
ORDER BY Total_Profit DESC LIMIT 10;

-- 9. Loss Making Products

SELECT Product_Name, ROUND(SUM(Profit_Clean),2) AS Total_Loss
FROM orders GROUP BY Product_Name
HAVING SUM(Profit_Clean) < 0 ORDER BY Total_Loss;

-- 10. Average Discount by Category

SELECT Category, ROUND(AVG(Discount),2) AS Average_Discount
FROM orders GROUP BY Category;

-- 11. Sales by Shipping Mode

SELECT Ship_Mode, ROUND(SUM(Sales_Clean),2) AS Total_Sales
FROM orders GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;

-- 12. High Priority Orders

SELECT Order_Priority, COUNT(*) AS Total_Orders
FROM orders GROUP BY Order_Priority
ORDER BY Total_Orders DESC;


-- =====================================================
-- Step 6: Intermediate SQL Analysis
-- =====================================================

-- 13. Rank Customers by Sales

SELECT Customer_Name, ROUND(SUM(Sales_Clean),2) AS Total_Sales,
    RANK() OVER(
        ORDER BY SUM(Sales_Clean) DESC) AS Sales_Rank
FROM orders GROUP BY Customer_Name;


-- 14. Top Product in Each Category

WITH RankedProducts AS
(SELECT Category, Product_Name,
SUM(Sales_Clean) AS Sales,
ROW_NUMBER() OVER(PARTITION BY Category ORDER BY SUM(Sales_Clean) DESC) AS rn
FROM orders GROUP BY Category, Product_Name)
SELECT * FROM RankedProducts WHERE rn = 1;


-- 15. Profit Margin by Category

SELECT Category, ROUND(SUM(Profit_Clean) / SUM(Sales_Clean) * 100, 2)
 AS Profit_Margin_Percentage
FROM orders GROUP BY Category;


-- 16. Customer Segmentation Analysis

SELECT Segment, COUNT(DISTINCT Customer_ID) AS Customers,
ROUND(SUM(Sales_Clean),2) AS Total_Sales,
ROUND(AVG(Sales_Clean),2) AS Average_Order_Value
FROM orders GROUP BY Segment;


-- 17. Running Sales Total

SELECT Order_Date, SUM(Sales_Clean) AS Daily_Sales,
SUM(SUM(Sales_Clean)) OVER(ORDER BY Order_Date) AS Running_Total
FROM orders GROUP BY Order_Date;


-- 18. Monthly Sales Trend

SELECT
YEAR(Order_Date) AS Year, MONTH(Order_Date) AS Month,
ROUND(SUM(Sales_Clean),2) AS Monthly_Sales
FROM orders GROUP BY
YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

-- =====================================================
-- End of Project
-- =====================================================
