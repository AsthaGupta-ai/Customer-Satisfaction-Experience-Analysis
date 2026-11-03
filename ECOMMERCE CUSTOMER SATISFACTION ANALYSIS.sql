-- ==========================================
-- PROJECT: Customer Satisfaction & Experience Analysis
-- TOOL: MySQL
-- DATASET: E-Commerce Customer Satisfaction
-- TOTAL ORDERS: 2000
-- TOTAL CUSTOMERS: 500
-- TOTAL PRODUCTS: 30
-- ==========================================

-- 1. Average Customer Rating
-- 2. Feedback Category Analysis
-- 3. Category-wise Customer Rating
-- 4. Region-wise Customer Rating
-- 5. Order Status Analysis
-- 6. Delivery Days Analysis
-- 7. Product-wise Customer Rating

-- SQL CONCEPTS USED:
-- 1. CREATE DATABASE
-- 2. CREATE TABLE
-- 3. USE DATABASE
-- 4. PRIMARY KEY
-- 5. SELECT
-- 6. FROM
-- 7. WHERE
-- 8. COUNT()
-- 9. AVG()
-- 10. ROUND()
-- 11. GROUP BY
-- 12. ORDER BY
-- 13. INNER JOIN
-- 14. LIMIT
-- 15. Aggregate Functions


-- OBJECTIVE:
-- To analyze customer satisfaction, feedback,
-- product ratings, delivery performance and order status.



SELECT 1;
USE customer_satisfaction;
SELECT DATABASE();
SHOW TABLES;
CREATE DATABASE IF NOT EXISTS customer_satisfaction;
USE customer_satisfaction;

CREATE TABLE Orders (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Quantity INT,
    Order_Amount DECIMAL(12,2),
    Order_Status VARCHAR(30),
    Delivery_Days INT,
    Customer_Rating DECIMAL(3,1),
    Feedback_Category VARCHAR(30)
);

SHOW TABLES;
USE customer_satisfaction;

-- 1. Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Quantity INT,
    Order_Amount DECIMAL(12,2),
    Order_Status VARCHAR(30),
    Delivery_Days INT,
    Customer_Rating DECIMAL(3,1),
    Feedback_Category VARCHAR(30)
);

-- 2. Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Gender VARCHAR(20),
    Age INT,
    Customer_Segment VARCHAR(50),
    Region VARCHAR(50),
    City VARCHAR(100)
);

-- 3. Products Table
CREATE TABLE IF NOT EXISTS Products (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Product_Name VARCHAR(150),
    Category VARCHAR(100),
    Brand VARCHAR(100),
    Product_Price DECIMAL(12,2)
);

SHOW TABLES;



DESCRIBE Orders;

DESCRIBE Customers;

DESCRIBE Products;



USE customer_satisfaction;

SELECT COUNT(*) FROM Orders;

USE customer_satisfaction;
SELECT COUNT(*) FROM Customers;

USE customer_satisfaction;
SELECT COUNT(*) FROM Products;
USE customer_satisfaction;

SELECT COUNT(*) AS Total_Orders
FROM Orders;

SELECT COUNT(*) AS Total_Customers
FROM Customers;

SELECT COUNT(*) AS Total_Products
FROM Products;
SELECT * FROM Orders
LIMIT 10;

SELECT
    ROUND(AVG(Customer_Rating), 2) AS Average_Rating
FROM Orders;

SELECT
    Feedback_Category,
    COUNT(*) AS Total_Orders
    
    SELECT
    Feedback_Category,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Feedback_Category
ORDER BY Total_Orders DESC;

SELECT 
Feedback_Category, COUNT(*) 
FROM Orders
GROUP BY Feedback_Category;

SELECT
    p.Category,
    ROUND(AVG(o.Customer_Rating), 2) AS Average_Rating
FROM Orders o
JOIN Products p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category;

SELECT
    c.Region,
    ROUND(AVG(o.Customer_Rating), 2) AS Average_Rating
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region;

SELECT
    Order_Status,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Customer_Rating), 2) AS Average_Rating
FROM Orders
GROUP BY Order_Status;

SELECT
    p.Product_Name,
    p.Category,
    COUNT(*) AS Negative_Orders,
    ROUND(AVG(o.Customer_Rating), 2) AS Average_Rating
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
WHERE o.Feedback_Category = 'Negative'
GROUP BY p.Product_Name, p.Category
ORDER BY Negative_Orders DESC;
SELECT
    ROUND(AVG(Delivery_Days), 2) AS Average_Delivery_Days
FROM Orders;


SELECT
    Delivery_Days,
    ROUND(AVG(Customer_Rating), 2) AS Average_Rating,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Delivery_Days
ORDER BY Delivery_Days;

SELECT
    p.Product_Name,
    ROUND(AVG(o.Customer_Rating), 2) AS Average_Rating,
    COUNT(*) AS Total_Orders
FROM Orders o
JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Average_Rating ASC;

SELECT
    Feedback_Category,
    COUNT(*) AS Total_Orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Orders), 2) AS Percentage
FROM Orders
GROUP BY Feedback_Category;


SELECT
    c.Customer_Segment,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(o.Customer_Rating), 2) AS Average_Rating
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY Average_Rating DESC;

-- CONCLUSION:
-- SQL analysis helped identify customer satisfaction
-- trends and areas that need improvement.


