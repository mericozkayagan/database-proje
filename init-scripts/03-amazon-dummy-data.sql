\c amazon

-- Insert dummy users
INSERT INTO users.users (email, password_hash, password_salt, first_name, last_name, phone) VALUES
('john.doe@email.com', 'hash1', 'salt1', 'John', 'Doe', '+905551234567'),
('jane.smith@email.com', 'hash2', 'salt2', 'Jane', 'Smith', '+905557654321'),
('ali.yilmaz@email.com', 'hash3', 'salt3', 'Ali', 'Yılmaz', '+905559876543');

-- Insert payment methods
INSERT INTO payments.payment_methods (user_id, type, provider, account_number, expiry_date, is_default, is_active)
SELECT user_id, 'credit_card', 'Visa', '4111111111111111', '2025-12-31', TRUE, TRUE FROM users.users;

-- Insert saved payments
INSERT INTO users.saved_payments (user_id, payment_method_id, nickname, is_active)
SELECT u.user_id, pm.payment_method_id, 'My Visa', TRUE FROM users.users u
JOIN payments.payment_methods pm ON u.user_id = pm.user_id;

-- Insert contact info
INSERT INTO users.contact_info (user_id, contact_type, contact_value, is_primary)
SELECT user_id, 'email', email, TRUE FROM users.users;

-- Insert saved carts
INSERT INTO users.saved_carts (user_id, cart_items)
SELECT user_id, '[{"product_id": "some-product-id", "quantity": 2}]'::jsonb FROM users.users;

-- Insert user roles
INSERT INTO users.user_roles (user_id, role_name)
SELECT user_id, 'customer' FROM users.users;

-- Insert addresses
INSERT INTO users.addresses (user_id, address_type, address_line1, city, postal_code, country_code, is_default)
SELECT user_id, 'shipping', 'Test Address 123', 'Istanbul', '34000', 'TR', TRUE FROM users.users;

-- Insert user preferences
INSERT INTO users.preferences (user_id, default_language, default_currency, notification_settings, privacy_settings)
SELECT user_id, 'en_US', 'USD', '{"email": true}'::jsonb, '{"share_data": false}'::jsonb FROM users.users;

-- Insert user security settings
INSERT INTO users.user_security (user_id, two_factor_enabled, security_questions)
SELECT user_id, FALSE, '{"question": "What is your pets name?", "answer": "Fluffy"}'::jsonb FROM users.users;

-- Insert languages
INSERT INTO users.languages (language_code, language_name, is_default) VALUES
('en_US', 'English (United States)', TRUE),
('tr_TR', 'Turkish (Turkey)', FALSE);

-- Insert categories
INSERT INTO products.categories (name, slug, level, path) VALUES
('Electronics', 'electronics', 1, 'electronics'::ltree),
('Books', 'books', 1, 'books'::ltree),
('Fashion', 'fashion', 1, 'fashion'::ltree);

-- Insert brands
INSERT INTO products.brands (name, slug, description) VALUES
('Samsung', 'samsung', 'Electronics manufacturer'),
('Apple', 'apple', 'Technology company'),
('Nike', 'nike', 'Sports equipment manufacturer');

-- Insert sellers
INSERT INTO marketplace.sellers (user_id, business_name, tax_id, business_type, status)
SELECT user_id, 'Test Store ' || first_name, 'TAX' || generate_series(1,3), 'retail', 'active' FROM users.users LIMIT 3;

-- Insert products
INSERT INTO products.products (seller_id, category_id, brand_id, name, slug, description)
SELECT
    s.seller_id,
    c.category_id,
    b.brand_id,
    'Test Product ' || generate_series(1,5),
    'test-product-' || generate_series(1,5),
    'Description for product ' || generate_series(1,5)
FROM marketplace.sellers s
CROSS JOIN products.brands b
CROSS JOIN products.categories c
LIMIT 5;

-- Insert product specifications
INSERT INTO products.product_specifications (product_id, key, value)
SELECT p.product_id, 'Color', 'Red' FROM products.products p;

-- Insert product images
INSERT INTO products.product_images (product_id, url, alt_text, sort_order, is_primary)
SELECT p.product_id, 'http://example.com/image.jpg', 'Product Image', 1, TRUE FROM products.products p;

-- Insert product variants
INSERT INTO products.product_variants (product_id, sku, name, attributes)
SELECT p.product_id, 'SKU-' || generate_series(1,5), 'Variant for product ' || generate_series(1,5), '{"color": "red", "size": "M"}'::jsonb FROM products.products p LIMIT 5;

-- Insert warehouses
INSERT INTO products.warehouses (name, code, address_line1, city, postal_code, country_code)
VALUES ('Main Warehouse', 'WH001', 'Warehouse Address', 'Istanbul', '34000', 'TR');

-- Insert inventory
INSERT INTO products.inventory (product_id, variant_id, warehouse_id, quantity, reserved_quantity, reorder_point)
SELECT p.product_id, v.variant_id, w.warehouse_id, 100, 10, 20
FROM products.products p
CROSS JOIN products.product_variants v
CROSS JOIN products.warehouses w
LIMIT 1;

-- Insert product reviews
INSERT INTO products.reviews (product_id, user_id, rating, comment)
SELECT p.product_id, u.user_id, 5, 'Great product!' FROM products.products p CROSS JOIN users.users u LIMIT 3;

