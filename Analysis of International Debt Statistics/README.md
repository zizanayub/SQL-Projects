## 01. About the Dataset


International Debt Statistics Dataset is provided by The World Bank. In this dataset, we will be able to observe various countries with their debt amounts. These countries used these debt amounts in their development works or improvement of infrastructure. 

It is an EDA (Exploratory Data Analysis) project where we will try to find different insights from this dataset and draw the conclusion on different aspects. I have used MySQL to conduct the whole procedures of this project. 




## Project Works



### ▶️ 01. First 10 Rows of the Table


At first we will have a look at a portion of the dataset. The first 10 rows will be checked and we will make sure that the data existing in the table is alright and ready to work. 



```SQL
-- 01. Find out all the columns of IDS table (Limit first 10 rows)
SELECT *
FROM idsdata
LIMIT 10; 
```




Result:



![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/df2cdd2b-9c7b-489a-9b2d-e6acf3209cd4)







### ▶️ 02. Number of Distinct Countries


Now, we will have look about the number of countries that are taking debts from World Bank for various purposes. We are observing that there are repetition of countries. Because a country can take debt under multiple indicators. For that reason, now it is important to count the number of countries.



```SQL
-- 02. Number of Distinct Countries
SELECT COUNT(DISTINCT Country_Name) Total_Countries
FROM idsdata; 
```




Result: 



![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/dcd36022-b75e-4cea-80e1-34a5ba2976a4)






### 💡 How to use COUNT DISTINCT?


The correct way of writing this query is `COUNT(DISTINCT xxxxx)`. We first approached with `SELECT DISTINCT(COUNT xxxx)` that is completely wrong. 






### ▶️ 03. DIstinct Debt Indicators.


Under different indicators, the countries have taken loans for this organization. Each indicator covers different types of purposes. Such as, DT.GRE.DPPG means Average grant element on new external debt commitments (%). In short, The grant element of a loan is the grant equivalent expressed as a percentage of the amount committed. It is used as a measure of the overall cost of borrowing.


Now, we tend to find out all of the debt indicators and their names from the dataset. 





```SQL
-- 03. DIstinct Debt Indicators.
SELECT DISTINCT Indicator_Code AS distinct_debt_indicators, Indicator_Name
FROM idsdata
ORDER BY distinct_debt_indicators; 
```






Result:


The results came with 214 rows in total. 




![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/da50756a-c38e-4f3a-931a-a5d64dd153f9)






### ▶️ 03.01. DIstinct Debt Indicators Count.


Anyways, the count of debt indicators show exactly the same. 214. 




```SQL
-- 03.01. DIstinct Debt Indicators Count
SELECT COUNT(DISTINCT Indicator_Code) AS distinct_debt_indicators_count
FROM idsdata;
```




Result: 





![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/49e7b61e-fe2a-4287-94c9-2cb7ae0f01f3)

