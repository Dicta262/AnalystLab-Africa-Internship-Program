
CREATE DATABASE Retail_DB;

CREATE TABLE Online_Retail (
    invoice_no VARCHAR(20),
    stock_code VARCHAR(50),
    description NVARCHAR(255),
    quantity INT,
    invoice_date VARCHAR(50),
    unit_price DECIMAL(10,2),
    customer_id VARCHAR(20),
    country VARCHAR(100)
);

SELECT COUNT(*) AS Total_Rows
FROM OnlineRetail;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'OnlineRetail';


SELECT
    SUM(CASE WHEN stockcode IS NULL OR stockcode = '' THEN 1 ELSE 0 END) AS Missing_StockCode,
    SUM(CASE WHEN description IS NULL OR description = '' THEN 1 ELSE 0 END) AS Missing_Description,
    SUM(CASE WHEN customerid IS NULL OR customerid = '' THEN 1 ELSE 0 END) AS Missing_CustomerID
FROM OnlineRetail;



UPDATE OnlineRetail
SET description = 'Unknown'
WHERE description IS NULL OR description = '';

UPDATE OnlineRetail
SET customerid = 'Unknown'
WHERE customerid IS NULL OR customerid = '';


WITH DuplicateCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY invoiceno, stockcode, quantity
               ORDER BY invoiceno
           ) AS rn
    FROM OnlineRetail
)

DELETE FROM DuplicateCTE
WHERE rn > 1;


ALTER TABLE OnlineRetail
ADD invoice_date_clean DATETIME;


UPDATE OnlineRetail
SET invoice_date_clean =
TRY_CONVERT(DATETIME, invoicedate);


SELECT *
FROM OnlineRetail
WHERE quantity < 0;


SELECT *
FROM OnlineRetail
WHERE unitprice < 0;


SELECT AVG(quantity) AS Avg_Quantity
FROM OnlineRetail;

SELECT AVG(unitprice) AS Avg_UnitPrice
FROM OnlineRetail;


SELECT
SUM(quantity * unitprice) AS Total_Revenue
FROM OnlineRetail
WHERE quantity > 0;

SELECT TOP 10
description,
SUM(quantity) AS Total_Sold
FROM OnlineRetail
GROUP BY description
ORDER BY Total_Sold DESC;


SELECT
country,
SUM(quantity * unitprice) AS Revenue
FROM OnlineRetail
GROUP BY country
ORDER BY Revenue DESC;


SELECT
YEAR(invoice_date_clean) AS Sales_Year,
MONTH(invoice_date_clean) AS Sales_Month,
SUM(quantity * unitprice) AS Revenue
FROM OnlineRetail
GROUP BY
YEAR(invoice_date_clean),
MONTH(invoice_date_clean)
ORDER BY Sales_Year, Sales_Month;


SELECT
quantity,
(quantity * unitprice) AS Revenue
FROM OnlineRetail;


SELECT
country,
SUM(quantity * unitprice) AS Revenue
FROM OnlineRetail
GROUP BY country;


SELECT * FROM OnlineRetail





