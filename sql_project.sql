-- SQL Retail sales Analysis

-- Create Table 

CREATE TABLE retail_sales
          (
             transactional_id INT PRIMARY KEY,
			 sale_date DATE,
			 sale_time TIME,
			 customer_id INT,
			 gender VARCHAR(15),
			 age INT,
			 category VARCHAR(15),
			 quantity INT,
			 price_per_unit FLOAT,
			 cogs FLOAT,
			 total_sale FLOAT
			 
		   );


SELECT * FROM retail_sales;

SELECT COUNT(*)
FROM retail_sales


SELECT * FROM retail_sales
WHERE transactional_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date is null

SELECT * FROM retail_sales
WHERE 
      transactional_id IS NULL
	  or
      sale_date is null
	  or
      sale_time is null
	  or
	  customer_id is null
	  or
	  gender is null
	  or
	  age is null
	  or 
	  category is null
	  or 
	  quantity is null
	  or 
	  price_per_unit is null
	  or 
	  cogs is null
	  or 
	  total_sale is null
--
DELETE FROM retail ;

SELECT *FROM retail_sales

SELECT COUNT(*)
FROM retail_sales


SELECT * FROM retail_sales
WHERE 
      transactional_id IS NULL
	  or
      sale_date is null
	  or
      sale_time is null
	  or
	  customer_id is null
	  or
	  gender is null
	  or
	  age is null
	  or 
	  category is null
	  or 
	  quantity is null
	  or 
	  price_per_unit is null
	  or 
	  cogs is null
	  or 
	  total_sale is null;
--
DELETE FROM retail_sales
WHERE 
      transactional_id IS NULL
	  or
      sale_date is null
	  or
      sale_time is null
	  or
	  customer_id is null
	  or
	  gender is null
	  or
	  age is null
	  or 
	  category is null
	  or 
	  quantity is null
	  or 
	  price_per_unit is null
	  or 
	  cogs is null
	  or 
	  total_sale is null


SELECT COUNT(*) from retail_sales


-- data exploration
-- how many sales we have
SELECT COUNT(*) as total_sale FROM retail_sales

-- how many unique customer we have?

SELECT COUNT(DISTINCT customer_id) FROM retail_sales

-- how many unique category we have ?
SELECT DISTINCT category FROM retail_sales


-- Data analysis and business key problem and answers

-- 1. write a sql query to retrieve all columns for sales made on  '2022-11-05'

SELECT * 
FROM retail_sales
WHERE Sale_date = '2022-11-05'

--2. write a sql query  to  retreive all  transaction where the  category is 'clothing' and the 
-- quantity sold in more 10 in the month  of nov-2022

SELECT 
*
FROM retail_sales
WHERE
     category = 'Clothing' 
	 AND
	 TO_CHAR(sale_date,'YYYY-MM')= '2022-11'
	 AND
	 quantity >=3

--3. write a sql query  to calculate  the total sales (total sale) for each category
SELECT 
     category,
	 SUM(total_sale) as  net_sale,
	 COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1


--4. write a sql query to find the average of customer who puchased  items from  the beauty category

SELECT AVG(age)
FROM retail_sales
WHERE category = 'Beauty'

--5.write a sql query to find all transaction where the total_sale is greater 1000

SELECT *
FROM retail_sales
WHERE total_sale>1000

--6. write a sql query to find the total number of transactions (transaction_id) made by each gender in each directory

SELECT
      category,
	  gender,
	  COUNT(*) as total_trans
FROM retail_sales
GROUP
     BY
	 category,
	 gender

--7. write a sql query to calculate the average sale for each month. Find out the best selling month in each year

SELECT
      year,
	  month,
	  avg_sale
FROM
(
SELECT
     EXTRACT(YEAR FROM sale_date) as year,
	 EXTRACT(MONTH FROM sale_date) as month,
	 AVG(total_sale) as avg_sale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG (total_sale) DESC) AS Rank
FROM retail_sales
GROUP BY 1,2
) as t1

WHERE rank=1
--ORDER BY 1,3 DESC

-- 8  WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST SALES

SELECT
      customer_id,
	  sum(total_sale) as total_slaes
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 9 WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY

SELECT
      category,
      COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY 1

--10 wrote a sql query to create  each shift and number of orders(example Morning<=12,afternoon Between 12 &17, evening >17)

WITH hourly_sale
AS
(
SELECT *,
     CASE
	    WHEN EXTRACT (HOUR FROM sale_time) <12 Then 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 and 17 THEN 'Afternoon'
		ELSE 'evening'
	END as shift
FROM retail_sales
)
SELECT
     shift,
	 COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

-- End of project


