-- =========================
-- DIMENSION TABLES
-- =========================

-- Date Dimension
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    year INT,
    quarter INT
);

-- Store Dimension
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

-- Product Dimension
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50)
);

-- =========================
-- FACT TABLE
-- =========================

CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- =========================
-- INSERT CLEANED DATA
-- =========================

-- dim_date (standardized YYYY-MM-DD format)
INSERT INTO dim_date VALUES
(1, '2026-03-01', 1, 3, 2026, 1),
(2, '2026-04-02', 2, 4, 2026, 1),
(3, '2026-03-03', 3, 3, 2026, 1),
(4, '2026-05-04', 4, 5, 2026, 1),
(5, '2026-10-05', 5, 10, 2026, 1);

-- dim_store (standardized casing, NULLs handled as 'Unknown')
INSERT INTO dim_store VALUES
(101, 'Store A', 'Mumbai', 'Maharashtra'),
(102, 'Store B', 'Delhi', 'Delhi'),
(103, 'Store C', 'Bangalore', 'Karnataka'),
(104, 'Store D', 'Jaipur', 'Rajasthan');

-- dim_product (category casing standardized)
INSERT INTO dim_product VALUES
(1001, 'Amul Butter 500g', 'Groceries', 'Amul'),
(1002, 'iPhone 14', 'Electronics', 'Apple'),
(1003, 'T-Shirt', 'Apparel', 'Puma'),
(1004, 'LED TV 42"', 'Electronics', 'Samsung'),
(1005, 'Formal Pants', 'Apparel', 'Adidas'),
(1006, 'Cookies', 'Groceries', 'SunFeast');

-- =========================
-- FACT TABLE DATA
-- =========================

-- Cleaned data:
-- - Dates mapped to dim_date
-- - NULL quantities replaced with 0
-- - Category inconsistencies resolved in dimension
-- - Total = quantity * unit_price

INSERT INTO fact_sales VALUES
(1, 1, 101, 1001, 2, 275.00, 550.00),
(2, 1, 102, 1002, 1, 70000.00, 70000.00),
(3, 2, 103, 1003, 3, 1200.00, 3600.00),
(4, 2, 104, 1004, 1, 30000.00, 30000.00),
(5, 3, 102, 1005, 5, 275.00, 1375.00),
(6, 3, 103, 1002, 2, 70000.00, 140000.00),
(7, 4, 101, 1003, 0, 1200.00, 0.00),  -- NULL handled as 0
(8, 4, 102, 1004, 1, 30000.00, 30000.00),
(9, 5, 104, 1001, 4, 275.00, 1100.00),
(10, 5, 101, 1005, 2, 1500.00, 3000.00),
(11, 4, 102, 1002, 1, 70000.00, 70000.00),
(12, 5, 104, 1006, 10, 70.00, 700.00);
