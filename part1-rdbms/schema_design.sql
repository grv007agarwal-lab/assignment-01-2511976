-- =========================
-- CUSTOMERS TABLE
-- =========================
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

INSERT INTO customers VALUES
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C006','Neha Gupta','neha@gmail.com','Delhi'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai');


-- =========================
-- PRODUCTS TABLE
-- =========================
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

INSERT INTO products VALUES
('P004','Notebook','Stationery',120),
('P007','Pen Set','Stationery',250),
('P005','Headphones','Electronics',3200),
('P003','Desk Chair','Furniture',8500),
('P006','Standing Desk','Furniture',22000);


-- =========================
-- SALES REPRESENTATIVES
-- =========================
CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address VARCHAR(200) NOT NULL
);

INSERT INTO sales_reps VALUES
('SR01','Arjun Kapoor','arjun@company.com',
 'Mumbai HQ, Nariman Point, Mumbai - 400021'),

('SR02','Sneha Iyer','sneha@company.com',
 'Delhi Office, Connaught Place, New Delhi - 110001'),

('SR03','Rahul Nair','rahul@company.com',
 'South Zone, MG Road, Bangalore - 560001'),

('SR04','Pooja Shah','pooja@company.com',
 'West Zone, Andheri East, Mumbai - 400069'),

('SR05','Karan Malhotra','karan@company.com',
 'North Zone, Chandigarh - 160017');


-- =========================
-- ORDERS TABLE
-- =========================
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

INSERT INTO orders VALUES
('ORD1027','C002','SR02','2023-11-02'),
('ORD1114','C001','SR01','2023-08-06'),
('ORD1153','C006','SR01','2023-02-14'),
('ORD1002','C002','SR02','2023-01-17'),
('ORD1118','C006','SR02','2023-11-10');


-- =========================
-- ORDER ITEMS TABLE
-- =========================
CREATE TABLE order_items (
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
('ORD1027','P004',4),
('ORD1114','P007',2),
('ORD1153','P007',3),
('ORD1002','P005',1),
('ORD1118','P006',1);
