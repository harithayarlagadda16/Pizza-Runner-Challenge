# 1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
select extract(WEEK from registration_date) as week_of_reg, count(runner_id) as no_of_runners from pizza_runner.runners
 group by week_of_reg;

# 2.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
select round(avg(TIMESTAMPDIFF(MINUTE, a.order_time, b.pickup_time)),1) as avg_time, b.runner_id
 from runner_tab b inner join customer_tab a on a.order_id=b.order_id  group by runner_id;

# 3.Is there any relationship between the number of pizzas and how long the order takes to prepare?
with cte as (select a.order_id,count(b.order_id) as no_orders, round(TIMESTAMPDIFF(MINUTE,b.order_time,a.pickup_time),1) as time_taken from runner_tab a inner join customer_tab b on a.order_id=b.order_id where cancellation is NULL group by a.order_id)
 select no_orders, avg(time_taken) from cte group by no_orders;
 
 # 4.What was the average distance travelled for each customer?
select round(avg(b.distance),2) as avg_dist, a.customer_id
 from runner_tab b inner join customer_tab a on a.order_id=b.order_id where cancellation is NULL group by customer_id;
 
 # 5.What was the difference between the longest and shortest delivery times for all orders?
 select max(duration) as max_dur,min(duration) as min_dur,(max(duration) - min(duration)) as diff
 from runner_tab;
 
 # 6.What was the average speed for each runner for each delivery and do you notice any trend for these values?
 select runner_id,round((duration/60),2) as dur_hr,round((distance*60/duration),2) as avg_speed
 from runner_tab where cancellation is NULL group by runner_id,dur_hr,avg_speed;
 
 # 7.What is the successful delivery percentage for each runner?
 select runner_id, count(order_id) as no_orders,count(pickup_time) as del_orders,round((count(pickup_time)*100/count(*)),2) as succ_del 
 from runner_tab group by runner_id order by succ_del desc;


