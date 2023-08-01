-- 01. Schema SQL

CREATE DATABASE pizza_runner;
SET search_path = pizza_runner;
USE pizza_runner; 
DROP TABLE IF EXISTS runners;

CREATE TABLE runners (
  runner_id INTEGER,
  registration_date DATE
);
INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);
INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);
INSERT INTO pizza_recipes
  (pizza_id,
  toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);
INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');








-- 02.01. Cleaning `customer_orders` table


CREATE TEMPORARY TABLE temp_customer_orders AS
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders; 

SELECT * FROM temp_customer_orders; 









-- 02.02. Cleaning `runner_orders` table

DROP TABLE IF EXISTS temp_runner_orders;
CREATE TEMPORARY TABLE temp_runner_orders AS
SELECT 
    order_id,
    runner_id,
    CASE 
       WHEN pickup_time IS NULL OR pickup_time LIKE "null" THEN " "
       ELSE pickup_time
	END AS pickup_time,
    CASE 
       WHEN distance LIKE "%km" THEN TRIM("km" FROM distance)
       WHEN distance IS NULL OR distance LIKE "null" THEN " "
       ELSE distance 
	END AS distance,
    CASE 
       WHEN duration LIKE "%minutes" THEN TRIM("minutes" FROM duration)
       WHEN duration LIKE "%mins" THEN TRIM("mins" FROM duration)
       WHEN duration LIKE "%minute" THEN TRIM("minute" FROM duration)
       WHEN duration IS NULL OR duration LIKE "null" THEN " " 
       ELSE duration
	END AS duration,
    CASE 
       WHEN cancellation IS NULL OR cancellation LIKE "null" THEN " " 
       ELSE cancellation
	END AS cancellation
FROM runner_orders; 

SELECT * FROM temp_runner_orders; 



SELECT *
FROM 
(SELECT 
    order_id,
    runner_id,
    CASE 
       WHEN pickup_time IS NULL OR pickup_time LIKE "null" THEN " "
       ELSE pickup_time
	END AS pickup_time,
    CASE 
       WHEN distance LIKE "%km" THEN TRIM("km" FROM distance)
       WHEN distance IS NULL OR distance LIKE "null" THEN " "
       ELSE distance 
	END AS distance,
    CASE 
       WHEN duration LIKE "%minutes" THEN TRIM("minutes" FROM duration)
       WHEN duration LIKE "%mins" THEN TRIM("mins" FROM duration)
       WHEN duration LIKE "%minute" THEN TRIM("minute" FROM duration)
       WHEN duration IS NULL OR duration LIKE "null" THEN " " 
       ELSE duration
	END AS duration,
    CASE 
       WHEN cancellation IS NULL OR cancellation LIKE "null" THEN " " 
       ELSE cancellation
	END AS cancellation
FROM runner_orders) AS Runner_orders; 
	
    
    



-- 03.Solution
-- A. Pizza Metrics

-- 03.01. How many pizzas were ordered?
USE pizza_runner;
SELECT * FROM temp_customer_orders; 

SELECT COUNT(order_id) AS pizza_orders_count
FROM temp_customer_orders; 


-- 03.02.  How many unique customer orders were made?
SELECT * FROM temp_customer_orders;

SELECT COUNT(DISTINCT order_id) AS unique_customer_orders
FROM temp_customer_orders;




-- 03.03. How many successful orders were delivered by each runner?
WITH cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
)

SELECT
    runner_id,
    COUNT(order_id) AS "Count of orders"
FROM cte_runner_orders
WHERE distance != " "
GROUP BY runner_id;



-- 03.04. How many of each type of pizza was delivered?

WITH cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders),

cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
)

SELECT 
    co.pizza_id,
    pn.pizza_name,
    COUNT(ro.order_id) AS "Delivered Pizza Count"
FROM cte_customer_orders co 
JOIN cte_runner_orders ro
	ON co.order_id = ro.order_id
JOIN pizza_names pn
    ON co.pizza_id = pn.pizza_id
WHERE ro.duration!= " "
GROUP BY co.pizza_id,pn.pizza_name; 




-- 03.05. How many Vegetarian and Meatlovers were ordered by each customer?

WITH cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders),

cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
)

SELECT 
    co.customer_id,
    pn.pizza_name,
    COUNT(co.pizza_id) AS "Delivered"
FROM cte_customer_orders co 
JOIN pizza_names pn
  ON co.pizza_id = pn.pizza_id 
GROUP BY co.customer_id,pn.pizza_name
ORDER BY co.customer_id;





-- 03.06. What was the maximum number of pizzas delivered in a single order?


WITH cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders)

SELECT
    COUNT(pizza_id) AS ordered_pizza
FROM cte_customer_orders
GROUP BY order_id
ORDER BY ordered_pizza DESC
LIMIT 1;



-- 03.07. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

WITH cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders),


cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
)


SELECT 
    co.customer_id,
    SUM(CASE 
		   WHEN co.exclusions <> " " OR extras <> " " THEN 1
           ELSE 0
		END) AS at_least_1_change,
	SUM(CASE 
		   WHEN co.exclusions = " " OR extras = " " THEN 1
           ELSE 0
		END) AS no_changes
FROM cte_customer_orders co
JOIN cte_runner_orders ro 
   ON co.order_id = ro.order_id
GROUP BY co.customer_id;





-- OR 
SELECT 
   customer_id,
   COUNT(no_changes),
   COUNT(changes)
