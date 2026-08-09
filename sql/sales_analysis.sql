
-- Total Sales

SELECT ROUND(SUM(s.orderquantity*p.productprice),2) total_revenue
FROM sales s
JOIN products p ON p.productkey = s.productkey;

-- Monthly Sales Trend

SELECT TO_CHAR(cl.date,'Month') AS month_name,
    ROUND(SUM(s.orderquantity*p.productprice),2) total_revenue
FROM sales s
JOIN products p ON p.productkey = s.productkey
JOIN calender cl ON cl.date = s.orderdate
GROUP BY month_name, EXTRACT(MONTH FROM cl.date)
ORDER BY EXTRACT(MONTH FROM cl.date) ASC;

-- Yearly Sales Trend

SELECT EXTRACT(YEAR FROM cl.date) AS year,
    ROUND(SUM(s.orderquantity*p.productprice),2) total_revenue
FROM sales s
JOIN products p ON p.productkey = s.productkey
JOIN calender cl ON cl.date = s.orderdate
GROUP BY EXTRACT(YEAR FROM cl.date)
ORDER BY EXTRACT(YEAR FROM cl.date) ASC;

-- Top 10 Selling Products

SELECT p.productname,SUM(s.orderquantity * p.productprice) total_revenue
FROM products p
JOIN sales s ON s.productkey = p.productkey
GROUP BY ProductName
ORDER BY total_revenue DESC
LIMIT 10;

-- Revenue by Category

SELECT pc.categoryname,ROUND(SUM(s.orderquantity * p.productprice),2) totalrevenue
FROM sales s
JOIN products p ON p.productkey = s.productkey
JOIN productsubcategories ps ON ps.productsubcategorykey = p.productsubcategorykey
JOIN productcategories pc ON pc.productcategorykey = ps.productcategorykey
GROUP BY pc.categoryname;

-- Revenue By Region

SELECT t.region,ROUND(SUM(s.orderquantity * p.productprice),2) total_revenue
FROM sales s
JOIN products p ON p.productkey = s.productkey
JOIN territories t ON t.salesterritorykey = s.territorykey
GROUP BY t.region
ORDER BY total_revenue DESC;

