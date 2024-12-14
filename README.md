# E-Commerce Database Analysis Project

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Technical Requirements](#2-technical-requirements)
   - [Development Environment](#21-development-environment)
   - [System Requirements](#22-system-requirements)
3. [Data Requirements](#3-data-requirements)
   - [Common Data Structures](#31-common-data-structures)
   - [Platform-Specific Data](#32-platform-specific-data)
4. [EER Diagram Creation](#4-eer-diagram-creation)
   - [Tools Setup](#41-tools-setup)
   - [Design Guidelines](#42-design-guidelines)
5. [Implementation Plan](#5-implementation-plan)
6. [Security & Monitoring](#6-security--monitoring)

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

#### Amazon.com.tr

- Prime membership data
- Video streaming entitlements
- International shipping capabilities
- Cross-border trade information

#### Hepsiburada (Future)

- Local marketplace specifics
- Domestic shipping requirements
- Turkish payment methods
- Vendor management data

#### Trendyol (Future)

- Fashion category specifics
- Boutique system data
- Flash sales information
- Influencer collaboration data

## 4. EER Diagram Creation

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

   - One-to-One: ──||────||──
   - One-to-Many: ──||────<
   - Many-to-Many: >────<
   - Optional: ----
   - Mandatory: ────

3. **Entity Organization**
   - Group by domain
   - Clear hierarchy
   - Consistent naming
   - Proper spacing

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