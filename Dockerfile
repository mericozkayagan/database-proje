# Use the official PostgreSQL image as base
FROM postgres:16

# Set environment variables
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin123
ENV POSTGRES_DB=postgres

# Install necessary extensions
RUN apt-get update && \
    apt-get install -y postgresql-contrib && \
    rm -rf /var/lib/apt/lists/*

# Create directory for custom initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy initialization scripts in correct order
COPY ./init-scripts/00-init-extensions.sql /docker-entrypoint-initdb.d/00-init-extensions.sql
COPY ./init-scripts/01-create-databases.sql /docker-entrypoint-initdb.d/01-create-databases.sql
COPY ./init-scripts/02-amazon-init.sql /docker-entrypoint-initdb.d/02-amazon-init.sql
COPY ./init-scripts/03-amazon-dummy-data.sql /docker-entrypoint-initdb.d/05-amazon-dummy-data.sql

# Set permissions
RUN chmod -R 755 /docker-entrypoint-initdb.d

# Expose PostgreSQL port
EXPOSE 5432

LABEL version="1.0"
LABEL description="PostgreSQL container with Amazon, Hepsiburada, and Trendyol databases"