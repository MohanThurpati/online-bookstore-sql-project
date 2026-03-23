-- Create Database 
CREATE DATABASE OnlineBookstore;

-- Switch to the database
    OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:\SQL Practice Files\All Excel Practice Files\Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\SQL Practice Files\All Excel Practice Files\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\SQL Practice Files\All Excel Practice Files\Orders.csv' 
CSV HEADER;

-- Basic Questions : 

-- Check for NULL values 
SELECT * FROM Books
WHERE Book_ID IS NULL OR Title IS NULL OR 
      Author IS NULL OR Genre IS NULL OR 
	  Published_Year IS NULL OR Price IS NULL OR Stock  IS NULL ;

SELECT * FROM Customers
WHERE Customer_ID IS NULL OR Name IS NULL OR 
      Email IS NULL OR Phone IS NULL OR 
	  City IS NULL OR Country IS NULL ;

SELECT * FROM Orders
WHERE Order_ID IS NULL OR Customer_ID IS NULL OR   
      Book_ID IS NULL OR Order_Date IS NULL OR 
	  Quantity IS NULL OR Total_Amount IS NULL ;

-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books 
WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_year>1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE country='Canada';


-- 4) Show orders placed in November 2023:

SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;


-- 6) Find the details of the most expensive book:
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1;



-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;



-- 9) List all genres available in the Books table:
SELECT DISTINCT genre
   FROM Books;


-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;



-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.Genre, sum(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;




-- 4) Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;



-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;


-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id 
ORDER BY b.book_id;

--10) Rank genres based on revenue: 
--(To Find Revenue Based On Genres and assigning ranks)
 SELECT b.genre,SUM(o.total_amount) as Revenue,
 RANK() OVER (order by SUM(o.total_amount) desc) AS rank
 FROM Books b JOIN Orders o ON b.book_id=o.book_id
 GROUP BY b.genre;
 


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
 --11)Find the monthly revenue trend over time: 
 --(Helps understand business growth and seasonal patterns)
SELECT  date_trunc('month',order_date)::DATE AS Months,
SUM(total_amount) AS Monthly_Revenue
FROM orders
GROUP BY  months
ORDER BY  months ;
	 

--Find the top 3 highest-spending customers in each country:
--(Identifies valuable customers across different regions)
SELECT * FROM(
SELECT c.customer_id,c.name,c.country,SUM(o.total_amount) AS Total_Spent,
RANK()OVER(PARTITION BY c.country ORDER BY SUM(o.total_amount) DESC) AS Ranks
FROM Customers c JOIN Orders o USING (customer_id)
GROUP BY c.customer_id,c.name,c.country
)t
WHERE ranks<=3;

--13)Find the percentage contribution of each genre to total revenue:
--(Shows which genres generate the most revenue)
SELECT b.genre,sum(o.total_amount) AS Revenue,
ROUND(SUM(o.total_amount)*100.0/SUM(SUM(o.total_amount)) OVER(),2) AS Percentage_Contribution
FROM Books b JOIN Orders o USING(book_id)
GROUP BY b.genre;


--14)Find customers who have never placed any orders:
--(Helps identify inactive customers for marketing strategies)
SELECT c.*
FROM Customers c LEFT JOIN Orders o USING (customer_id)
WHERE o.order_id IS NULL
ORDER BY c.customer_id ;

--15)Find the running total of revenue over time:
--(Tracks cumulative revenue growth of the business)
SELECT order_date,total_amount,
SUM(total_amount) OVER(ORDER BY order_date ) AS Running_Total 
FROM Orders;



