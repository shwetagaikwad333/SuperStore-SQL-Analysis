# SuperStore Sales Analysis | SQL (MySQL)

## Project Overview

This project focuses on data cleaning, validation, and business analysis using SQL and MySQL. The SuperStore dataset is used to explore sales performance, profitability, customer behaviour, product performance, and shipping operations.

The project progresses from database and table creation to data validation, cleaning, exploratory business analysis, and intermediate SQL analysis.

## Project Objectives

- Clean and validate sales data before analysis.
- Identify duplicate records and missing values.
- Standardize sales and profit values, including handling negative profit values.
- Analyze overall sales, profit, and customer metrics.
- Evaluate sales and profitability across product categories and geographical locations.
- Identify top-performing customers, states, cities, and products.
- Examine discounts, shipping modes, and order priorities.
- Analyze customer segments and monthly sales trends.

## Data Preparation & Cleaning

The SQL script includes the following data preparation steps:

- Created a MySQL database and an `orders` table.
- Defined appropriate data types for order, customer, product, and sales-related fields.
- Imported the SuperStore CSV dataset using MySQL Workbench.
- Renamed columns to maintain consistent naming conventions.
- Cleaned sales and profit values by removing currency symbols, commas, and spaces.
- Converted negative profit values represented in parentheses into negative numeric values.
- Treated dash (`-`) profit entries as zero.
- Checked for duplicate order-product combinations.
- Identified missing values in sales, profit, and customer name fields.
- Examined records with negative profits.

## SQL Business Analysis

The project explores the following business questions:

### 1. Sales & Profitability Analysis
- What are the total sales and total profit?
- How do sales and profit compare across product categories?
- What are the profit margins by category?
- Which products generate losses?

### 2. Customer Analysis
- Who are the top 10 customers by sales?
- How do customer segments compare in terms of customer count and sales?
- What is the average order value across customer segments?
- How can customers be ranked by sales performance?

### 3. Product & Geographic Analysis
- Which states generate the highest sales?
- Which cities are the most profitable?
- What is the top-selling product within each category?

### 4. Shipping & Order Analysis
- How do sales vary by shipping mode?
- Which order priorities occur most frequently?
- How do shipping and order characteristics relate to business performance?

### 5. Time-Based Analysis
- How do monthly sales change over time?
- What is the cumulative running sales total by order date?

## SQL Techniques & Concepts

**Basic SQL**
- CREATE DATABASE and CREATE TABLE
- ALTER TABLE and UPDATE
- SELECT, WHERE, GROUP BY, HAVING
- ORDER BY, DISTINCT, LIMIT
- Aggregate functions: SUM, AVG, COUNT, ROUND

**Intermediate SQL**
- Common Table Expressions (CTEs)
- Window functions: RANK() and ROW_NUMBER()
- PARTITION BY and OVER()
- Running totals using window functions
- Conditional logic using CASE
- Data transformation using REPLACE() and TRIM()

## Tools & Technologies

- **MySQL** – Database creation, data cleaning, and business analysis.
- **MySQL Workbench** – SQL development and CSV data import.

## Repository Contents

- `Superstore_SQL_Analysis.sql` – SQL script containing database setup, data preparation, validation checks, and business analysis queries.
- `README.md` – Project documentation.
- `LICENSE` – Repository license.

## Project Outcome

Developed an end-to-end SQL analysis workflow covering data preparation, data quality checks, and business-focused analysis. Applied SQL aggregation, conditional transformations, CTEs, and window functions to examine sales, profitability, customer segments, product performance, and operational trends.

