
## Problem Statement

Danny has a restaurant. After managing that restaurant for few months, Danny had an idea to expand his restaurant business and introduce personalized experience for the customers. He decided that data analysis will be the best solution to find the possible solution and idea.

He wanted specifically insights about:

Customer's visiting patterns in the restaurant.
Which item is the most favorite to the customers.
How much money customers spent to buy food from his restautant.
Regrettably, due to privacy considerations, the restaurant owner, Danny, is unable to share the actual database. However, he has provided us with a conceptual understanding of the data structure, which consists of three tables: sales,menu, and members. These tables form the foundation for conducting the analysis task at hand.

![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/6f94f850-2bb9-4718-97b7-ef6d1c93fc1c)


## ❓ 01. What is the total amount each customer spent at the restaurant?


### Approaches:

1. First, I selected the required column names and added an aggregate function `SUM()` to find out `Total Amount Spent`
2. `GROUP BY` customer_id

```SQL
SELECT 
    s.customer_id,
    SUM(m.price) "Total Amount Spent"
FROM sales s
JOIN menu m
    ON s.product_id = m.product_id
GROUP BY s.customer_id;
```

Output:




![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/e7ab2416-a6e0-4f49-a623-53013c17952a)


## ❓ 02. How many days has each customer visited the restaurant?

### Approaches:

Nothing complex. Just select order dates distinctly and order them in descending order. You must group selected column names by customer_id since it required " by each customer" 

```SQL
SELECT
      customer_id,
      COUNT(DISTINCT order_date) visit_count 
FROM sales
GROUP BY customer_id
ORDER BY visit_count DESC;
```


Output:


![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/78b4838b-5bed-4d03-9bab-3672329aaab3)


## ❓ 03. What was the first item from the menu purchased by each customer?

1. To get the ranking of the order dates, `DENSE_RANK()` function will be workable here. We should write the query based on the customers. After partitioning the
outcomes by customer_id, order each partition by `order_date`.

2. Like previous, use `GROUP BY` and `ORDER BY` clauses as necessary. `GROUP BY` all the columns you mentioned after the `SELECT` statement. Order the outcome by order dates.
3. As we need the first date, we must add a `WHERE` clause here. The condition will be `WHERE ranked_first_order=1`

```SQL
SELECT 
     customer_id,
     product_name
FROM
(SELECT
    s.customer_id,
    s.order_date,
    m.product_name,
    DENSE_RANK() OVER (PARTITION BY s.customer_id
                       ORDER BY s.order_date) AS ranked_first_order
FROM sales s 
JOIN menu m
   ON s.product_id = m.product_id
GROUP BY s.customer_id,m.product_name,s.order_date
ORDER BY s.order_date) 
AS first_order_date

WHERE ranked_first_order = 1
;
```


Output:



![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/6f7d3cd9-62f9-4fea-8433-96ad8f364238)


Here, customer A ordered two dishes simultaneously. So, it gave output two dishes. 

## ❓ 04. What is the most purchased item on the menu and how many times was it purchased by all customers?


```SQL
SELECT 
     s.product_id,
     m.product_name,
     COUNT(s.product_id) AS times_purchased
FROM sales s
JOIN menu m
    ON s.product_id = m.product_id
GROUP BY s.product_id,m.product_name
ORDER BY times_purchased DESC
LIMIT 1;
```




## ❓ 05. Which item was the most popular for each customers?

### ▶️ Approaches-01: 

I found all the customers, their bought products information by using `GROUP BY` clause and joining `menu` and `sales` table. 

```SQL
SELECT 
    s.customer_id,
    s.product_id,
    m.product_name
FROM sales s 
JOIN menu m 
    ON s.product_id = m.product_id
GROUP BY s.customer_id,s.product_id,m.product_name;
```




### ▶️ Approaches-02: 

Using COUNT() function to find the count of each item purchased by each customers.

```SQL
SELECT 
    s.customer_id,
    s.product_id,
    m.product_name,
    COUNT(s.product_id) AS counted_purchased_items
FROM sales s 
JOIN menu m 
    ON s.product_id = m.product_id
GROUP BY s.customer_id,s.product_id,m.product_name;
```


### ▶️ Approaches-03: 

