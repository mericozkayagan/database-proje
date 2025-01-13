# E-Commerce Database Analysis Project

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Technical Requirements](#2-technical-requirements)
3. [Data Requirements](#3-data-requirements)
   - [Common Data Requirements](#31-common-data-requirements)
   - [Amazon-Specific Data](#32-amazon-specific-data)
   - [Hepsiburada-Specific Data](#33-hepsiburada-specific-data)
   - [Trendyol-Specific Data](#34-trendyol-specific-data)
4. [Getting Started](#4-getting-started)

## 1. Project Overview

This project implements a database system to analyze data from major Turkish e-commerce platforms, focusing on Amazon, Hepsiburada, and Trendyol.

## 2. Technical Requirements

- Docker
- Git for version control

## 3. Data Requirements

### 3.1 Common Data Requirements

#### Users Schema

1. **Users Table (`users.users`)**
   - **Purpose:** Stores core information for each user registered on the platform.
   - **Key Features:**
     - Each user is uniquely identified by a `user_id`.
     - Users must provide a valid `email` address for login and communication.
     - Passwords are securely stored using `password_hash` and `password_salt`.
     - Optional fields include `first_name`, `last_name`, and `phone`.
     - The `is_active` field indicates if a user's account is active.
     - Timestamps (`last_login`, `created_at`, `updated_at`) track user activity and account changes.
     - Soft deletion is supported with `is_deleted` and `deleted_at`.

2. **Contact Information Table (`users.contact_info`)**
   - **Purpose:** Manages additional contact methods for users.
   - **Key Features:**
     - Each contact entry is uniquely identified by a `contact_id`.
     - The `user_id` links each contact method to a user.
     - `contact_type` specifies the type of contact (e.g., email, phone).
     - `contact_value` holds the actual contact information.
     - The `is_primary` field indicates if this is the primary contact method.

3. **Saved Carts Table (`users.cart`)**
   - **Purpose:** Allows users to save their shopping carts for future purchases.
   - **Key Features:**
     - Each saved cart is uniquely identified by a `cart_id`.
     - The `user_id` links the cart to a user.
     - `cart_items` is a JSON array storing items in the cart, including product IDs and quantities.
     - Timestamps (`created_at`, `updated_at`) track when the cart was created and modified.

4. **User Roles Table (`users.user_roles`)**
   - **Purpose:** Assigns roles to users, defining their permissions and access levels.
   - **Key Features:**
     - Each role assignment is uniquely identified by a `role_id`.
     - The `user_id` links the role to a user.
     - `role_name` specifies the role (e.g., admin, customer).
     - The `created_at` timestamp records when the role was assigned.

5. **Addresses Table (`users.addresses`)**
   - **Purpose:** Stores multiple addresses for users, such as billing and shipping addresses.
   - **Key Features:**
     - Each address is uniquely identified by an `address_id`.
     - The `user_id` links the address to a user.
     - `address_type` indicates whether the address is for billing or shipping.
     - Address details include `address_line1`, `address_line2`, `city`, `state`, `postal_code`, and `country_code`.
     - The `is_default` field indicates if this is the default address for transactions.

6. **Preferences Table (`users.preferences`)**
   - **Purpose:** Stores user preferences for language, currency, and notification settings.
   - **Key Features:**
     - Each preference set is uniquely identified by a `preference_id`.
     - The `user_id` links the preferences to a user.
     - `language_code` and `currency_code` store the user's preferred language and currency.
     - `notification_settings` and `privacy_settings` are JSON objects storing user-specific settings.

7. **User Security Table (`users.user_security`)**
   - **Purpose:** Manages security settings for users, including two-factor authentication.
   - **Key Features:**
     - Each security setting is uniquely identified by a `security_id`.
     - The `user_id` links the security settings to a user.
     - `two_factor_enabled` indicates if two-factor authentication is active.
     - `security_questions` is a JSON array storing security questions and answers.

8. **Languages Table (`users.languages`)**
   - **Purpose:** Defines the languages supported by the platform.
   - **Key Features:**
     - Each language is uniquely identified by a `language_code`.
     - `language_name` provides the name of the language.
     - The `is_default` field indicates if this language is the default for the platform.

9. **Saved Payments Table (`users.saved_payments`)**
   - **Purpose:** Allows users to save their preferred payment methods for quick access.
   - **Key Features:**
     - Each saved payment method is uniquely identified by a `saved_payment_id`.
     - The `user_id` links the payment method to a user.
     - `payment_method_id` references the actual payment method details.
     - Users can assign a `nickname` to each payment method.
     - The `is_active` field indicates if the payment method is active.

#### Products Schema

1. **Addresses Table (`products.addresses`)**
   - **Purpose:** Stores addresses related to products.
   - **Key Features:**
     - Each address is uniquely identified by an `address_id`.
     - Includes fields like `address_line1`, `city`, `postal_code`, and `country_code`.

2. **Warehouses Table (`products.warehouses`)**
   - **Purpose:** Manages warehouse information.
   - **Key Features:**
     - Each warehouse is uniquely identified by a `warehouse_id`.
     - Includes `name`, `code`, and `address_id`.
     - The `is_active` field indicates if the warehouse is operational.

3. **Categories Table (`products.categories`)**
   - **Purpose:** Organizes products into categories.
   - **Key Features:**
     - Each category is uniquely identified by a `category_id`.
     - Includes `name`, `slug`, and hierarchical `path`.
     - The `is_active` field indicates if the category is available.

4. **Brands Table (`products.brands`)**
   - **Purpose:** Stores brand information.
   - **Key Features:**
     - Each brand is uniquely identified by a `brand_id`.
     - Includes `name`, `slug`, and optional `logo_url`.
     - The `is_active` field indicates if the brand is active.

5. **Products Table (`products.products`)**
   - **Purpose:** Stores core product information.
   - **Key Features:**
     - Each product is uniquely identified by a `product_id`.
     - Includes `name`, `description`, `price`, and `is_active`.
     - References `seller_id`, `category_id`, and `brand_id`.

6. **Product Variants Table (`products.product_variants`)**
   - **Purpose:** Manages product variants.
   - **Key Features:**
     - Each variant is uniquely identified by a `variant_id`.
     - Includes `sku`, `name`, and `attributes` as JSONB.
     - The `is_active` field indicates if the variant is available.

7. **Inventory Table (`products.inventory`)**
   - **Purpose:** Tracks inventory levels.
   - **Key Features:**
     - Each inventory entry is uniquely identified by an `inventory_id`.
     - Includes `quantity`, `reserved_quantity`, and `reorder_point`.
     - References `product_id` and `variant_id`.

8. **Inventory Warehouse Table (`products.inventory_warehouse`)**
   - **Purpose:** Links inventory to warehouses.
   - **Key Features:**
     - Composite primary key of `inventory_id` and `warehouse_id`.

9. **Product Specifications Table (`products.product_specifications`)**
   - **Purpose:** Stores product specifications.
   - **Key Features:**
     - Each specification is uniquely identified by a `specification_id`.
     - Includes `key` and `value`.

10. **Product Images Table (`products.product_images`)**
    - **Purpose:** Manages product images.
    - **Key Features:**
      - Each image is uniquely identified by an `image_id`.
      - Includes `url`, `alt_text`, and `sort_order`.
      - The `is_primary` field indicates if the image is the primary one.

11. **Warehouse Addresses Table (`products.warehouse_addresses`)**
    - **Purpose:** Links warehouses to addresses.
    - **Key Features:**
      - Composite primary key of `warehouse_id` and `address_id`.

12. **Reviews Table (`products.reviews`)**
    - **Purpose:** Stores product reviews.
    - **Key Features:**
      - Each review is uniquely identified by a `review_id`.
      - Includes `rating` and `comment`.
      - References `product_id` and `user_id`.

#### Orders Schema

1. **Orders Table (`orders.orders`)**
   - **Purpose:** Manages order information.
   - **Key Features:**
     - Each order is uniquely identified by an `order_id`.
     - Includes `order_number`, `order_date`, `status`, and financial details like `subtotal` and `total_amount`.
     - References `user_id`.

2. **Order Items Table (`orders.order_items`)**
   - **Purpose:** Stores items within an order.
   - **Key Features:**
     - Each order item is uniquely identified by an `order_item_id`.
     - Includes `quantity`, `unit_price`, and `total_price`.
     - References `order_id` and `product_id`.

3. **Order History Table (`orders.order_history`)**
   - **Purpose:** Tracks order status changes.
   - **Key Features:**
     - Each history entry is uniquely identified by a `history_id`.
     - Includes `status` and `comment`.
     - References `order_id` and `created_by`.

#### Payments Schema

1. **Payment Methods Table (`payments.payment_methods`)**
   - **Purpose:** Manages payment methods.
   - **Key Features:**
     - Each payment method is uniquely identified by a `payment_method_id`.
     - Includes `type`, `provider`, and `account_number`.
     - The `is_default` field indicates if this is the default payment method.

2. **Installment Plans Table (`payments.installment_plans`)**
   - **Purpose:** Stores installment plan details.
   - **Key Features:**
     - Each plan is uniquely identified by a `plan_id`.
     - Includes `number_of_installments` and `interest_rate`.
     - References `payment_method_id`.

3. **Transactions Table (`payments.transactions`)**
   - **Purpose:** Tracks payment transactions.
   - **Key Features:**
     - Each transaction is uniquely identified by a `transaction_id`.
     - Includes `amount`, `currency_code`, and `status`.
     - References `order_id` and `payment_method_id`.

4. **Currencies Table (`payments.currencies`)**
   - **Purpose:** Manages currency information.
   - **Key Features:**
     - Each currency is uniquely identified by a `currency_code`.
     - Includes `currency_name` and `exchange_rate`.

#### Shipping Schema

1. **Carriers Table (`shipping.carriers`)**
   - **Purpose:** Stores carrier information.
   - **Key Features:**
     - Each carrier is uniquely identified by a `carrier_id`.
     - Includes `name` and `tracking_url_template`.
     - The `is_active` field indicates if the carrier is operational.

2. **Shipping Methods Table (`shipping.shipping_methods`)**
   - **Purpose:** Manages shipping methods.
   - **Key Features:**
     - Each method is uniquely identified by a `method_id`.
     - Includes `name`, `code`, and eligibility flags.
     - References `carrier_id`.

3. **Shipping Tracking Table (`shipping.shipping_tracking`)**
   - **Purpose:** Tracks shipping status.
   - **Key Features:**
     - Each tracking entry is uniquely identified by a `tracking_id`.
     - Includes `tracking_number` and `status`.
     - References `order_id` and `carrier_id`.

#### Marketplace Schema

1. **Sellers Table (`marketplace.sellers`)**
   - **Purpose:** Manages seller information.
   - **Key Features:**
     - Each seller is uniquely identified by a `seller_id`.
     - Includes `business_name`, `tax_id`, and `status`.
     - References `user_id`.

#### Promotions Schema

1. **Campaigns Table (`promotions.campaigns`)**
   - **Purpose:** Manages promotional campaigns.
   - **Key Features:**
     - Each campaign is uniquely identified by a `campaign_id`.
     - Includes `name`, `description`, and `discount_type`.

2. **Campaign Products Table (`promotions.campaign_products`)**
   - **Purpose:** Links products to campaigns.
   - **Key Features:**
     - Composite primary key of `campaign_id` and `product_id`.

3. **Promotion Rules Table (`promotions.promotion_rules`)**
   - **Purpose:** Stores rules for promotions.
   - **Key Features:**
     - Each rule is uniquely identified by a `rule_id`.
     - Includes `rule_type` and `rule_details` as JSONB.
     - References `campaign_id`.

### 3.2 Amazon-Specific Data

#### Prime Schema

1. **Memberships Table (`prime.memberships`)**
   - **Purpose:** Manages prime memberships for users.
   - **Key Features:**
     - Each membership is uniquely identified by a `membership_id`.
     - Includes `plan_type`, `status`, and `auto_renewal`.
     - References `user_id`.

2. **Benefit Eligibility Table (`prime.benefit_eligibility`)**
   - **Purpose:** Tracks benefit eligibility for prime members.
   - **Key Features:**
     - Each eligibility entry is uniquely identified by an `eligibility_id`.
     - Includes `is_video_included`.
     - References `content_id`.

#### Video Schema

1. **Content Table (`video.content`)**
   - **Purpose:** Stores information about video content available on the platform.
   - **Key Features:**
     - Each content entry is uniquely identified by a `content_id`.
     - Includes `title`, `description`, `type`, and `release_year`.

2. **Series Table (`video.series`)**
   - **Purpose:** Manages series episodes available on the platform.
   - **Key Features:**
     - Each series entry is uniquely identified by a `episode_id`.
     - Includes `season_number` and `episode_number`.
     - References `content_id`.

3. **Film Table (`video.film`)**
   - **Purpose:** Stores information about films available on the platform.
   - **Key Features:**
     - Each film entry is uniquely identified by a `film_id`.
     - Includes `duration_minutes`.
     - References `content_id`.

4. **Watch History Table (`video.watch_history`)**
   - **Purpose:** Tracks user watch history for video content.
   - **Key Features:**
     - Each history entry is uniquely identified by a `history_id`.
     - Includes `watched_duration`.
     - References `user_id` and `content_id`.

### 3.3 Hepsiburada-Specific Data

#### Premium Schema

1. **Memberships Table (`premium.memberships`)**
   - **Purpose:** Manages premium memberships for users.
   - **Key Features:**
     - Each membership is uniquely identified by a `membership_id`.
     - Includes `plan_type`, `status`, and `auto_renewal`.
     - References `user_id`.

2. **Benefit Eligibility Table (`premium.benefit_eligibility`)**
   - **Purpose:** Tracks benefit eligibility for premium members.
   - **Key Features:**
     - Each eligibility entry is uniquely identified by an `eligibility_id`.
     - Includes benefit flags.

### 3.4 Trendyol-Specific Data

#### Food and Restaurant Services

1. **Supermarket Table (`supermarket`)**
   - **Purpose:** Manages information about supermarkets.
   - **Key Features:**
     - Each supermarket is uniquely identified by a `supermarket_id`.
     - Includes `name`, `phone`, and `address`.

2. **Restaurant Table (`restaurant`)**
   - **Purpose:** Stores information about restaurants.
   - **Key Features:**
     - Each restaurant is uniquely identified by a `restaurant_id`.
     - Includes `name`, `address`, and `phone`.

3. **Procurement Table (`procurement`)**
   - **Purpose:** Tracks procurement transactions related to food services.
   - **Key Features:**
     - Each procurement entry is uniquely identified by a `procurement_id`.
     - Includes `order_date`, `supplier_name`, and `total_amount`.

4. **Procurement-Supermarket Table (`procurement_supermarket`)**
   - **Purpose:** Links procurement entries to supermarkets.
   - **Key Features:**
     - Composite primary key of `procurement_id` and `supermarket_id`.

5. **Procurement-Restaurant Table (`procurement_restaurant`)**
   - **Purpose:** Links procurement entries to restaurants.
   - **Key Features:**
     - Composite primary key of `procurement_id` and `restaurant_id`.

## Getting Started

### Docker Setup

1. **Build the Docker Image:**

   - Ensure you have Docker installed on your machine.
   - Navigate to the directory containing your Dockerfile.
   - Run the following command to build the Docker image:
     ```bash
     docker build -t ecommerce-db .
     ```

2. **Run the Docker Container:**

   - Start a new container from the image you just built:
     ```bash
     docker run --name ecommerce-db-container -d -p 5432:5432 ecommerce-db
     ```

3. **Execute into the Container:**

   - To access the PostgreSQL database inside the running container, execute the following command:

     ```bash
     #first use this to get container id
     docker ps

     #then use this to get into the container
     docker exec -it <container_id> psql -U admin -d main
     ```

   - Replace `your_username` and `your_database` with the appropriate PostgreSQL username and database name.

4. **Run SQL Queries:**

   - Once inside the PostgreSQL prompt, you can run SQL queries directly.
   - For example, to list all tables, use:
     ```sql
     \dt
     ```

5. **Stop the Docker Container:**

   - When you're done, you can stop the container with:
     ```bash
     docker stop <container_id>
     ```

6. **Remove the Docker Container:**
   - If you need to remove the container, use:
     ```bash
     docker rm <container_id>
     ```

This setup will allow you to interact with your PostgreSQL database within a Docker container, providing a consistent and isolated environment for development and testing.

## Triggers

1. Stock Update Trigger
   Purpose: Automatically update the product stock quantity when an order is created.
   Explanation: This trigger fires after a new order item is inserted, reducing the stock quantity of the ordered product in the inventory.

```sql
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
```

2. Sales and Revenue Tracking Trigger
   Purpose: Update sales statistics when an order is completed.
   Explanation: This trigger updates the daily sales and revenue statistics when an order's status changes to "Completed".

```sql
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
```

3. Low Stock Notification Trigger
   Purpose: Notify the administrator when a product's stock quantity falls below a critical level.
   Explanation: This trigger adds a notification entry when a product's stock quantity drops below 10, alerting the administrator.

```sql
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
```

## Check Constraints

1. Positive Price Check
   Purpose: Ensure that product prices are not negative.
   Explanation: This constraint prevents the entry of negative prices for products, ensuring data integrity.

```sql
ALTER TABLE products.products
ADD CONSTRAINT chk_positive_price CHECK (price >= 0);
```

2. Stock Quantity Validation
   Purpose: Ensure that stock quantities are not negative.
   Explanation: This constraint ensures that the stock quantity for any product cannot be negative.

```sql
ALTER TABLE products.inventory
ADD CONSTRAINT chk_stock_quantity CHECK (quantity >= 0);
```

3. Order Status Validation
   Purpose: Restrict order statuses to predefined values (Pending, Completed, Cancelled).
   Explanation: This constraint ensures that the order status is always one of the allowed values, maintaining consistency in order processing.

```sql
ALTER TABLE orders.orders
ADD CONSTRAINT chk_order_status CHECK (status IN ('Pending', 'Completed', 'Cancelled'));
```
