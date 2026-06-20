-- =======================================================
-- TASK 4: SQL FOR DATA ANALYSIS (E-COMMERCE DATA SYSTEM)
-- =======================================================

-- 1. SCHEMA ARCHITECTURE & SETUP
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    city TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT,
    category TEXT,
    price REAL,
    stock_quantity INTEGER
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    order_date TEXT,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 2. SEED SAMPLE RECORDS
INSERT INTO customers (first_name, last_name, email, city) VALUES
('Rahul', 'Sharma', 'rahul@email.com', 'Delhi'),
('Amit', 'Verma', 'amit@email.com', 'Mumbai'),
('Priya', 'Singh', 'priya@email.com', 'Patna'),
('Sneha', 'Reddy', 'sneha@email.com', 'Bangalore'),
('Vikram', 'Kumar', 'vikram@email.com', 'Delhi');

INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop', 'Electronics', 55000.00, 10),
('Smartphone', 'Electronics', 25000.00, 25),
('Wireless Headphones', 'Accessories', 3000.00, 50),
('Running Shoes', 'Footwear', 4500.00, 15),
('Coffee Maker', 'Appliances', 6000.00, 8);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2026-06-01', 58000.00),
(2, '2026-06-02', 25000.00),
(3, '2026-06-03', 7500.00),
(1, '2026-06-04', 3000.00),
(4, '2026-06-05', 61000.00);

-- =======================================================
-- CORE ASSIGNMENT QUERY DELIVERABLES
-- =======================================================

-- [Requirement a]: SELECT, GROUP BY & ORDER BY
SELECT category, AVG(price) AS average_price, COUNT(*) AS total_products
FROM products
GROUP BY category;

-- [Requirement b]: RELATIONSHIP JOINING VIA LEFT JOIN
SELECT c.customer_id, c.first_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- [Requirement c & d]: DATA INFERENCE VIA SUBQUERY & AGGREGATES
SELECT product_name, price 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);

-- [Requirement e]: REUSABLE BUSINESS VIEW CREATION
CREATE VIEW view_sales_summary AS
SELECT o.order_id, c.first_name || ' ' || c.last_name AS customer_name, o.total_amount
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id;

-- [Requirement f]: SYSTEM OPTIMIZATION WITH INDEXES
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_customer_email ON customers(email);