-- Insert inventory alerts
INSERT INTO products.inventory_alerts (product_id, variant_id, warehouse_id, alert_type, alert_details)
SELECT p.product_id, v.variant_id, w.warehouse_id, 'low stock', '{"threshold": 10}'::jsonb
FROM products.products p
CROSS JOIN products.product_variants v
CROSS JOIN products.warehouses w
LIMIT 1;

-- Insert orders
INSERT INTO orders.orders (user_id, order_number, status, currency_code, subtotal, shipping_cost, tax_amount, total_amount)
SELECT u.user_id, 'ORD-' || generate_series(1,3), 'processing', 'TRY', 100.00, 10.00, 18.00, 128.00 FROM users.users u LIMIT 3;

-- Insert order items
INSERT INTO orders.order_items (order_id, product_id, quantity, unit_price, total_price)
SELECT o.order_id, p.product_id, 1, 100.00, 100.00 FROM orders.orders o CROSS JOIN products.products p LIMIT 3;

-- Insert order history
INSERT INTO orders.order_history (order_id, status, comment, created_by)
SELECT o.order_id, 'shipped', 'Order shipped', u.user_id FROM orders.orders o CROSS JOIN users.users u LIMIT 3;

-- Insert installment plans
INSERT INTO payments.installment_plans (payment_method_id, number_of_installments, interest_rate, is_active)
SELECT pm.payment_method_id, 12, 1.5, TRUE FROM payments.payment_methods pm;

-- Insert transactions
INSERT INTO payments.transactions (order_id, payment_method_id, amount, currency_code, status, provider_transaction_id)
SELECT o.order_id, pm.payment_method_id, 128.00, 'TRY', 'completed', 'TXN12345' FROM orders.orders o CROSS JOIN payments.payment_methods pm LIMIT 3;

-- Insert currencies
INSERT INTO payments.currencies (currency_code, currency_name, exchange_rate) VALUES
('USD', 'United States Dollar', 1.00),
('TRY', 'Turkish Lira', 0.11);

-- Insert carriers
INSERT INTO shipping.carriers (name, code, tracking_url_template)
VALUES ('DHL', 'DHL', 'http://dhl.com/track?num={TRACKING_NUMBER}');

-- Insert shipping methods
INSERT INTO shipping.shipping_methods (carrier_id, name, code, estimated_days_min, estimated_days_max, is_prime_eligible, is_international)
SELECT c.carrier_id, 'Standard Shipping', 'STD', 3, 5, FALSE, TRUE FROM shipping.carriers c;

-- Insert shipping tracking
INSERT INTO shipping.shipping_tracking (order_id, carrier_id, tracking_number, status, estimated_delivery)
SELECT o.order_id, c.carrier_id, 'TRACK123', 'in transit', CURRENT_TIMESTAMP + interval '5 days'
FROM orders.orders o
CROSS JOIN shipping.carriers c
LIMIT 1;

-- Insert prime memberships
INSERT INTO prime.memberships (user_id, plan_type, status, start_date, end_date, auto_renewal)
SELECT user_id, 'annual', 'active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + interval '1 year', TRUE FROM users.users;

-- Insert video content
INSERT INTO video.content (title, description, type, release_year, rating, duration_minutes, is_prime_exclusive)
VALUES ('Sample Movie', 'A great movie', 'movie', 2023, 'PG', 120, TRUE);

-- Insert video episodes
INSERT INTO video.episodes (content_id, season_number, episode_number, title, description, duration_minutes)
SELECT c.content_id, 1, 1, 'Episode 1', 'First episode', 45 FROM video.content c;

-- Insert watch history for a movie
INSERT INTO video.watch_history (user_id, content_id, watched_duration)
SELECT u.user_id, c.content_id, 45
FROM users.users u
CROSS JOIN video.content c
WHERE c.type = 'movie'
LIMIT 1;

-- Insert watch history for an episode
INSERT INTO video.watch_history (user_id, episode_id, watched_duration)
SELECT u.user_id, e.episode_id, 45
FROM users.users u
CROSS JOIN video.episodes e
LIMIT 1;

-- Insert promotions campaigns
INSERT INTO promotions.campaigns (name, description, start_date, end_date, discount_type, discount_value, minimum_purchase)
VALUES ('Summer Sale', 'Discounts on summer products', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + interval '1 month', 'percentage', 10.00, 50.00);

-- Insert campaign products
INSERT INTO promotions.campaign_products (campaign_id, product_id)
SELECT c.campaign_id, p.product_id FROM promotions.campaigns c CROSS JOIN products.products p LIMIT 1;

-- Insert promotion rules
INSERT INTO promotions.promotion_rules (campaign_id, rule_type, rule_details)
SELECT c.campaign_id, 'discount', '{"percentage": 10}'::jsonb FROM promotions.campaigns c LIMIT 1;

-- Insert user recommendations
INSERT INTO analytics.user_recommendations (user_id, recommended_products)
SELECT u.user_id, '[{"product_id": "some-product-id", "score": 0.95}]'::jsonb FROM users.users u LIMIT 1;

-- Insert search indexes
INSERT INTO analytics.search_indexes (table_name, index_details)
VALUES ('products', '{"fields": ["name", "description"]}'::jsonb);

-- Insert seller locations
INSERT INTO marketplace.seller_locations (seller_id, warehouse_id, is_primary)
SELECT s.seller_id, w.warehouse_id, TRUE FROM marketplace.sellers s CROSS JOIN products.warehouses w LIMIT 1;

-- Insert benefit eligibility for Prime
INSERT INTO prime.benefit_eligibility (country_code, is_video_included, is_shipping_included, is_music_included)
VALUES ('TR', TRUE, TRUE, FALSE);
