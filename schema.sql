-- ================================================
-- FILE: schema.sql
-- Run this FIRST in MySQL Workbench
-- ================================================

CREATE DATABASE IF NOT EXISTS ecommerce_analysis;
USE ecommerce_analysis;

CREATE TABLE customers (
  customer_id   INT PRIMARY KEY,
  customer_name VARCHAR(100),
  city          VARCHAR(50),
  age           INT,
  gender        VARCHAR(10)
);

CREATE TABLE products (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(100),
  category     VARCHAR(50),
  price        DECIMAL(10,2)
);

CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT,
  product_id  INT,
  quantity    INT,
  order_date  DATE,
  status      VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id)  REFERENCES products(product_id)
);
