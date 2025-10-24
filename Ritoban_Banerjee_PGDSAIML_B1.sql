/* IMPORTANT INSTRUCTIONS FOR LEARNERS
1) DO NOT CHANGE THE ORDER OF COLUMNS.
2) YOUR QUERY SHOULD DISPLAY COLUMNS IN THE SAME ORDER AS MENTIONED IN ALL QUESTIONS.
3) YOU CAN FIND THE ORDER OF COLUMNS IN QUESTION TEMPLATE SECTION OF EACH QUESTION.
4) USE ALIASING AS MENTIONED IN QUESTION TEMPLATE FOR ALL COLUMNS
5) DO NOT CHANGE COLUMN NAMES*/

-- Question 1 (Marks: 2)
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column
                   
SELECT DISTINCT
    t.customername AS CustomerName
FROM
    customers t;

-- Question 2 (Marks: 2)
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

SELECT DISTINCT
    t.productname AS ProductName
FROM
    products t
WHERE
    t.price < 15;

-- Question 3 (Marks: 2)
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

SELECT 
    t.firstname AS FirstName, t.lastname AS LastName
FROM
    Employees t;


-- Question 4 (Marks: 2)
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

SELECT 
    t.OrderID, t.OrderDate
FROM
    orders t
WHERE
    YEAR(t.orderdate) = 1997;

-- Question 5 (Marks: 2)
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

SELECT DISTINCT
    t.productname AS ProductName, t.Price
FROM
    products t
WHERE
    t.price > 50;

-- Question 6 (Marks: 3)
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

-- Write your SQL solution here
SELECT 
    t1.CustomerName, t3.FirstName, t3.LastName
FROM
    customers t1
        INNER JOIN
    orders t2 ON t1.CustomerID = t2.CustomerID
        INNER JOIN
    employees t3 ON t2.EmployeeID = t3.EmployeeID;

-- Question 7 (Marks: 3)
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

-- Write your SQL solution here
SELECT 
    t.Country, COUNT(t.CustomerID) AS CustomerCount
FROM
    customers t
GROUP BY 1;

-- Question 8 (Marks: 3)
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

SELECT 
    t2.CategoryName, ROUND(AVG(t1.Price), 2) AS AvgPrice
FROM
    products t1
        JOIN
    categories t2 ON t2.CategoryID = t1.CategoryID
GROUP BY 1;

-- Question 9 (Marks: 3)
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

SELECT 
    t.EmployeeID, COUNT(t.OrderID) AS OrderCount
FROM
    orders t
GROUP BY 1;

-- Question 10 (Marks: 3)
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

SELECT 
    ProductName
FROM
    products t1
        JOIN
    suppliers t2 ON t1.SupplierID = t2.SupplierID
WHERE
    t2.SupplierName = 'Exotic Liquid';

-- Question 11 (Marks: 5)
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity).
-- Question Template: Display ProductID, TotalOrdered Columns

SELECT 
    t.ProductID, SUM(t.Quantity) AS TotalOrdered
FROM
    orderdetails t
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

-- Question 12 (Marks: 5)
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

SELECT 
    t1.CustomerName, SUM(t3.Quantity * t4.price) AS TotalSpent
FROM
    customers t1
        JOIN
    orders  t2 ON t1.CustomerID = t2.CustomerID
        JOIN
    orderdetails t3 ON t2.OrderID = t3.OrderID
        JOIN
    products  t4 ON t3.ProductID = t4.ProductID
GROUP BY 1
HAVING TotalSpent > 10000;

-- Question 13 (Marks: 5)
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

-- Write your SQL solution here
SELECT 
    t1.OrderID, SUM(t2.Quantity * t3.Price) AS OrderValue
FROM
    orders t1
        JOIN
    orderdetails t2 ON t1.OrderID = t2.OrderID
        JOIN
    products t3 ON t2.ProductID = t3.ProductID
GROUP BY 1
HAVING OrderValue > 2000;

-- Question 14 (Marks: 5)
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

-- Write your SQL solution here
SELECT 
    t1.CustomerName,
    t2.OrderID,
    SUM(t3.Quantity * t4.Price) AS TotalValue
FROM
    customers t1
        JOIN
    orders t2 ON t1.CustomerID = t2.CustomerID
        JOIN
    orderdetails t3 ON t2.OrderID = t3.OrderID
        JOIN
    products t4 ON t3.ProductID = t4.ProductID
GROUP BY t2.OrderID
HAVING TotalValue = (SELECT 
        MAX(OrderTotal)
    FROM
        (SELECT 
            SUM(t6.Quantity * t7.Price) AS OrderTotal
        FROM
            orders t5
        JOIN orderdetails t6 ON t5.OrderID = t6.OrderID
        JOIN products t7 ON t6.ProductID = t7.ProductID
        GROUP BY t5.OrderID) t8);

-- Question 15 (Marks: 5)
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

-- Write your SQL solution here
SELECT 
    t.ProductName
FROM
    products t
WHERE
    t.ProductID NOT IN (SELECT DISTINCT
            t1.ProductID
        FROM
            orderdetails t1);
