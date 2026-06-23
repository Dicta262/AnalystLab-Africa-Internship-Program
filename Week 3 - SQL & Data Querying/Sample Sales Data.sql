
-- CREATING DATABASE AND TABLE 

CREATE DATABASE sales_data;

USE sales_data;

CREATE TABLE sample_sales_dataset(
ORDERNUMBER INT,
    QUANTITYORDERED INT,
    PRICEEACH DECIMAL(10,2),
    ORDERLINENUMBER INT,
    SALES DECIMAL(12,2),
    ORDERDATE DATETIME,
    STATUS VARCHAR(50),
    QTR_ID INT,
    MONTH_ID INT,
    YEAR_ID INT,
    PRODUCTLINE VARCHAR(100),
    MSRP INT,
    PRODUCTCODE VARCHAR(50),
    CUSTOMERNAME VARCHAR(255),
    PHONE VARCHAR(50),
    ADDRESSLINE1 VARCHAR(255),
    ADDRESSLINE2 VARCHAR(255),
    CITY VARCHAR(100),
    STATE VARCHAR(100),
    POSTALCODE VARCHAR(50),
    COUNTRY VARCHAR(100),
    TERRITORY VARCHAR(100),
    CONTACTLASTNAME VARCHAR(100),
    CONTACTFIRSTNAME VARCHAR(100),
    DEALSIZE VARCHAR(50),

    PRIMARY KEY (ORDERNUMBER, ORDERLINENUMBER)
);


-- CHECKING FOR ERRORS AFTER IMPORTING FILE 

-- ERROR NOTICED!!
-- ERROR DURING IMPORTATION!!
-- TABLE NAME NO LONGER sample_sales_dataset 
-- TABLE NAME =  sales_data_sample 

SELECT COUNT(*) AS Total_Rows
FROM sales_data_sample;

SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_data_sample';

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sales_data_sample';

-- CLEANING QUERIES

SELECT * FROM sales_data_sample;

SELECT CONVERT(DATE, ORDERDATE) AS ORDERDATE
FROM sales_data_sample;

ALTER TABLE sales_data_sample
ALTER COLUMN ORDERDATE DATE;

SELECT * FROM sales_data_sample;

SELECT CONVERT(DECIMAL(10,2), ROUND(PRICEEACH, 2)) AS PRICEEACH
FROM sales_data_sample;

ALTER TABLE sales_data_sample
ALTER COLUMN PRICEEACH DECIMAL(10,2);

SELECT * FROM sales_data_sample;

SELECT CONVERT(DECIMAL(10,2), ROUND(SALES, 2)) AS SALES
FROM sales_data_sample;

ALTER TABLE sales_data_sample
ALTER COLUMN SALES DECIMAL(10,2);

SELECT * FROM sales_data_sample;

ALTER TABLE sales_data_sample
DROP COLUMN CLEANEPHONENUMBER;

SELECT CASE WHEN LEN(Digits) > 10 THEN 
            '+' + LEFT(Digits, LEN(Digits) - 10) + ' ' +
            '(' + SUBSTRING(Digits, LEN(Digits) - 9, 3) + ') ' +
            SUBSTRING(Digits, LEN(Digits) - 6, 3) + '-' +
            SUBSTRING(Digits, LEN(Digits) - 3, 4)
ELSE
    '(' + SUBSTRING(Digits, 1, 3) + ') ' +
            SUBSTRING(Digits, 4, 3) + '-' +
            SUBSTRING(Digits, 7, 4)  END AS FormattedPhoneNumber
FROM (
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    PHONE,'(','') ,')','') ,'-','') ,' ','') ,'.','') ,'+','') ,'[','') ,']','') ,'{','') ,'}',''
    ) AS Digits
    FROM sales_data_sample
) t;

SELECT Phone AS OldValue,
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
       Phone,'(','') ,')','') ,'-','') ,' ','') ,'.','') ,'+','') ,'[','') ,']','') ,'{','') ,'}',''
       ) AS CleanValue
FROM sales_data_sample;

