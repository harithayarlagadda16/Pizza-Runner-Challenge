# 1.How many pizzas were ordered?

select count(pizza_id) as Pizza_Ordered from customer_tab;

# 2.How many unique customer orders were made?

select count(distinct order_id) as Total_Orders from customer_tab;

# 3.How many successful orders were delivered by each runner?

select runner_id, count(order_id) as Orders_Del from runner_tab
where distance is not null
group by runner_id;

# 4.How many of each type of pizza was delivered?

select a.pizza_name, count(b.order_id) as no_orders from pizza_runner.pizza_names a inner join customer_tab b on a.pizza_id=b.pizza_id inner join runner_tab c on b.order_id=c.order_id where duration is not NULL group by a.pizza_name order by no_orders;

# 5.How many Vegetarian and Meatlovers were ordered by each customer?

select a.pizza_name, b.customer_id, count(b.pizza_id) as no_orders from pizza_runner.pizza_names a inner join customer_tab b on a.pizza_id=b.pizza_id
group by b.customer_id,a.pizza_name order by no_orders;

# 6.What was the maximum number of pizzas delivered in a single order?

select a.order_id, count(b.pizza_id) as no_orders from runner_tab a inner join customer_tab b on a.order_id = b.order_id where a.distance is not null group by a.order_id order by no_orders desc limit 1;

# 7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

select a.customer_id, SUM(CASE WHEN (exclusions IS NOT NULL OR extras IS NOT NULL) THEN 1 ELSE 0 END) AS changes,SUM(CASE WHEN (exclusions IS NULL AND extras IS NULL) THEN 1 ELSE 0 END) AS no_changes from customer_tab a inner join runner_tab b on a.order_id= b.order_id where b.cancellation is  NULL group by a.customer_id order by a.customer_id;

# 8.How many pizzas were delivered that had both exclusions and extras?

select a.customer_id, SUM(CASE WHEN (exclusions IS NOT NULL and extras IS NOT NULL) THEN 1 ELSE 0 END) AS changes from customer_tab a inner join runner_tab b on a.order_id= b.order_id where b.cancellation is  NULL group by a.customer_id order by a.customer_id;

# 9.What was the total volume of pizzas ordered for each hour of the day?

select extract(hour from order_time) as hours, count(pizza_id) as pizza_ordered from customer_tab group by hours order by pizza_ordered desc;

# 10.What was the volume of orders for each day of the week?

SELECT dayname(order_time) AS day_of_week,count(order_id) AS pizzas_ordered
FROM customer_tab
GROUP BY day_of_week
ORDER BY 2 DESC;

