# 🛒 E-Commerce Database Management System (SQL Project)

This project is a complete E-commerce Database Management System built using MySQL.  
It demonstrates end-to-end SQL skills including:

- Database schema design  
- Table creation using DDL  
- Data insertion using DML  
- Foreign keys and constraints  
- Real-world analytical queries  

Perfect for showcasing SQL knowledge in interviews and assessments.

---

## 📦 Database Schema

The project includes the following tables:

| Table Name        | Description                         |
|-------------------|-------------------------------------|
| customers         | Stores customer data                |
| categories        | Product categories                  |
| products          | Product catalog with category link  |
| orders            | Customer orders                     |
| order_details     | Items purchased in each order       |
| payments          | Payment details for each order      |

---

## 📂 Files in This Repository

- **ecommerce_database.sql** → Full SQL code  
- **Ecommerce Database Management System.pdf** → Detailed report with screenshots  
- **LICENSE** → MIT License  

---

## 🚀 How to Run

1. Open MySQL Workbench / dbfiddle / SQLFiddle  
2. Copy the contents of `ecommerce_database.sql`  
3. Execute the script  
4. Use the sample queries at the bottom for testing  

---

## 📊 Sample Query

```sql
SELECT
    o.order_id,
    o.order_date,
    o.status,
    p.name AS product_name,
    od.quantity,
    od.unit_price
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE o.customer_id = 'c1';