FROM 
(
SELECT 
   customer_id,
   CASE WHEN exclusions = " " OR extras = " " THEN "no changes" END AS no_changes,
   CASE WHEN exclusions <> " " OR extras <> " " THEN "At least 1 change" END AS changes
FROM cte_customer_orders co 
JOIN cte_runner_orders ro 
   ON co.order_id = ro.order_id
WHERE distance != " " 
) AS customer_changes
GROUP BY customer_id; 



-- 03.08. How many pizzas were delivered that had both exclusions and extras?

WITH cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders),


cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
)
SELECT  
 SUM(CASE
  WHEN exclusions <> " " AND extras <> " " THEN 1
  ELSE 0
  END) AS pizza_count_w_exclusions_extras
FROM cte_customer_orders AS c
JOIN cte_runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.distance >= 1 ;





-- 03.09. What was the total volume of pizzas ordered for each hour of the day?

WITH cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders)

SELECT 
    EXTRACT(HOUR FROM order_time) AS hour_of_day,
    COUNT(order_id) AS "Ordered Pizzas"
FROM cte_customer_orders
GROUP BY hour_of_day
ORDER BY hour_of_day,"Ordered Pizzas" DESC;



-- 03.10. What was the volume of orders for each day of the week?

WITH cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders)

SELECT
   DATE_FORMAT(DATE_ADD(order_time, INTERVAL 2 DAY),"%W") AS day_of_week,
   COUNT(order_id) AS volume_of_orders
FROM cte_customer_orders
GROUP BY day_of_week;




USE pizza_runner;





-- 04. B. 

-- 04.01. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

SELECT 
    EXTRACT(WEEK FROM DATE_ADD(registration_date,INTERVAL 1 WEEK)) AS registration_week,
    COUNT(runner_id) AS runners_count
FROM runners
GROUP BY registration_week;



-- 04.02. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

WITH cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
),
cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders)

SELECT
    ro.runner_id,
    AVG(DATEDIFF(EXTRACT(MINUTE FROM ro.pickup_time),EXTRACT(MINUTE FROM co.order_time))) AS Avg_Duration_of_pickup
FROM cte_customer_orders co 
JOIN cte_runner_orders ro 
   ON co.order_id = ro.order_id
WHERE ro.distance != " "
GROUP BY ro.runner_id,ro.pickup_time,co.order_time;






-- 04.03. Is there any relationship between the number of pizzas and how long the order takes to prepare?

WITH cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
),
cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders)

SELECT 
    order_count,
    AVG(order_takes_to_prepare_in_mins)
FROM
(   

SELECT
    co.order_id, 
    COUNT(co.order_id) AS order_count,
    TIMESTAMPDIFF(MINUTE,co.order_time,ro.pickup_time) AS order_takes_to_prepare_in_mins

FROM cte_customer_orders co
JOIN cte_runner_orders ro
   ON co.order_id = ro.order_id
WHERE distance != " "
GROUP BY co.order_id,co.order_time,ro.pickup_time
) AS order_count_stats
GROUP BY order_count;
 




-- 04.04. What was the average distance travelled for each customer?

WITH cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
),
cte_customer_orders AS (
SELECT
	order_id,
    customer_id, 
    pizza_id,
    CASE 
       WHEN exclusions is NULL OR exclusions LIKE 'null' THEN ' '
       ELSE exclusions 
	END AS exclusions,
	CASE 
       WHEN extras is NULL OR extras LIKE 'null' THEN ' '
       ELSE extras
	END AS extras,
    order_time
FROM customer_orders)


SELECT 
    co.customer_id,
    ROUND(AVG(ro.distance)) AS "Average Distance"
FROM cte_customer_orders co
JOIN cte_runner_orders ro 
   ON co.order_id = ro.order_id
WHERE distance != " " 
GROUP BY co.customer_id;







-- 04.05. What was the difference between the longest and shortest delivery times for all orders?

WITH cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders
)

SELECT 
    MAX(duration),
    MIN(duration),
    (MAX(duration) - MIN(duration)) AS "Difference Between Delivery Times"

FROM cte_runner_orders
WHERE duration != " "; 







-- 04.06. What was the average speed for each runner for each delivery and do you notice any trend for these values?
WITH cte_runner_orders AS (
    SELECT 
        order_id,
        runner_id,
        CASE 
           WHEN pickup_time IS NULL OR pickup_time LIKE 'null' THEN ' '
           ELSE pickup_time
        END AS pickup_time,
        CASE 
           WHEN distance REGEXP 'km' THEN TRIM('km' FROM distance)
           WHEN distance IS NULL OR distance LIKE 'null' THEN ' '
           ELSE distance 
        END AS distance,
        CASE 
           WHEN duration REGEXP 'minutes' THEN TRIM('minutes' FROM duration)
           WHEN duration REGEXP 'mins' THEN TRIM('mins' FROM duration)
           WHEN duration REGEXP 'minute' THEN TRIM('minute' FROM duration)
           WHEN duration IS NULL OR duration LIKE 'null' THEN ' ' 
           ELSE duration
        END AS duration,
        CASE 
           WHEN cancellation IS NULL OR cancellation LIKE 'null' THEN ' ' 
           ELSE cancellation
        END AS cancellation
    FROM runner_orders)

SELECT 
   order_id, 
   runner_id,
   (distance*1000) AS distance_in_metre,
   (duration*60) AS duration_in_seconds,
   (duration/60) AS duration_in_hr,
   ROUND((distance*1000)/(duration*60)) AS "Average Speed in m/s",
   ROUND(distance/(duration/60)) AS "Average Speed in km/hr"
FROM cte_runner_orders
WHERE duration != " " 
GROUP BY order_id,runner_id,distance,duration;