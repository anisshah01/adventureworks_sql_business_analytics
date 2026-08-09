-- Best Selling Products

SELECT p.productname,ROUND(SUM(p.productprice * s.orderquantity)) total_revenue
FROM products p
JOIN sales s ON s.productkey = p.productkey
GROUP BY p.productname
ORDER BY SUM(p.productprice * s.orderquantity) DESC;

-- Lowest Selling Products

SELECT p.productname,ROUND(SUM(p.productprice * s.orderquantity)) total_revenue
FROM products p
JOIN sales s ON s.productkey = p.productkey
GROUP BY p.productname
ORDER BY SUM(p.productprice * s.orderquantity) ASC;

-- Product Categories

SELECT categoryname
FROM productcategories;

-- Sub-Category Performance

SELECT psc.subcategoryname,ROUND(SUM(p.productprice*s.orderquantity)) total_revenue
FROM productsubcategories psc
JOIN products p ON p.productsubcategorykey = psc.productsubcategorykey
JOIN sales s ON s.productkey = p.productkey
GROUP BY psc.productsubcategorykey
ORDER BY total_revenue DESC