UPDATE sales_data_sample
SET PHONE = CASE WHEN LEN(Digits) > 10 THEN 
            '+' + LEFT(Digits, LEN(Digits) - 10) + ' ' +
            '(' + SUBSTRING(Digits, LEN(Digits) - 9, 3) + ') ' +
            SUBSTRING(Digits, LEN(Digits) - 6, 3) + '-' +
            SUBSTRING(Digits, LEN(Digits) - 3, 4)
ELSE
            '(' + SUBSTRING(Digits, 1, 3) + ') ' +
            SUBSTRING(Digits, 4, 3) + '-' +
            SUBSTRING(Digits, 7, 4) END
FROM sales_data_sample
CROSS APPLY (
    SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    PHONE,'(','') ,')','') ,'-','') ,' ','') ,'.','') ,'+','') ,'[','') ,']','') ,'{','') ,'}',''
    ) AS Digits
) c;

SELECT * FROM sales_data_sample;

-- ANALYZING QUERIES

-- BASIC SQL QUERIES 

-- TOTAL REVENUE
SELECT SUM(SALES) AS Total_Revenue
FROM sales_data_sample;
-- Total_Revenue = 10,032,628.85

--TOTAL ORDERS
SELECT COUNT(DISTINCT ORDERNUMBER) AS Total_Orders
FROM sales_data_sample;
-- Total_Orders = 307

-- TOP 10 CUSTOMERS BY REVENUE
SELECT TOP 10 CUSTOMERNAME, SUM(SALES) AS Total_Spent
FROM sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY Total_Spent DESC;

-- REVENUE BY COUNTRY
SELECT COUNTRY, SUM(SALES) AS Revenue
FROM sales_data_sample
GROUP BY COUNTRY
ORDER BY Revenue DESC;

-- MONTHLY REVENUE TREND
SELECT YEAR_ID, MONTH_ID, SUM(SALES) AS Monthly_Revenue_Trend
FROM sales_data_sample
GROUP BY YEAR_ID,MONTH_ID
ORDER BY YEAR_ID, MONTH_ID;

-- AVERAGE ORDER VALUE
 SELECT AVG(SALES) AS Avg_Order_Value
 FROM sales_data_sample;
-- Avg_Order_Value = 3553.889071

-- BEST SELLING PRODUCT
SELECT PRODUCTLINE, SUM(SALES) AS Revenue
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY Revenue DESC;

SELECT * FROM sales_data_sample;

-- ADVANCED SQL QUERIES

-- WINDOW FUNCTIONS

-- CUSTOMER RANKING
SELECT CUSTOMERNAME,SUM(SALES) AS Revenue, RANK() OVER (ORDER BY SUM(SALES) DESC) AS Customer_Rank
FROM sales_data_sample
GROUP BY CUSTOMERNAME;

-- RUNNING REVENUE TOTAL
SELECT ORDERDATE, SALES, SUM(SALES) OVER(ORDER BY ORDERDATE) AS Running_Total
FROM sales_data_sample;

-- JOINS

-- CREATING CUSTOMER TABLE
CREATE TABLE CUSTOMER(
    CUSTOMERID INT PRIMARY KEY IDENTITY(1,1),
    CUSTOMERNAME VARCHAR(255)NOT NULL,
    PRODUCTLINE VARCHAR (255)
    );

  INSERT INTO CUSTOMER(CUSTOMERNAME, PRODUCTLINE)
  SELECT DISTINCT CUSTOMERNAME,PRODUCTLINE
  FROM sales_data_sample;

  SELECT * FROM CUSTOMER

-- INNER JOIN

SELECT S.CUSTOMERNAME, C.PRODUCTLINE,S.SALES
FROM sales_data_sample S
INNER JOIN CUSTOMER C
ON S.CUSTOMERNAME = C.CUSTOMERNAME;

SELECT * FROM sales_data_sample;

CREATE INDEX idx_customer
ON sales_data_sample(CUSTOMERNAME);


CREATE INDEX idx_productline
ON sales_data_sample(PRODUCTLINE);


CREATE INDEX idx_country
ON sales_data_sample(COUNTRY);

EXEC sp_helpindex 'sales_data_sample';





