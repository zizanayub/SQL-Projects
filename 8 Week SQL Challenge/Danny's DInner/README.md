## ❓ Which item was the most popular for each customers?

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
