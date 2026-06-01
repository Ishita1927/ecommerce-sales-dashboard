-- ================================================
-- FILE: analysis.sql
-- Run each query ONE AT A TIME in MySQL Workbench
-- ================================================

USE ecommerce_analysis;

-- QUERY 1: Total Revenue (delivered orders only)
SELECT ROUND(SUM(p.price * o.quantity), 2) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered';
-- WRITE DOWN: Total Revenue = ₹ __________

-- QUERY 2: Revenue by Category
SELECT p.category,
       ROUND(SUM(p.price * o.quantity), 2) AS category_revenue,
       COUNT(o.order_id) AS total_orders
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY category_revenue DESC;
-- WRITE DOWN: Top category = __________

-- QUERY 3: Top 5 Customers by Spending
SELECT c.customer_name, c.city,
       ROUND(SUM(p.price * o.quantity), 2) AS total_spent,
       COUNT(o.order_id) AS number_of_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 5;
-- WRITE DOWN: Top customer = __________ spent ₹ __________

-- QUERY 4: Monthly Order Trend
SELECT MONTHNAME(o.order_date) AS month_name,
       MONTH(o.order_date) AS month_number,
       COUNT(o.order_id) AS total_orders
FROM orders o
GROUP BY month_number, month_name
ORDER BY month_number;
-- WRITE DOWN: Busiest month = __________

-- QUERY 5: Average Order Value
SELECT ROUND(AVG(p.price * o.quantity), 2) AS avg_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered';
-- WRITE DOWN: Avg order value = ₹ __________

-- QUERY 6: Customers by City
SELECT city, COUNT(customer_id) AS number_of_customers
FROM customers
GROUP BY city
ORDER BY number_of_customers DESC;
-- WRITE DOWN: Top city = __________

-- QUERY 7: Order Status Breakdown
SELECT status,
       COUNT(order_id) AS count,
       ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS percentage
FROM orders
GROUP BY status
ORDER BY count DESC;
-- WRITE DOWN: Delivered = __% Cancelled = __% Returned = __%

-- QUERY 8: Best Selling Products
SELECT p.product_name, p.category,
       SUM(o.quantity) AS total_units_sold,
       ROUND(SUM(p.price * o.quantity), 2) AS revenue_generated
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_units_sold DESC
LIMIT 10;
-- WRITE DOWN: Best product = __________ units = __________
