\c main

-- Insert dummy users
INSERT INTO users.users (email, password_hash, password_salt, first_name, last_name, phone) VALUES
('john.doe@email.com', 'hash1', 'salt1', 'John', 'Doe', '+905551234567'),
('jane.smith@email.com', 'hash2', 'salt2', 'Jane', 'Smith', '+905557654321'),
('ali.yilmaz@email.com', 'hash3', 'salt3', 'Ali', 'Yılmaz', '+905559876543');

-- Insert addresses
INSERT INTO products.addresses (address_line1, address_line2, address_title, city, state, postal_code, country_code) VALUES
('123 Main St', 'Apt 1', 'Home', 'Istanbul', 'Istanbul', '34000', 'TR'),
('456 Elm St', NULL, 'Work', 'Ankara', 'Ankara', '06000', 'TR');

-- Insert warehouses
INSERT INTO products.warehouses (name, code, address_id, is_active) VALUES
('Main Warehouse', 'WH001', (SELECT address_id FROM products.addresses LIMIT 1), TRUE),
('Secondary Warehouse', 'WH002', (SELECT address_id FROM products.addresses OFFSET 1 LIMIT 1), TRUE);

-- Insert sellers
INSERT INTO marketplace.sellers (user_id, business_name, tax_id, business_type, status) VALUES
((SELECT user_id FROM users.users LIMIT 1), 'Doe Enterprises', 'TAX123', 'retail', 'active'),
((SELECT user_id FROM users.users OFFSET 1 LIMIT 1), 'Smith Ventures', 'TAX456', 'wholesale', 'active');

-- Insert categories
INSERT INTO products.categories (name, slug, level, path) VALUES
('Electronics', 'electronics', 1, 'electronics'::ltree),
('Home Appliances', 'home-appliances', 1, 'home-appliances'::ltree);

-- Insert brands
INSERT INTO products.brands (name, slug, description) VALUES
('Samsung', 'samsung', 'Electronics manufacturer'),
('LG', 'lg', 'Home appliances and electronics');

