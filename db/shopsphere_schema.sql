-- ============================================================
-- ShopSphere — schema + seed data
-- For: Day 67 SQL/JPA refresher  (1 Oct 2026, 8:15–9:00 PM slot)
-- Run in MySQL:  mysql -u root -p < shopsphere_schema.sql
-- (or paste into MySQL Workbench / phpMyAdmin)
-- ============================================================

DROP DATABASE IF EXISTS shopsphere;
CREATE DATABASE shopsphere;
USE shopsphere;

-- ---------- users ----------
CREATE TABLE users (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(60)  NOT NULL,
  email       VARCHAR(120) NOT NULL UNIQUE,
  password    VARCHAR(100) NOT NULL,
  role        VARCHAR(10)  NOT NULL DEFAULT 'USER',
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---------- products ----------
CREATE TABLE products (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(80)  NOT NULL,
  price       DECIMAL(10,2) NOT NULL,
  stock       INT          NOT NULL DEFAULT 0,
  category    VARCHAR(40)
);

-- ---------- orders ----------  ('order' is a reserved word -> use 'orders')
CREATE TABLE orders (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  user_id     INT           NOT NULL,
  order_date  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status      VARCHAR(15)   NOT NULL DEFAULT 'PLACED',
  CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ---------- order_items ----------
CREATE TABLE order_items (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  order_id    INT           NOT NULL,
  product_id  INT           NOT NULL,
  quantity    INT           NOT NULL,
  price       DECIMAL(10,2) NOT NULL,          -- price at time of order
  CONSTRAINT fk_items_order   FOREIGN KEY (order_id)   REFERENCES orders(id),
  CONSTRAINT fk_items_product FOREIGN KEY (product_id) REFERENCES products(id)
);

-- ============================================================
-- SEED DATA  (deliberately has gaps: one user never ordered,
--            one product was never ordered, one order has 1 item)
-- ============================================================
INSERT INTO users (name, email, password, role) VALUES
 ('Aarav Sharma',   'aarav@example.com',   'x', 'ADMIN'),
 ('Diya Verma',     'diya@example.com',    'x', 'USER'),
 ('Rohan Gupta',    'rohan@example.com',   'x', 'USER'),
 ('Sneha Kapoor',   'sneha@example.com',   'x', 'USER'),
 ('Kabir Singh',    'kabir@example.com',   'x', 'USER');   -- never places an order

INSERT INTO products (name, price, stock, category) VALUES
 ('Mechanical Keyboard', 3499.00, 12, 'Accessories'),
 ('Wireless Mouse',       899.00, 40, 'Accessories'),
 ('27-inch Monitor',    14999.00,  5, 'Displays'),
 ('USB-C Hub',           1799.00, 25, 'Accessories'),
 ('Laptop Stand',        1299.00, 18, 'Accessories'),
 ('Noise-cancel Headset',4999.00,  8, 'Audio'),
 ('Webcam 1080p',        2599.00,  0, 'Video'),          -- never ordered
 ('Desk Lamp',            749.00, 30, 'Home');

INSERT INTO orders (user_id, order_date, status) VALUES
 (1, '2026-08-02 10:15:00', 'DELIVERED'),
 (2, '2026-08-14 18:40:00', 'DELIVERED'),
 (2, '2026-09-01 09:05:00', 'PLACED'),
 (3, '2026-09-12 21:30:00', 'SHIPPED'),
 (1, '2026-09-20 12:00:00', 'PLACED'),
 (4, '2026-09-25 16:45:00', 'PLACED');                   -- Sneha: one small order

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
 (1, 1, 1, 3499.00),
 (1, 2, 2,  899.00),
 (2, 3, 1,14999.00),
 (2, 5, 1, 1299.00),
 (3, 6, 1, 4999.00),
 (4, 2, 1,  899.00),
 (4, 8, 3,  749.00),
 (5, 4, 2, 1799.00),
 (5, 1, 1, 3499.00),
 (6, 8, 1,  749.00);

-- sanity check
SELECT 'users' AS table_name, COUNT(*) AS rows_ FROM users
UNION ALL SELECT 'products',    COUNT(*) FROM products
UNION ALL SELECT 'orders',      COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;
