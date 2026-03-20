-- every DuckDB SQL query will be between  con.execute(""" SQL QUERY """).fetchdf()



-- Q1: Total number of orders per customer
con.execute("""
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') c
LEFT JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, 
    c.name
ORDER BY total_orders DESC
""").fetchdf()


-- Q2: Top 3 customers by total order value
con.execute("""
SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, 
    c.name
ORDER BY total_spent DESC
LIMIT 3
""").fetchdf()


-- Q3: List all products purchased by customers from Bangalore
con.execute("""
SELECT DISTINCT
    p.product_name
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('products.parquet') p
    ON o.order_id = p.order_id
WHERE LOWER(c.city) = 'bangalore'
""").fetchdf()


-- Q4: Join all three files to show: customer name, order date, product name, and quantity
con.execute("""
SELECT 
    c.name AS customer_name,
    o.order_date,
    p.product_name,
    p.quantity
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
JOIN read_parquet('products.parquet') p
    ON o.order_id = p.order_id
ORDER BY 
    o.order_date,
    c.name
""").fetchdf()
