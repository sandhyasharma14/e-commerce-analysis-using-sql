 USE E_Commerce_Project;

select * from customers

select * from products

select * from orders

select * from order_items

--Business questions.--

--1. what is the total revenue so far?
select round(sum(quantity*unit_price),2) as total_revenue
from order_items;

--2. how many total orders have we received?
select count(*) as total_orders
from orders

--3. how many total customers do we have?
select count(*) as total_customers
from customers

--4. how many total product do we sell?
select count(*) as total_products
from products

--5. what is the average amount a customer spends per orders?
select round(sum(quantity * unit_price) / count(distinct order_id),2) as avg_ordervalue
from order_items

--6. what are the top 5 best selling products?
select top 5 p.product_name,sum(oi.quantity) as total_qty
from order_items oi
join products p
on oi.product_id = p.product_id
group by p.product_name
order by sum(oi.quantity) desc;

--7. which category is generating the most revenue
select p.category,sum(oi.quantity* oi.unit_price) as revenue
from order_items oi
join products p
on oi.product_id = p.product_id
group by p.category
order by sum(oi.quantity* oi.unit_price) desc;

--8. who are the top 5 most valuable customers?
select top 5 c.customer_name,sum(oi.quantity * oi.unit_price) as revenue
from customers c
join orders o
on o.customer_id = c.customer_id
join order_items oi
on oi.order_id =o.order_id
group by c.customer_name
order by sum(oi.quantity * oi.unit_price) desc;

--9. how has the revenue trending month by month?
select * from order_items
select * from orders 

select format(o.order_date,'yyyy-MM') as month,sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
where o.order_status='Delivered'
group by format(o.order_date,'yyyy-MM')
order by format(o.order_date,'yyyy-MM') desc;

--10. which city is generate the most sales?
select c.city,sum(oi.quantity*oi.unit_price) as revenue
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items oi
on oi.order_id = o.order_id
group by c.city
order by sum(oi.quantity*oi.unit_price) desc;

--11. which customer purchase repeatedly?
select customer_id,count(order_id) as total_orders
from orders
group by customer_id
having count(order_id)>1
order by count(order_id) desc

--12.which customer have never placed an orders?
select c.customer_id,c.customer_name
from customers c
left join orders o
on c.customer_id=o.customer_id
where o.order_id is null;


--13. which customer have been inactive in the last 90 days?
select c.customer_id,c.customer_name,max(o.order_date) as last_order
from customers c
left join orders o
on c.customer_id=o.customer_id
group by  c.customer_id,c.customer_name
having max(o.order_date)<'2026-04-30'or max(o.order_date) is null
order by max(o.order_date);

--14. what is the best selling category?
select p.category,sum(oi.quantity) as unit_sold
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.category
order by sum(oi.quantity) desc;

--15. which product generate the highest revenue?
select top 1 p.product_name,sum(oi.quantity* oi.unit_price) as revenue
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_name
order by sum(oi.quantity* oi.unit_price) desc;

--16. on average,how many product are bought per order?
select avg(product_count) as avg_product_per_order
from(
select order_id, sum(quantity) as product_count
from order_items 
group by  order_id) t;

--17.which orders are worth more than 10,000?
select order_id ,sum(quantity* unit_price)  as order_value
from order_items
group by order_id
having sum(quantity* unit_price)>10000
order by sum(quantity* unit_price)  desc;

--18. which customer have the highest average order value?
select top 5 customer_id,avg(order_value) as avg_value
from(
select o.customer_id, o.order_id, sum(oi.quantity* oi.unit_price) as order_value
from orders o
join order_items oi
on o.order_id = oi.order_id 
group by o.customer_id ,o.order_id) t
group by customer_id
order by avg(order_value) desc;

--19. what are the top 3 cities by revenue?
select * from customers
select * from order_items

select top 3 c.city,sum(oi.quantity* oi.unit_price) as revenue
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items oi
on o.order_id = oi.order_id
group by c.city
order by sum(oi.quantity* oi.unit_price) desc;

