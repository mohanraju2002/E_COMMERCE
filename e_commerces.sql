-- =========================================
-- E-Commerce Sales Analysis System
-- =========================================

-- 1. CREATE DATABASE
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- =========================================
-- 2. CREATE TABLES
-- =========================================

-- Customers Table
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50),
    JoinDate DATE
);

-- Products Table
CREATE TABLE Products
(
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQty INT
);

-- Orders Table
CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10,2),

    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments Table
CREATE TABLE Payments
(
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(30),

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- =========================================
-- 3. INSERT SAMPLE DATA
-- =========================================

-- Customers
INSERT INTO Customers (CustomerName, Email, City, JoinDate)
VALUES
('Ravi Kumar', 'ravi@gmail.com', 'Hyderabad', '2024-01-10'),
('Priya Sharma', 'priya@gmail.com', 'Bangalore', '2024-02-15'),
('Amit Verma', 'amit@gmail.com', 'Chennai', '2024-03-20'),
('Sneha Reddy', 'sneha@gmail.com', 'Mumbai', '2024-04-05');

-- Products
INSERT INTO Products (ProductName, Category, Price, StockQty)
VALUES
('Laptop', 'Electronics', 55000, 20),
('Mobile', 'Electronics', 25000, 50),
('Shoes', 'Fashion', 3000, 100),
('Watch', 'Accessories', 5000, 40);

-- Orders
INSERT INTO Orders (CustomerID, ProductID, OrderDate, Quantity, TotalAmount)
VALUES
(1, 1, '2024-05-01', 1, 55000),
(2, 2, '2024-05-02', 2, 50000),
(3, 3, '2024-05-03', 3, 9000),
(4, 4, '2024-05-04', 2, 10000),
(1, 2, '2024-05-10', 1, 25000);


-- Payments
INSERT INTO Payments (OrderID, PaymentDate, PaymentMethod, PaymentStatus)
VALUES
(1, '2024-05-01', 'UPI', 'Completed'),
(2, '2024-05-02', 'Card', 'Completed'),
(3, '2024-05-03', 'Cash', 'Pending'),
(4, '2024-05-04', 'UPI', 'Completed'),
(5, '2024-05-10', 'Net Banking', 'Completed');


select * from  customers
select * from products
select * from  orders
select  * from payments


-- =========================================
-- 4. MONTHLY SALES REPORT
-- =========================================

select  (orderdate),sum(totalamount) as total,avg(totalamount) as average from orders
group by  (orderdate)

SELECT 
    MONTH(OrderDate) AS MonthNumber,
    SUM(TotalAmount) AS TotalSales,
    AVG(TotalAmount) AS AverageSales
FROM Orders
GROUP BY MONTH(OrderDate);


-- =========================================
-- 5. TOP-SELLING PRODUCTS
-- =========================================


select p.productname,sum(o.quantity) as total_quantity
from Products p
inner join Orders o
on p.ProductID=o.ProductID
group by  p.productname
order by  total_quantity desc

-- =========================================
-- 6. CUSTOMER SEGMENTATION
-- High Value Customers (Spent > 30000)
-- =========================================

select c.customername,sum(o.totalamount) as  totalspent
from Customers c
inner join Orders o
on c.CustomerID=o.CustomerID
group by c.customername
having  sum(o.totalamount) >30000


-- =========================================
-- 7. SUBQUERY EXAMPLE
-- Find Customers Who Purchased Laptop
-- =========================================

select c.customerid,c.customername,p.productname
from Customers c 
inner join orders o on c.CustomerID=o.CustomerID
inner join Products p on o.ProductID=p.ProductID
where productname='laptop'

-- =========================================
-- 8. CTE EXAMPLE
-- =========================================

with cte as
(
select customerid,sum(totalamount) as totalsales from Orders
group by CustomerID
)
select * from cte
where totalsales >20000

-- =========================================
-- 9. INDEX FOR PERFORMANCE
-- =========================================


create index customer_id on customers(customerid)

select * from customers where CustomerID=2


create index product_id on products(productid)

select * from products where productid=2


create index order_id on orders(orderid)

select * from orders  where orderid=2

create index payment_id on payments (paymentid)

select * from payments where paymentid=1