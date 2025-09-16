-- =====================================================
-- Complete Database Schema for Scripting Language Course
-- Includes all tables needed for PHP MySQL examples
-- =====================================================

-- Create the database
CREATE DATABASE IF NOT EXISTS scripting_course;
USE scripting_course;

-- =====================================================
-- TABLE DEFINITIONS
-- =====================================================

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    age INT,
    phone VARCHAR(20),
    address TEXT,
    country VARCHAR(50) DEFAULT 'Nepal',
    status ENUM('active', 'inactive') DEFAULT 'active',
    role ENUM('admin', 'editor', 'subscriber', 'member') DEFAULT 'member',
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted BOOLEAN DEFAULT 0,
    deleted_at TIMESTAMP NULL
);

-- Categories table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_id INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Brands table
CREATE TABLE brands (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    brand_id INT,
    sku VARCHAR(50) UNIQUE,
    weight DECIMAL(5,2),
    dimensions VARCHAR(50),
    image_url VARCHAR(255),
    featured BOOLEAN DEFAULT 0,
    status ENUM('active', 'inactive', 'discontinued') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(id) ON DELETE SET NULL,
    INDEX idx_price (price),
    INDEX idx_category (category_id),
    INDEX idx_status (status)
);

-- Orders table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address TEXT,
    billing_address TEXT,
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'cash_on_delivery') DEFAULT 'cash_on_delivery',
    payment_status ENUM('pending', 'paid', 'failed', 'refunded') DEFAULT 'pending',
    order_status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    shipping_fee DECIMAL(8,2) DEFAULT 0.00,
    discount_amount DECIMAL(8,2) DEFAULT 0.00,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_customer (customer_id),
    INDEX idx_order_date (order_date),
    INDEX idx_status (order_status)
);

-- Order Items table (for products in each order)
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_order (order_id),
    INDEX idx_product (product_id)
);

-- Authors table (for book examples)
CREATE TABLE authors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    bio TEXT,
    birth_date DATE,
    nationality VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Books table
CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    isbn VARCHAR(20),
    price DECIMAL(8,2),
    pages INT,
    publication_date DATE,
    genre VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE SET NULL
);