``DENSE_RANK()` OVER (PARTITION BY s.customer_id ORDER BY COUNT(s.customer_id) DESC)`` will help us to find out the rank of the customers
by maximum orders. The whole query was grouped by `product_id`. So the query will return **the ranks based on count of purchases per product**

```SQL
SELECT 
    s.customer_id,
    s.product_id,
    m.product_name,
    COUNT(m.product_id) AS counted_purchased_items,
    DENSE_RANK() OVER 
    (PARTITION BY s.customer_id
    ORDER BY COUNT(s.customer_id) DESC) AS most_popular
FROM sales s 
JOIN menu m 
    ON s.product_id = m.product_id
GROUP BY s.customer_id,s.product_id,m.product_name; 
```





### ▶️ Approaches-04 (FINAL): 

Include the whole query in approach-03 in a subquery and select specific needed columns with the `WHERE` clause equals to 1. 



```SQL
SELECT 
      customer_id,
      product_name,
      counted_purchased_items
FROM 
(
SELECT 
    s.customer_id,
    s.product_id,
    m.product_name,
    COUNT(m.product_id) AS counted_purchased_items,
    DENSE_RANK() OVER 
    (PARTITION BY s.customer_id
    ORDER BY COUNT(s.customer_id) DESC) AS most_popular
FROM sales s 
JOIN menu m 
    ON s.product_id = m.product_id
GROUP BY s.customer_id,s.product_id,m.product_name) AS most_popular_table
WHERE most_popular = 1; 


;
```


Output:

| customer_id | product_name | counted_purchased_items |
|-------------|--------------|------------------------|
| A           | ramen        | 3                      |
| B           | curry        | 2                      |
| B           | sushi        | 2                      |
| B           | ramen        | 2                      |
| C           | ramen        | 3                      |





## ❓ 06. Which item was purchased after they become a member?

### ▶️ 06.01. Approaches-01:

First got the customers with their purchases after joining date. We first joined `sales` and `menu` table and then joined `members` table with connecting `customer_id` columns. 

Then, finally got all the information where joining date is less than the order date. 

```SQL
SELECT 
      s.customer_id,
      s.product_id,
      m.product_name,
      s.order_date,
      mem.join_date
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
JOIN members mem
ON s.customer_id = mem.customer_id
WHERE s.order_date > mem.join_date
GROUP BY s.customer_id,s.product_id,m.product_name,s.order_date,mem.join_date;
```



### ▶️ 06.02. Approaches-02 (Final)

Used `DENSE_RANK()` function to get the ranking by order_date of each customers after their joining date. Take the whole query in a subquery named `orders_by_date` and select required columns with `WHERE order_rank = 1`


```SQL
SELECT 
      customer_id,
      order_date,
      product_name
FROM 
(
SELECT 
      s.customer_id,
      s.product_id,
      m.product_name,
      s.order_date,
      DENSE_RANK() OVER 
      (PARTITION BY s.customer_id
      ORDER BY s.order_date) AS order_rank
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
JOIN members mem
ON s.customer_id = mem.customer_id
WHERE s.order_date > mem.join_date
GROUP BY s.customer_id,s.product_id,m.product_name,s.order_date
ORDER BY s.customer_id) AS orders_by_date

WHERE order_rank = 1;
```




## ❓ 07. Which item was purchased just before the customer became a member?

### ▶️ 07.01. Approach:


Nothing much. Same query, just change the sign from '>' to '<' as the `order_date` must be less than `joining_date'  


```SQL
SELECT 
      customer_id,
      order_date,
      product_name
FROM 
(
SELECT 
      s.customer_id,
      s.product_id,
      m.product_name,
      s.order_date,
      DENSE_RANK() OVER 
      (PARTITION BY s.customer_id
      ORDER BY s.order_date) AS order_rank
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
JOIN members mem
ON s.customer_id = mem.customer_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id,s.product_id,m.product_name,s.order_date
ORDER BY s.customer_id) AS orders_by_date

WHERE order_rank = 1;
```


Output:

| customer_id | date       | product |
|-------------|------------|---------|
| A           | 2021-01-01 | sushi   |
| A           | 2021-01-01 | curry   |
| B           | 2021-01-01 | curry   |






