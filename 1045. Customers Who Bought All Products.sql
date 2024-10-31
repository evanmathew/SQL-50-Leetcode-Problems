SELECT c.customer_id FROM Customer c
JOIN Product p
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.product_key) = COUNT(DISTINCT c.product_key)