-- Sessions table (for custom session handling)
CREATE TABLE sessions (
    id VARCHAR(128) PRIMARY KEY,
    data TEXT,
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Customers table (alternative users table for some examples)
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    membership_level ENUM('basic', 'premium', 'vip') DEFAULT 'basic',
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Featured products table (for JOIN examples)
CREATE TABLE featured_products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- User preferences table (for JSON examples in newer MySQL)
CREATE TABLE user_preferences (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    preferences JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =====================================================
-- SAMPLE DATA INSERTION
-- =====================================================

-- Insert Categories
INSERT INTO categories (name, description, parent_id) VALUES
('Electronics', 'Electronic devices and gadgets', NULL),
('Computers', 'Desktop and laptop computers', 1),
('Mobile Phones', 'Smartphones and basic phones', 1),
('Accessories', 'Electronic accessories', 1),
('Clothing', 'Apparel and fashion', NULL),
('Men Clothing', 'Clothing for men', 5),
('Women Clothing', 'Clothing for women', 5),
('Books', 'Books and literature', NULL),
('Home & Garden', 'Home improvement and gardening', NULL),
('Sports', 'Sports equipment and accessories', NULL);

-- Insert Brands
INSERT INTO brands (name, description) VALUES
('Apple', 'Premium electronics and technology'),
('Samsung', 'Korean electronics manufacturer'),
('Dell', 'Computer technology company'),
('HP', 'Hewlett-Packard technology solutions'),
('Nike', 'Athletic footwear and apparel'),
('Adidas', 'German sports apparel manufacturer'),
('Sony', 'Japanese electronics and entertainment'),
('Microsoft', 'Software and technology corporation'),
('Canon', 'Japanese imaging and optical products'),
('LG', 'South Korean electronics company');

-- Insert Users
INSERT INTO users (name, email, password, age, phone, address, country, status, role, last_login) VALUES
('John Doe', 'john@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 30, '9841234567', '123 Main St, Kathmandu', 'Nepal', 'active', 'admin', '2024-01-15 10:30:00'),
('Jane Smith', 'jane@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 28, '9841234568', '456 Oak Ave, Pokhara', 'Nepal', 'active', 'editor', '2024-01-14 14:20:00'),
('Bob Johnson', 'bob@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 35, '9841234569', '789 Pine Rd, Lalitpur', 'Nepal', 'active', 'member', '2024-01-13 09:15:00'),
('Alice Brown', 'alice@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 26, '9841234570', '321 Elm St, Bhaktapur', 'Nepal', 'active', 'subscriber', '2024-01-12 16:45:00'),
('Charlie Wilson', 'charlie@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 42, '9841234571', '654 Maple Dr, Chitwan', 'Nepal', 'inactive', 'member', '2023-12-20 11:30:00'),
('Diana Davis', 'diana@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 31, '9841234572', '987 Birch Ln, Biratnagar', 'Nepal', 'active', 'editor', '2024-01-10 13:22:00'),
('Edward Miller', 'edward@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 29, '9841234573', '147 Cedar St, Butwal', 'Nepal', 'active', 'member', '2024-01-11 08:17:00'),
('Fiona Taylor', 'fiona@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 33, '9841234574', '258 Spruce Ave, Dharan', 'Nepal', 'active', 'member', '2024-01-09 15:55:00'),
('George Anderson', 'george@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 38, NULL, '369 Willow Rd, Janakpur', 'Nepal', 'active', 'subscriber', '2024-01-08 12:40:00'),
('Helen Thomas', 'helen@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 27, '9841234576', '741 Poplar St, Nepalgunj', 'Nepal', 'active', 'member', '2024-01-07 17:33:00');

-- Insert Products
INSERT INTO products (name, description, price, stock, category_id, brand_id, sku, weight, featured, status) VALUES
('iPhone 14 Pro', 'Latest Apple smartphone with advanced camera', 1299.99, 25, 3, 1, 'APPL-IP14P-128', 0.21, 1, 'active'),
('MacBook Pro 16"', 'High-performance laptop for professionals', 2499.99, 15, 2, 1, 'APPL-MBP16-512', 2.1, 1, 'active'),
('Samsung Galaxy S23', 'Android smartphone with excellent display', 899.99, 30, 3, 2, 'SAMS-GS23-256', 0.19, 1, 'active'),
('Dell XPS 13', 'Ultrabook with premium build quality', 1199.99, 20, 2, 3, 'DELL-XPS13-512', 1.3, 0, 'active'),
('Sony WH-1000XM5', 'Noise-canceling wireless headphones', 399.99, 50, 4, 7, 'SONY-WH1000XM5', 0.25, 1, 'active'),
('iPad Air', 'Powerful tablet for work and creativity', 599.99, 35, 1, 1, 'APPL-IPAD-AIR-256', 0.46, 0, 'active'),
('Canon EOS R6', 'Professional mirrorless camera', 2499.99, 8, 1, 9, 'CANON-EOSR6-BODY', 0.68, 1, 'active'),
('Nike Air Max 270', 'Comfortable running shoes', 149.99, 100, 10, 5, 'NIKE-AM270-BLK-10', 0.4, 0, 'active'),
('HP Pavilion 15', 'Mid-range laptop for everyday use', 699.99, 40, 2, 4, 'HP-PAV15-256', 1.75, 0, 'active'),
('Samsung 4K Smart TV 55"', 'Ultra HD Smart Television', 799.99, 12, 1, 2, 'SAMS-TV55-4K', 15.8, 1, 'active'),
('Microsoft Surface Pro 9', '2-in-1 tablet and laptop', 1099.99, 18, 2, 8, 'MSFT-SP9-256', 0.88, 0, 'active'),
('AirPods Pro', 'Wireless earbuds with noise cancellation', 249.99, 75, 4, 1, 'APPL-APP-PRO', 0.06, 1, 'active'),
('Adidas Ultraboost 22', 'Premium running shoes', 179.99, 60, 10, 6, 'ADID-UB22-WHT-9', 0.35, 0, 'active'),
('LG OLED TV 65"', 'Premium OLED display television', 1999.99, 5, 1, 10, 'LG-OLED65-C2', 22.7, 1, 'active'),
('Gaming Mechanical Keyboard', 'RGB backlit gaming keyboard', 129.99, 45, 4, 3, 'DELL-KB-MECH-RGB', 1.2, 0, 'active'),
('Wireless Mouse', 'Ergonomic wireless mouse', 49.99, 80, 4, 4, 'HP-MOUSE-WL-ERG', 0.15, 0, 'active'),
('USB-C Hub', '7-in-1 USB-C hub with multiple ports', 79.99, 65, 4, 3, 'DELL-HUB-7IN1', 0.2, 0, 'active'),
('Bluetooth Speaker', 'Portable waterproof speaker', 89.99, 55, 4, 7, 'SONY-SPK-BT-WP', 0.45, 0, 'active'),
('Fitness Tracker', 'Health and fitness monitoring watch', 199.99, 70, 10, 2, 'SAMS-FIT-TRK-BLK', 0.08, 0, 'active'),
('External Hard Drive 2TB', 'Portable storage solution', 129.99, 35, 4, 4, 'HP-HDD-2TB-USB3', 0.3, 0, 'active');

-- Insert Authors
INSERT INTO authors (name, email, bio, birth_date, nationality) VALUES
('J.K. Rowling', 'jk@example.com', 'British author, best known for Harry Potter series', '1965-07-31', 'British'),
('Stephen King', 'stephen@example.com', 'American author of horror, supernatural fiction', '1947-09-21', 'American'),
('Agatha Christie', 'agatha@example.com', 'English writer known for detective novels', '1890-09-15', 'British'),
('Dan Brown', 'dan@example.com', 'American author of thriller fiction', '1964-06-22', 'American'),
('Paulo Coelho', 'paulo@example.com', 'Brazilian lyricist and novelist', '1947-08-24', 'Brazilian');

-- Insert Books
INSERT INTO books (title, author_id, isbn, price, pages, publication_date, genre) VALUES
('Harry Potter and the Philosopher Stone', 1, '9780747532699', 12.99, 223, '1997-06-26', 'Fantasy'),
('Harry Potter and the Chamber of Secrets', 1, '9780747538493', 12.99, 251, '1998-07-02', 'Fantasy'),
('The Shining', 2, '9780385121675', 15.99, 447, '1977-01-28', 'Horror'),
('It', 2, '9780670813028', 18.99, 1138, '1986-09-15', 'Horror'),
('Murder on the Orient Express', 3, '9780062693662', 14.99, 256, '1934-01-01', 'Mystery'),
('The Da Vinci Code', 4, '9780385504201', 16.99, 454, '2003-03-18', 'Thriller'),
('The Alchemist', 5, '9780061122415', 13.99, 163, '1988-01-01', 'Fiction');

-- Insert Customers (for JOIN examples)
INSERT INTO customers (name, email, membership_level, status) VALUES
('Premium Customer 1', 'premium1@example.com', 'premium', 'active'),
('VIP Customer 1', 'vip1@example.com', 'vip', 'active'),
('Basic Customer 1', 'basic1@example.com', 'basic', 'active'),
('Premium Customer 2', 'premium2@example.com', 'premium', 'inactive'),
('VIP Customer 2', 'vip2@example.com', 'vip', 'active');

-- Insert Orders
INSERT INTO orders (customer_id, order_date, total_amount, shipping_address, payment_method, payment_status, order_status, shipping_fee, discount_amount) VALUES
(1, '2024-01-15', 1549.98, '123 Main St, Kathmandu', 'credit_card', 'paid', 'delivered', 50.00, 0.00),
(2, '2024-01-14', 2749.98, '456 Oak Ave, Pokhara', 'paypal', 'paid', 'shipped', 75.00, 100.00),
(3, '2024-01-13', 699.99, '789 Pine Rd, Lalitpur', 'cash_on_delivery', 'pending', 'processing', 25.00, 25.00),
(1, '2024-01-12', 449.98, '123 Main St, Kathmandu', 'debit_card', 'paid', 'delivered', 30.00, 0.00),
(4, '2024-01-11', 179.99, '321 Elm St, Bhaktapur', 'credit_card', 'paid', 'delivered', 20.00, 0.00),
(5, '2024-01-10', 1999.99, '654 Maple Dr, Chitwan', 'paypal', 'paid', 'shipped', 100.00, 200.00),
(2, '2024-01-09', 329.98, '456 Oak Ave, Pokhara', 'credit_card', 'paid', 'delivered', 25.00, 0.00),
(6, '2024-01-08', 899.99, '987 Birch Ln, Biratnagar', 'debit_card', 'paid', 'delivered', 40.00, 0.00),
(3, '2024-01-07', 249.99, '789 Pine Rd, Lalitpur', 'cash_on_delivery', 'pending', 'pending', 15.00, 0.00),
(7, '2024-01-06', 1299.99, '147 Cedar St, Butwal', 'credit_card', 'paid', 'shipped', 60.00, 0.00),
(8, '2024-01-05', 599.99, '258 Spruce Ave, Dharan', 'paypal', 'paid', 'delivered', 35.00, 0.00),
(1, '2024-01-04', 149.99, '123 Main St, Kathmandu', 'credit_card', 'paid', 'delivered', 20.00, 0.00),
(9, '2024-01-03', 2499.99, '369 Willow Rd, Janakpur', 'debit_card', 'paid', 'processing', 80.00, 0.00),
(2, '2024-01-02', 129.99, '456 Oak Ave, Pokhara', 'credit_card', 'paid', 'delivered', 15.00, 0.00),
(10, '2024-01-01', 1199.99, '741 Poplar St, Nepalgunj', 'paypal', 'paid', 'shipped', 55.00, 50.00),
-- Adding some orders from 2023 for time-based queries
(1, '2023-12-25', 799.99, '123 Main St, Kathmandu', 'credit_card', 'paid', 'delivered', 40.00, 0.00),
(2, '2023-12-20', 399.99, '456 Oak Ave, Pokhara', 'paypal', 'paid', 'delivered', 25.00, 0.00),
(3, '2023-11-15', 1099.99, '789 Pine Rd, Lalitpur', 'credit_card', 'paid', 'delivered', 50.00, 0.00),
(4, '2023-10-10', 699.99, '321 Elm St, Bhaktapur', 'debit_card', 'paid', 'delivered', 35.00, 0.00),
(5, '2023-09-05', 2499.99, '654 Maple Dr, Chitwan', 'credit_card', 'paid', 'delivered', 100.00, 0.00);

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
-- Order 1: iPhone + MacBook
(1, 1, 1, 1299.99, 1299.99),
(1, 12, 1, 249.99, 249.99),
-- Order 2: MacBook + Samsung Galaxy
(2, 2, 1, 2499.99, 2499.99),
(2, 3, 1, 899.99, 899.99),
-- Order 3: Dell XPS
(3, 4, 1, 699.99, 699.99),
-- Order 4: Sony Headphones + AirPods
(4, 5, 1, 399.99, 399.99),
(4, 12, 1, 249.99, 249.99),
-- Order 5: Adidas Shoes
(5, 13, 1, 179.99, 179.99),
-- Order 6: LG OLED TV
(6, 14, 1, 1999.99, 1999.99),
-- Order 7: Gaming Keyboard + Mouse
(7, 15, 1, 129.99, 129.99),
(7, 16, 1, 49.99, 49.99),
(7, 17, 1, 79.99, 79.99),
(7, 18, 1, 89.99, 89.99),
-- Order 8: Samsung Galaxy
(8, 3, 1, 899.99, 899.99),
-- Order 9: AirPods Pro
(9, 12, 1, 249.99, 249.99),
-- Order 10: iPhone 14 Pro
(10, 1, 1, 1299.99, 1299.99),
-- Order 11: iPad Air
(11, 6, 1, 599.99, 599.99),
-- Order 12: Nike Shoes
(12, 8, 1, 149.99, 149.99),
-- Order 13: Canon Camera
(13, 7, 1, 2499.99, 2499.99),
-- Order 14: USB-C Hub
(14, 17, 1, 129.99, 129.99),
-- Order 15: Dell XPS 13
(15, 4, 1, 1199.99, 1199.99),
-- 2023 Orders
(16, 10, 1, 799.99, 799.99),
(17, 5, 1, 399.99, 399.99),
(18, 11, 1, 1099.99, 1099.99),
(19, 9, 1, 699.99, 699.99),
(20, 7, 1, 2499.99, 2499.99);

-- Insert Featured Products
INSERT INTO featured_products (product_id, start_date, end_date) VALUES
(1, '2024-01-01', '2024-01-31'),  -- iPhone 14 Pro
(2, '2024-01-01', '2024-02-29'),  -- MacBook Pro
(3, '2024-01-15', '2024-02-15'),  -- Samsung Galaxy S23
(5, '2024-01-01', '2024-01-31'),  -- Sony Headphones
(7, '2023-12-01', '2024-01-31'),  -- Canon Camera
(10, '2024-01-01', '2024-03-31'), -- Samsung TV
(12, '2024-01-01', '2024-01-31'), -- AirPods Pro
(14, '2023-12-15', '2024-02-15'); -- LG OLED TV

-- Insert User Preferences (JSON examples for MySQL 5.7+)
INSERT INTO user_preferences (user_id, preferences) VALUES
(1, '{"theme": "dark", "fontSize": "large", "notifications": true, "language": "en"}'),
(2, '{"theme": "light", "fontSize": "medium", "notifications": false, "language": "en"}'),
(3, '{"theme": "dark", "fontSize": "small", "notifications": true, "language": "ne"}'),
(4, '{"theme": "light", "fontSize": "large", "notifications": true, "language": "en"}'),
(5, '{"theme": "auto", "fontSize": "medium", "notifications": false, "language": "en"}');

-- =====================================================
-- USEFUL QUERIES FOR TEACHING EXAMPLES
-- =====================================================

-- You can use these queries to demonstrate various concepts:

-- 1. Basic SELECT queries
SELECT * FROM users LIMIT 5;
SELECT name, email FROM users WHERE status = 'active';

-- 2. WHERE clause examples
SELECT * FROM products WHERE price > 500;
SELECT * FROM products WHERE category_id = 2;
SELECT * FROM products WHERE name LIKE '%Pro%';

-- 3. ORDER BY examples
SELECT * FROM products ORDER BY price DESC;
SELECT * FROM users ORDER BY created_at DESC;

-- 4. GROUP BY and aggregate functions
SELECT category_id, COUNT(*) as product_count, AVG(price) as avg_price 
FROM products GROUP BY category_id;

SELECT YEAR(order_date) as year, MONTH(order_date) as month, 
       COUNT(*) as order_count, SUM(total_amount) as total_sales
FROM orders 
GROUP BY YEAR(order_date), MONTH(order_date);

-- 5. JOIN examples
SELECT o.id, u.name, o.total_amount, o.order_date
FROM orders o
JOIN users u ON o.customer_id = u.id;

SELECT p.name, c.name as category_name, b.name as brand_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN brands b ON p.brand_id = b.id;

-- 6. Subquery examples
SELECT * FROM products 
WHERE price > (SELECT AVG(price) FROM products);

SELECT * FROM users 
WHERE id IN (SELECT DISTINCT customer_id FROM orders);

-- 7. Date functions
SELECT * FROM orders WHERE order_date >= '2024-01-01';
SELECT *, DATEDIFF(NOW(), created_at) as days_since_created FROM users;

-- 8. Update and Delete examples
UPDATE products SET price = price * 1.1 WHERE category_id = 1;
UPDATE users SET last_login = NOW() WHERE id = 1;

-- 9. Complex queries for dashboard
SELECT 
    COUNT(DISTINCT customer_id) as unique_customers,
    COUNT(*) as total_orders,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_order_value
FROM orders 
WHERE order_date >= DATE_SUB(NOW(), INTERVAL 30 DAY);

-- 10. Product statistics by category
SELECT 
    c.name as category,
    COUNT(p.id) as product_count,
    MIN(p.price) as min_price,
    MAX(p.price) as max_price,
    AVG(p.price) as avg_price,
    SUM(p.stock) as total_stock
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
GROUP BY c.id, c.name
ORDER BY product_count DESC;