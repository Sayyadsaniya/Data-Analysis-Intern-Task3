
-- 1. Most common mode of shipment
SELECT Mode_of_Shipment, COUNT(*) AS total_orders
FROM shipping_ecommerce
GROUP BY Mode_of_Shipment
ORDER BY total_orders DESC;

-- 2.Basic analysis using SELECT, WHERE, ORDER BY, GROUP BY
SELECT Product_importance, Gender, COUNT(*) AS order_count
FROM shipping_ecommerce
WHERE Discount_offered > 10
GROUP BY Product_importance, Gender
ORDER BY order_count DESC;

-- 3. JOINS (assuming a customer_details table exists for demonstration)
-- INNER JOIN example
SELECT s.ID, s.Mode_of_Shipment, c.Customer_name
FROM shipping_ecommerce s
INNER JOIN customer_details c ON s.Customer_care_calls = c.Customer_care_calls;

-- LEFT JOIN example
SELECT s.ID, c.Customer_name
FROM shipping_ecommerce s
LEFT JOIN customer_details c ON s.Customer_care_calls = c.Customer_care_calls;

-- RIGHT JOIN example (note: not all DBMS support RIGHT JOINs)
SELECT s.ID, c.Customer_name
FROM shipping_ecommerce s
RIGHT JOIN customer_details c ON s.Customer_care_calls = c.Customer_care_calls;

-- 3. Total and average weight shipped per warehouse block
SELECT Warehouse_block,
       COUNT(*) AS total_orders,
       SUM(Weight_in_gms) AS total_weight,
       AVG(Weight_in_gms) AS avg_weight
FROM shipping_ecommerce
GROUP BY Warehouse_block
ORDER BY total_weight DESC;

-- 4. How customer ratings affect shipping class
SELECT Customer_rating, Class, COUNT(*) AS count
FROM shipping_ecommerce
GROUP BY Customer_rating, Class
ORDER BY Customer_rating, Class;

-- 5. Top 5 highest discounts and their shipment mode
SELECT Mode_of_Shipment, Discount_offered
FROM shipping_ecommerce
ORDER BY Discount_offered DESC
LIMIT 5;

-- 6. Product importance analysis
SELECT Product_importance, COUNT(*) AS total
FROM shipping_ecommerce
GROUP BY Product_importance
ORDER BY total DESC;

-- 7. Gender-wise shipping behavior
SELECT Gender, 
       COUNT(*) AS total_orders,
       AVG(Weight_in_gms) AS avg_weight,
       AVG(Discount_offered) AS avg_discount
FROM shipping_ecommerce
GROUP BY Gender;

-- 8. Prior purchases vs shipping class
SELECT Prior_purchases, Class, COUNT(*) AS count
FROM shipping_ecommerce
GROUP BY Prior_purchases, Class
ORDER BY Prior_purchases;

-- 9. Orders with high discount & low weight (anomaly check)
SELECT *
FROM shipping_ecommerce
WHERE Discount_offered > 20 AND Weight_in_gms < 3000;

-- 10. Which block has highest failed deliveries (if Class=0 means failure)
SELECT Warehouse_block, COUNT(*) AS failed_deliveries
FROM shipping_ecommerce
WHERE Class = 0
GROUP BY Warehouse_block
ORDER BY failed_deliveries DESC;

-- 11. Correlation-like query (Discount vs Class)
SELECT Class, 
       AVG(Discount_offered) AS avg_discount, 
       COUNT(*) AS orders
FROM shipping_ecommerce
GROUP BY Class;

-- 12. Subquery to find top discount per shipment mode
SELECT Mode_of_Shipment, Discount_offered
FROM shipping_ecommerce
WHERE Discount_offered = (
    SELECT MAX(Discount_offered)
    FROM shipping_ecommerce AS inner_tbl
    WHERE inner_tbl.Mode_of_Shipment = shipping_ecommerce.Mode_of_Shipment
);

-- 13. Aggregate functions
SELECT Gender, 
       SUM(Weight_in_gms) AS total_weight,
       AVG(Discount_offered) AS avg_discount
FROM shipping_ecommerce
GROUP BY Gender;

-- 14. Create a view for analysis
CREATE VIEW shipment_summary AS
SELECT Mode_of_Shipment, COUNT(*) AS total_shipments, AVG(Weight_in_gms) AS avg_weight
FROM shipping_ecommerce
GROUP BY Mode_of_Shipment;

-- 15. Optimize with index (depends on database, syntax for MySQL)
-- Creating index on frequently filtered column
CREATE INDEX idx_mode_shipment ON shipping_ecommerce(Mode_of_Shipment);

-- 16.Creating composite index for filtering and sorting
CREATE INDEX idx_discount_weight ON shipping_ecommerce(Discount_offered, Weight_in_gms);



