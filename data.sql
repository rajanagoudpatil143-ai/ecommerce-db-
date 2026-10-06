USE ecommerce_db;

-- ============================================
-- CATEGORY DATA
-- ============================================

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen'),
('Sports');


-- ============================================
-- CUSTOMER DATA
-- ============================================

INSERT INTO customers
(customer_name, email, city, signup_date)
VALUES
('Rahul Sharma', 'rahul.sharma@gmail.com', 'Bangalore', '2025-01-10'),
('Priya Patel', 'priya.patel@gmail.com', 'Mumbai', '2025-01-15'),
('Arjun Kumar', 'arjun.kumar@gmail.com', 'Delhi', '2025-02-05'),
('Sneha Rao', 'sneha.rao@gmail.com', 'Bangalore', '2025-02-18'),
('Vikram Singh', 'vikram.singh@gmail.com', 'Pune', '2025-03-01'),
('Ananya Das', 'ananya.das@gmail.com', 'Kolkata', '2025-03-15'),
('Rohan Mehta', 'rohan.mehta@gmail.com', 'Hyderabad', '2025-04-02'),
('Kavya Nair', 'kavya.nair@gmail.com', 'Chennai', '2025-04-20'),
('Aditya Jain', 'aditya.jain@gmail.com', 'Jaipur', '2025-05-10'),
('Meera Joshi', 'meera.joshi@gmail.com', 'Bangalore', '2025-05-25'),
('Karan Shah', 'karan.shah@gmail.com', 'Ahmedabad', '2025-06-05'),
('Pooja Verma', 'pooja.verma@gmail.com', 'Delhi', '2025-06-18'),
('Nikhil Rao', 'nikhil.rao@gmail.com', 'Bangalore', '2025-07-01'),
('Divya Menon', 'divya.menon@gmail.com', 'Kochi', '2025-07-12'),
('Manish Gupta', 'manish.gupta@gmail.com', 'Lucknow', '2025-08-01');


-- ============================================
-- PRODUCT DATA
-- ============================================

INSERT INTO products
(product_name, category_id, price, stock_quantity)
VALUES
('Wireless Headphones', 1, 2499.00, 50),
('Smart Watch', 1, 3999.00, 35),
('Bluetooth Speaker', 1, 1999.00, 40),
('USB-C Charger', 1, 899.00, 100),
('Wireless Mouse', 1, 1299.00, 75),

('Men T-Shirt', 2, 799.00, 80),
('Women Hoodie', 2, 1499.00, 60),
('Running Shoes', 2, 2999.00, 45),
('Denim Jeans', 2, 1999.00, 55),
('Formal Shirt', 2, 1299.00, 70),

('SQL Mastery Book', 3, 699.00, 70),
('Python Programming', 3, 899.00, 55),
('Machine Learning Guide', 3, 1199.00, 40),
('Data Structures Book', 3, 799.00, 65),

('Coffee Maker', 4, 2499.00, 30),
('Non-Stick Pan', 4, 1299.00, 50),
('Electric Kettle', 4, 1599.00, 40),
('Mixer Grinder', 4, 3499.00, 25),

('Cricket Bat', 5, 2499.00, 25),
('Football', 5, 999.00, 45),
('Badminton Racket', 5, 1799.00, 35),
('Yoga Mat', 5, 699.00, 80);


-- ============================================
-- ORDER DATA
-- ============================================

INSERT INTO orders
(customer_id, order_date, status)
VALUES
(1,  '2025-01-15', 'Completed'),
(2,  '2025-01-20', 'Completed'),
(3,  '2025-01-28', 'Completed'),

(1,  '2025-02-10', 'Completed'),
(4,  '2025-02-15', 'Completed'),
(5,  '2025-02-22', 'Completed'),

(2,  '2025-03-05', 'Completed'),
(6,  '2025-03-12', 'Completed'),
(7,  '2025-03-20', 'Completed'),

(8,  '2025-04-05', 'Completed'),
(3,  '2025-04-15', 'Completed'),
(9,  '2025-04-25', 'Completed'),

(10, '2025-05-02', 'Completed'),
(1,  '2025-05-15', 'Completed'),
(5,  '2025-05-25', 'Completed'),

(7,  '2025-06-05', 'Completed'),
(11, '2025-06-15', 'Completed'),
(12, '2025-06-25', 'Completed'),

(13, '2025-07-05', 'Completed'),
(4,  '2025-07-15', 'Completed'),
(8,  '2025-07-25', 'Completed'),

(2,  '2025-08-05', 'Completed'),
(9,  '2025-08-15', 'Completed'),
(14, '2025-08-25', 'Completed'),

