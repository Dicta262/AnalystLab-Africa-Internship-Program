
CREATE DATABASE Netflix_DB;

CREATE TABLE Netflix_Titles (
    Show_ID VARCHAR(20),
    Show_Type VARCHAR(20),
    Title NVARCHAR(MAX),
    Director NVARCHAR(MAX),
    Cast_Members NVARCHAR(MAX),
    Country NVARCHAR(255),
    Date_Added VARCHAR(50),
    Release_Year INT,
    Rating VARCHAR(20),
    Duration VARCHAR(50),
    Listed_In NVARCHAR(255),
    Show_Description NVARCHAR(MAX)
);



SELECT TOP 10 *
FROM Netflix_Titles;

SELECT COUNT(*) AS Total_Rows
FROM Netflix_Titles;

SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Netflix_Titles';


SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Netflix_Titles';


SELECT
    SUM(CASE WHEN director IS NULL OR director = '' THEN 1 ELSE 0 END) AS Missing_Director,
    SUM(CASE WHEN Cast IS NULL OR Cast = '' THEN 1 ELSE 0 END) AS Missing_Cast,
    SUM(CASE WHEN country IS NULL OR country = '' THEN 1 ELSE 0 END) AS Missing_Country,
    SUM(CASE WHEN rating IS NULL OR rating = '' THEN 1 ELSE 0 END) AS Missing_Rating,
    SUM(CASE WHEN duration IS NULL OR duration = '' THEN 1 ELSE 0 END) AS Missing_Duration
FROM Netflix_Titles;

SELECT
SUM(CASE WHEN date_added IS NULL OR date_added = '' THEN 1 ELSE 0 END) AS Missing_Date
FROM Netflix_Titles;

UPDATE Netflix_Titles
SET director = 'Unknown'
WHERE director IS NULL OR director = '';

UPDATE Netflix_Titles
SET cast = 'Unknown'
WHERE cast IS NULL OR cast = '';

UPDATE Netflix_Titles
SET country = 'Unknown'
WHERE country IS NULL OR country = '';

UPDATE Netflix_Titles
SET rating = 'Not Rated'
WHERE rating IS NULL OR rating = '';

UPDATE Netflix_Titles
SET duration = 'Unknown'
WHERE duration IS NULL OR duration = '';

UPDATE Netflix_Titles
SET Date_Added = 'Unknown'
WHERE Date_Added IS NULL OR Date_Added = '';


WITH DuplicateCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY title, type, release_year
               ORDER BY show_id
           ) AS rn
    FROM Netflix_Titles
)

DELETE FROM DuplicateCTE
WHERE rn > 1;

UPDATE Netflix_Titles
SET type = UPPER(type);

UPDATE Netflix_Titles
SET country = TRIM(country);


ALTER TABLE Netflix_Titles
ADD date_added_clean DATE;

UPDATE Netflix_Titles
SET date_added_clean =
TRY_CONVERT(DATE, date_added);


SELECT *
FROM Netflix_Titles
WHERE release_year < 1900
   OR release_year > YEAR(GETDATE());


SELECT *
FROM Netflix_Titles
WHERE title IS NULL OR title = '';


SELECT COUNT(*) AS Total_Content
FROM Netflix_Titles;

SELECT type, COUNT(*) AS Total
FROM Netflix_Titles
GROUP BY type;

SELECT AVG(release_year) AS Avg_Release_Year
FROM Netflix_Titles;

SELECT TOP 10 country,
       COUNT(*) AS Total_Content
FROM Netflix_Titles
GROUP BY country
ORDER BY Total_Content DESC;

SELECT rating,
       COUNT(*) AS Total
FROM Netflix_Titles
GROUP BY rating
ORDER BY Total DESC;


SELECT YEAR(date_added_clean) AS Year_Added,
       COUNT(*) AS Total_Content
FROM Netflix_Titles
GROUP BY YEAR(date_added_clean)
ORDER BY Year_Added;


SELECT type,
       rating,
       COUNT(*) AS Total
FROM Netflix_Titles
GROUP BY type, rating
ORDER BY Total DESC;


SELECT country,
       type,
       COUNT(*) AS Total
FROM Netflix_Titles
GROUP BY country, type;

SELECT 
    release_year,
    COUNT(*) AS total_titles
FROM Netflix_Titles
GROUP BY release_year
ORDER BY release_year;


SELECT * FROM Netflix_Titles;














