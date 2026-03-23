#  Online Bookstore SQL Analysis Project

##  Project Overview
This project focuses on analyzing an online bookstore dataset using SQL. The goal is to extract meaningful insights related to sales performance, customer behavior, and inventory management.

The analysis is performed using PostgreSQL, covering data extraction, aggregation, joins, and advanced analytical queries.

---

##  Objectives
- Analyze sales and revenue trends  
- Identify top-performing books and genres  
- Understand customer purchasing behavior  
- Evaluate inventory and stock levels  
- Generate business insights from raw data  

---

##  Dataset Description

The project consists of three main tables:

###  Books
- Book_ID (Primary Key)  
- Title  
- Author  
- Genre  
- Published_Year  
- Price  
- Stock  

###  Customers
- Customer_ID (Primary Key)  
- Name  
- Email  
- Phone  
- City  
- Country  

###  Orders
- Order_ID (Primary Key)  
- Customer_ID (Foreign Key)  
- Book_ID (Foreign Key)  
- Order_Date  
- Quantity  
- Total_Amount  

---

##  Tools & Technologies
- SQL (PostgreSQL)  
- Relational Database Concepts  
- Data Analysis Techniques  

---

##  Key Analysis Performed

###  Basic Analysis
- Filtering books by genre and publication year  
- Identifying customers by location  
- Analyzing orders by date  
- Calculating total stock and revenue  

###  Intermediate Analysis
- Total books sold by genre  
- Average book price by category  
- Customers with multiple orders  
- Most frequently ordered books  

###  Advanced Analysis
- Revenue ranking by genre (Window Functions)  
- Monthly revenue trend analysis  
- Top customers by country  
- Revenue contribution percentage by genre  
- Identification of inactive customers  
- Running total of revenue over time  

---

## Key Business Insights

###  Revenue & Sales
- Certain genres contribute significantly more to total revenue, indicating strong customer preference  
- Revenue trends over time help identify business growth patterns and potential seasonality  

###  Customer Behavior
- A small group of customers contributes a large portion of total revenue (high-value customers)  
- Some customers have never placed orders, representing potential opportunities for targeted marketing  

###  Product Performance
- Some books are ordered more frequently, indicating high demand  
- Genre-level analysis highlights which categories drive business success  

###  Inventory Insights
- Stock analysis reveals which books are running low and require restocking  
- Helps in maintaining optimal inventory levels and avoiding stockouts  

---

##  Advanced SQL Concepts Used
- JOINs (INNER JOIN, LEFT JOIN)  
- GROUP BY and HAVING  
- Aggregate Functions (SUM, AVG, COUNT)  
- Window Functions (RANK, SUM OVER)  
- COALESCE for NULL handling  
- DATE_TRUNC for time-based analysis  

---

##  Conclusion
This project demonstrates the ability to analyze relational datasets using SQL and extract actionable business insights. It showcases strong understanding of SQL fundamentals, data relationships, and analytical thinking required for data analyst roles.

---
 
