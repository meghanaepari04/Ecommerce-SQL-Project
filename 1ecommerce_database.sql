-- SQL for E-commerce Database Management System
-- Full DDL + DML + sample queries (Cart & Shipping removed)

------------------------------------------------------------
-- CLEAN UP: DROP TABLES
------------------------------------------------------------
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

------------------------------------------------------------
-- CREATE TABLE: CUSTOMERS
------------------------------------------------------------
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

------------------------------------------------------------
-- CREATE TABLE: CATEGORIES
------------------------------------------------------------
CREATE TABLE categories (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

------------------------------------------------------------
-- CREATE TABLE: PRODUCTS
------------------------------------------------------------
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    category_id VARCHAR(10),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

------------------------------------------------------------
-- CREATE TABLE: ORDERS
------------------------------------------------------------
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

------------------------------------------------------------
-- CREATE TABLE: ORDER DETAILS
------------------------------------------------------------
CREATE TABLE order_details (
    order_detail_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

------------------------------------------------------------
-- CREATE TABLE: PAYMENTS
------------------------------------------------------------
CREATE TABLE payments (
    payment_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

------------------------------------------------------------
-- INSERT CUSTOMERS
------------------------------------------------------------
INSERT INTO customers VALUES
('c1', 'Alice Smith', 'alice@example.com', '555-0101'),
('c2', 'Bob Johnson', 'bob@example.com', '555-0102'),
('c3', 'Charlie Lee', 'charlie@example.com', '555-0103');

------------------------------------------------------------
-- INSERT CATEGORIES
------------------------------------------------------------
INSERT INTO categories VALUES
('cat1', 'Electronics'),
('cat2', 'Accessories'),
('cat3', 'Computer Peripherals');

------------------------------------------------------------
-- INSERT PRODUCTS
------------------------------------------------------------
INSERT INTO products VALUES
('p1', 'Laptop', 1200.00, 10, 'cat1'),
('p2', 'Mouse', 25.00, 50, 'cat2'),
('p3', 'Keyboard', 75.00, 30, 'cat3'),
('p4', 'Monitor', 300.00, 0, 'cat1'),
('p5', 'Headphones', 150.00, 20, 'cat2');

------------------------------------------------------------
-- INSERT ORDERS
------------------------------------------------------------
INSERT INTO orders VALUES
('o1001', 'c1', '2023-10-15 10:30:00', 'Shipped'),
('o1002', 'c2', '2023-10-18 14:45:00', 'Processing'),
('o1003', 'c1', '2023-11-01 09:15:00', 'Delivered'),
('o1004', 'c3', '2023-11-05 11:00:00', 'Shipped'),
('o1005', 'c2', '2023-11-07 16:20:00', 'Pending');

------------------------------------------------------------
-- INSERT ORDER DETAILS
------------------------------------------------------------
INSERT INTO order_details VALUES
('od1', 'o1001', 'p1', 1, 1200.00),
('od2', 'o1001', 'p2', 1, 25.00),
('od3', 'o1002', 'p3', 1, 75.00),
('od4', 'o1002', 'p5', 1, 150.00),
('od5', 'o1003', 'p2', 2, 25.00),
('od6', 'o1004', 'p4', 1, 300.00),
('od7', 'o1005', 'p1', 1, 1200.00);

------------------------------------------------------------
-- INSERT PAYMENTS
------------------------------------------------------------
INSERT INTO payments VALUES
('pay1', 'o1001', 1225.00, '2023-10-15 10:32:00', 'Credit Card'),
('pay2', 'o1002', 225.00, '2023-10-18 14:46:00', 'PayPal'),
('pay3', 'o1003', 50.00, '2023-11-01 09:16:00', 'Credit Card'),
('pay4', 'o1004', 300.00, '2023-11-05 11:01:00', 'PayPal'),
('pay5', 'o1005', 1200.00, '2023-11-07 16:21:00', 'Credit Card');

------------------------------------------------------------
-- EXAMPLE QUERIES
------------------------------------------------------------

-- 1. Orders placed by customer 'c1'
SELECT
    o.order_id,
    o.order_date,
    o.status,
    p.name AS product_name,
    od.quantity,
    od.unit_price
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE o.customer_id = 'c1';

-- 2. Total revenue for October 2023
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE MONTH(payment_date) = 10 AND YEAR(payment_date) = 2023;

-- 3. Out of stock products
SELECT product_id, name, price
FROM products
WHERE stock = 0;

-- 4. Update customer information
UPDATE customers
SET phone = '555-0199'
WHERE customer_id = 'c3';

