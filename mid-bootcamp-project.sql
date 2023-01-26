#1 Create a database called house_price_regression.

CREATE DATABASE 
	house_price_regression;
USE 
	house_price_regression;

#2 Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.

CREATE TABLE 
	house_price_data(id CHAR(10),
					date CHAR(10),
					bedrooms INT,
					bathrooms double,
					sqft_living INT,
					sqft_lot INT,
					floors DOUBLE,
					waterfront INT,
					view INT,
					condition1 INT,
					grade INT,
					sqft_above INT,
					sqft_basement INT,
					yr_built INT,
					yr_renovated INT,
					zipcode INT,
					latitude double,
					longitude double,
					sqft_living15 INT,
					sqft_lot15 INT,
					price double);

#4 Select all the data from table house_price_data to check if the data was imported correctly

SELECT 
	* 
FROM 
	house_price_data;

# 5 Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
# Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE
	house_price_data
DROP COLUMN
	date;

SELECT 
	* 
FROM 
	house_price_data
LIMIT
	10;

#6 Use sql query to find how many rows of data you have.

SELECT
	count(*) 
FROM
	house_price_data;
    
#7 Now we will try to find the unique values in some of the categorical columns:

#What are the unique values in the column bedrooms?
    
SELECT DISTINCT 
				bedrooms
FROM 
	house_price_data;
    
#What are the unique values in the column bathrooms?

SELECT DISTINCT 
				bathrooms
FROM 
	house_price_data;

#What are the unique values in the column floors?

SELECT DISTINCT 
				floors
FROM 
	house_price_data;

#What are the unique values in the column condition?

SELECT DISTINCT 
				condition1
FROM 
	house_price_data;
    
#What are the unique values in the column grade?    

SELECT DISTINCT 
				grade
FROM 
	house_price_data;
    
#8 Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.

SELECT
	id
FROM
	house_price_data
ORDER BY 
	price desc
LIMIT
	10;
    
#9 What is the average price of all the properties in your data?

SELECT 
	ROUND(AVG(price),2) as average_price
FROM
	house_price_data;
    
    
#10 exercise we will use simple group by to check the properties of some of the categorical variables in our data
#What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. 
#Use an alias to change the name of the second column.

SELECT 
	bedrooms, ROUND(AVG(price),2) as average_price
FROM
	house_price_data
GROUP BY
	bedrooms
ORDER BY
	bedrooms;

#What is the average sqft_living of the houses grouped by bedrooms? 

SELECT 
	bedrooms, ROUND(AVG(sqft_living))
FROM
	house_price_data
GROUP BY
	bedrooms
ORDER BY
	bedrooms;


#The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.

SELECT 
	bedrooms, ROUND(AVG(sqft_living)) as average_living
FROM
	house_price_data
GROUP BY
	bedrooms
ORDER BY
	bedrooms;

#What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. 
#Use an alias to change the name of the second column.

SELECT 
	waterfront, ROUND(AVG(price),2) as average_living
FROM
	house_price_data
GROUP BY
	waterfront
ORDER BY
	waterfront;

#Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then 
#aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

SELECT 
	grade, avg(condition1)
FROM
	house_price_data
GROUP BY
	grade
ORDER BY
	grade;

SELECT 
	condition1, avg(grade)
FROM
	house_price_data
GROUP BY
	condition1
ORDER BY
	condition1;
    
# no evidence of correlation.


#11 One of the customers is only interested in the following houses:

#Number of bedrooms either 3 or 4

SELECT
	*
FROM
	house_price_data
WHERE 
	bedrooms = 3 or bedrooms = 4;


#Bathrooms more than 3

SELECT
	*
FROM
	house_price_data
WHERE 
	bathrooms > 3;
    
    
#One Floor

SELECT
	*
FROM
	house_price_data
WHERE 
	floors = 1;
    
    
#No waterfront

SELECT
	*
FROM
	house_price_data
WHERE 
	waterfront = 0;
    
    
#Condition should be 3 at least

SELECT
	*
FROM
	house_price_data
WHERE 
	condition1 >= 3;

#Grade should be 5 at least

SELECT
	*
FROM
	house_price_data
WHERE 
	grade >= 5;
    
    
#Price less than 300000

SELECT
	*
FROM
	house_price_data
WHERE 
	price < 300000;

#For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

SELECT
	*
FROM
	house_price_data
WHERE
	bedrooms > 2
    AND
    bedrooms < 5
    AND
    bathrooms > 3
    AND
    floors = 1
    AND
    waterfront = 0
    AND
    condition1 >= 3
    AND
    grade >= 5
    AND
    price < 300000;
    
# There is no house that fits their conditions.

#12 Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. 
#Write a query to show them the list of such properties. You might need to use a sub query for this problem.


SELECT
	*
FROM
	house_price_data
WHERE
	price > (SELECT 
				avg(price)*2
			FROM
				house_price_data);
                
#13 Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW
	price_twice_avg
AS
SELECT
	*
FROM
	house_price_data
WHERE
	price > (SELECT 
				avg(price)*2
			FROM
				house_price_data);


#14 Most customers are interested in properties with three or four bedrooms. 
#What is the difference in average prices of the properties with three and four bedrooms?

SELECT
	(SELECT 
		ROUND(AVG(price)) 
	FROM house_price_data 
    WHERE bedrooms = 4) - (SELECT 
								ROUND(AVG(price)) 
							FROM house_price_data 
                            WHERE bedrooms = 3) 
AS difference;
 
# 15 What are the different locations where properties are available in your database? (distinct zip codes)

SELECT 
	DISTINCT(zipcode) 
FROM 
	house_price_data;

# 16 Show the list of all the properties that were renovated.

SELECT
	id, yr_renovated
FROM
	house_price_data
WHERE
	yr_renovated > 0
ORDER BY
	yr_renovated;

#17 Provide the details of the property that is the 11th most expensive property in your database.

SELECT
	*
FROM
	house_price_data
ORDER BY
	price desc
LIMIT
	10, 1;
