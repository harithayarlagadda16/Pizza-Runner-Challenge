# Normalize Pizza Recipe table
drop table if exists pizza_rec;
create table pizza_rec 
(
 pizza_id int,
    toppings int);
insert into pizza_rec
(pizza_id, toppings) 
values
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,8),
(1,10),
(2,4),
(2,6),
(2,7),
(2,9),
(2,11),
(2,12);

# 1.What are the standard ingredients for each pizza?
with cte as (
select a.pizza_name,b.pizza_id, c.topping_name
from pizza_rec b
inner join pizza_runner.pizza_toppings c
on b.toppings = c.topping_id
inner join pizza_runner.pizza_names a
on a.pizza_id = b.pizza_id
order by a.pizza_name, b.pizza_id)
select pizza_name, group_concat(topping_name) as StandardToppings
from cte
group by pizza_name;

# 2.What was the most commonly added extra?
drop table if exists numbers;
CREATE TABLE numbers (
  num INT PRIMARY KEY
);
INSERT INTO numbers VALUES
( 1 ), ( 2 ), ( 3 ), ( 4 ), ( 5 ), ( 6 ), ( 7 ), ( 8 ), ( 9 ), ( 10 ),( 11 ), ( 12 ), ( 13 ), ( 14 );
with cte as (SELECT n.num, SUBSTRING_INDEX(SUBSTRING_INDEX(all_tags, ',', num), ',', -1) as one_tag
FROM (
  SELECT
    GROUP_CONCAT(extras SEPARATOR ',') AS all_tags,
    LENGTH(GROUP_CONCAT(extras SEPARATOR ',')) - LENGTH(REPLACE(GROUP_CONCAT(extras SEPARATOR ','), ',', '')) + 1 AS count_tags
  FROM customer_tab
) a
JOIN numbers n
ON n.num <= a.count_tags)
select one_tag as Extras,b.topping_name as ExtraTopping, count(one_tag) as Occurrencecount
from cte
inner join pizza_toppings b
on b.topping_id = cte.one_tag
where one_tag != 0
group by one_tag order by occurrencecount desc limit 1;

# 3.What was the most common exclusion?
with cte as (SELECT n.num, SUBSTRING_INDEX(SUBSTRING_INDEX(all_tags, ',', num), ',', -1) as one_tag
FROM (
  SELECT
    GROUP_CONCAT(exclusions SEPARATOR ',') AS all_tags,
    LENGTH(GROUP_CONCAT(exclusions SEPARATOR ',')) - LENGTH(REPLACE(GROUP_CONCAT(exclusions SEPARATOR ','), ',', '')) + 1 AS count_tags
  FROM customer_tab
) a
JOIN numbers n
ON n.num <= a.count_tags)
select one_tag as Exclusions,b.topping_name as com_exclu, count(one_tag) as Occurrencecount
from cte
inner join pizza_toppings b
on b.topping_id = cte.one_tag
where one_tag != 0
group by one_tag order by occurrencecount desc limit 1;

# 4.Generate an order item for each record in the customers_orders table in the format of one of the following:
#Meat Lovers
#Meat Lovers - Exclude Beef
#Meat Lovers - Extra Bacon
#Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
select a.order_id, a.pizza_id, b.pizza_name, a.exclusions, a.extras, 
case
when a.pizza_id = 1 and (exclusions is null) and (extras is null) then 'Meat Lovers'
when a.pizza_id = 2 and (exclusions is null) and (extras is null) then 'Veg Lovers'
when a.pizza_id = 2 and (exclusions =4 ) and (extras is null) then 'Veg Lovers - Exclude Cheese'
when a.pizza_id = 1 and (exclusions =4 ) and (extras is null) then 'Meat Lovers - Exclude Cheese'
when a.pizza_id=1 and (exclusions like '%3%' or exclusions =3) and (extras is null) then 'Meat Lovers - Exclude Beef'
when a.pizza_id =1 and (exclusions is null) and (extras like '%1%' or extras =1) then 'Meat Lovers - Extra Bacon'
when a.pizza_id=1 and (exclusions like '1, 4' ) and (extras like '6, 9') then 'Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers'
when a.pizza_id=1 and (exclusions like '2, 6' ) and (extras like '1, 4') then 'Meat Lovers - Exclude BBQ Sauce,Mushroom - Extra Bacon, Cheese'
when a.pizza_id=1 and (exclusions =4) and (extras like '1, 5') then 'Meat Lovers - Exclude Cheese - Extra Bacon, Chicken'
end as OrderItem
from customer_tab a
inner join pizza_runner.pizza_names b
on b.pizza_id = a.pizza_id;