## ❓ 08. What is the total items and amount spent for each member before they became a member?


### ▶️ Approaches:

1. Joined all the 3 tables based on their common columns.
2. Added required columns. Used aggregate functions `COUNT()` and `SUM()` to get the count of total items purchased and total amount spent by the customers respectively.
3. Leveraged `GROUP BY` and `ORDER BY` clause to specifically find the outcomes based on customers' information.

```SQL
SELECT 
      s.customer_id,
      COUNT(s.product_id) AS count_of_purchased_items,
      SUM(m.price) AS total_amount
FROM sales s
JOIN menu m 
   ON s.product_id = m.product_id
JOIN members mem
   ON mem.customer_id = s.customer_id
WHERE mem.join_date > s.order_date
GROUP BY s.customer_id
ORDER BY s.customer_id; 
```



Output:

| customer_id | count_of_purchased_items | total_amount |
|-------------|-------------------------|--------------|
| A           | 2                       | 25           |
| B           | 3                       | 40           |






## ❓ 09. If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?

### ▶️ Approaches:

1. Join two tables `menu` and `sales` based on the common columns. Execute query to find total_purchased_items by customers using `GROUP BY` clause.
2. Execute `CASE` statement to measure the points.
3. Include the whole query in a subquery, named as `points_table`. Run the query with required column names and Group the whole query by `customer_id`

```SQL
SELECT
      s.customer_id,
      s.product_id,
      COUNT(s.product_id),
      CASE 
         WHEN m.product_id = 1 THEN COUNT(s.product_id)*m.price*20
         ELSE COUNT(s.product_id)*m.price*10
	  END AS points
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY s.customer_id,m.product_id,m.price) AS points_table
GROUP BY customer_id
;
```



## ❓ 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi — how many points do customer A and B have after the joining?

```SQL
SELECT 
     customer_id,
     SUM(points)
FROM
(SELECT 
      customer_id,
      CASE
        WHEN product_id != 1  AND (order_date BETWEEN join_date AND valid_date) THEN COUNT(product_id)*price*10*2
        WHEN product_id = 1 AND (order_date BETWEEN join_date AND valid_date) THEN COUNT(product_id)*price*10*2*2
        WHEN product_id = 1 THEN COUNT(product_id)*price*2*10
        ELSE COUNT(product_id)*price*10
	END AS points
FROM
(
SELECT 
      s.customer_id,
      s.product_id,
      s.order_date,
      m.price,
      mem.join_date,
      DATE(mem.join_date + 6) AS valid_date
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
JOIN members mem
ON s.customer_id = mem.customer_id
WHERE s.order_date >= mem.join_date AND MONTH(s.order_date) = 1
GROUP BY s.customer_id,s.product_id,mem.join_date,s.order_date,m.price)
AS first_week_summary
GROUP BY customer_id,product_id,price,order_date,valid_date,join_date) AS points_by_customer_id
GROUP BY customer_id
ORDER BY SUM(points) DESC
;
```






## ❓ 11. Bonus Question: Join All the Things



```SQL
SELECT 
     s.customer_id,
     s.order_date,
     m.product_name,
     m.price,
     CASE 
        WHEN s.order_date >= mem.join_date THEN 'Y'
        ELSE 'N'
	 END AS member_status
FROM sales s
JOIN menu m
   ON s.product_id = m.product_id
JOIN members mem
   ON mem.customer_id = s.customer_id
ORDER BY s.customer_id,s.order_date;
```



## ❓ 12. Bonus Question: Rank all the Things

Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

```SQL
SELECT
    customer_id,
    order_date,
    product_name,
    price,
    member_status,
CASE 
   WHEN member_status = 'Y' THEN
           DENSE_RANK() OVER (PARTITION BY customer_id,member_status
                              ORDER BY order_date)
	ELSE 'null'
END AS ranked
FROM
(
SELECT 
	s.customer_id,
    s.order_date,
    s.product_id,
    m.product_name,
    m.price,
    CASE 
       WHEN s.order_date >= mem.join_date THEN 'Y'
       ELSE 'N'
	END AS member_status
FROM sales s
JOIN menu m
  ON s.product_id = m.product_id
JOIN members mem
  ON s.customer_id = mem.customer_id
) AS member_status_table;
```
