-- Revenue by Continent
SELECT tr.continent,
    ROUND(SUM(p.productprice * s.orderquantity)) total_revenue
FROM territories tr
    JOIN sales s ON s.territorykey = tr.salesterritorykey
    JOIN products p ON p.productkey = s.productkey
GROUP BY tr.continent
ORDER BY total_revenue DESC;
-- Revenue by Region
SELECT tr.region,
    ROUND(SUM(p.productprice * s.orderquantity)) total_revenue
FROM territories tr
    JOIN sales s ON s.territorykey = tr.salesterritorykey
    JOIN products p ON p.productkey = s.productkey
GROUP BY tr.region
ORDER BY total_revenue DESC;
-- Revenue by Country
SELECT tr.country,
    ROUND(SUM(p.productprice * s.orderquantity)) total_revenue
FROM territories tr
    JOIN sales s ON s.territorykey = tr.salesterritorykey
    JOIN products p ON p.productkey = s.productkey
GROUP BY tr.country
ORDER BY total_revenue DESC;

-- Total Customers by Country

SELECT t.country,COUNT(c.*) total_customers
FROM customers c
JOIN sales s ON s.customerkey = c.customerkey
JOIN territories t ON t.salesterritorykey = s.territorykey
GROUP BY t.country
ORDER BY total_customers DESC;

-- Which Country Have Most High Value Customers

WITH cust_seg AS (
SELECT s.customerkey,
CASE
    WHEN SUM(p.productprice * s.orderquantity) <= 2000 THEN 'Low Value'
    WHEN SUM(p.productprice * s.orderquantity) <= 4000 THEN 'Medium Value'
    ELSE 'High Value'
END AS customer_segment
FROM customers c
JOIN sales s ON c.customerkey = s.customerkey
JOIN products p ON p.productkey = s.productkey
GROUP BY s.customerkey
)
SELECT tr.country country,cs.customer_segment,
    COUNT(DISTINCT cs.customerkey) total_customers
FROM territories tr
JOIN sales s ON s.territorykey = tr.salesterritorykey
JOIN cust_seg cs ON cs.customerkey = s.customerkey
WHERE cs.customer_segment = 'High Value'
GROUP BY tr.country,cs.customer_segment
ORDER BY total_customers DESC;

-- Which Country Have Most Medium Value Customers

WITH cust_seg AS (
SELECT s.customerkey,
CASE
    WHEN SUM(p.productprice * s.orderquantity) <= 2000 THEN 'Low Value'
    WHEN SUM(p.productprice * s.orderquantity) <= 4000 THEN 'Medium Value'
    ELSE 'High Value'
END AS customer_segment
FROM customers c
JOIN sales s ON c.customerkey = s.customerkey
JOIN products p ON p.productkey = s.productkey
GROUP BY s.customerkey
)
SELECT tr.country country,cs.customer_segment,
    COUNT(DISTINCT cs.customerkey) total_customers
FROM territories tr
JOIN sales s ON s.territorykey = tr.salesterritorykey
JOIN cust_seg cs ON cs.customerkey = s.customerkey
WHERE cs.customer_segment = 'Medium Value'
GROUP BY tr.country,cs.customer_segment
ORDER BY total_customers DESC;

-- Which Country Have Most Low Value Customers

WITH cust_seg AS (
SELECT s.customerkey,
CASE
    WHEN SUM(p.productprice * s.orderquantity) <= 2000 THEN 'Low Value'
    WHEN SUM(p.productprice * s.orderquantity) <= 4000 THEN 'Medium Value'
    ELSE 'High Value'
END AS customer_segment
FROM customers c
JOIN sales s ON c.customerkey = s.customerkey
JOIN products p ON p.productkey = s.productkey
GROUP BY s.customerkey
)
SELECT tr.country country,cs.customer_segment,
    COUNT(DISTINCT cs.customerkey) total_customers
FROM territories tr
JOIN sales s ON s.territorykey = tr.salesterritorykey
JOIN cust_seg cs ON cs.customerkey = s.customerkey
WHERE cs.customer_segment = 'Low Value'
GROUP BY tr.country,cs.customer_segment
ORDER BY total_customers DESC;