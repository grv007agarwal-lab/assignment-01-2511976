## Storage Systems

The architecture uses a combination of specialized storage systems aligned to the four goals. For predicting patient readmission risk, a Data Lake (e.g., S3/ADLS/GCS) is used to store large volumes of historical treatment data, including structured (EHR, lab results) and unstructured data (clinical notes). This enables scalable storage and supports feature engineering and model training.

For doctor-facing natural language queries, a Vector Database (e.g., Pinecone/FAISS/Weaviate) is used. Patient records and clinical notes are chunked and converted into embeddings using a language model, enabling semantic search. This allows doctors to retrieve relevant patient history even when queries do not match exact keywords.

For management reporting, a Data Warehouse (e.g., Snowflake/BigQuery/Redshift) is used. It stores cleaned, structured, and aggregated data optimized for OLAP workloads such as monthly reporting on bed occupancy and departmental costs.

For real-time ICU vitals, a streaming + Data Lake combination is used. Streaming platforms (Kafka/Kinesis/Event Hub) ingest real-time data, which is processed using engines like Spark/Flink and stored in the Data Lake for persistence and downstream analytics. This ensures both low-latency monitoring and long-term storage.

## OLTP vs OLAP Boundary

The OLTP layer consists of operational systems such as EHR, billing, and ICU monitoring devices, where transactions are continuously generated and require high consistency and low latency. These systems are optimized for write-heavy workloads and real-time updates.

The boundary between OLTP and OLAP is established at the data ingestion layer (ETL/streaming pipelines). Once data is extracted from operational systems, it is transformed and loaded into analytical storage systems such as the Data Lake and Data Warehouse.

The OLAP layer begins in the Data Lake and Data Warehouse, where data is processed for analytics, machine learning, and reporting. The Data Lake supports exploratory analysis and model training, while the Data Warehouse supports structured queries and dashboards. The Vector Database also belongs to the analytical side, as it enables semantic retrieval rather than transactional processing. This separation ensures that analytical workloads do not impact the performance of critical transactional systems.

## Trade-offs

A key trade-off in this design is increased architectural complexity versus flexibility and performance. Using multiple specialized systems (Data Lake, Data Warehouse, Vector DB, streaming engine) improves scalability and supports diverse workloads, but it introduces challenges in data integration, governance, and operational overhead.

To mitigate this, a unified data orchestration and governance layer can be implemented using tools like Apache Airflow or managed workflow services. Additionally, adopting a Lakehouse approach (e.g., Delta Lake) can reduce duplication between the Data Lake and Data Warehouse by enabling ACID transactions and structured querying on the same data.

Standardizing data schemas, implementing strong metadata management, and using centralized monitoring can further reduce complexity while retaining the benefits of a modular, scalable architecture.