
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- Import data from Books table

BULK INSERT Books
FROM 'C:\Users\Lenove\Desktop\BulkData\Books.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

-- Insert Data Into Customers      

BULK INSERT Customers
FROM 'C:\Users\Lenove\Desktop\BulkData\Customers.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);  

-- Insert Data Into Orders

BULK INSERT Orders
FROM 'C:\Users\Lenove\Desktop\BulkData\Orders.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

SELECT * FROM Books
SELECT * FROM Orders
SELECT * FROM Customers


-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books
WHERE Genre = 'Fiction';

SELECT *,
       COUNT(*) OVER() AS Fiction_Count
FROM Books
WHERE Genre = 'Fiction';

-- 2) Find books published after the year 1950:

SELECT * FROM Books
WHERE Published_Year > 1950;

SELECT *,
         COUNT(*) OVER() AS Total
FROM Books
WHERE Published_Year > 1950


-- 3) List all customers from the Canada:

SELECT * FROM Customers
WHERE Country LIKE '%Canada%';

-- 4) Show orders placed in November 2023:

SELECT * FROM Orders
WHERE Order_Date BETWEEN 2023-11-01 AND 2023-11-31;

SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30'
ORDER BY Order_Date;

SELECT COUNT(Order_Date) FROM ORDERS 
WHERE Order_Date
BETWEEN '2023-11-01' AND '2023-11-30'

-- 5) Retrieve the total stock of books available:

SELECT Book_ID,sum(Stock) AS Total_count 
FROM Books
GROUP BY Book_ID

-- 6) Find the details of the most expensive book:

SELECT TOP 5 * FROM Books
ORDER BY Price DESC

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT COUNT(*)
FROM (
      SELECT Customer_ID
      FROM Orders
      GROUP BY Customer_ID
      HAVING SUM(Quantity) > 1
     ) AS T;

SELECT Customer_ID,SUM(Quantity)
FROM Orders
GROUP BY Customer_ID
HAVING SUM(Quantity) > 1

SELECT COUNT(*) FROM(
SELECT Customer_ID,Quantity
FROM Orders
WHERE Quantity > 1) AS T

SELECT Customer_ID,Quantity
FROM Orders
WHERE Quantity > 1

select * from Customers;

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Books
WHERE Price > 20;

-- 9) List all genres available in the Books table:

SELECT DISTINCT Genre FROM Books;


-- 10) Find the book with the lowest stock:

SELECT TOP 5 * FROM Books
ORDER BY Stock ASC

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(Total_Amount) FROM Orders

-- 1) Retrieve the total number of books sold for each genre:

SELECT b.Genre,SUM(Quantity) AS Total_Book_Sold
FROM Orders o
JOIN Books b 
ON o.Book_ID = b.Book_ID
GROUP BY b.Genre

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT Genre,AVG(Price) AS Avg_Price
FROM Books
WHERE Genre = 'Fantasy'
GROUP BY Genre

-- 3) List customers who have placed at least 2 orders:

SELECT Customer_ID,COUNT(Order_ID) AS Order_Count 
FROM Orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) >= 2

select * from Customers

SELECT o.customer_id, c.name,c.phone, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name,c.Phone
HAVING COUNT(Order_id) >= 2;

-- 4) Find the most frequently ordered book:

SELECT TOP 1 o.Book_ID,b.Title,COUNT(o.Order_ID) AS TotalOrders
FROM Orders o
JOIN Books b on o.Book_ID = b.Book_ID
GROUP BY o.Book_ID,b.Title
ORDER BY TotalOrders DESC;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT TOP 3 * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC


-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.Author,SUM(o.Quantity) AS Total_Book_Sold
FROM Orders o
JOIN Books b ON b.Book_ID = o.Book_ID
GROUP BY b.Author

-- 7) List the cities where customers who spent over $30 are located:

SELECT c.City,o.Total_Amount FROM 
Orders o 
JOIN Customers c ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30
ORDER BY Total_Amount DESC

-- 8) Find the customer who spent the most on orders:

SELECT o.Customer_ID,c.Name,SUM(o.Total_Amount) AS Most_Spent 
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY o.Customer_ID,c.Name
order by Most_Spent desc

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock - COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;

