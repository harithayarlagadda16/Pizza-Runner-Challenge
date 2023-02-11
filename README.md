# 8weekSQLchallenge-PizzaRunner
# Business Case:
Did you know that over 115 million kilograms of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

# Dataset
Key datasets for this case study

- **runners** : The table shows the registration_date for each new runner
- **customer_orders** : Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order. The pizza_id relates to the type of pizza which was ordered whilst the exclusions are the ingredient_id values which should be removed from the pizza and the extras are the ingredient_id values which need to be added to the pizza.
- **runner_orders** : After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer. The pickup_time is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. The distance and duration fields are related to how far and long the runner had to travel to deliver the order to the respective customer.
- **pizza_names** : Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!
- **pizza_recipes** : Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.
- **pizza_toppings** : The table contains all of the topping_name values with their corresponding topping_id value

# Entity Relationship Diagram
![alt text](https://github.com/LakshmiPrasadR/8weekSQLchallenge-PizzaRunner/blob/main/ERD.jpg)

# Data Clean
There are some known data issues with few tables. Data cleaning was performed and saved in temporary tables before attempting the case study.

**customer_orders table**

- The exclusions and extras columns in customer_orders table will need to be cleaned up before using them in the queries
- In the exclusions and extras columns, there are blank spaces and null values.

**runner_orders table**
- The pickup_time, distance, duration and cancellation columns in runner_orders table will need to be cleaned up before using them in the queries
- In the pickup_time column, there are null values.
- In the distance column, there are null values. It contains unit - km. The 'km' must also be stripped
- In the duration column, there are null values. The 'minutes', 'mins' 'minute' must be stripped
- In the cancellation column, there are blank spaces and null values.

Click [here](https://github.com/LakshmiPrasadR/8weekSQLchallenge-PizzaRunner/blob/main/Data-Clean.sql) to view the data cleaning peformed.

# Case Study Solutions
- [A. Pizza Metrics](https://github.com/LakshmiPrasadR/8weekSQLchallenge-PizzaRunner/blob/main/Topic-1-%20Pizza%20Metrics.sql)
- [B. Customer and Runner metrics](https://github.com/LakshmiPrasadR/8weekSQLchallenge-PizzaRunner/blob/main/Topic%20-2-%20Customer%20and%20Runner%20metrics.sql)
- [C. Ingredient Optimisation](https://github.com/LakshmiPrasadR/8weekSQLchallenge-PizzaRunner/blob/main/Topic-4-%20Ingredient%20Optimization.sql)
- [D. Pricing and Ratings](https://github.com/LakshmiPrasadR/8weekSQLchallenge-PizzaRunner/blob/main/Topic%20-3-%20Pricing%20and%20Ratings.sql)
- [E. Bonus Questions](https://github.com/LakshmiPrasadR/8weekSQLchallenge-PizzaRunner/blob/main/Bonus%20Question.sql)
