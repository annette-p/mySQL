/* */ 

/* install chinook.sql database to local file*/ 
mysql -u root < chinook.sql

mysql -u root

show databases;
use Chinook;

show tables;

/* choose to show the overall table of each field and data type of the desired table in Chinook database (e.g choose either one of the table below Track or Album or Genre or Invoice or any other*/ 
describe Track;
describe Album;
describe Genre;
describe Invoice;

/* select the table to display the details of that table of desired, limited by first 10 items (in order not to flood the memory) */
SELECT * FROM Track
LIMIT 10;


/*  1. Display all Sales Support Agents with their first name and last name */ 
SELECT FirstName, LastName FROM Employee WHERE Title="Sales Support Agent";

/* 2. Display all employees hired between 2002 and 2003, and display their first name and last name */
SELECT FirstName, LastName FROM Employee WHERE YEAR(HireDate)=2002 OR YEAR(HireDate)=2003;
SELECT FirstName, LastName FROM Employee WHERE YEAR(HireDate) BETWEEN 2002 AND 2003;

/* 3. Display all artists that have the word 'Metal' in their name */ 
SELECT * FROM Artist WHERE Name LIKE "%Metal%";

/* 4. Display all employees who are in sales (sales manager, sales rep etc.) */
SELECT * FROM Employee WHERE Title LIKE "%sales%";

/* 5. Display the titles of all tracks which has the genre "easy listening" */ 
SELECT * FROM Track JOIN Genre
on Track.GenreId = Genre.GenreId
WHERE Genre.GenreId = 12
LIMIT 10;

SELECT Track.Name AS "Track Name", Genre.Name AS "Genre Name"  FROM Track JOIN Genre
on Track.GenreId = Genre.GenreId
WHERE Genre.GenreId = 12
LIMIT 10;

/* 6 - Display all the tracks from all albums along with the genre of each track */ 
SELECT Track.Name as "Track name", Album.Title as "Album title", Genre.Name as "Genre name" FROM Track 
JOIN Album
on Track.AlbumId = Album.AlbumId
JOIN Genre 
on Track.GenreId = Genre.GenreId 
LIMIT 10;


/* 7 - Using the Invoice table, show the average payment made for each country */ 
/* first - to see the table details
        SELECT * from Invoice
        LIMIT 10;
 */
SELECT BillingCountry, AVG(Total) as "average payment" from Invoice
GROUP BY BillingCountry;


/* 8 - Using the Invoice table, show the average payment made for each country, but only for countries that paid more than $5.50 in total average */ 
SELECT BillingCountry, AVG(Total) as "average payment" from Invoice
GROUP BY BillingCountry
HAVING AVG(Total) > 5.50;


/* 9 - Using the Invoice table, show the average payment made for each customer, but only for customer reside in Germany and only if that customer has paid more than 10 in total */ 
SELECT BillingCountry, AVG(Invoice.Total) as "average payment", Customer.FirstName, Customer.LastName from Invoice
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId 
WHERE Invoice.BillingCountry = "Germany"
GROUP BY BillingCountry, Customer.FirstName, Customer.LastName
HAVING SUM(Invoice.Total) > 10;


SELECT BillingCountry, AVG(Invoice.Total) as "average payment", SUM(Invoice.Total), Customer.FirstName, Customer.LastName from Invoice
JOIN Customer
ON Invoice.CustomerId = Customer.CustomerId 
WHERE Invoice.BillingCountry = "Germany"
GROUP BY BillingCountry, Customer.FirstName, Customer.LastName
HAVING SUM(Invoice.Total) > 10;

/* 10 - Display the average length of Jazz song (that is, the genre of the song is Jazz) for each album */ 

/* first */ 
select * from Track
limit 10;

select * from Genre
limit 10;

/* second */ 
SELECT AVG(Track.Milliseconds), Album.Title, Genre.Name as "Genre name" FROM Track 
JOIN Genre 
/* must always have "on" when "Genre", PK = FK, the data type of both key must be the same */ 
ON Track.GenreId = Genre.GenreId
JOIN Album
ON Track.AlbumId = Album.AlbumId
Where Genre.Name = "Jazz"
GROUP BY Album.Title;
