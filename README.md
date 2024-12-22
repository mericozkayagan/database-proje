# E-Commerce Database Analysis Project

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Technical Requirements](#2-technical-requirements)
   - [Development Environment](#21-development-environment)
   - [System Requirements](#22-system-requirements)
3. [Data Requirements](#3-data-requirements)
   - [Common Data Structures](#31-common-data-structures)
   - [Platform-Specific Data](#32-platform-specific-data)
4. [Amazon Database Initialization](#amazon-database-initialization)
   - [Users Schema](#users-schema)
   - [Products Schema](#products-schema)
   - [Orders Schema](#orders-schema)
   - [Payments Schema](#payments-schema)
   - [Shipping Schema](#shipping-schema)
   - [Analytics Schema](#analytics-schema)
   - [Marketplace Schema](#marketplace-schema)
   - [Promotions Schema](#promotions-schema)
   - [Prime Schema](#prime-schema)
   - [Video Schema](#video-schema)
5. [Hepsiburada Database Initialization](#hepsiburada-database-initialization)
   - [Users Schema](#hepsiburada-users-schema)
   - [Products Schema](#hepsiburada-products-schema)
   - [Orders Schema](#hepsiburada-orders-schema)
   - [Payments Schema](#hepsiburada-payments-schema)
   - [Shipping Schema](#hepsiburada-shipping-schema)
   - [Analytics Schema](#hepsiburada-analytics-schema)
   - [Marketplace Schema](#hepsiburada-marketplace-schema)
   - [Promotions Schema](#hepsiburada-promotions-schema)
   - [Premium Schema](#hepsiburada-premium-schema)
6. [Trendyol Database Initialization](#trendyol-database-initialization)
   - [Users Schema](#trendyol-users-schema)
   - [Products Schema](#trendyol-products-schema)
   - [Orders Schema](#trendyol-orders-schema)
   - [Payments Schema](#trendyol-payments-schema)
   - [Shipping Schema](#trendyol-shipping-schema)
   - [Analytics Schema](#trendyol-analytics-schema)
   - [Marketplace Schema](#trendyol-marketplace-schema)
   - [Promotions Schema](#trendyol-promotions-schema)
   - [Trendyol Yemek Schema](#trendyol-yemek-schema)
   - [Trendyol Market Schema](#trendyol-market-schema)
7. [EER Diagram Creation](#4-eer-diagram-creation)
   - [Tools Setup](#41-tools-setup)
   - [Design Guidelines](#42-design-guidelines)
8. [Getting Started](#getting-started)
   - [Docker Setup](#docker-setup)
9. [TODO](#todo)
10. [Usage](#usage)
11. [License](#license)

## 1. Project Overview

This project implements a database system to analyze data from major Turkish e-commerce platforms:

- Initial focus on Amazon.com.tr
- Future integration with Hepsiburada
- Future integration with Trendyol

## 2. Technical Requirements

### 2.1 Development Environment

- Docker Desktop
  - Windows: WSL 2 enabled
  - macOS: Apple Silicon or Intel version
  - Linux: Docker Engine
- VS Code with extensions:
  - Docker
  - PlantUML
  - PostgreSQL
- Git for version control

## 3. Data Requirements

### 3.1 Common Data Structures

- Unique identifiers for all entities
- Timestamps for record tracking
- Multi-language support
- Multi-currency support
- Audit trail information
- Soft delete capability
- Version control for critical data

### 3.2 Platform-Specific Data

## Amazon Database Initialization

### Users Schema

#### 1. Users Table (`users.users`)
- **Purpose:** This table stores the core information for each user registered on the platform.
- **Key Features:**
  - Each user is uniquely identified by a `user_id`.
  - Users must provide a valid `email` address, which is used for login and communication.
  - Passwords are securely stored using a `password_hash` and `password_salt`.
  - Users can optionally provide their `first_name`, `last_name`, and `phone` number.
  - The `is_active` field indicates whether a user's account is currently active.
  - Timestamps such as `last_login`, `created_at`, and `updated_at` help track user activity and account changes.
  - Soft deletion is supported with the `is_deleted` and `deleted_at` fields, allowing accounts to be marked as deleted without permanent removal.

#### 2. Contact Information Table (`users.contact_info`)
- **Purpose:** This table manages additional contact methods for users, such as alternative emails or phone numbers.
- **Key Features:**
  - Each contact entry is uniquely identified by a `contact_id`.
  - The `user_id` links each contact method to a specific user.
  - `contact_type` specifies the type of contact (e.g., email, phone).
  - `contact_value` holds the actual contact information.
  - The `is_primary` field indicates if this is the user's primary contact method.

#### 3. Saved Carts Table (`users.saved_carts`)
- **Purpose:** This table allows users to save their shopping carts for future purchases.
- **Key Features:**
  - Each saved cart is uniquely identified by a `cart_id`.
  - The `user_id` links the cart to a specific user.
  - `cart_items` is a JSON array that stores the items in the cart, including product IDs and quantities.
  - Timestamps `created_at` and `updated_at` track when the cart was created and last modified.

#### 4. User Roles Table (`users.user_roles`)
- **Purpose:** This table assigns roles to users, defining their permissions and access levels within the platform.
- **Key Features:**
  - Each role assignment is uniquely identified by a `role_id`.
  - The `user_id` links the role to a specific user.
  - `role_name` specifies the role (e.g., admin, customer).
  - The `created_at` timestamp records when the role was assigned.

#### 5. Addresses Table (`users.addresses`)
- **Purpose:** This table stores multiple addresses for users, such as billing and shipping addresses.
- **Key Features:**
  - Each address is uniquely identified by an `address_id`.
  - The `user_id` links the address to a specific user.
  - `address_type` indicates whether the address is for billing or shipping.
  - Address details include `address_line1`, `address_line2`, `city`, `state`, `postal_code`, and `country_code`.
  - The `is_default` field indicates if this is the user's default address for transactions.

#### 6. Preferences Table (`users.preferences`)
- **Purpose:** This table stores user preferences for language, currency, and notification settings.
- **Key Features:**
  - Each preference set is uniquely identified by a `preference_id`.
  - The `user_id` links the preferences to a specific user.
  - `default_language` and `default_currency` store the user's preferred language and currency.
  - `notification_settings` and `privacy_settings` are JSON objects that store user-specific settings for notifications and privacy.

#### 7. User Security Table (`users.user_security`)
- **Purpose:** This table manages security settings for users, including two-factor authentication and security questions.
- **Key Features:**
  - Each security setting is uniquely identified by a `security_id`.
  - The `user_id` links the security settings to a specific user.
  - `two_factor_enabled` indicates if two-factor authentication is active for the user.
  - `security_questions` is a JSON array storing security questions and answers for account recovery.

#### 8. Languages Table (`users.languages`)
- **Purpose:** This table defines the languages supported by the platform.
- **Key Features:**
  - Each language is uniquely identified by a `language_code`.
  - `language_name` provides the name of the language.
  - The `is_default` field indicates if this language is the default for the platform.

#### 9. Saved Payments Table (`users.saved_payments`)
- **Purpose:** This table allows users to save their preferred payment methods for quick access during checkout.
- **Key Features:**
  - Each saved payment method is uniquely identified by a `saved_payment_id`.
  - The `user_id` links the payment method to a specific user.
  - `payment_method_id` references the actual payment method details stored elsewhere.
  - Users can assign a `nickname` to each payment method for easy identification.
  - The `is_active` field indicates if the payment method is currently active and available for use.

### Products Schema

#### 1. Categories Table (`products.categories`)
- **Purpose:** Organizes products into hierarchical categories for easier navigation and filtering.
- **Key Features:**
  - Each category is uniquely identified by a `category_id`.
  - Supports nested category structures with `parent_id`.
  - `name` and `slug` provide identifiers for each category.
  - `level` and `path` represent the category's position in the hierarchy.
  - The `is_active` field indicates if the category is visible to users.

#### 2. Brands Table (`products.brands`)
- **Purpose:** Stores information about product brands, allowing filtering and searching by brand.
- **Key Features:**
  - Each brand is uniquely identified by a `brand_id`.
  - `name` and `slug` provide identifiers for each brand.
  - Includes `description`, `logo_url`, and `website_url`.
  - The `is_active` field indicates if the brand is available for association with products.

#### 3. Products Table (`products.products`)
- **Purpose:** Stores detailed information about each product available on the platform.
- **Key Features:**
  - Each product is uniquely identified by a `product_id`.
  - Links to specific sellers, categories, and brands.
  - `name`, `slug`, and `description` provide identifiers and details.
  - The `is_active` field indicates if the product is available for purchase.
  - Timestamps track when the product was added and modified.

#### 4. Product Specifications Table (`products.product_specifications`)
- **Purpose:** Stores key-value pairs of specifications for each product.
- **Key Features:**
  - Each specification is uniquely identified by a `specification_id`.
  - Links to specific products.
  - Stores specification `key` and `value`.
  - Timestamp records when the specification was added.

#### 5. Product Images Table (`products.product_images`)
- **Purpose:** Stores images associated with products, enhancing visual presentation.
- **Key Features:**
  - Each image is uniquely identified by an `image_id`.
  - Links to specific products.
  - Stores image `url` and `alt_text`.
  - `sort_order` and `is_primary` determine display order and main image.
  - Timestamp records when the image was added.

#### 6. Product Variants Table (`products.product_variants`)
- **Purpose:** Stores variations of a product, such as different sizes or colors.
- **Key Features:**
  - Each variant is uniquely identified by a `variant_id`.
  - Links to specific products.
  - Stores `sku`, `name`, and `attributes`.
  - The `is_active` field indicates if the variant is available for purchase.
  - Timestamps track when the variant was added and modified.

#### 7. Warehouses Table (`products.warehouses`)
- **Purpose:** Stores information about warehouses where products are stored.
- **Key Features:**
  - Each warehouse is uniquely identified by a `warehouse_id`.
  - Stores `name`, `code`, and address details.
  - The `is_active` field indicates if the warehouse is operational.
  - Timestamp records when the warehouse was added.

#### 8. Inventory Table (`products.inventory`)
- **Purpose:** Tracks inventory levels of products and their variants across warehouses.
- **Key Features:**
  - Each inventory record is uniquely identified by an `inventory_id`.
  - Links to specific product variants and warehouses.
  - Tracks `quantity`, `reserved_quantity`, and `reorder_point`.
  - Timestamp records when the inventory was modified.

#### 9. Reviews Table (`products.reviews`)
- **Purpose:** Stores user reviews for products, providing feedback and ratings.
- **Key Features:**
  - Each review is uniquely identified by a `review_id`.
  - Links to specific products and users.
  - Stores `rating` and `comment`.
  - Timestamp records when the review was submitted.

#### 10. Inventory Alerts Table (`products.inventory_alerts`)
- **Purpose:** Stores alerts related to inventory levels, such as low stock warnings.
- **Key Features:**
  - Each alert is uniquely identified by an `alert_id`.
  - Links to specific product variants and warehouses.
  - Stores `alert_type` and `alert_details`.
  - Timestamp records when the alert was generated.

### Orders Schema

#### 1. Orders Table (`orders.orders`)
- **Purpose:** Records all customer orders placed on the platform, tracking their status and financial details.
- **Key Features:**
  - Each order is uniquely identified by an `order_id`.
  - `user_id` links the order to the customer who placed it.
  - `order_number` provides a unique identifier for each order.
  - `order_date` records when the order was placed.
  - `status` tracks the current state of the order (e.g., pending, shipped, completed).
  - Financial fields include `currency_code`, `subtotal`, `shipping_cost`, `tax_amount`, and `total_amount`.
  - Timestamps `created_at` and `updated_at` track when the order was created and last modified.

#### 2. Order Items Table (`orders.order_items`)
- **Purpose:** Details the individual items included in each order, including product information and pricing.
- **Key Features:**
  - Each order item is uniquely identified by an `order_item_id`.
  - `order_id` links the item to a specific order.
  - `product_id` references the product being purchased.
  - `quantity` indicates the number of units ordered.
  - `unit_price` and `total_price` provide pricing information for the item.

#### 3. Order History Table (`orders.order_history`)
- **Purpose:** Tracks changes in the status of orders, providing a historical record of order processing.
- **Key Features:**
  - Each history entry is uniquely identified by a `history_id`.
  - `order_id` links the history entry to a specific order.
  - `status` records the order's status at the time of the entry.
  - `comment` provides additional context or notes about the status change.
  - `created_by` references the user who made the change.
  - `created_at` records when the status change occurred.

### Payments Schema

#### 1. Payment Methods Table (`payments.payment_methods`)
- **Purpose:** Stores information about the various payment methods users can use on the platform.
- **Key Features:**
  - Each payment method is uniquely identified by a `payment_method_id`.
  - `user_id` links the payment method to the user who owns it.
  - `type` specifies the type of payment method (e.g., credit card, PayPal).
  - `provider` indicates the payment provider (e.g., Visa, MasterCard).
  - `account_number` stores the account or card number.
  - `expiry_date` records the expiration date of the payment method.
  - The `is_default` field indicates if this is the user's default payment method.
  - The `is_active` field indicates if the payment method is currently active and available for use.

#### 2. Transactions Table (`payments.transactions`)
- **Purpose:** Records all financial transactions processed through the platform.
- **Key Features:**
  - Each transaction is uniquely identified by a `transaction_id`.
  - `order_id` links the transaction to a specific order.
  - `payment_method_id` references the payment method used for the transaction.
  - `amount` records the total amount of the transaction.
  - `currency_code` specifies the currency used in the transaction.
  - `status` tracks the current state of the transaction (e.g., pending, completed, failed).
  - `provider_transaction_id` stores the transaction ID from the payment provider.
  - `created_at` records when the transaction was processed.

#### 3. Installment Plans Table (`payments.installment_plans`)
- **Purpose:** Manages installment plans available for users to pay for their purchases over time.
- **Key Features:**
  - Each installment plan is uniquely identified by a `plan_id`.
  - `payment_method_id` links the plan to a specific payment method.
  - `number_of_installments` specifies how many installments the payment will be divided into.
  - `interest_rate` records the interest rate applied to the installment plan.
  - `created_at` and `updated_at` track when the plan was created and last modified.

### Shipping Schema

#### 1. Carriers Table (`shipping.carriers`)
- **Purpose:** Stores information about the shipping carriers available on the platform.
- **Key Features:**
  - Each carrier is uniquely identified by a `carrier_id`.
  - `name` provides the name of the shipping carrier.
  - `tracking_url` stores the URL format for tracking shipments with this carrier.
  - The `is_active` field indicates if the carrier is currently available for use.

#### 2. Shipping Methods Table (`shipping.shipping_methods`)
- **Purpose:** Defines the various shipping methods offered by the platform.
- **Key Features:**
  - Each shipping method is uniquely identified by a `method_id`.
  - `carrier_id` links the method to a specific shipping carrier.
  - `name` provides a descriptive name for the shipping method.
  - `delivery_time` estimates the time required for delivery.
  - `cost` specifies the base cost of using this shipping method.
  - The `is_active` field indicates if the shipping method is currently available for selection.

#### 3. Shipments Table (`shipping.shipments`)
- **Purpose:** Records all shipments processed through the platform, tracking their status and details.
- **Key Features:**
  - Each shipment is uniquely identified by a `shipment_id`.
  - `order_id` links the shipment to a specific order.
  - `carrier_id` and `method_id` reference the carrier and method used for the shipment.
  - `tracking_number` stores the tracking number provided by the carrier.
  - `status` tracks the current state of the shipment (e.g., in transit, delivered).
  - `shipped_at` and `delivered_at` record the timestamps for when the shipment was sent and received.

### Analytics Schema

#### 1. User Activity Table (`analytics.user_activity`)
- **Purpose:** Tracks user interactions and activities on the platform, providing insights into user behavior.
- **Key Features:**
  - Each activity is uniquely identified by an `activity_id`.
  - `user_id` links the activity to a specific user.
  - `activity_type` specifies the type of activity (e.g., login, purchase).
  - `activity_details` stores additional information about the activity in a JSONB format.
  - `created_at` records when the activity occurred.

#### 2. Product Views Table (`analytics.product_views`)
- **Purpose:** Records views of products by users, helping to analyze product popularity and user interest.
- **Key Features:**
  - Each view is uniquely identified by a `view_id`.
  - `user_id` links the view to a specific user.
  - `product_id` references the product that was viewed.
  - `viewed_at` records the timestamp when the product was viewed.

#### 3. Sales Performance Table (`analytics.sales_performance`)
- **Purpose:** Aggregates sales data to evaluate the performance of products and categories over time.
- **Key Features:**
  - Each record is uniquely identified by a `performance_id`.
  - `product_id` and `category_id` link the performance data to specific products and categories.
  - `sales_date` records the date of the sales data.
  - `units_sold` and `total_revenue` provide metrics on sales volume and revenue.
  - `created_at` records when the performance data was generated.

### Marketplace Schema

#### 1. Sellers Table (`marketplace.sellers`)
- **Purpose:** Stores information about sellers who list products on the platform.
- **Key Features:**
  - Each seller is uniquely identified by a `seller_id`.
  - `name` provides the name of the seller or business.
  - `email` and `phone` store contact information for the seller.
  - `address` fields store the seller's business address.
  - The `is_active` field indicates if the seller is currently active on the platform.
  - `created_at` and `updated_at` track when the seller was added and last modified.

#### 2. Seller Ratings Table (`marketplace.seller_ratings`)
- **Purpose:** Records ratings and reviews for sellers, providing feedback on their performance.
- **Key Features:**
  - Each rating is uniquely identified by a `rating_id`.
  - `seller_id` links the rating to a specific seller.
  - `user_id` links the rating to the user who provided it.
  - `rating` provides a numerical score for the seller.
  - `comment` offers additional feedback from the user.
  - `created_at` records when the rating was submitted.

#### 3. Listings Table (`marketplace.listings`)
- **Purpose:** Manages product listings by sellers, including pricing and availability.
- **Key Features:**
  - Each listing is uniquely identified by a `listing_id`.
  - `seller_id` links the listing to a specific seller.
  - `product_id` references the product being listed.
  - `price` and `quantity` provide pricing and stock information.
  - The `is_active` field indicates if the listing is currently available for purchase.
  - `created_at` and `updated_at` track when the listing was added and last modified.

### Promotions Schema

#### 1. Promotions Table (`promotions.promotions`)
- **Purpose:** Stores information about promotional campaigns available on the platform.
- **Key Features:**
  - Each promotion is uniquely identified by a `promotion_id`.
  - `name` provides a descriptive name for the promotion.
  - `description` offers details about the promotion.
  - `start_date` and `end_date` define the active period of the promotion.
  - `discount_type` specifies the type of discount (e.g., percentage, fixed amount).
  - `discount_value` indicates the value of the discount.
  - The `is_active` field indicates if the promotion is currently active.

#### 2. Promotion Products Table (`promotions.promotion_products`)
- **Purpose:** Links promotions to specific products, indicating which products are eligible for the promotion.
- **Key Features:**
  - Each record is uniquely identified by a `promotion_product_id`.
  - `promotion_id` links the record to a specific promotion.
  - `product_id` references the product eligible for the promotion.
  - `created_at` records when the link was established.

#### 3. Promotion Usage Table (`promotions.promotion_usage`)
- **Purpose:** Tracks the usage of promotions by users, providing insights into promotion effectiveness.
- **Key Features:**
  - Each usage record is uniquely identified by a `usage_id`.
  - `promotion_id` links the usage to a specific promotion.
  - `user_id` links the usage to the user who utilized the promotion.
  - `order_id` references the order where the promotion was applied.
  - `used_at` records when the promotion was used.

### Prime Schema

#### 1. Prime Memberships Table (`prime.prime_memberships`)
- **Purpose:** Stores information about users' prime memberships, including their status and benefits.
- **Key Features:**
  - Each membership is uniquely identified by a `membership_id`.
  - `user_id` links the membership to a specific user.
  - `start_date` and `end_date` define the active period of the membership.
  - `status` indicates the current state of the membership (e.g., active, expired).
  - `benefits` is a JSONB field storing details about the benefits associated with the membership.
  - `created_at` and `updated_at` track when the membership was added and last modified.

#### 2. Prime Benefits Table (`prime.prime_benefits`)
- **Purpose:** Defines the various benefits available to prime members.
- **Key Features:**
  - Each benefit is uniquely identified by a `benefit_id`.
  - `name` provides a descriptive name for the benefit.
  - `description` offers details about what the benefit entails.
  - The `is_active` field indicates if the benefit is currently available to members.

#### 3. Prime Usage Table (`prime.prime_usage`)
- **Purpose:** Tracks the usage of prime benefits by members, providing insights into benefit utilization.
- **Key Features:**
  - Each usage record is uniquely identified by a `usage_id`.
  - `membership_id` links the usage to a specific prime membership.
  - `benefit_id` references the benefit being used.
  - `used_at` records when the benefit was utilized.

### Video Schema

#### 1. Videos Table (`video.videos`)
- **Purpose:** Stores information about videos available on the platform, including metadata and content details.
- **Key Features:**
  - Each video is uniquely identified by a `video_id`.
  - `title` provides the name of the video.
  - `description` offers a summary or details about the video content.
  - `url` stores the location of the video file.
  - `thumbnail_url` provides a link to the video's thumbnail image.
  - `duration` records the length of the video in seconds.
  - `created_at` and `updated_at` track when the video was added and last modified.

#### 2. Video Categories Table (`video.video_categories`)
- **Purpose:** Organizes videos into categories for easier navigation and filtering.
- **Key Features:**
  - Each category is uniquely identified by a `category_id`.
  - `name` provides a descriptive name for the category.
  - `description` offers details about the category.
  - The `is_active` field indicates if the category is currently available for use.

#### 3. Video Views Table (`video.video_views`)
- **Purpose:** Tracks views of videos by users, providing insights into video popularity and user engagement.
- **Key Features:**
  - Each view is uniquely identified by a `view_id`.
  - `video_id` links the view to a specific video.
  - `user_id` links the view to the user who watched the video.
  - `viewed_at` records the timestamp when the video was viewed.

## Hepsiburada Database Initialization

### Hepsiburada Users Schema

#### 1. Users Table (`hepsiburada.users`)
- **Purpose:** This table stores the core information for each user registered on the platform.
- **Key Features:**
  - Each user is uniquely identified by a `user_id`.
  - Users must provide a valid `email` address, which is used for login and communication.
  - Passwords are securely stored using a `password_hash` and `password_salt`.
  - Users can optionally provide their `first_name`, `last_name`, and `phone` number.
  - The `is_active` field indicates whether a user's account is currently active.
  - Timestamps such as `last_login`, `created_at`, and `updated_at` help track user activity and account changes.
  - Soft deletion is supported with the `is_deleted` and `deleted_at` fields, allowing accounts to be marked as deleted without permanent removal.

#### 2. Contact Information Table (`hepsiburada.contact_info`)
- **Purpose:** This table manages additional contact methods for users, such as alternative emails or phone numbers.
- **Key Features:**
  - Each contact entry is uniquely identified by a `contact_id`.
  - The `user_id` links each contact method to a specific user.
  - `contact_type` specifies the type of contact (e.g., email, phone).
  - `contact_value` holds the actual contact information.
  - The `is_primary` field indicates if this is the user's primary contact method.

#### 3. Saved Carts Table (`hepsiburada.saved_carts`)
- **Purpose:** This table allows users to save their shopping carts for future purchases.
- **Key Features:**
  - Each saved cart is uniquely identified by a `cart_id`.
  - The `user_id` links the cart to a specific user.
  - `cart_items` is a JSON array that stores the items in the cart, including product IDs and quantities.
  - Timestamps `created_at` and `updated_at` track when the cart was created and last modified.

#### 4. User Roles Table (`hepsiburada.user_roles`)
- **Purpose:** This table assigns roles to users, defining their permissions and access levels within the platform.
- **Key Features:**
  - Each role assignment is uniquely identified by a `role_id`.
  - The `user_id` links the role to a specific user.
  - `role_name` specifies the role (e.g., admin, customer).
  - The `created_at` timestamp records when the role was assigned.

#### 5. Addresses Table (`hepsiburada.addresses`)
- **Purpose:** This table stores multiple addresses for users, such as billing and shipping addresses.
- **Key Features:**
  - Each address is uniquely identified by an `address_id`.
  - The `user_id` links the address to a specific user.
  - `address_type` indicates whether the address is for billing or shipping.
  - Address details include `address_line1`, `address_line2`, `city`, `state`, `postal_code`, and `country_code`.
  - The `is_default` field indicates if this is the user's default address for transactions.

#### 6. Preferences Table (`hepsiburada.preferences`)
- **Purpose:** This table stores user preferences for language, currency, and notification settings.
- **Key Features:**
  - Each preference set is uniquely identified by a `preference_id`.
  - The `user_id` links the preferences to a specific user.
  - `default_language` and `default_currency` store the user's preferred language and currency.
  - `notification_settings` and `privacy_settings` are JSON objects that store user-specific settings for notifications and privacy.

#### 7. User Security Table (`hepsiburada.user_security`)
- **Purpose:** This table manages security settings for users, including two-factor authentication and security questions.
- **Key Features:**
  - Each security setting is uniquely identified by a `security_id`.
  - The `user_id` links the security settings to a specific user.
  - `two_factor_enabled` indicates if two-factor authentication is active for the user.
  - `security_questions` is a JSON array storing security questions and answers for account recovery.

#### 8. Languages Table (`hepsiburada.languages`)
- **Purpose:** This table defines the languages supported by the platform.
- **Key Features:**
  - Each language is uniquely identified by a `language_code`.
  - `language_name` provides the name of the language.
  - The `is_default` field indicates if this language is the default for the platform.

#### 9. Saved Payments Table (`hepsiburada.saved_payments`)
- **Purpose:** This table allows users to save their preferred payment methods for quick access during checkout.
- **Key Features:**
  - Each saved payment method is uniquely identified by a `saved_payment_id`.
  - The `user_id` links the payment method to a specific user.
  - `payment_method_id` references the actual payment method details stored elsewhere.
  - Users can assign a `nickname` to each payment method for easy identification.
  - The `is_active` field indicates if the payment method is currently active and available for use.

### Hepsiburada Products Schema

#### 1. Categories Table (`hepsiburada.categories`)
- **Purpose:** Organizes products into hierarchical categories for easier navigation and filtering.
- **Key Features:**
  - Each category is uniquely identified by a `category_id`.
  - Supports nested category structures with `parent_id`.
  - `name` and `slug` provide identifiers for each category.
  - `level` and `path` represent the category's position in the hierarchy.
  - The `is_active` field indicates if the category is visible to users.

#### 2. Brands Table (`hepsiburada.brands`)
- **Purpose:** Stores information about product brands, allowing filtering and searching by brand.
- **Key Features:**
  - Each brand is uniquely identified by a `brand_id`.
  - `name` and `slug` provide identifiers for each brand.
  - Includes `description`, `logo_url`, and `website_url`.
  - The `is_active` field indicates if the brand is available for association with products.

#### 3. Products Table (`hepsiburada.products`)
- **Purpose:** Stores detailed information about each product available on the platform.
- **Key Features:**
  - Each product is uniquely identified by a `product_id`.
  - Links to specific sellers, categories, and brands.
  - `name`, `slug`, and `description` provide identifiers and details.
  - The `is_active` field indicates if the product is available for purchase.
  - Timestamps track when the product was added and modified.

#### 4. Product Specifications Table (`hepsiburada.product_specifications`)
- **Purpose:** Stores key-value pairs of specifications for each product.
- **Key Features:**
  - Each specification is uniquely identified by a `specification_id`.
  - Links to specific products.
  - Stores specification `key` and `value`.
  - Timestamp records when the specification was added.

#### 5. Product Images Table (`hepsiburada.product_images`)
- **Purpose:** Stores images associated with products, enhancing visual presentation.
- **Key Features:**
  - Each image is uniquely identified by an `image_id`.
  - Links to specific products.
  - Stores image `url` and `alt_text`.
  - `sort_order` and `is_primary` determine display order and main image.
  - Timestamp records when the image was added.

#### 6. Product Variants Table (`hepsiburada.product_variants`)
- **Purpose:** Stores variations of a product, such as different sizes or colors.
- **Key Features:**
  - Each variant is uniquely identified by a `variant_id`.
  - Links to specific products.
  - Stores `sku`, `name`, and `attributes`.
  - The `is_active` field indicates if the variant is available for purchase.
  - Timestamps track when the variant was added and modified.

#### 7. Warehouses Table (`hepsiburada.warehouses`)
- **Purpose:** Stores information about warehouses where products are stored.
- **Key Features:**
  - Each warehouse is uniquely identified by a `warehouse_id`.
  - Stores `name`, `code`, and address details.
  - The `is_active` field indicates if the warehouse is operational.
  - Timestamp records when the warehouse was added.

#### 8. Inventory Table (`hepsiburada.inventory`)
- **Purpose:** Tracks inventory levels of products and their variants across warehouses.
- **Key Features:**
  - Each inventory record is uniquely identified by an `inventory_id`.
  - Links to specific product variants and warehouses.
  - Tracks `quantity`, `reserved_quantity`, and `reorder_point`.
  - Timestamp records when the inventory was modified.

#### 9. Reviews Table (`hepsiburada.reviews`)
- **Purpose:** Stores user reviews for products, providing feedback and ratings.
- **Key Features:**
  - Each review is uniquely identified by a `review_id`.
  - Links to specific products and users.
  - Stores `rating` and `comment`.
  - Timestamp records when the review was submitted.

#### 10. Inventory Alerts Table (`hepsiburada.inventory_alerts`)
- **Purpose:** Stores alerts related to inventory levels, such as low stock warnings.
- **Key Features:**
  - Each alert is uniquely identified by an `alert_id`.
  - Links to specific product variants and warehouses.
  - Stores `alert_type` and `alert_details`.
  - Timestamp records when the alert was generated.

### Hepsiburada Orders Schema

#### 1. Orders Table (`hepsiburada.orders`)
- **Purpose:** Records all customer orders placed on the platform, tracking their status and financial details.
- **Key Features:**
  - Each order is uniquely identified by an `order_id`.
  - `user_id` links the order to the customer who placed it.
  - `order_number` provides a unique identifier for each order.
  - `order_date` records when the order was placed.
  - `status` tracks the current state of the order (e.g., pending, shipped, completed).
  - Financial fields include `currency_code`, `subtotal`, `shipping_cost`, `tax_amount`, and `total_amount`.
  - Timestamps `created_at` and `updated_at` track when the order was created and last modified.

#### 2. Order Items Table (`hepsiburada.order_items`)
- **Purpose:** Details the individual items included in each order, including product information and pricing.
- **Key Features:**
  - Each order item is uniquely identified by an `order_item_id`.
  - `order_id` links the item to a specific order.
  - `product_id` references the product being purchased.
  - `quantity` indicates the number of units ordered.
  - `unit_price` and `total_price` provide pricing information for the item.

#### 3. Order History Table (`hepsiburada.order_history`)
- **Purpose:** Tracks changes in the status of orders, providing a historical record of order processing.
- **Key Features:**
  - Each history entry is uniquely identified by a `history_id`.
  - `order_id` links the history entry to a specific order.
  - `status` records the order's status at the time of the entry.
  - `comment` provides additional context or notes about the status change.
  - `created_by` references the user who made the change.
  - `created_at` records when the status change occurred.

### Hepsiburada Payments Schema

#### 1. Payment Methods Table (`hepsiburada.payment_methods`)
- **Purpose:** Stores information about the various payment methods users can use on the platform.
- **Key Features:**
  - Each payment method is uniquely identified by a `payment_method_id`.
  - `user_id` links the payment method to the user who owns it.
  - `type` specifies the type of payment method (e.g., credit card, PayPal).
  - `provider` indicates the payment provider (e.g., Visa, MasterCard).
  - `account_number` stores the account or card number.
  - `expiry_date` records the expiration date of the payment method.
  - The `is_default` field indicates if this is the user's default payment method.
  - The `is_active` field indicates if the payment method is currently active and available for use.

#### 2. Transactions Table (`hepsiburada.transactions`)
- **Purpose:** Records all financial transactions processed through the platform.
- **Key Features:**
  - Each transaction is uniquely identified by a `transaction_id`.
  - `order_id` links the transaction to a specific order.
  - `payment_method_id` references the payment method used for the transaction.
  - `amount` records the total amount of the transaction.
  - `currency_code` specifies the currency used in the transaction.
  - `status` tracks the current state of the transaction (e.g., pending, completed, failed).
  - `provider_transaction_id` stores the transaction ID from the payment provider.
  - `created_at` records when the transaction was processed.

#### 3. Installment Plans Table (`hepsiburada.installment_plans`)
- **Purpose:** Manages installment plans available for users to pay for their purchases over time.
- **Key Features:**
  - Each installment plan is uniquely identified by a `plan_id`.
  - `payment_method_id` links the plan to a specific payment method.
  - `number_of_installments` specifies how many installments the payment will be divided into.
  - `interest_rate` records the interest rate applied to the installment plan.
  - `created_at` and `updated_at` track when the plan was created and last modified.

### Hepsiburada Shipping Schema

#### 1. Carriers Table (`hepsiburada.carriers`)
- **Purpose:** Stores information about the shipping carriers available on the platform.
- **Key Features:**
  - Each carrier is uniquely identified by a `carrier_id`.
  - `name` provides the name of the shipping carrier.
  - `tracking_url` stores the URL format for tracking shipments with this carrier.
  - The `is_active` field indicates if the carrier is currently available for use.

#### 2. Shipping Methods Table (`hepsiburada.shipping_methods`)
- **Purpose:** Defines the various shipping methods offered by the platform.
- **Key Features:**
  - Each shipping method is uniquely identified by a `method_id`.
  - `carrier_id` links the method to a specific shipping carrier.
  - `name` provides a descriptive name for the shipping method.
  - `delivery_time` estimates the time required for delivery.
  - `cost` specifies the base cost of using this shipping method.
  - The `is_active` field indicates if the shipping method is currently available for selection.

#### 3. Shipments Table (`hepsiburada.shipments`)
- **Purpose:** Records all shipments processed through the platform, tracking their status and details.
- **Key Features:**
  - Each shipment is uniquely identified by a `shipment_id`.
  - `order_id` links the shipment to a specific order.
  - `carrier_id` and `method_id` reference the carrier and method used for the shipment.
  - `tracking_number` stores the tracking number provided by the carrier.
  - `status` tracks the current state of the shipment (e.g., in transit, delivered).
  - `shipped_at` and `delivered_at` record the timestamps for when the shipment was sent and received.

### Hepsiburada Analytics Schema

#### 1. User Activity Table (`hepsiburada.user_activity`)
- **Purpose:** Tracks user interactions and activities on the platform, providing insights into user behavior.
- **Key Features:**
  - Each activity is uniquely identified by an `activity_id`.
  - `user_id` links the activity to a specific user.
  - `activity_type` specifies the type of activity (e.g., login, purchase).
  - `activity_details` stores additional information about the activity in a JSONB format.
  - `created_at` records when the activity occurred.

#### 2. Product Views Table (`hepsiburada.product_views`)
- **Purpose:** Records views of products by users, helping to analyze product popularity and user interest.
- **Key Features:**
  - Each view is uniquely identified by a `view_id`.
  - `user_id` links the view to a specific user.
  - `product_id` references the product that was viewed.
  - `viewed_at` records the timestamp when the product was viewed.

#### 3. Sales Performance Table (`hepsiburada.sales_performance`)
- **Purpose:** Aggregates sales data to evaluate the performance of products and categories over time.
- **Key Features:**
  - Each record is uniquely identified by a `performance_id`.
  - `product_id` and `category_id` link the performance data to specific products and categories.
  - `sales_date` records the date of the sales data.
  - `units_sold` and `total_revenue` provide metrics on sales volume and revenue.
  - `created_at` records when the performance data was generated.

### Hepsiburada Marketplace Schema

#### 1. Sellers Table (`hepsiburada.sellers`)
- **Purpose:** Stores information about sellers who list products on the platform.
- **Key Features:**
  - Each seller is uniquely identified by a `seller_id`.
  - `name` provides the name of the seller or business.
  - `email` and `phone` store contact information for the seller.
  - `address` fields store the seller's business address.
  - The `is_active` field indicates if the seller is currently active on the platform.
  - `created_at` and `updated_at` track when the seller was added and last modified.

#### 2. Seller Ratings Table (`hepsiburada.seller_ratings`)
- **Purpose:** Records ratings and reviews for sellers, providing feedback on their performance.
- **Key Features:**
  - Each rating is uniquely identified by a `rating_id`.
  - `seller_id` links the rating to a specific seller.
  - `user_id` links the rating to the user who provided it.
  - `rating` provides a numerical score for the seller.
  - `comment` offers additional feedback from the user.
  - `created_at` records when the rating was submitted.

#### 3. Listings Table (`hepsiburada.listings`)
- **Purpose:** Manages product listings by sellers, including pricing and availability.
- **Key Features:**
  - Each listing is uniquely identified by a `listing_id`.
  - `seller_id` links the listing to a specific seller.
  - `product_id` references the product being listed.
  - `price` and `quantity` provide pricing and stock information.
  - The `is_active` field indicates if the listing is currently available for purchase.
  - `created_at` and `updated_at` track when the listing was added and last modified.

### Hepsiburada Promotions Schema

#### 1. Promotions Table (`hepsiburada.promotions`)
- **Purpose:** Stores information about promotional campaigns available on the platform.
- **Key Features:**
  - Each promotion is uniquely identified by a `promotion_id`.
  - `name` provides a descriptive name for the promotion.
  - `description` offers details about the promotion.
  - `start_date` and `end_date` define the active period of the promotion.
  - `discount_type` specifies the type of discount (e.g., percentage, fixed amount).
  - `discount_value` indicates the value of the discount.
  - The `is_active` field indicates if the promotion is currently active.

#### 2. Promotion Products Table (`hepsiburada.promotion_products`)
- **Purpose:** Links promotions to specific products, indicating which products are eligible for the promotion.
- **Key Features:**
  - Each record is uniquely identified by a `promotion_product_id`.
  - `promotion_id` links the record to a specific promotion.
  - `product_id` references the product eligible for the promotion.
  - `created_at` records when the link was established.

#### 3. Promotion Usage Table (`hepsiburada.promotion_usage`)
- **Purpose:** Tracks the usage of promotions by users, providing insights into promotion effectiveness.
- **Key Features:**
  - Each usage record is uniquely identified by a `usage_id`.
  - `promotion_id` links the usage to a specific promotion.
  - `user_id` links the usage to the user who utilized the promotion.
  - `order_id` references the order where the promotion was applied.
  - `used_at` records when the promotion was used.

### Hepsiburada Premium Schema

#### 1. Premium Memberships Table (`hepsiburada.premium_memberships`)
- **Purpose:** Stores information about users' premium memberships, including their status and benefits.
- **Key Features:**
  - Each membership is uniquely identified by a `membership_id`.
  - `user_id` links the membership to a specific user.
  - `start_date` and `end_date` define the active period of the membership.
  - `status` indicates the current state of the membership (e.g., active, expired).
  - `benefits` is a JSONB field storing details about the benefits associated with the membership.
  - `created_at` and `updated_at` track when the membership was added and last modified.

#### 2. Premium Benefits Table (`hepsiburada.premium_benefits`)
- **Purpose:** Defines the various benefits available to premium members.
- **Key Features:**
  - Each benefit is uniquely identified by a `benefit_id`.
  - `name` provides a descriptive name for the benefit.
  - `description` offers details about what the benefit entails.
  - The `is_active` field indicates if the benefit is currently available to members.

#### 3. Premium Usage Table (`hepsiburada.premium_usage`)
- **Purpose:** Tracks the usage of premium benefits by members, providing insights into benefit utilization.
- **Key Features:**
  - Each usage record is uniquely identified by a `usage_id`.
  - `membership_id` links the usage to a specific premium membership.
  - `benefit_id` references the benefit being used.
  - `used_at` records when the benefit was utilized.

## Trendyol Database Initialization

### Trendyol Users Schema

#### 1. Users Table (`trendyol.users`)
- **Purpose:** This table stores the core information for each user registered on the platform.
- **Key Features:**
  - Each user is uniquely identified by a `user_id`.
  - Users must provide a valid `email` address, which is used for login and communication.
  - Passwords are securely stored using a `password_hash` and `password_salt`.
  - Users can optionally provide their `first_name`, `last_name`, and `phone` number.
  - The `is_active` field indicates whether a user's account is currently active.
  - Timestamps such as `last_login`, `created_at`, and `updated_at` help track user activity and account changes.
  - Soft deletion is supported with the `is_deleted` and `deleted_at` fields, allowing accounts to be marked as deleted without permanent removal.

#### 2. Contact Information Table (`trendyol.contact_info`)
- **Purpose:** This table manages additional contact methods for users, such as alternative emails or phone numbers.
- **Key Features:**
  - Each contact entry is uniquely identified by a `contact_id`.
  - The `user_id` links each contact method to a specific user.
  - `contact_type` specifies the type of contact (e.g., email, phone).
  - `contact_value` holds the actual contact information.
  - The `is_primary` field indicates if this is the user's primary contact method.

#### 3. Saved Carts Table (`trendyol.saved_carts`)
- **Purpose:** This table allows users to save their shopping carts for future purchases.
- **Key Features:**
  - Each saved cart is uniquely identified by a `cart_id`.
  - The `user_id` links the cart to a specific user.
  - `cart_items` is a JSON array that stores the items in the cart, including product IDs and quantities.
  - Timestamps `created_at` and `updated_at` track when the cart was created and last modified.

#### 4. User Roles Table (`trendyol.user_roles`)
- **Purpose:** This table assigns roles to users, defining their permissions and access levels within the platform.
- **Key Features:**
  - Each role assignment is uniquely identified by a `role_id`.
  - The `user_id` links the role to a specific user.
  - `role_name` specifies the role (e.g., admin, customer).
  - The `created_at` timestamp records when the role was assigned.

#### 5. Addresses Table (`trendyol.addresses`)
- **Purpose:** This table stores multiple addresses for users, such as billing and shipping addresses.
- **Key Features:**
  - Each address is uniquely identified by an `address_id`.
  - The `user_id` links the address to a specific user.
  - `address_type` indicates whether the address is for billing or shipping.
  - Address details include `address_line1`, `address_line2`, `city`, `state`, `postal_code`, and `country_code`.
  - The `is_default` field indicates if this is the user's default address for transactions.

#### 6. Preferences Table (`trendyol.preferences`)
- **Purpose:** This table stores user preferences for language, currency, and notification settings.
- **Key Features:**
  - Each preference set is uniquely identified by a `preference_id`.
  - The `user_id` links the preferences to a specific user.
  - `default_language` and `default_currency` store the user's preferred language and currency.
  - `notification_settings` and `privacy_settings` are JSON objects that store user-specific settings for notifications and privacy.

#### 7. User Security Table (`trendyol.user_security`)
- **Purpose:** This table manages security settings for users, including two-factor authentication and security questions.
- **Key Features:**
  - Each security setting is uniquely identified by a `security_id`.
  - The `user_id` links the security settings to a specific user.
  - `two_factor_enabled` indicates if two-factor authentication is active for the user.
  - `security_questions` is a JSON array storing security questions and answers for account recovery.

#### 8. Languages Table (`trendyol.languages`)
- **Purpose:** This table defines the languages supported by the platform.
- **Key Features:**
  - Each language is uniquely identified by a `language_code`.
  - `language_name` provides the name of the language.
  - The `is_default` field indicates if this language is the default for the platform.

#### 9. Saved Payments Table (`trendyol.saved_payments`)
- **Purpose:** This table allows users to save their preferred payment methods for quick access during checkout.
- **Key Features:**
  - Each saved payment method is uniquely identified by a `saved_payment_id`.
  - The `user_id` links the payment method to a specific user.
  - `payment_method_id` references the actual payment method details stored elsewhere.
  - Users can assign a `nickname` to each payment method for easy identification.
  - The `is_active` field indicates if the payment method is currently active and available for use.

### Trendyol Products Schema

#### 1. Categories Table (`trendyol.categories`)
- **Purpose:** Organizes products into hierarchical categories for easier navigation and filtering.
- **Key Features:**
  - Each category is uniquely identified by a `category_id`.
  - Supports nested category structures with `parent_id`.
  - `name` and `slug` provide identifiers for each category.
  - `level` and `path` represent the category's position in the hierarchy.
  - The `is_active` field indicates if the category is visible to users.

#### 2. Brands Table (`trendyol.brands`)
- **Purpose:** Stores information about product brands, allowing filtering and searching by brand.
- **Key Features:**
  - Each brand is uniquely identified by a `brand_id`.
  - `name` and `slug` provide identifiers for each brand.
  - Includes `description`, `logo_url`, and `website_url`.
  - The `is_active` field indicates if the brand is available for association with products.

#### 3. Products Table (`trendyol.products`)
- **Purpose:** Stores detailed information about each product available on the platform.
- **Key Features:**
  - Each product is uniquely identified by a `product_id`.
  - Links to specific sellers, categories, and brands.
  - `name`, `slug`, and `description` provide identifiers and details.
  - The `is_active` field indicates if the product is available for purchase.
  - Timestamps track when the product was added and modified.

#### 4. Product Specifications Table (`trendyol.product_specifications`)
- **Purpose:** Stores key-value pairs of specifications for each product.
- **Key Features:**
  - Each specification is uniquely identified by a `specification_id`.
  - Links to specific products.
  - Stores specification `key` and `value`.
  - Timestamp records when the specification was added.

#### 5. Product Images Table (`trendyol.product_images`)
- **Purpose:** Stores images associated with products, enhancing visual presentation.
- **Key Features:**
  - Each image is uniquely identified by an `image_id`.
  - Links to specific products.
  - Stores image `url` and `alt_text`.
  - `sort_order` and `is_primary` determine display order and main image.
  - Timestamp records when the image was added.

#### 6. Product Variants Table (`trendyol.product_variants`)
- **Purpose:** Stores variations of a product, such as different sizes or colors.
- **Key Features:**
  - Each variant is uniquely identified by a `variant_id`.
  - Links to specific products.
  - Stores `sku`, `name`, and `attributes`.
  - The `is_active` field indicates if the variant is available for purchase.
  - Timestamps track when the variant was added and modified.

#### 7. Warehouses Table (`trendyol.warehouses`)
- **Purpose:** Stores information about warehouses where products are stored.
- **Key Features:**
  - Each warehouse is uniquely identified by a `warehouse_id`.
  - Stores `name`, `code`, and address details.
  - The `is_active` field indicates if the warehouse is operational.
  - Timestamp records when the warehouse was added.

#### 8. Inventory Table (`trendyol.inventory`)
- **Purpose:** Tracks inventory levels of products and their variants across warehouses.
- **Key Features:**
  - Each inventory record is uniquely identified by an `inventory_id`.
  - Links to specific product variants and warehouses.
  - Tracks `quantity`, `reserved_quantity`, and `reorder_point`.
  - Timestamp records when the inventory was modified.

#### 9. Reviews Table (`trendyol.reviews`)
- **Purpose:** Stores user reviews for products, providing feedback and ratings.
- **Key Features:**
  - Each review is uniquely identified by a `review_id`.
  - Links to specific products and users.
  - Stores `rating` and `comment`.
  - Timestamp records when the review was submitted.

#### 10. Inventory Alerts Table (`trendyol.inventory_alerts`)
- **Purpose:** Stores alerts related to inventory levels, such as low stock warnings.
- **Key Features:**
  - Each alert is uniquely identified by an `alert_id`.
  - Links to specific product variants and warehouses.
  - Stores `alert_type` and `alert_details`.
  - Timestamp records when the alert was generated.

### Trendyol Orders Schema

#### 1. Orders Table (`trendyol.orders`)
- **Purpose:** Records all customer orders placed on the platform, tracking their status and financial details.
- **Key Features:**
  - Each order is uniquely identified by an `order_id`.
  - `user_id` links the order to the customer who placed it.
  - `order_number` provides a unique identifier for each order.
  - `order_date` records when the order was placed.
  - `status` tracks the current state of the order (e.g., pending, shipped, completed).
  - Financial fields include `currency_code`, `subtotal`, `shipping_cost`, `tax_amount`, and `total_amount`.
  - Timestamps `created_at` and `updated_at` track when the order was created and last modified.

#### 2. Order Items Table (`trendyol.order_items`)
- **Purpose:** Details the individual items included in each order, including product information and pricing.
- **Key Features:**
  - Each order item is uniquely identified by an `order_item_id`.
  - `order_id` links the item to a specific order.
  - `product_id` references the product being purchased.
  - `quantity` indicates the number of units ordered.
  - `unit_price` and `total_price` provide pricing information for the item.

#### 3. Order History Table (`trendyol.order_history`)
- **Purpose:** Tracks changes in the status of orders, providing a historical record of order processing.
- **Key Features:**
  - Each history entry is uniquely identified by a `history_id`.
  - `order_id` links the history entry to a specific order.
  - `status` records the order's status at the time of the entry.
  - `comment` provides additional context or notes about the status change.
  - `created_by` references the user who made the change.
  - `created_at` records when the status change occurred.

### Trendyol Payments Schema

#### 1. Payment Methods Table (`trendyol.payment_methods`)
- **Purpose:** Stores information about the various payment methods users can use on the platform.
- **Key Features:**
  - Each payment method is uniquely identified by a `payment_method_id`.
  - `user_id` links the payment method to the user who owns it.
  - `type` specifies the type of payment method (e.g., credit card, PayPal).
  - `provider` indicates the payment provider (e.g., Visa, MasterCard).
  - `account_number` stores the account or card number.
  - `expiry_date` records the expiration date of the payment method.
  - The `is_default` field indicates if this is the user's default payment method.
  - The `is_active` field indicates if the payment method is currently active and available for use.

#### 2. Transactions Table (`trendyol.transactions`)
- **Purpose:** Records all financial transactions processed through the platform.
- **Key Features:**
  - Each transaction is uniquely identified by a `transaction_id`.
  - `order_id` links the transaction to a specific order.
  - `payment_method_id` references the payment method used for the transaction.
  - `amount` records the total amount of the transaction.
  - `currency_code` specifies the currency used in the transaction.
  - `status` tracks the current state of the transaction (e.g., pending, completed, failed).
  - `provider_transaction_id` stores the transaction ID from the payment provider.
  - `created_at` records when the transaction was processed.

#### 3. Installment Plans Table (`trendyol.installment_plans`)
- **Purpose:** Manages installment plans available for users to pay for their purchases over time.
- **Key Features:**
  - Each installment plan is uniquely identified by a `plan_id`.
  - `payment_method_id` links the plan to a specific payment method.
  - `number_of_installments` specifies how many installments the payment will be divided into.
  - `interest_rate` records the interest rate applied to the installment plan.
  - `created_at` and `updated_at` track when the plan was created and last modified.

### Trendyol Shipping Schema

#### 1. Carriers Table (`trendyol.carriers`)
- **Purpose:** Stores information about the shipping carriers available on the platform.
- **Key Features:**
  - Each carrier is uniquely identified by a `carrier_id`.
  - `name` provides the name of the shipping carrier.
  - `tracking_url` stores the URL format for tracking shipments with this carrier.
  - The `is_active` field indicates if the carrier is currently available for use.

#### 2. Shipping Methods Table (`trendyol.shipping_methods`)
- **Purpose:** Defines the various shipping methods offered by the platform.
- **Key Features:**
  - Each shipping method is uniquely identified by a `method_id`.
  - `carrier_id` links the method to a specific shipping carrier.
  - `name` provides a descriptive name for the shipping method.
  - `delivery_time` estimates the time required for delivery.
  - `cost` specifies the base cost of using this shipping method.
  - The `is_active` field indicates if the shipping method is currently available for selection.

#### 3. Shipments Table (`trendyol.shipments`)
- **Purpose:** Records all shipments processed through the platform, tracking their status and details.
- **Key Features:**
  - Each shipment is uniquely identified by a `shipment_id`.
  - `order_id` links the shipment to a specific order.
  - `carrier_id` and `method_id` reference the carrier and method used for the shipment.
  - `tracking_number` stores the tracking number provided by the carrier.
  - `status` tracks the current state of the shipment (e.g., in transit, delivered).
  - `shipped_at` and `delivered_at` record the timestamps for when the shipment was sent and received.

### Trendyol Analytics Schema

#### 1. User Activity Table (`trendyol.user_activity`)
- **Purpose:** Tracks user interactions and activities on the platform, providing insights into user behavior.
- **Key Features:**
  - Each activity is uniquely identified by an `activity_id`.
  - `user_id` links the activity to a specific user.
  - `activity_type` specifies the type of activity (e.g., login, purchase).
  - `activity_details` stores additional information about the activity in a JSONB format.
  - `created_at` records when the activity occurred.

#### 2. Product Views Table (`trendyol.product_views`)
- **Purpose:** Records views of products by users, helping to analyze product popularity and user interest.
- **Key Features:**
  - Each view is uniquely identified by a `view_id`.
  - `user_id` links the view to a specific user.
  - `product_id` references the product that was viewed.
  - `viewed_at` records the timestamp when the product was viewed.

#### 3. Sales Performance Table (`trendyol.sales_performance`)
- **Purpose:** Aggregates sales data to evaluate the performance of products and categories over time.
- **Key Features:**
  - Each record is uniquely identified by a `performance_id`.
  - `product_id` and `category_id` link the performance data to specific products and categories.
  - `sales_date` records the date of the sales data.
  - `units_sold` and `total_revenue` provide metrics on sales volume and revenue.
  - `created_at` records when the performance data was generated.

### Trendyol Marketplace Schema

#### 1. Sellers Table (`trendyol.sellers`)
- **Purpose:** Stores information about sellers who list products on the platform.
- **Key Features:**
  - Each seller is uniquely identified by a `seller_id`.
  - `name` provides the name of the seller or business.
  - `email` and `phone` store contact information for the seller.
  - `address` fields store the seller's business address.
  - The `is_active` field indicates if the seller is currently active on the platform.
  - `created_at` and `updated_at` track when the seller was added and last modified.

#### 2. Seller Ratings Table (`trendyol.seller_ratings`)
- **Purpose:** Records ratings and reviews for sellers, providing feedback on their performance.
- **Key Features:**
  - Each rating is uniquely identified by a `rating_id`.
  - `seller_id` links the rating to a specific seller.
  - `user_id` links the rating to the user who provided it.
  - `rating` provides a numerical score for the seller.
  - `comment` offers additional feedback from the user.
  - `created_at` records when the rating was submitted.

#### 3. Listings Table (`trendyol.listings`)
- **Purpose:** Manages product listings by sellers, including pricing and availability.
- **Key Features:**
  - Each listing is uniquely identified by a `listing_id`.
  - `seller_id` links the listing to a specific seller.
  - `product_id` references the product being listed.
  - `price` and `quantity` provide pricing and stock information.
  - The `is_active` field indicates if the listing is currently available for purchase.
  - `created_at` and `updated_at` track when the listing was added and last modified.

### Trendyol Promotions Schema

#### 1. Promotions Table (`trendyol.promotions`)
- **Purpose:** Stores information about promotional campaigns available on the platform.
- **Key Features:**
  - Each promotion is uniquely identified by a `promotion_id`.
  - `name` provides a descriptive name for the promotion.
  - `description` offers details about the promotion.
  - `start_date` and `end_date` define the active period of the promotion.
  - `discount_type` specifies the type of discount (e.g., percentage, fixed amount).
  - `discount_value` indicates the value of the discount.
  - The `is_active` field indicates if the promotion is currently active.

#### 2. Promotion Products Table (`trendyol.promotion_products`)
- **Purpose:** Links promotions to specific products, indicating which products are eligible for the promotion.
- **Key Features:**
  - Each record is uniquely identified by a `promotion_product_id`.
  - `promotion_id` links the record to a specific promotion.
  - `product_id` references the product eligible for the promotion.
  - `created_at` records when the link was established.

#### 3. Promotion Usage Table (`trendyol.promotion_usage`)
- **Purpose:** Tracks the usage of promotions by users, providing insights into promotion effectiveness.
- **Key Features:**
  - Each usage record is uniquely identified by a `usage_id`.
  - `promotion_id` links the usage to a specific promotion.
  - `user_id` links the usage to the user who utilized the promotion.
  - `order_id` references the order where the promotion was applied.
  - `used_at` records when the promotion was used.

### Trendyol Yemek Schema

#### 1. Restaurants Table (`trendyol_yemek.restaurants`)
- **Purpose:** Stores information about restaurants available on the platform.
- **Key Features:**
  - Each restaurant is uniquely identified by a `restaurant_id`.
  - `name` provides the name of the restaurant.
  - `address` fields store the restaurant's location.
  - `phone` stores contact information for the restaurant.
  - The `is_active` field indicates if the restaurant is currently active on the platform.
  - `created_at` and `updated_at` track when the restaurant was added and last modified.

#### 2. Menus Table (`trendyol_yemek.menus`)
- **Purpose:** Stores menu items offered by restaurants.
- **Key Features:**
  - Each menu item is uniquely identified by a `menu_id`.
  - `restaurant_id` links the menu item to a specific restaurant.
  - `name` provides the name of the menu item.
  - `description` offers details about the menu item.
  - `price` specifies the cost of the menu item.
  - The `is_active` field indicates if the menu item is currently available.

#### 3. Orders Table (`trendyol_yemek.orders`)
- **Purpose:** Records all food orders placed on the platform, tracking their status and details.
- **Key Features:**
  - Each order is uniquely identified by an `order_id`.
  - `user_id` links the order to the customer who placed it.
  - `restaurant_id` links the order to the restaurant fulfilling it.
  - `order_date` records when the order was placed.
  - `status` tracks the current state of the order (e.g., pending, delivered).
  - `total_amount` records the total cost of the order.
  - Timestamps `created_at` and `updated_at` track when the order was created and last modified.

### Trendyol Market Schema

#### 1. Stores Table (`trendyol_market.stores`)
- **Purpose:** Stores information about stores available on the platform.
- **Key Features:**
  - Each store is uniquely identified by a `store_id`.
  - `name` provides the name of the store.
  - `address` fields store the store's location.
  - `phone` stores contact information for the store.
  - The `is_active` field indicates if the store is currently active on the platform.
  - `created_at` and `updated_at` track when the store was added and last modified.

#### 2. Products Table (`trendyol_market.products`)
- **Purpose:** Stores detailed information about each product available in the market.
- **Key Features:**
  - Each product is uniquely identified by a `product_id`.
  - `store_id` links the product to a specific store.
  - `name`, `slug`, and `description` provide identifiers and details.
  - `price` specifies the cost of the product.
  - The `is_active` field indicates if the product is available for purchase.
  - Timestamps track when the product was added and modified.

#### 3. Orders Table (`trendyol_market.orders`)
- **Purpose:** Records all market orders placed on the platform, tracking their status and details.
- **Key Features:**
  - Each order is uniquely identified by an `order_id`.
  - `user_id` links the order to the customer who placed it.
  - `store_id` links the order to the store fulfilling it.
  - `order_date` records when the order was placed.
  - `status` tracks the current state of the order (e.g., pending, delivered).
  - `total_amount` records the total cost of the order.
  - Timestamps `created_at` and `updated_at` track when the order was created and last modified.


## EER Diagram Creation

### 4.1 Tools Setup

1. **PlantUML Setup**
   - Install PlantUML extension
   - Configure Java runtime
   - Set up rendering preview

### 4.2 Design Guidelines

1. **Color Coding**

   - Users & Auth: Blue (#2196F3)
   - Products: Green (#4CAF50)
   - Orders: Orange (#FF9800)
   - Platform-specific: Purple (#9C27B0)

2. **Relationship Notation**

   - **One-to-One**: `||--||` - A single instance of an entity is associated with a single instance of another entity.
   - **One-to-Many**: `||--o{` - A single instance of an entity is associated with multiple instances of another entity.
   - **Many-to-Many**: `o{--o{` - Multiple instances of an entity are associated with multiple instances of another entity. This often requires a junction table to implement.
   - **Optional**: `o--` - The relationship is optional, meaning an instance of an entity may or may not be associated with an instance of another entity.
   - **Mandatory**: `||--` - The relationship is mandatory, meaning an instance of an entity must be associated with an instance of another entity.

3. **Entity Organization**
   - Group by domain
   - Clear hierarchy
   - Consistent naming
   - Proper spacing

### 4.3 EER Diagram with Specialization

## Getting Started

### Docker Setup

1. **Build the Docker Image**
   ```bash
   docker build -t ecommerce-db .
   ```

2. **Run the Container**
   ```bash
   docker run -d \
     --name ecommerce-postgres \
     ecommerce-db
   ```

This will:
- Build the image with all database schemas and initialization scripts
- Start a container named 'ecommerce-postgres'
- Map port 5432 to allow local connections
- Set up the databases with the configured credentials

## TODO
### AMAZON
* Relationların PK ve FK'ları derstekine uygun değişicek
* EER diagram oluşucak
* Data requirements yazılacak

## Usage

After setting up the database, you can connect to it using your preferred SQL client and start querying or modifying the data as needed.

## License

This project is licensed under the MIT License.

## Setting Up Amazon Diagram on macOS

To set up and view the `amazon_diagram.puml` on a macOS machine, follow these steps:

### Prerequisites

1. **Install Java:**
   - Ensure Java is installed on your system. You can check this by running `java -version` in the terminal.
   - If Java is not installed, download and install it from the [official Oracle website](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) or use Homebrew:
     ```bash
     brew install openjdk
     ```

2. **Install Graphviz:**
   - Graphviz is required by PlantUML to render diagrams. Install it using Homebrew:
     ```bash
     brew install graphviz
     ```

3. **Download PlantUML:**
   - Ensure you have the `plantuml.jar` file. If not, download it from the [official PlantUML website](http://plantuml.com/download).

### Steps to Generate and View the Diagram

1. **Navigate to the Directory:**
   - Open the terminal and navigate to the directory containing your `amazon_diagram.puml` and `plantuml.jar` files:
     ```bash
     cd path/to/your/diagrams
     ```

2. **Generate the Diagram:**
   - Run the following command to generate a PNG or PDF of the diagram:
     ```bash
     java -jar plantuml.jar amazon_diagram.puml
     ```
   - This will create a `amazon_diagram.png` or `amazon_diagram.pdf` file in the same directory.

3. **View the Diagram:**
   - Open the generated PNG or PDF file using the Preview app or any other image/PDF viewer on macOS.

### Additional Tips

- **Ensure PATH is Set Correctly:**
  - If you encounter issues with Graphviz, ensure that the `dot` executable is in your system's PATH. You can check this by running `dot -V` in the terminal.

- **Troubleshooting:**
  - If you face any issues, ensure that all software is up to date and that you have the necessary permissions to execute files in the directory.

By following these steps, you should be able to set up and view the `amazon_diagram.puml` on a macOS machine successfully.
