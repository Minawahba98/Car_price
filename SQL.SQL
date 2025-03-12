--- Create Table 
CREATE TABLE Car_Price (
Brand VARCHAR(50),
Model VARCHAR(50),
Year INT,
Engine_Size FLOAT,
Fuel_Type VARCHAR(20),
Transmission VARCHAR(30),
Mileage INT,
Doors INT,
Owner_Count INT,
Price INT
);


--Checking for Missing Values (NULLs)
select count(*) from car_price
WHERE Brand IS NULL 
OR Model IS NULL 
OR Year IS NULL 
OR Engine_Size IS NULL 
OR Fuel_Type IS NULL 
OR Transmission IS NULL 
OR Mileage IS NULL 
OR Doors IS NULL 
OR Owner_Count IS NULL 
OR Price IS NULL;

-- Check for Duplicate Records
select  Brand , Model, Year, Engine_Size, Fuel_Type, Transmission, Mileage, Doors, Owner_Count, Price, COUNT(*) 
FROM Car_Price
group by Brand , Model, Year, Engine_Size, Fuel_Type, Transmission, Mileage, Doors, Owner_Count, Price
having count(*) > 1


--Check for Incorrect Data
SELECT * FROM Car_Price WHERE Year < 1900 OR Year > 2025;
--
SELECT * FROM Car_Price WHERE Engine_Size < 0.5 OR Engine_Size > 10;
--
SELECT * FROM Car_Price WHERE Mileage < 0 OR Mileage > 500000;
--
SELECT * FROM Car_Price WHERE Doors < 2 OR Doors > 6;
--
SELECT * FROM Car_Price WHERE Owner_Count < 1 OR Owner_Count > 10;
--
SELECT * FROM Car_Price WHERE Price < 500 OR Price > 500000;




--Standardizing Categorical Data
SELECT DISTINCT Fuel_Type FROM Car_Price;
--
SELECT DISTINCT Transmission FROM Car_Price;

-------------------------------------Business Quetions ------------------------------------------------------------

-- Find all cars priced above $20,000.
select * from car_price
where Price >= 20000

-- List all Toyota cars manufactured in 2015 or later.
select * from car_price
where year = '2015' or year > 2015

-- Retrieve all electric cars with less than 50,000 miles.
select * from car_price 
where lower(fuel_type) = 'electric'
and mileage < 50000


--  Get a list of all unique car brands in the dataset.
select distinct brand from car_price

-- Find all cars that have exactly 2 previous owners.
select * from car_price
where owner_count = 2


-- Show the 5 cheapest cars in the dataset.
with min_price as (select min(price) from car_price)
select * from car_price 
where price <= (select * from min_price)
order by price 
limit 5


-- Find all cars that have "Automatic" transmission and were made after 2018.
select * from car_price
where lower(transmission) = 'automatic'
and year > 2018


-- Retrieve all cars where the engine size is greater than 3.0 and the price is below $15,000.
select * from car_price
where engine_size > 3.0
and price < 15000

-- Find all cars with mileage between 10,000 and 100,000 miles.
select * from car_price 
where mileage between 10000 and 100000

-- List all cars sorted by price from highest to lowest..
select * from car_price 
order by price DESC

-- Find the total number of cars in the dataset.
select Count(*) from car_price

-- Count how many cars each brand has in the dataset.
select brand , count(*) from car_price
group by brand

-- Find the average price of cars for each brand.
select brand , round(avg(price), 2) from car_price
group by brand

-- Show the top 5 most expensive cars
select max(price) , brand from car_price
group by brand
order by max(price) DESC
limit 5


-- Find the total number of electric cars in the dataset
select Count(*) from car_price
where lower(fuel_type) = 'electric' 

-- Get the average mileage of cars grouped by fuel type
select fuel_type, round(avg(mileage) , 2) from car_price
group by fuel_type


-- Find the number of cars with each transmission type
select transmission, count(*)  from car_price
group by transmission


-- Find the highest and lowest price for each car brand.
select brand , max(price) as highest , min(price) as lowest from car_price
group by brand


-- Get the total number of cars that have been owned by more than 2 people.
select count(*) from car_price
where owner_count > 2

-- Show the brands that have more than 50 cars in the dataset.
select brand , count(*) from car_price
group by brand
having count(*) > 50

WITH RankedCars AS (
    SELECT 
        Brand, 
        Model, 
        Price, 
        RANK() OVER (PARTITION BY Brand ORDER BY Price ASC) AS rank
    FROM Car_Price
)
SELECT Brand, Model, Price
FROM RankedCars
WHERE rank <= 3;