--20. how are the customers ranked based on revenue?
with customer_revenue as (
	select o.customer_id,sum(oi.quantity*oi.unit_price) as revenue
	from orders o
	join order_items oi
	on o.order_id = oi.order_id
	group by o.customer_id
	)
select customer_id,revenue as revenue,
 dense_rank() over(order by revenue desc) as rnk
 from customer_revenue 
 order by rnk

--21. what is the top selling product in each category?
select * from products
select * from order_items

;with cte as (
	select p.category,p.product_name,sum(oi.quantity) as total_qty
	from products p
	join order_items oi
	on p.product_id = oi.product_id
	group by p.category,p.product_name
)
select category,product_name,total_qty
from(
   select*, ROW_NUMBER() over(partition by category order by total_qty desc ) as rnk 
   from cte) t
   where rnk = 1;


--22. how has revenue accumulated over time -- running total?
with daily_sale as(
select cast(o.order_date as date) as order_date,sum(oi.quantity*oi.unit_price) as daily_revenue
from orders o
join order_items oi
on o.order_id = oi.order_id
group by cast(o.order_date as date))

select order_date,daily_revenue,
     sum(daily_revenue) over(order by order_date) as running_total
	 from daily_sale

--23. when was each customer's previous order placed?
select customer_id,order_id,order_date,
       lag(order_date) over(partition by customer_id order by order_date desc) as previous_order_date
from orders
order by customer_id,order_date desc;

--24. who are the top 3 customer by revenue?
select top 3 c.customer_name,c.customer_id,sum(oi.quantity* oi.unit_price) as revenue
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items oi
on o.order_id = oi.order_id
group by c.customer_name,c.customer_id
order by sum(oi.quantity* oi.unit_price) desc;

--25. what percentage does each product contribute to total revenue?
with product_revenue as (
	select p.product_name,sum(oi.quantity*oi.unit_price) as revenue
	from products p
	join order_items oi
	on p.product_id = oi.product_id
	group by p.product_name
   )
select top 10 product_name,revenue,
	round(revenue*100/sum(revenue) over(),2) as revenue_percentage
	from product_revenue
	order by revenue desc;

--26.what is the month over month revenue growth?
with monthly_sale as(
    select FORMAT(o.order_date,'yyyy-MM') as month,
	sum(oi.quantity*oi.unit_price) as revenue
	from orders o
	join order_items oi 
	on o.order_id = oi.order_id
	group by  FORMAT(o.order_date,'yyyy-MM')
	)
select month,revenue,
	lag(revenue) over(order by month) as previous_month_revenue,
	100*(revenue - lag(revenue) over(order by month))/lag(revenue) over(order by month) as growth_percentage
from monthly_sale
order by month 

--27. what was the each customer's highest order value?
with order_value as(
	select o.customer_id,o.order_id,sum(oi.quantity*oi.unit_price) as revenue
	from orders o
	join order_items oi 
	on o.order_id = oi.order_id
	group by o.customer_id,o.order_id
	)
select top 10  customer_id,order_id,revenue
from(
select*, row_number() over(partition by customer_id order by revenue desc)as rnk
from order_value
)t
where rnk =1
order by revenue desc;

--28. what is each customer's lifetime value?
select o.customer_id,sum(oi.quantity*oi.unit_price) as customer_lifetime_value
	from orders o
	join order_items oi 
	on o.order_id = oi.order_id
	group by o.customer_id
	order by customer_lifetime_value desc;


--29. what percentage of customer make repeat purchase?
with customer_order as (
	select customer_id,count(*) as total_orders
	from orders 
	group by customer_id
	)
select 100*(count(case when total_orders >1 then 1 end)/count(*)) as repeat_purchase_rate
from customer_order;

--30. how many customer are new vs returing?
with first_order as (
	select customer_id,min(order_date) as first_order_date
	from orders
	group by customer_id
	),