(1,  '2025-09-05', 'Completed'),
(5,  '2025-09-15', 'Completed'),
(10, '2025-09-25', 'Completed'),

(6,  '2025-10-05', 'Completed'),
(15, '2025-10-15', 'Completed'),
(3,  '2025-10-25', 'Completed'),

(7,  '2025-11-05', 'Completed'),
(11, '2025-11-15', 'Completed'),
(13, '2025-11-25', 'Completed'),

(2,  '2025-12-05', 'Completed'),
(4,  '2025-12-15', 'Completed'),
(8,  '2025-12-25', 'Completed'),

(1,  '2025-12-28', 'Cancelled'),
(6,  '2025-11-28', 'Cancelled');


-- ============================================
-- ORDER ITEMS DATA
-- ============================================

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES

-- Order 1
(1, 1, 2, 2499.00),
(1, 11, 1, 699.00),

-- Order 2
(2, 2, 1, 3999.00),
(2, 6, 2, 799.00),

-- Order 3
(3, 3, 2, 1999.00),
(3, 12, 1, 899.00),

-- Order 4
(4, 8, 1, 2999.00),
(4, 13, 1, 1199.00),

-- Order 5
(5, 1, 1, 2499.00),
(5, 4, 2, 899.00),

-- Order 6
(6, 15, 1, 2499.00),
(6, 16, 2, 1299.00),

-- Order 7
(7, 2, 1, 3999.00),
(7, 7, 1, 1499.00),

-- Order 8
(8, 19, 1, 2499.00),
(8, 20, 2, 999.00),

-- Order 9
(9, 1, 3, 2499.00),
(9, 11, 2, 699.00),

-- Order 10
(10, 6, 2, 799.00),
(10, 8, 1, 2999.00),

-- Order 11
(11, 13, 2, 1199.00),
(11, 12, 1, 899.00),

-- Order 12
(12, 3, 1, 1999.00),
(12, 4, 3, 899.00),

-- Order 13
(13, 15, 1, 2499.00),
(13, 17, 1, 1599.00),

-- Order 14
(14, 2, 2, 3999.00),
(14, 1, 1, 2499.00),

-- Order 15
(15, 19, 2, 2499.00),
(15, 22, 2, 699.00),

-- Order 16
(16, 8, 2, 2999.00),
(16, 6, 2, 799.00),

-- Order 17
(17, 9, 2, 1999.00),
(17, 10, 1, 1299.00),

-- Order 18
(18, 7, 2, 1499.00),
(18, 11, 1, 699.00),

-- Order 19
(19, 1, 1, 2499.00),
(19, 2, 1, 3999.00),

-- Order 20
(20, 15, 1, 2499.00),
(20, 18, 1, 3499.00),

-- Order 21
(21, 3, 2, 1999.00),
(21, 5, 1, 1299.00),

-- Order 22
(22, 2, 2, 3999.00),
(22, 8, 1, 2999.00),

-- Order 23
(23, 13, 1, 1199.00),
(23, 14, 2, 799.00),

-- Order 24
(24, 6, 3, 799.00),
(24, 9, 1, 1999.00),

-- Order 25
(25, 1, 2, 2499.00),
(25, 4, 2, 899.00),

-- Order 26
(26, 19, 1, 2499.00),
(26, 20, 2, 999.00),

-- Order 27
(27, 7, 2, 1499.00),
(27, 22, 2, 699.00),

-- Order 28
(28, 12, 2, 899.00),
(28, 13, 1, 1199.00),

-- Order 29
(29, 17, 1, 1599.00),
(29, 18, 1, 3499.00),

-- Order 30
(30, 3, 2, 1999.00),
(30, 15, 1, 2499.00),

-- Order 31
(31, 8, 2, 2999.00),
(31, 5, 2, 1299.00),

-- Order 32
(32, 1, 1, 2499.00),
(32, 2, 1, 3999.00),

-- Order 33
(33, 6, 2, 799.00),
(33, 10, 1, 1299.00),

-- Order 34
(34, 2, 1, 3999.00),
(34, 3, 2, 1999.00),

-- Order 35
(35, 11, 2, 699.00),
(35, 12, 1, 899.00),

-- Order 36
(36, 15, 1, 2499.00),
(36, 16, 2, 1299.00),

-- Order 37 - Cancelled
(37, 1, 1, 2499.00),
(37, 2, 1, 3999.00),

-- Order 38 - Cancelled
(38, 8, 1, 2999.00),
(38, 19, 1, 2499.00);