# Library Management System

# Project Overview

This is a SQL-based Library Management System project developed using Microsoft SQL Server. The project is designed to manage books, customers, and orders while performing different SQL operations for data analysis and reporting.

The main objective of this project was to practice database design, data importing, joins, aggregate functions, and real-world business queries using SQL.

# Database Schema

The project contains the following tables:

# Books

Stores information about books available in the library.

Columns:

* Book_ID
* Title
* Author
* Genre
* Published_Year
* Price
* Stock

# Customers

Stores customer details.

Columns:

* Customer_ID
* Name
* Email
* Phone
* City
* Country

# Orders

Stores information about book orders.

Columns:

* Order_ID
* Customer_ID
* Book_ID
* Order_Date
* Quantity
* Total_Amount
* 
# Concepts Used

* Database Creation
* Table Creation
* Primary Keys
* Foreign Keys
* BULK INSERT
* SELECT Statements
* WHERE Clause
* ORDER BY
* GROUP BY
* HAVING Clause
* Aggregate Functions
* Joins
* Subqueries
* Inventory Analysis
* Sales Analysis

# Data Import

The data was imported from CSV files using SQL Server's BULK INSERT command.

Files Used:

* Books.csv
* Customers.csv
* Orders.csv

Example:

BULK INSERT Books
FROM 'D:\Books.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

## SQL Queries Performed

# Basic Queries

1. Retrieve all books in the Fiction genre.
2. Find books published after 1950.
3. List all customers from Canada.
4. Show orders placed in November 2023.
5. Retrieve total stock available.
6. Find the most expensive book.
7. Find customers who ordered more than one quantity.
8. Retrieve books with price greater than $20.
9. List all available genres.
10. Find books with the lowest stock.
11. Calculate total revenue generated.

# Aggregate Functions & Grouping

12. Find total books sold for each genre.
13. Find average book price in Fantasy genre.
14. List customers who placed at least two orders.
15. Find total quantity of books sold by each author.

# Joins

16. Find the most frequently ordered book.
17. Display customer details with total number of orders.
18. List cities where customers spent more than $30.
19. Find the customer who spent the highest amount.

# Inventory Analysis

20. Calculate remaining stock after fulfilling all orders.

## Sample SQL Query

# Find Customers Who Placed At Least Two Orders

SELECT Customer_ID
FROM Orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) >= 2;


# Find Most Frequently Ordered Book

SELECT B.Title,
       SUM(O.Quantity) AS Total_Orders
FROM Orders O
JOIN Books B
ON O.Book_ID = B.Book_ID
GROUP BY B.Title
ORDER BY Total_Orders DESC;

## Key Insights Generated

* Identified the most popular books.
* Calculated total revenue generated through orders.
* Found high-spending customers.
* Analyzed sales by genre and author.
* Tracked inventory after book sales.
* Identified customers with multiple purchases.

## Learning Outcomes

Through this project, I gained practical experience in:

* Relational Database Design
* Writing SQL Queries
* Data Importing using BULK INSERT
* Working with Joins
* Aggregate Functions
* GROUP BY and HAVING
* Sales and Inventory Analysis
* Problem Solving using SQL

## Technologies Used

* Microsoft SQL Server
* SQL
* CSV Files

## Future Improvements

1. Add stored procedures
2. Add triggers for inventory updates
3. Create views for reporting
4. Develop a Power BI dashboard for visualization
5. Build a front-end application for users

## Author

Ratan Swami

Aspiring Data Analyst | SQL | Power BI | Python

LinkedIn:
https://www.linkedin.com/in/ratan-swami-880b37322


This project was created as part of my SQL learning journey to strengthen database management and data analysis skills.