customer_order as(
select	
	case when o.order_date = f.first_order_date then 'new customer' 
	else 'returning'end as customer_type
	from orders o
join first_order f
on o.customer_id = f.customer_id
)
select customer_type,count(*) as total_order
from customer_order
group by customer_type;

--31. how many customer were active each month - retention?
with monthly_order as(
	select distinct customer_id,format(order_date,'yyyy-MM') as order_month
	from orders
	)
select order_month,count(distinct customer_id) as active_customers
from monthly_order
group by  order_month
order by  order_month;

--32. which customer purchase from more than one category?
select o.customer_id,count(distinct p.category) as category_purchase
from orders o
join order_items oi
on o.order_id=oi.order_id
join products p
on p.product_id=oi.product_id
group by o.customer_id
having count(distinct p.category)>1
order by category_purchase;

--33. which two products are most frequently purchased together?
select oi1.product_id as product_1,oi2.product_id as product_2,count(*) as purchase_count
from order_items oi1
join order_items oi2
   on oi1.order_id=oi2.order_id
   and oi1.product_id<oi2.product_id
group by oi1.product_id ,oi2.product_id 
order by purchase_count desc



--34. on average, how many days pass between a customer's order?
with customer_order as(
	select customer_id,order_date,
	lag(order_date) over(partition by customer_id order by order_date) as previous_order
	from orders
	)
select customer_id,
	round(avg(datediff(day,order_date, previous_order)*1.0),2) as avg_days_orders
	from customer_order
	where previous_order is not null
	group by customer_id
	order by  avg_days_orders;

--35.which category is growing the fastest?
with monthly_category_sale as (
	select format(order_date,'yyyy-MM') as month_name,
	p.category,sum(oi.quantity*oi.unit_price) as revenue
	from orders o
	join order_items oi
	on o.order_id=oi.order_id
	join products p
	on p.product_id=oi.product_id
	group by format(order_date,'yyyy-MM'),p.category
	)
select top 10 month_name,category,revenue,
	revenue-lag(revenue) over(partition by category order by month_name) as revenue_growth
from monthly_category_sale
order by  revenue_growth desc;


--36. which customer are at risk of churn?
select customer_id,max(order_date) as last_order_date
from orders 
group by customer_id
having max(order_date) < '2026-04-30'
order by max(order_date);


--37. how do customers look based on RFM(recency,frequency,monetry) analysis?
select o.customer_id,
	datediff(day,'2026-07-30',max(o.order_date)) as recency_days,
	count(distinct o.order_id) as frequency,
	sum(oi.quantity*oi.unit_price) as monetry
from orders o
join order_items oi
on o.order_id=oi.order_id
group by o.customer_id
order by monetry desc;

--38. what is the daily sale trend?
select o.order_date,sum(oi.quantity*oi.unit_price) as daily_revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
group by o.order_date
order by o.order_date

--39. how much revenue comes from male vs female customers?
select c.gender,sum(oi.quantity*oi.unit_price) as revenue
from customers c
join orders o
on c.customer_id =o.customer_id
join order_items oi
on oi.order_id = o.order_id
group by c.gender;


--40. what is customer churn rate?
with customer_status as(
	select customer_id,max(order_date) as last_order_date,
	case when max(order_date) <'2026-04-30' then 1 else 0 end as is_churned
	from orders 
	group by customer_id
	)
select 100*sum(is_churned)/count(*) as churn_rate
from customer_status


--41. how many new customer were acquired each month?
;with first_order as(
	select customer_id,min(order_date) as first_order_date
	from orders
	group by customer_id
	)
select format(first_order_date,'yyyy-MM') as acquired_month,count(customer_id) as new_customer
from first_order
group by format(first_order_date,'yyyy-MM');


--42. what percenatge does each category contribute to total reveue?
with category_revenue as(
	select p.category,sum(oi.quantity*oi.unit_price) as revenue
	from products p 
	join order_items oi
	on p.product_id=oi.product_id
	group by p.category
	)
select category,revenue,round(100*revenue/sum(revenue) over(),2) as revenue_percentage
from category_revenue
order by revenue desc;
