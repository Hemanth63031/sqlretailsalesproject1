create table retailsales(
					transactions_id int primary key,
					sale_date DATE,
					sale_time TIME,
					customer_id varchar(50),
					gender varchar(20),
					age int,
					category varchar(50),
					quantiy int,
					price_per_unit float,
					cogs float,
					total_sale float
                        );

select * from retailsales limit 10;
select count(*) from retailsales;
--data cleaning
select * from retailsales 
where 
    transactions_id is null
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
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;

delete from retailsales
where
    transactions_id is null
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
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;



--Data exploration

--How many sales we have?
select
      count(*)as total_sales 
	  from retailsales;

-- How many uniuque customers we have?
select
      count(DISTINCT customer_id) as uniuque_customers 
	  from retailsales;

select
      DISTINCT category as uniuque_category 
	  from retailsales;



--Q.1 Write a sql quary to retrieve all columns for sales made on '2022-11-05'
select * from retailsales
	   where 
       sale_date='2022-11-05';


--Q.2 Write a sql quary to retrieve all transections where the category is 'Clothing' and quantity sold more than or equal to 4 in the month of Nov-2022 
select * from retailsales 
	   where 
	   category='Clothing' 
	   and
	   quantiy >=4 
	   and 
	   TO_CHAR(sale_date, 'YYYY-MM')='2022-11';


--Q.3 Write a sql quary to calculate the total sales(total_sale) from each category
select
      category,sum(total_sale) as net_sale,
	  count(*) as total_orders
	  from retailsales
	  Group by 1;


--Q.4 Write a sql quary to find the average age of customers who purchased items from the 'Beauty'category
select
      round(avg(age) ,2)
	  from retailsales 
	  where
	  category='Beauty';


--Q.5 Write a sql quary to find all transections where the total_sale is greater than 1000
select * from retailsales 
       where
	   total_sale>1000;


--Q.6 Write a sql quary to find the total number of transactions (transaction_id) made by each gender in each category
select 
      category,gender, count(*) as total_trans 
	  from retailsales 
	  group by category,gender 
	  order by 1


--Q.7 Write a sql quary to calculate the average sale for each month , Find out the best selling month in each years

select 
      year,
	  month,
	  avg_sale
from 
(
select 
      extract(year from sale_date) as year,
	  extract(month from sale_date) as month,
	  avg(total_sale) as avg_sale,
	  rank()over(partition by extract(year from sale_date)order by avg(total_sale)desc)as rank
from retailsales
group by 1, 2
) as t1
where
rank=1


--Q.8 Write a sql quary to find the top 5 customers based on the highest total sales
select
      customer_id,
	  sum(total_sale) as total_sale from retailsales
	  group by 1 
	  order by 2 desc
	  limit 5


--Q.9 Write a sql quary to find the number of unique customer who purchased items from each category 
select 
      category,
	  count(distinct customer_id) from retailsales
group by 1


--Q.10 Write a sql quary to create each shift and number of orders (Example Monring <12, Afternoon Between 12 & 17, Evening >17) 
with hourly_sale
as
(select *, 
       case 
	       when extract (hour from sale_time) < 12 THEN 'Morning' 
		   when extract (hour from sale_time) Between 12 and 17 THEN 'Afternoon' 
		   else 'Evening'
	   end as shift from retailsales
)
select 
      shift, 
	  count(*) as total_orders
from hourly_sale
group by shift 

-- End of project 
	   




	
