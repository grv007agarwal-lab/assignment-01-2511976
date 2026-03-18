## Anomaly Analysis

An Insert Anomaly:

	Example from dataset fields: product_id, product_name, category, unit_price

	If a new product needs to be added but no order exists yet, it cannot be inserted without creating an order record.

	Example structure required by the table:

	order_id	customer_id		customer_name		customer_email	customer_city	product_id	product_name	category	unit_price	quantity	order_date	sales_rep_id	sales_rep_name	sales_rep_email		office_address
	NULL		NULL			NULL				NULL			NULL			P600		Smart Watch		Electronics	NULL		NULL		NULL		NULL			NULL			NULL				NULL

	Issue: Because the table is order-centric, a product like “Smart Watch” cannot be added unless an order is created. This is an Insert Anomaly.

An Update Anomaly:

	Product information is repeated across many rows.

	Example rows from the dataset:

	order_id	customer_id	customer_name	customer_email		customer_city	product_id	product_name	category	unit_price	quantity	order_date	sales_rep_id	sales_rep_name	sales_rep_email		office_address
	ORD1061		C006		Neha Gupta		neha@gmail.com		Delhi			P001		Laptop			Electronics	55000		4			10/27/2023	SR01			Deepak Joshi	deepak@corp.com		Mumbai HQ, Nariman Point, Mumbai - 400021
	ORD1098		C007		Arjun Nair		arjun@gmail.com		Bangalore		P001		Laptop			Electronics	55000		2			10/3/2023	SR03			Ravi Kumar		ravi@corp.com		South Zone, MG Road, Bangalore - 560001
	ORD1131		C008		Kavya Rao		kavya@gmail.com		Hyderabad		P001		Laptop			Electronics	55000		4			6/22/2023	SR02			Anita Desai		anita@corp.com		Delhi Office, Connaught Place, New Delhi - 110001

	Issue: If product_id for Laptop changes from P001 to P100, all rows with product_id = P100 must be updated.

	If one row is missed (ORD1098), this creates inconsistent data, which is an Update Anomaly.
	order_id	customer_id		customer_name	customer_email		customer_city	product_id	product_name	category	unit_price	quantity	order_date	sales_rep_id	sales_rep_name	sales_rep_email		office_address
	ORD1061		C006			Neha Gupta		neha@gmail.com		Delhi			P100		Laptop			Electronics	55000		4			10/27/2023	SR01			Deepak Joshi	deepak@corp.com		Mumbai HQ, Nariman Point, Mumbai - 400021
	ORD1098		C007			Arjun Nair		arjun@gmail.com		Bangalore		P001		Laptop			Electronics	55000		2			10/3/2023	SR03			Ravi Kumar		ravi@corp.com		South Zone, MG Road, Bangalore - 560001
	ORD1131		C008			Kavya Rao		kavya@gmail.com		Hyderabad		P100		Laptop			Electronics	55000		4			6/22/2023	SR02			Anita Desai		anita@corp.com		Delhi Office, Connaught Place, New Delhi - 110001


A Delete Anomaly :

	Suppose a product appears in only one order.

	Example Row:
	order_id	customer_id		customer_name	customer_email		customer_city	product_id	product_name	category	unit_price	quantity	order_date	sales_rep_id	sales_rep_name	sales_rep_email		office_address
	ORD1185		C003			Amit Verma		amit@gmail.com		Bangalore		P008		Webcam			Electronics	2100		1			6/15/2023	SR03			Ravi Kumar		ravi@corp.com		South Zone, MG Road, Bangalore - 560001

	If order ORD1185 is deleted, the dataset also loses: Product information (product_id, product_name)

	Issue: Deleting the order removes valid product information, which is a Delete Anomaly.


##Normalization Justification

While storing all information in a single table such as orders_flat may initially appear simpler, it creates several structural problems that affect data quality, maintainability, and scalability. The dataset combines customer, product, order, and sales representative information in the same table, which results in significant data redundancy.

For example, when a customer places multiple orders, their details such as customer_name and customer_city are repeated in every row. In the dataset, if a customer like C101 from Mumbai places several orders for different products, the same customer information appears repeatedly across rows. This redundancy increases storage usage and makes the dataset harder to maintain.

The single-table structure also introduces update anomalies. If a customer changes their city from Mumbai to Pune, every row associated with that customer must be updated. If even one row is missed, the dataset will contain inconsistent customer information. Similarly, product information such as product_name is repeated in every order line where the product appears, creating the same risk when product details change.

There are also insert and delete anomalies. A new product cannot be added to the dataset unless it is associated with an order, because product information exists only within order records. Conversely, if the only order containing a particular product is deleted, the product information may disappear from the dataset entirely.

Normalization addresses these issues by separating the dataset into related tables such as Customers, Products, Orders, and Order_Items. This design removes redundancy, ensures consistent updates, and preserves data integrity. Therefore, normalization is not over-engineering but a necessary practice for maintaining reliable and scalable database systems.
