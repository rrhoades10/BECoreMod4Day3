CREATE DATABASE e_commerce_db; --  semi-colon is going to end a sql statement

-- USE to tell the query interpretter that I want to work within my e_commerce_db
USE e_commerce_db; 

-- DDL Data Definition Language -- defines where our data is going to live
-- DDL is going to be related to the shape of our database
CREATE TABLE Customer(
-- sql doesnt care about indentation
-- its just looking within the parantheses 
	customer_id INT AUTO_INCREMENT PRIMARY KEY, -- integer datatype that auto-increments for each new row, and is the primary key
    name VARCHAR(255) NOT NULL, -- this column must have data 
    email VARCHAR(255) NULL -- defaults to NULL, but specifies that this column doesnt always need data
	
);

-- Creating Order Table with a Foreign Key from the Customer Table
 CREATE TABLE Orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL, 
    customer_id INT,
    -- setting FOREIGN KEY constraint to the customer_id
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    
 ); -- unless...

-- ALTER TABLE oders
-- RENAME TO Orders

-- Adding columns to a table
-- changing the shape of the table
ALTER TABLE Customer
ADD phone VARCHAR(15); -- 15 is the maximum number of characters allocated for the phone column

-- modifying a columns type with ALTER and MODIFY
-- changing VARHCHAR for phone to CHAR
ALTER TABLE Customer
MODIFY phone CHAR(15);


-- allocated more characters to our email column
-- VARCHAR(255) to VARCHAR(320)
ALTER TABLE Customer
MODIFY email VARCHAR(320);

ALTER TABLE Customer
ADD address VARCHAR(255);

ALTER TABLE Customer
ADD username VARCHAR(100);

-- DROPPING DATABASES, TABLES, and COLUMNS
-- DROP DATABASE old_useless_database;

--  Dropping a table
-- DROP TABLE UnusedTable; 

-- Dropping a column -- ALTER TABLE
ALTER TABLE Customer
DROP username; 
-- ======================= DML - DATA MANIPULATION LANGUAGE - INSERT, UPDATE, DELETE ===================
--  inserting one row of data
INSERT INTO Customer (name, email, phone)
VALUES ("Obi-Wan Kenobi", NULL, "773-421-5210");

SELECT *
FROM Customer;

-- inserting multiple rows of data
-- entering a phone number longer than 15 characters
-- what happens if we leave NON NULL column empty

-- exceeding the character limit on a CHAR type
-- VALUES("Anakin Skywalker", "skyguy24@gmail.com", "1234567890123456"); <-- Error Data Too long for column
-- because of the 15 character limit

INSERT INTO Customer(name, email, phone)
VALUES("Anakin Skywalker", "skyguy24@gmail.com", "6308528209"); 

-- entering a NULL value for a NOT NULL column constraint 
-- INSERT INTO Customer(name, email, phone)
-- VALUES(NULL, "tano156@gmail.com", "6307894561"); Column name cannot be null

INSERT INTO Customer(name, email, phone)
VALUES("Ahsoka Tano", "tano156@gmail.com", "6307894561"); 

SELECT *
FROM Customer;

-- inserting multiple values
INSERT INTO Customer(name, email, phone)
VALUES ("Mace Windo", "purple@gmail.com", "7894561233"),
("Yoda", "lilgreenman@gmail.com", "773202LUNA"),
("Quinlan Vos", "vossyboi@gmail.com", "3122349874"),
("Kit Fisto", "squidguy@gmail.com", "3127765434"),
("Omen", "behindyou@gmail.com", "7631234324");

SELECT *
FROM Customer;

-- UPDATING SPECIFIC ROWS OF DATA - UPDATE, SET, WHERE 
UPDATE Customer
SET email = 'thesearenotthedroidsyourelookingfor@gmail.com' 
WHERE customer_id = 1;

-- SQL_SAFE_UPDATES -- SQL prevents us from updating or deleting rows of data without an id condition
-- while it is active
-- UPDATE Customer
-- SET address = "A Galaxy far far away...except Omen";
-- ^ give us an error because of the safe update mode. Cannot update without the where clause and a key column

