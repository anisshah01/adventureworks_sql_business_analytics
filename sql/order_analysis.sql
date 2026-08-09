-- Average Order Value

SELECT ROUND(SUM(p.productprice*s.orderquantity)/COUNT(DISTINCT s.ordernumber),2)average_order_value
FROM sales s
JOIN products p ON p.productkey = s.productkey

-- Largest Order

SELECT s.ordernumber,SUM(s.orderquantity*p.productprice) total_revenue
FROM sales s
JOIN products p ON p.productkey = s.productkey
GROUP BY s.ordernumber
ORDER BY total_revenue DESC
LIMIT 1;

-- Monthly Order Trend

SELECT TO_CHAR(date,'Month'),
    COUNT(*) total_orders
FROM sales s
JOIN calender cl ON cl.date = s.orderdate
GROUP BY TO_CHAR(date,'Month'),EXTRACT(MONTH FROM cl.date)
ORDER BY EXTRACT(MONTH FROM cl.date) ASC;