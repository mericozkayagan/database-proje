INSERT INTO users.users (email, password_hash, password_salt, first_name, last_name, phone)
VALUES ('alice@example.com', 'hash4', 'salt4', 'Alice', 'Wonderland', '+905551234568');

DELETE FROM users.users WHERE email = 'alice@example.com';

UPDATE users.users
SET last_login = CURRENT_TIMESTAMP
WHERE email = 'john.doe@email.com';

---

INSERT INTO products.products (seller_id, category_id, brand_id, name, slug, description, price)
VALUES (
    (SELECT seller_id FROM marketplace.sellers LIMIT 1),
    (SELECT category_id FROM products.categories LIMIT 1),
    (SELECT brand_id FROM products.brands LIMIT 1),
    'New Product', 'new-product', 'Description of new product', 99.99
);

DELETE FROM products.products WHERE name = 'New Product';

UPDATE products.products
SET price = 89.99
WHERE name = 'Smartphone';

---

INSERT INTO orders.orders (user_id, order_number, currency_code, subtotal, shipping_cost, tax_amount, total_amount, status)
VALUES (
    (SELECT user_id FROM users.users LIMIT 1),
    'ORD123456', 'USD', 100.00, 5.00, 8.00, 113.00, 'Pending'
);

DELETE FROM orders.orders WHERE order_number = 'ORD123456';

UPDATE orders.orders
SET status = 'Completed'
WHERE order_number = 'ORD123456';

-- Using a Minimum of 2 Tables

-- SELECT 1: Join users and orders
SELECT u.email, o.order_number, o.status
FROM users.users u
JOIN orders.orders o ON u.user_id = o.user_id;

-- SELECT 2: Join products and categories
SELECT p.name AS product_name, c.name AS category_name
FROM products.products p
JOIN products.categories c ON p.category_id = c.category_id;


-- Using a Minimum of 3 Tables

-- SELECT 3: Join users, orders, and order_items
SELECT u.email, o.order_number, oi.quantity, oi.total_price
FROM users.users u
JOIN orders.orders o ON u.user_id = o.user_id
JOIN orders.order_items oi ON o.order_id = oi.order_id;

-- SELECT 4: Join products, brands, and categories
SELECT p.name AS product_name, b.name AS brand_name, c.name AS category_name
FROM products.products p
JOIN products.brands b ON p.brand_id = b.brand_id
JOIN products.categories c ON p.category_id = c.category_id;

-- SELECT 5: Join orders, order_items, and products
SELECT o.order_number, oi.quantity, p.name AS product_name
FROM orders.orders o
JOIN orders.order_items oi ON o.order_id = oi.order_id
JOIN products.products p ON oi.product_id = p.product_id;


-- Critical Select Statements

-- SELECT 6: Top Buying User
SELECT u.email, SUM(o.total_amount) AS total_spent
FROM users.users u
JOIN orders.orders o ON u.user_id = o.user_id
WHERE o.status = 'Completed'
GROUP BY u.email
ORDER BY total_spent DESC
LIMIT 1;

-- SELECT 7: Monthly Revenue
SELECT DATE_TRUNC('month', o.order_date) AS month, SUM(o.total_amount) AS monthly_revenue
FROM orders.orders o
WHERE o.status = 'Completed'
GROUP BY month
ORDER BY month;

-- SELECT 8: List all active users
SELECT email, first_name, last_name
FROM users.users
WHERE is_active = TRUE;

-- SELECT 9: Find products with low stock
SELECT p.name, i.quantity
FROM products.products p
JOIN products.inventory i ON p.product_id = i.product_id
WHERE i.quantity < 10;

-- SELECT 10: List all active promotions
SELECT name, start_date, end_date
FROM promotions.campaigns
WHERE start_date <= CURRENT_DATE AND end_date >= CURRENT_DATE;

-- SELECT 11: Find top-rated products
SELECT p.name, AVG(r.rating) AS average_rating
FROM products.products p
JOIN products.reviews r ON p.product_id = r.product_id
GROUP BY p.name
ORDER BY average_rating DESC
LIMIT 5;