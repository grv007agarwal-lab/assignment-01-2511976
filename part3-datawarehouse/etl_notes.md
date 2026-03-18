## ETL Decisions

Decision 1 — Date Standardization

Problem: The raw dataset contained inconsistent date formats (e.g., DD-MM-YYYY, MM/DD/YYYY, timestamps), which would lead to incorrect grouping and aggregation in time-based analysis.
Resolution: All date values were parsed and converted into a uniform YYYY-MM-DD format. A surrogate date_id was generated and mapped to a dedicated dim_date table, with derived attributes such as day, month, year, and quarter to support efficient reporting.

Decision 2 — Handling NULL and Missing Values

Problem: Certain records had NULL or missing values in critical fields such as quantity, store, or product attributes, which could distort aggregations (e.g., total revenue) or break foreign key relationships.
Resolution:

NULL quantity values were replaced with 0 to maintain numerical consistency in calculations.

Missing categorical attributes (e.g., store location) were replaced with a default value such as 'Unknown'.

Records with missing foreign key references were either mapped to default dimension entries or excluded based on data quality rules.

Decision 3 — Category and Text Normalization

Problem: Product categories and other textual attributes had inconsistent casing and formatting (e.g., “electronics”, “Electronics”, “ELECTRONICS”), leading to fragmented aggregations in BI reports.
Resolution: All textual fields were standardized using consistent casing (e.g., proper case). Data was deduplicated and mapped into dimension tables (dim_product) to ensure a single, authoritative representation for each category and attribute, enabling accurate grouping and reporting.