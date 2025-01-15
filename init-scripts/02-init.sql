\c main

CREATE SCHEMA users;
CREATE SCHEMA products;
CREATE SCHEMA orders;
CREATE SCHEMA payments;
CREATE SCHEMA shipping;
CREATE SCHEMA analytics;
CREATE SCHEMA marketplace;
CREATE SCHEMA promotions;
CREATE SCHEMA prime;
CREATE SCHEMA video;

CREATE TABLE users.users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    password_salt VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by UUID,
    updated_by UUID,
    is_deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP
);

CREATE TABLE products.addresses (
    address_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    address_title VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_code VARCHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.warehouses (
    warehouse_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) UNIQUE NOT NULL,
    address_id UUID REFERENCES products.addresses(address_id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.sellers (
    seller_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    business_name VARCHAR(255) NOT NULL,
    tax_id VARCHAR(100),
    business_type VARCHAR(50),
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'active', 'suspended', 'terminated')),
    rating DECIMAL(3,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.categories (
    category_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parent_id UUID REFERENCES products.categories(category_id),
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(150) UNIQUE NOT NULL,
    level INTEGER NOT NULL,
    path ltree NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.brands (
    brand_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(150) UNIQUE NOT NULL,
    description TEXT,
    logo_url VARCHAR(255),
    website_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.products (
    product_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seller_id UUID REFERENCES marketplace.sellers(seller_id),
    category_id UUID REFERENCES products.categories(category_id),
    brand_id UUID REFERENCES products.brands(brand_id),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(300) UNIQUE NOT NULL,
    description TEXT,
    price DECIMAL(15,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.product_variants (
    variant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products.products(product_id),
    sku VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.inventory (
    inventory_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products.products(product_id),
    variant_id UUID REFERENCES products.product_variants(variant_id),
    quantity INTEGER NOT NULL DEFAULT 0,
    reserved_quantity INTEGER NOT NULL DEFAULT 0,
    reorder_point INTEGER,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.inventory_warehouse (
    inventory_id UUID REFERENCES products.inventory(inventory_id),
    warehouse_id UUID REFERENCES products.warehouses(warehouse_id),
    PRIMARY KEY (inventory_id, warehouse_id)
);

CREATE TABLE orders.orders (
    order_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    currency_code VARCHAR(3) NOT NULL,
    subtotal DECIMAL(15,2) NOT NULL,
    shipping_cost DECIMAL(15,2) NOT NULL,
    tax_amount DECIMAL(15,2) NOT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments.payment_methods (
    payment_method_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR(50),
    provider VARCHAR(50),
    account_number VARCHAR(20),
    expiry_date DATE,
    is_default BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE payments.installment_plans (
    plan_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    payment_method_id UUID REFERENCES payments.payment_methods(payment_method_id),
    number_of_installments INTEGER,
    interest_rate DECIMAL(5,2),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE payments.transactions (
    transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders.orders(order_id),
    payment_method_id UUID REFERENCES payments.payment_methods(payment_method_id),
    amount DECIMAL(10,2),
    currency_code VARCHAR(3),
    status VARCHAR(20),
    provider_transaction_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments.currencies (
    currency_code VARCHAR(3) PRIMARY KEY,
    currency_name VARCHAR(100),
    exchange_rate DECIMAL(10,4)
);

CREATE TABLE users.contact_info (
    user_id UUID REFERENCES users.users(user_id),
    contact_type VARCHAR(50),
    contact_value VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, contact_type)
);

CREATE TABLE users.cart (
    cart_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    cart_items JSONB NOT NULL DEFAULT '[]',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users.user_roles (
    role_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    role_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users.addresses (
    address_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    address_type VARCHAR(20) CHECK (address_type IN ('billing', 'shipping')),
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_code VARCHAR(2) NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users.preferences (
    preference_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    language_code VARCHAR(5) DEFAULT 'en_US',
    currency_code VARCHAR(3) DEFAULT 'USD',
    notification_settings JSONB NOT NULL DEFAULT '{}',
    privacy_settings JSONB NOT NULL DEFAULT '{}'
);

CREATE TABLE users.user_security (
    security_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    two_factor_enabled BOOLEAN DEFAULT FALSE,
    security_questions JSONB
);

CREATE TABLE users.languages (
    language_code VARCHAR(5) PRIMARY KEY,
    language_name VARCHAR(50),
    is_default BOOLEAN DEFAULT FALSE
);

CREATE TABLE users.saved_payments (
    saved_payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    payment_method_id UUID REFERENCES payments.payment_methods(payment_method_id),
    nickname VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.product_specifications (
    specification_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products.products(product_id),
    key VARCHAR(100),
    value VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.product_images (
    image_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products.products(product_id),
    url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    sort_order INTEGER NOT NULL DEFAULT 0,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products.warehouse_addresses (
    warehouse_id UUID REFERENCES products.warehouses(warehouse_id),
    address_id UUID REFERENCES products.addresses(address_id),
    PRIMARY KEY (warehouse_id, address_id)
);

CREATE TABLE products.reviews (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products.products(product_id),
    user_id UUID REFERENCES users.users(user_id),
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders.order_items (
    order_item_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders.orders(order_id),
    product_id UUID REFERENCES products.products(product_id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(15,2) NOT NULL,
    total_price DECIMAL(15,2) NOT NULL
);

CREATE TABLE orders.order_history (
    history_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders.orders(order_id),
    status VARCHAR(50) NOT NULL,
    comment TEXT,
    created_by UUID REFERENCES users.users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shipping.carriers (
    carrier_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) UNIQUE NOT NULL,
    tracking_url_template VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shipping.shipping_methods (
    method_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    carrier_id UUID REFERENCES shipping.carriers(carrier_id),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) UNIQUE NOT NULL,
    estimated_days_min INTEGER NOT NULL,
    estimated_days_max INTEGER NOT NULL,
    is_prime_eligible BOOLEAN DEFAULT FALSE,
    is_international BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shipping.shipping_tracking (
    tracking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders.orders(order_id),
    carrier_id UUID REFERENCES shipping.carriers(carrier_id),
    tracking_number VARCHAR(100),
    status VARCHAR(50),
    estimated_delivery TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE prime.memberships (
    membership_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE REFERENCES users.users(user_id),
    plan_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('active', 'cancelled', 'expired')),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    auto_renewal BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE video.content (
    content_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    type VARCHAR(50) NOT NULL CHECK (type IN ('movie', 'series')),
    release_year INTEGER,
    rating VARCHAR(10),
    duration_minutes INTEGER,
    is_prime_exclusive BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE prime.benefit_eligibility (
    eligibility_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content_id UUID REFERENCES video.content(content_id),
    country_code VARCHAR(2),
    is_video_included BOOLEAN DEFAULT FALSE
);

CREATE TABLE video.series (
    episode_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content_id UUID UNIQUE REFERENCES video.content(content_id),
    season_number INTEGER NOT NULL,
    episode_number INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    duration_minutes INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE video.movie (
    movie_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content_id UUID UNIQUE REFERENCES video.content(content_id),
    duration_minutes INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE video.watch_history (
    history_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users.users(user_id),
    content_id UUID REFERENCES video.content(content_id),
    episode_id UUID REFERENCES video.series(episode_id),
    watched_duration INTEGER NOT NULL,
    watched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users.cart_items (
    order_item_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products.products(product_id),
    cart_id UUID REFERENCES users.cart(cart_id),
    unit_price DECIMAL(15,2) NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL(15,2) NOT NULL
);

CREATE TABLE promotions.campaigns (
    campaign_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    discount_type VARCHAR(20),
    discount_value DECIMAL(10,2) NOT NULL,
    minimum_purchase DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE promotions.campaign_products (
    campaign_id UUID REFERENCES promotions.campaigns(campaign_id),
    product_id UUID REFERENCES products.products(product_id),
    PRIMARY KEY (campaign_id, product_id)
);

CREATE TABLE promotions.promotion_rules (
    rule_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    campaign_id UUID REFERENCES promotions.campaigns(campaign_id),
    rule_type VARCHAR(50),
    rule_details JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE supermarket (
    supermarket_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    tracking_number VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE restaurant (
    restaurant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE procurement (
    procurement_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaction_id UUID REFERENCES payments.transactions(transaction_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    supplier_name VARCHAR(255),
    total_amount DECIMAL(15,2) NOT NULL
);

CREATE TABLE procurement_supermarket (
    procurement_id UUID REFERENCES procurement(procurement_id),
    supermarket_id UUID REFERENCES supermarket(supermarket_id),
    PRIMARY KEY (procurement_id, supermarket_id)
);

CREATE TABLE procurement_restaurant (
    procurement_id UUID REFERENCES procurement(procurement_id),
    restaurant_id UUID REFERENCES restaurant(restaurant_id),
    PRIMARY KEY (procurement_id, restaurant_id)
);

CREATE TABLE market_shelf (
    shelf_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    supermarket_id UUID REFERENCES supermarket(supermarket_id),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    price DECIMAL(15,2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menu (
    menu_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    restaurant_id UUID UNIQUE REFERENCES restaurant(restaurant_id),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add composite indexes for common queries
CREATE INDEX idx_product_category_brand ON products.products(category_id, brand_id);
CREATE INDEX idx_order_user_date ON orders.orders(user_id, created_at);
CREATE INDEX idx_inventory_status ON products.inventory(product_id)
    WHERE quantity > 0;

-- Add partial indexes for active records
CREATE INDEX idx_prime_members ON prime.memberships(user_id)
    WHERE status = 'active';

-- Indexes
CREATE INDEX idx_users_email ON users.users(email);
CREATE INDEX idx_orders_status_date ON orders.orders(status, created_at);
CREATE INDEX idx_products_name ON products.products(name);
CREATE INDEX idx_reviews_product_user ON products.reviews(product_id, user_id);
CREATE INDEX idx_promotion_rules_campaign ON promotions.promotion_rules(campaign_id);
CREATE INDEX idx_shipping_tracking_order ON shipping.shipping_tracking(order_id);
CREATE INDEX idx_user_security_user ON users.user_security(user_id);

CREATE OR REPLACE FUNCTION update_stock_after_order()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products.inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_after_order_trigger
AFTER INSERT ON orders.order_items
FOR EACH ROW EXECUTE FUNCTION update_stock_after_order();

CREATE OR REPLACE FUNCTION update_sales_revenue()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Completed' THEN
        UPDATE analytics.sales_stats
        SET total_revenue = total_revenue + NEW.total_amount,
            total_sales = total_sales + 1
        WHERE date = CURRENT_DATE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_sales_revenue_trigger
AFTER UPDATE ON orders.orders
FOR EACH ROW EXECUTE FUNCTION update_sales_revenue();

CREATE OR REPLACE FUNCTION notify_low_stock()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity < 10 THEN
        INSERT INTO notifications (message, created_at)
        VALUES (CONCAT('Product ', NEW.product_id, ' has reached a critical stock level.'), CURRENT_TIMESTAMP);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notify_low_stock_trigger
AFTER UPDATE ON products.inventory
FOR EACH ROW EXECUTE FUNCTION notify_low_stock();

ALTER TABLE products.products
ADD CONSTRAINT chk_positive_price CHECK (price >= 0);

ALTER TABLE products.inventory
ADD CONSTRAINT chk_stock_quantity CHECK (quantity >= 0);

ALTER TABLE orders.orders
ADD CONSTRAINT chk_order_status CHECK (status IN ('Pending', 'Completed', 'Cancelled'));