-- Turning off the SQL_SAFE_UPDATES
SET SQL_SAFE_UPDATES = 0; -- turns off safe update mode
UPDATE Customer
SET address = "A Galaxy far, far away...except Omen"
WHERE name = "Obi-Wan Kenobi";
SET SQL_SAFE_UPDATES = 1; -- turns on safe update mode

-- Updating a specific row of data using the primary key
UPDATE Customer
SET address = "The Headquarters of Valorant"
WHERE customer_id = 8;

SELECT *
FROM Customer;

-- DELETE FROM table_name
-- WHERE certain condition 
-- delete by primary key 
DELETE FROM Customer
WHERE customer_id = 7;  


UPDATE Customer
SET phone = 6308247768
WHERE customer_id = 4;

SELECT *
FROM Customer
WHERE city = "Chicago" and zipcode = "60618";

-- ====================== DQL Dairy Queen Land or Data Query Langyage - SELECT FROM WHERE and more! ==================================
--  query to select all rows of data from the customer table
SELECT * -- * indicates all columns 
FROM Customer; -- table we are displaying information from


-- naming columns in the SELECT state
-- columns that show up below
SELECT name, address -- query to display only the name and address columns
FROM Customer; -- from the customer table

--  only selecting the name column
SELECT name
FROM Customer;

-- using the WHERE clause 
SELECT * -- selecting all columns
FROM Customer -- from customer table
WHERE name = "Yoda";

-- refine our search with WHERE and AND 
SELECT * -- selecting all columns
FROM Customer -- from customer table
WHERE name = "Ahsoka Tano" and phone = 1234567890; -- both these need to be true in order to pull back the relevant data

-- OR for two or more possible conditions
 SELECT *
 FROM Customer
 WHERE name = "Mace Windu" or phone = "6308247768";
 
 -- excluding data with NOT
 SELECT *
 FROM Customer
 WHERE NOT name = "Omen";
 -- all rows of data where the name is not equal "Omen"
 
 -- ORDER BY - sorts by a specific column
 SELECT *
 FROM Customer
 ORDER BY name; -- defaults to ASC order
 
 -- Order BY DESC
 SELECT *
 FROM Customer
 ORDER BY customer_id DESC;
 
 -- DISTINCT for displaying only one instance of a specific column
 SELECT DISTINCT email
 FROM Customer;
 
 -- % <-- Wildcard character in combination with LIKE -- possibly pulling phone numbers with a specific area code
  -- anything that starts
 SELECT *
 FROM Customer
 WHERE phone LIKE '630%'; -- phone numbers that start with 630
 -- finding people with email domains
 SELECT *
 FROM Customer
 WHERE email LIKE "%green%"; -- emails that end with gmail.com
 
--  BETWEEN thing 1 and thing2
SELECT *
FROM Customer
WHERE customer_id BETWEEN 1 and 5;

-- MIN and MAX return the smallest and largest value from the column 
SELECT MIN(customer_id)
FROM Customer; -- customer_id 1

SELECT MAX(customer_id)
FROM Customer; -- customer_id 9

-- Counting the number of rows from a table -- COUNT()
SELECT COUNT(address)
FROM Customer;

SELECT *
FROM Customer;

-- Working with Foreign Keys
-- Insert Data into our Order Table
INSERT INTO Orders(date, customer_id)  
VALUES('2024-04-04', 1);
-- inserts data into our order table
-- with an order that was 'completed' by customer_id 1
SELECT *
FROM Orders;

-- referencing a customer_id that doesn't exist
-- will give us an error 
INSERT INTO Orders(date, customer_id)  
VALUES('2024-04-04', 25); -- customer_id 25 does not exist, we cant create a relationship with something that does not exist

-- creating multiple rows of data for the order table
-- to reflect several customers making orders
INSERT INTO Orders(date, customer_id)  
VALUES('2024-04-04', 1),
('2024-04-04', 2),
('2024-04-04', 3);

-- reflect the One to many relationship between the customer and order table
-- ONE customer can make MANY orders
-- ONE customer_id can show up in the Orders table, several times

SELECT *
FROM Orders;

SELECT *
FROM Orders
ORDER BY customer_id;

-- using distinct
SELECT DISTINCT customer_id
FROM Orders; 



 





