-- Insert products
INSERT INTO products.products (seller_id, category_id, brand_id, name, slug, description, price, is_active, created_at, updated_at) VALUES
((SELECT seller_id FROM marketplace.sellers LIMIT 1), (SELECT category_id FROM products.categories LIMIT 1), (SELECT brand_id FROM products.brands LIMIT 1), 'Smartphone', 'smartphone', 'Latest model smartphone', 999.99, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
((SELECT seller_id FROM marketplace.sellers OFFSET 1 LIMIT 1), (SELECT category_id FROM products.categories OFFSET 1 LIMIT 1), (SELECT brand_id FROM products.brands OFFSET 1 LIMIT 1), 'Washing Machine', 'washing-machine', 'High efficiency washing machine', 599.99, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert product variants
INSERT INTO products.product_variants (product_id, sku, name, type) VALUES
((SELECT product_id FROM products.products LIMIT 1), 'SKU123', 'Smartphone Variant', 'black'),
((SELECT product_id FROM products.products OFFSET 1 LIMIT 1), 'SKU456', 'Washing Machine Variant', 'white');

-- Insert inventory
INSERT INTO products.inventory (product_id, variant_id, quantity, reserved_quantity, reorder_point) VALUES
((SELECT product_id FROM products.products LIMIT 1), (SELECT variant_id FROM products.product_variants LIMIT 1), 100, 10, 20),
((SELECT product_id FROM products.products OFFSET 1 LIMIT 1), (SELECT variant_id FROM products.product_variants OFFSET 1 LIMIT 1), 50, 5, 10);

-- Insert inventory-warehouse relationships
INSERT INTO products.inventory_warehouse (inventory_id, warehouse_id) VALUES
((SELECT inventory_id FROM products.inventory LIMIT 1), (SELECT warehouse_id FROM products.warehouses LIMIT 1)),
((SELECT inventory_id FROM products.inventory OFFSET 1 LIMIT 1), (SELECT warehouse_id FROM products.warehouses OFFSET 1 LIMIT 1));

-- Insert orders
INSERT INTO orders.orders (user_id, order_number, status, currency_code, subtotal, shipping_cost, tax_amount, total_amount) VALUES
((SELECT user_id FROM users.users LIMIT 1), 'ORD001', 'Pending', 'TRY', 100.00, 10.00, 18.00, 128.00),
((SELECT user_id FROM users.users OFFSET 1 LIMIT 1), 'ORD002', 'Completed', 'USD', 200.00, 20.00, 36.00, 256.00);

-- Insert payment methods
INSERT INTO payments.payment_methods (type, provider, account_number, expiry_date, is_default, is_active) VALUES
('credit_card', 'Visa', '4111111111111111', '2025-12-31', TRUE, TRUE),
('paypal', 'PayPal', 'user@example.com', NULL, FALSE, TRUE);

-- Insert transactions
INSERT INTO payments.transactions (order_id, payment_method_id, amount, currency_code, status, provider_transaction_id) VALUES
((SELECT order_id FROM orders.orders LIMIT 1), (SELECT payment_method_id FROM payments.payment_methods LIMIT 1), 128.00, 'TRY', 'completed', 'TXN12345'),
((SELECT order_id FROM orders.orders OFFSET 1 LIMIT 1), (SELECT payment_method_id FROM payments.payment_methods OFFSET 1 LIMIT 1), 256.00, 'USD', 'completed', 'TXN67890');

-- Insert currencies
INSERT INTO payments.currencies (currency_code, currency_name, exchange_rate) VALUES
('USD', 'United States Dollar', 1.00),
('TRY', 'Turkish Lira', 0.11);

-- Insert carriers
INSERT INTO shipping.carriers (name, code, tracking_url_template) VALUES
('DHL', 'DHL', 'http://dhl.com/track?num={TRACKING_NUMBER}'),
('FedEx', 'FDX', 'http://fedex.com/track?num={TRACKING_NUMBER}');

-- Insert shipping methods
INSERT INTO shipping.shipping_methods (carrier_id, name, code, estimated_days_min, estimated_days_max, is_prime_eligible, is_international) VALUES
((SELECT carrier_id FROM shipping.carriers LIMIT 1), 'Standard Shipping', 'STD', 3, 5, FALSE, TRUE),
((SELECT carrier_id FROM shipping.carriers OFFSET 1 LIMIT 1), 'Express Shipping', 'EXP', 1, 2, TRUE, TRUE);

-- Insert prime memberships
INSERT INTO prime.memberships (user_id, plan_type, status, start_date, end_date, auto_renewal) VALUES
((SELECT user_id FROM users.users LIMIT 1), 'annual', 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + interval '1 year', TRUE),
((SELECT user_id FROM users.users OFFSET 1 LIMIT 1), 'monthly', 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + interval '1 month', TRUE);

-- Insert video content
INSERT INTO video.content (title, description, type, release_year, rating, duration_minutes, is_prime_exclusive) VALUES
('Sample Movie', 'A great movie', 'movie', 2023, 'PG', 120, TRUE),
('Sample Series', 'An exciting series', 'series', 2023, 'PG-13', 45, FALSE);

-- Insert promotions campaigns
INSERT INTO promotions.campaigns (name, description, start_date, end_date, discount_type, discount_value, minimum_purchase) VALUES
('Summer Sale', 'Discounts on summer products', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + interval '1 month', 'percentage', 10.00, 50.00),
('Winter Sale', 'Discounts on winter products', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + interval '2 months', 'fixed_amount', 20.00, 100.00);

-- Insert supermarkets
INSERT INTO supermarket (name, phone, address, tracking_number, is_active) VALUES
('Supermarket A', '+905551234567', '123 Market St', 'TRACK123', TRUE),
('Supermarket B', '+905557654321', '456 Market St', 'TRACK456', TRUE);

-- Insert restaurants
INSERT INTO restaurant (name, address, phone, is_active) VALUES
('Restaurant A', '456 Food St', '+905557654321', TRUE),
('Restaurant B', '789 Food St', '+905559876543', TRUE);

-- Insert procurement
INSERT INTO procurement (transaction_id, order_date, supplier_name, total_amount) VALUES
((SELECT transaction_id FROM payments.transactions LIMIT 1), CURRENT_TIMESTAMP, 'Supplier A', 500.00),
((SELECT transaction_id FROM payments.transactions OFFSET 1 LIMIT 1), CURRENT_TIMESTAMP, 'Supplier B', 1000.00);

-- Link procurement to supermarkets
INSERT INTO procurement_supermarket (procurement_id, supermarket_id) VALUES
((SELECT procurement_id FROM procurement LIMIT 1), (SELECT supermarket_id FROM supermarket LIMIT 1)),
((SELECT procurement_id FROM procurement OFFSET 1 LIMIT 1), (SELECT supermarket_id FROM supermarket OFFSET 1 LIMIT 1));

-- Link procurement to restaurants
INSERT INTO procurement_restaurant (procurement_id, restaurant_id) VALUES
((SELECT procurement_id FROM procurement LIMIT 1), (SELECT restaurant_id FROM restaurant LIMIT 1)),
((SELECT procurement_id FROM procurement OFFSET 1 LIMIT 1), (SELECT restaurant_id FROM restaurant OFFSET 1 LIMIT 1));

-- Insert order items
INSERT INTO orders.order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
((SELECT order_id FROM orders.orders LIMIT 1), (SELECT product_id FROM products.products LIMIT 1), 2, 999.99, 1999.98),
((SELECT order_id FROM orders.orders OFFSET 1 LIMIT 1), (SELECT product_id FROM products.products OFFSET 1 LIMIT 1), 1, 599.99, 599.99);

INSERT INTO promotions.campaigns (name, description, start_date, end_date, discount_type, discount_value, minimum_purchase) VALUES
('Summer Sale', 'Discounts on summer products', CURRENT_DATE - interval '1 month', CURRENT_DATE + interval '1 month', 'percentage', 10.00, 50.00),
('Winter Sale', 'Discounts on winter products', CURRENT_DATE - interval '2 months', CURRENT_DATE + interval '2 months', 'fixed_amount', 20.00, 100.00);

INSERT INTO products.inventory (product_id, variant_id, quantity, reserved_quantity, reorder_point) VALUES
((SELECT product_id FROM products.products LIMIT 1), (SELECT variant_id FROM products.product_variants LIMIT 1), 5, 1, 10),
((SELECT product_id FROM products.products OFFSET 1 LIMIT 1), (SELECT variant_id FROM products.product_variants OFFSET 1 LIMIT 1), 8, 2, 10);

-- Insert product reviews
INSERT INTO products.reviews (product_id, user_id, rating, comment, created_at) VALUES
((SELECT product_id FROM products.products LIMIT 1), (SELECT user_id FROM users.users LIMIT 1), 4, 'Great product!', CURRENT_TIMESTAMP),
((SELECT product_id FROM products.products OFFSET 1 LIMIT 1), (SELECT user_id FROM users.users OFFSET 1 LIMIT 1), 4, 'Very useful!', CURRENT_TIMESTAMP);