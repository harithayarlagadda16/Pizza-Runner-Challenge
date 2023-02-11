# 1.If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
select concat('$', sum(case when pizza_id =1 then 12 else 10 end)) as tot 
from customer_tab inner join runner_tab using(order_id) where cancellation is NULL;

# 2.What if there was an additional $1 charge for any pizza extras? Add cheese is $1 extra
SELECT CONCAT('$', topping_rev+ pizza_rev) AS total_rev
FROM
  (SELECT SUM(CASE
                  WHEN pizza_id = 1 THEN 12
                  ELSE 10
              END) AS pizza_rev,
          sum(topping_count) AS topping_rev
   FROM
     (SELECT *,
             length(extras) - length(replace(extras, ",", ""))+1 AS topping_count
      FROM customer_tab
      INNER JOIN pizza_names USING (pizza_id)
      INNER JOIN runner_tab USING (order_id)
      WHERE cancellation IS NULL
      ORDER BY order_id)t1) t2;
      
      # 3.The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5?
      
      DROP TABLE IF EXISTS runner_rating;

CREATE TABLE runner_rating (order_id INTEGER, rating INTEGER, review VARCHAR(100)) ;

-- Order 6 and 9 were cancelled
INSERT INTO runner_rating
VALUES ('1', '1', 'Really bad service'),
       ('2', '1', NULL),
       ('3', '4', 'Took too long...'),
       ('4', '1','Runner was lost, delivered it AFTER an hour. Pizza arrived cold' ),
       ('5', '2', 'Good service'),
       ('7', '5', 'It was great, good service and fast'),
       ('8', '2', 'He tossed it on the doorstep, poor service'),
       ('10', '5', 'Delicious!, he delivered it sooner than expected too!');


SELECT *
FROM runner_rating;

#4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
#customer_id,order_id,runner_id,rating,order_time,pickup_time,Time between order and pickup,Delivery duration,Average speed,Total number of pizzas?


SELECT customer_id,
       order_id,
       runner_id,
       rating,
       order_time,
       pickup_time,
       TIMESTAMPDIFF(MINUTE, order_time, pickup_time) pick_up_time,
       duration AS delivery_duration,
       round(distance*60/duration, 2) AS average_speed,
       count(pizza_id) AS total_pizza_count
FROM customer_tab
INNER JOIN runner_tab USING (order_id)
INNER JOIN runner_rating USING (order_id)
GROUP BY order_id ;

#5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

SELECT concat('$', round(sum(pizza_cost-delivery_cost), 2)) AS pizza_run_rev
FROM
  (SELECT order_id,
          distance,
          sum(pizza_cost) AS pizza_cost,
          round(0.30*distance, 2) AS delivery_cost
   FROM
     (SELECT *,
             (CASE
                  WHEN pizza_id = 1 THEN 12
                  ELSE 10
              END) AS pizza_cost
      FROM customer_tab
      INNER JOIN pizza_names USING (pizza_id)
      INNER JOIN runner_tab USING (order_id)
      WHERE cancellation IS NULL
      ORDER BY order_id) t1
   GROUP BY order_id
   ORDER BY order_id) t2;