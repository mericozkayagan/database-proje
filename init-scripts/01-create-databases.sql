-- Create databases
CREATE DATABASE amazon;

-- Create extensions in amazon database
\c amazon
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "ltree";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
