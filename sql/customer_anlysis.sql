-- Total Customers

SELECT COUNT(*) total_customers
FROM customers;

-- New Customers

SELECT COUNT(DISTINCT c.customerkey) new_customers
FROM customers c
    JOIN sales s ON s.customerkey = c.customerkey
    JOIN calender cl ON cl.date = s.orderdate
WHERE s.orderdate >= (
        SELECT MAX(orderdate)
        FROM sales
    ) - INTERVAL '6 month';

-- Top 20 Customers

SELECT c.customerkey,
    INITCAP(CONCAT(c.firstname, ' ', c.lastname)) customer_name,
    SUM(p.productprice * s.orderquantity) total_revenue
FROM customers c
    JOIN sales s ON s.customerkey = c.customerkey
    JOIN products p ON p.productkey = s.productkey
GROUP BY c.customerkey,
    CONCAT(c.firstname, ' ', c.lastname)
ORDER BY SUM(p.productprice * s.orderquantity) DESC
LIMIT 20;

-- Customer Segmentation

WITH cust_rev AS (
SELECT c.customerkey,
    INITCAP(CONCAT(c.firstname, ' ', c.lastname)) customer_name,
    ROUND(SUM(p.productprice * s.orderquantity),2) total_revenue,
    CASE 
        WHEN ROUND(SUM(p.productprice * s.orderquantity),2) <= 2000 THEN 'Low Value'
        WHEN ROUND(SUM(p.productprice * s.orderquantity),2) <= 4000 THEN 'Medium Values'
        ELSE 'High Value'
    END AS customer_segment
FROM customers c
JOIN sales s ON s.customerkey = c.customerkey
JOIN products p ON p.productkey = s.productkey
GROUP BY c.customerkey,CONCAT(c.firstname, ' ', c.lastname)
)
SELECT customer_segment,COUNT(*) total_customers
FROM cust_rev
GROUP BY customer_segment
ORDER BY total_customers DESC;

