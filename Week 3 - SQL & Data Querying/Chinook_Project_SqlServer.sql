

USE Chinook;



-- CHECKING TABLE RELATIONSHIPS

SELECT fk.name AS ForeignKey, pt.name AS ParentTable, rt.name AS ReferencedTable
FROM sys.foreign_keys AS fk
INNER JOIN sys.tables AS pt
ON fk.parent_object_id = pt.object_id
INNER JOIN sys.tables rt
ON fk.referenced_object_id = pt.object_id;



-- FACT TABLE

SELECT * FROM Track;



-- CUSTOMER TABLE

SELECT * FROM Customer;

SELECT * FROM Invoice;

-- FILTERING CUSTOMERS FROM COUNTRIES

SELECT * FROM Customer
WHERE Country = 'Canada';

SELECT * FROM Customer
WHERE Country = 'Czech Republic';

SELECT FirstName, LastName 
From Customer
ORDER BY LastName;

SELECT FirstName, LastName, Country
From Customer
WHERE Country = 'France';

-- CUSTOMER COUNT
SELECT COUNT(*) AS Total_Customers
FROM Customer;

-- CUSTOMERS BY COUNTRY
SELECT Country, COUNT(*) AS Total_Customers
From Customer
GROUP BY Country
ORDER BY Total_Customers DESC;

-- CUSTOMERS AND THEIR INVOICES
SELECT C.FirstName, C.LastName,
	   I.InvoiceDate, I.Total
FROM Customer AS C
INNER JOIN Invoice AS I
ON C.CustomerId = I.CustomerId;

-- TOP 10 CUSTOMERS BY REVENUE
SELECT TOP 10 C.CustomerID,C.FirstName, C.LastName, C.Country, SUM(I.Total) AS Total_Spent
FROM Customer AS C
INNER JOIN Invoice AS I
ON C.CustomerId = I.CustomerId
GROUP BY C.CustomerId, C.FirstName, C.LastName, C.Country
ORDER BY Total_Spent DESC;

-- CUSTOMERS WITH THE MOST PURCHASES
SELECT C.FirstName, C.LastName, COUNT(I.InvoiceId) AS Number_Of_Purchases
FROM Customer AS C
INNER JOIN Invoice AS I
ON C.CustomerId = I.CustomerId
GROUP BY C.FirstName, C.LastName
ORDER BY Number_Of_Purchases DESC;

-- CUSTOMERS RANK BY REVENUE
SELECT C.FirstName, C.LastName, SUM(I.Total) AS Total_Spent,
RANK() OVER (ORDER BY SUM(I.Total) DESC) AS Customer_Rank
FROM Customer AS C
INNER JOIN Invoice AS I
ON C.CustomerId = I.CustomerId
GROUP BY C.FirstName, C.LastName;


-- ALBUM AND ARTIST TABLE

SELECT * FROM Album;

SELECT * FROM Artist;

SELECT * FROM Track;

-- ALBUM COUNT
SELECT COUNT(*) AS Total_Albums
FROM Album;

-- COUNT OF ALBUMS PER ARTISTS
SELECT ArtistId, COUNT(*) AS Total_Albums
FROM Album
GROUP BY ArtistId
ORDER BY Total_Albums DESC;

-- JOIN ALBUM + ARTIST TABLES
SELECT AL.Title AS Album, AR.Name AS Artist
FROM Album AS AL
INNER JOIN Artist AS AR
ON AL.ArtistId = AR.ArtistId

-- ARTISTS WITH MULTIPLE ALBUMS
SELECT AR.Name, COUNT(AL.AlbumId) AS Album_Count
FROM Artist AS AR
INNER JOIN Album AS AL
ON AR.ArtistId = AL.ArtistId
GROUP BY AR.Name
HAVING COUNT(AL.AlbumId) > 1
ORDER BY Album_Count DESC;

-- ALBUMS WITH THE MOST TRACKS
SELECT AL.Title AS Album, COUNT(T.TrackId) AS Total_Tracks
FROM Album AS AL
INNER JOIN Track AS T
ON AL.AlbumId = T.AlbumId
GROUP BY AL.Title
ORDER BY Total_Tracks DESC;


-- INVOICE, INVOICELINE AND TRACK TABLE

SELECT * FROM Invoice;

SELECT * FROM InvoiceLine;

SELECT * FROM Track;

-- TOTAL REVENUE
SELECT SUM(Total) AS Total_Revenue
FROM Invoice;

-- AVERAGE INVOICE VALUE
SELECT AVG(Total) AS Avg_Invoice
FROM Invoice;

-- REVENUE BY COUNTRY
SELECT BillingCountry, SUM(Total) AS Revenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY Revenue DESC;

-- YEARLY REVENUE TREND
SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(Total) AS Revenue
FROM Invoice
GROUP BY YEAR(InvoiceDate),MONTH(InvoiceDate)
ORDER BY Year DESC;

SELECT * FROM Track;

-- MOST PURCHASED TRACKS
SELECT TrackId, SUM(Quantity) AS Total_Purchased
FROM InvoiceLine
GROUP BY TrackId
ORDER BY Total_Purchased;

-- JOIN INVOICELINE TABLE + TRACK TABLE
SELECT IL.InvoiceLineId,T.Name AS TrackName, IL.Quantity, IL.UnitPrice
FROM InvoiceLine AS IL
INNER JOIN Track AS T
ON IL.TrackId = T.TrackId;

-- JOIN TRACK + ALBUM + ARTIST TABLES
SELECT T.Name AS Track, AL.Title AS Album, AR.Name AS Artist
FROM Track AS T
INNER JOIN Album AS AL
ON T.AlbumId =AL.AlbumId
INNER JOIN Artist AS AR
ON AL.ArtistId = AR.ArtistId;

-- TRACK WITH THE MOST REVENUE
SELECT T.Name AS Track, SUM(IL.UnitPrice * IL.Quantity) AS Revenue
FROM InvoiceLine AS IL
INNER JOIN Track AS T
ON IL.TrackId = T.TrackId
GROUP BY T. Name
ORDER BY Revenue DESC;


-- EXTRA QUERIES

SELECT * FROM Genre;

SELECT * FROM Playlist;

SELECT * FROM PlaylistTrack;

SELECT * FROM MediaType;

-- MOST POPULAR GENRE
SELECT G.Name AS Genre, COUNT(IL.InvoiceLineId) AS Purchases
FROM InvoiceLine AS IL
INNER JOIN Track AS T
ON IL.TrackId = T.TrackId
INNER JOIN Genre AS G
ON T.GenreId = G.GenreId
GROUP BY G.Name
ORDER BY Purchases DESC;


-- PLAYLISTS WITH THE MOST TRACKS
SELECT P.Name AS Playlist, COUNT(PT.TrackId) AS Total_Tracks
FROM Playlist AS P
INNER JOIN PlaylistTrack AS PT
ON P.PlaylistId = PT.PlaylistId
GROUP BY P.Name
ORDER BY Total_Tracks DESC;


-- MOST USED MEDIA TYPE
SELECT MT.Name AS MediaType, COUNT(T.TrackId) AS Total_Tracks
FROM MediaType AS MT
INNER JOIN Track AS T
ON MT.MediaTypeId = T.MediaTypeId
GROUP BY MT.Name
ORDER BY Total_Tracks DESC;


















