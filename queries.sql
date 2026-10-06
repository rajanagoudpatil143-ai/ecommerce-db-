USE ecommerce_db;

-- ============================================================
-- E-COMMERCE DATABASE ANALYSIS
-- ============================================================


-- ============================================================
-- 1. TOP PRODUCTS BY UNITS SOLD
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC;


-- ============================================================
-- 2. TOP PRODUCTS BY REVENUE
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;


-- ============================================================
-- 3. TOP 5 PRODUCTS
-- ============================================================

SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 5;


-- ============================================================
-- 4. CUSTOMER SPENDING
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;


-- ============================================================
-- 5. TOP 5 CUSTOMERS BY SPENDING
-- ============================================================

SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 5;


-- ============================================================
-- 6. MONTHLY ORDER TRENDS
-- ============================================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM orders
WHERE status = 'Completed'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- 7. MONTHLY REVENUE TRENDS
-- ============================================================

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- 8. CATEGORY-WISE SALES
-- ============================================================

SELECT
    c.category_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY c.category_id, c.category_name
ORDER BY revenue DESC;


-- ============================================================
-- 9. AVERAGE ORDER VALUE
-- ============================================================

SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id
) AS order_summary;


-- ============================================================
-- 10. HIGHEST REVENUE MONTH
-- ============================================================

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY revenue DESC
LIMIT 1;


-- ============================================================
-- 11. RANK CUSTOMERS BY SPENDING
-- ============================================================

SELECT
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY customer_rank;


-- ============================================================
-- 12. BEST PRODUCT IN EACH CATEGORY
-- ============================================================

WITH product_sales AS (

    SELECT
        c.category_name,
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.unit_price) AS revenue

    FROM categories c

    JOIN products p
        ON c.category_id = p.category_id

    JOIN order_items oi
        ON p.product_id = oi.product_id

    JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.status = 'Completed'

    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),

ranked_products AS (

    SELECT
        *,
        RANK() OVER (
            PARTITION BY category_name
            ORDER BY revenue DESC
        ) AS product_rank

    FROM product_sales
)

SELECT
    category_name,
    product_name,
    units_sold,
    revenue
FROM ranked_products
WHERE product_rank = 1
ORDER BY category_name;


-- ============================================================
-- 13. PRODUCTS NEVER ORDERED
-- ============================================================

SELECT
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN orders o
    ON oi.order_id = o.order_id
    AND o.status = 'Completed'
WHERE o.order_id IS NULL;


-- ============================================================
-- 14. CUSTOMERS WITH MORE THAN ONE ORDER
-- ============================================================

SELECT
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;


-- ============================================================
-- 15. CUSTOMER ORDER HISTORY
-- ============================================================

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
ORDER BY
    c.customer_name,
    o.order_date;


-- ============================================================
-- 16. CITY-WISE SALES
-- ============================================================

SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.city
ORDER BY revenue DESC;


-- ============================================================
-- 17. LOW-STOCK PRODUCTS
-- ============================================================

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 40
ORDER BY stock_quantity ASC;


-- ============================================================
-- 18. ORDER STATUS SUMMARY
-- ============================================================

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- ============================================================
-- 19. TOTAL BUSINESS REVENUE
-- ============================================================

SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';


-- ============================================================
-- 20. TOTAL PRODUCTS SOLD
-- ============================================================

SELECT
    SUM(oi.quantity) AS total_units_sold
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';


-- ============================================================
-- 21. TOTAL COMPLETED ORDERS
-- ============================================================

SELECT
    COUNT(*) AS total_completed_orders
FROM orders
WHERE status = 'Completed';


-- ============================================================
-- 22. MONTHLY ORDERS + REVENUE
-- ============================================================

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- 23. TOP PRODUCT USING WINDOW FUNCTION
-- ============================================================

WITH product_revenue AS (

    SELECT
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue

    FROM products p

    JOIN order_items oi
        ON p.product_id = oi.product_id

    JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.status = 'Completed'

    GROUP BY p.product_id, p.product_name
),

ranked_products AS (

    SELECT
        product_name,
        revenue,
        DENSE_RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank

    FROM product_revenue
)

SELECT *
FROM ranked_products
WHERE revenue_rank <= 5
ORDER BY revenue_rank;


-- ============================================================
-- 24. CUSTOMER LIFETIME VALUE
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS orders,
    SUM(oi.quantity * oi.unit_price) AS lifetime_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC;


-- ============================================================
-- 25. CATEGORY REVENUE PERCENTAGE
-- ============================================================

WITH category_sales AS (

    SELECT
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS revenue

    FROM categories c

    JOIN products p
        ON c.category_id = p.category_id

    JOIN order_items oi
        ON p.product_id = oi.product_id

    JOIN orders o
        ON oi.order_id = o.order_id

    WHERE o.status = 'Completed'

    GROUP BY c.category_id, c.category_name
)

SELECT
    category_name,
    revenue,
    ROUND(
        revenue * 100.0 /
        SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM category_sales
ORDER BY revenue DESC;