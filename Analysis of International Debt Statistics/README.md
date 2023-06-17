## About the Dataset


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






### ▶️ 04. Total Debt Amount by all Countries.


Now, we would like to see how much amount the World Bank has provided to the countries for debt in total. 



```SQL
SELECT SUM(Total_Debt) AS Total_Debt_Overall
FROM idsdata; 
```




Result: 



![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/7bf87c83-efdf-4b7c-98dc-a250e40f365a)




This number is huge. 





### 💡 05. What does e mean?



The number you provided, "7.269140115541366e15," can be interpreted as 7.269140115541366 multiplied by 10 raised to the power of 15. In other words, it is equivalent to 7,269,140,115,541,366.

The use of exponential notation is common when dealing with very large or very small numbers, as it simplifies their representation. The "e" followed by a number indicates the power of 10 by which the preceding value should be multiplied.






### ▶️ 06. Total Debt Amount by all Countries (Upgrated and more Clear)




```SQL
-- 04. Total Debt by all countries
SELECT ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata;
```





Result:




![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/5548c656-bbed-41f1-98af-756dd272fd2b)






The number will show us in millions as we divided the whole number by 1000000. 






### 💡 07. What does `ROUND()` mean? And how it work?



The ROUND function is a mathematical function in SQL that allows you to round a numeric value to a specified number of decimal places. It takes two arguments:

The expression or numeric value you want to round.
The number of decimal places to round to.
In this specific query, the expression SUM(Total_Debt)/1000000 calculates the sum of the "Total_Debt" column from the "idsdata" table and then divides it by 1,000,000. The ROUND function is then applied to round this result to two decimal places.

The alias Total_Debt_Overall is assigned to the rounded result, which will be the value returned by the query.







### ▶️ 06.01 Total Debt Amount by each country



```SQL
-- 04.01 Total Debt by each country
SELECT Country_Code, Country_Name, ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata
GROUP BY Country_Code
ORDER BY Total_Debt_Overall DESC; 

```





### ❎ Error




```SQL
-- 04.01 Total Debt by each country
SELECT Country_Code, Country_Name, ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata
GROUP BY Country_Code
ORDER BY Total_Debt_Overall DESC; 
```





Result:

Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'idsproject.idsdata.Country_Name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by.






### 💡 07. `GROUP BY`



01. In standard SQL, when using the GROUP BY clause, any column in the SELECT statement that is not part of an aggregate function should be included in the GROUP BY clause. 


02. Alternatively, if you want to include the "Country_Name" column without grouping, you can use an aggregate function like MAX or MIN to select a single value for that column.





### ▶️ 07. Solved the Wrong Query


```SQL


-- 04.01 Total Debt by each country
SELECT Country_Code, Country_Name, ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata
GROUP BY Country_Code, COuntry_Name
ORDER BY Total_Debt_Overall DESC; 
```





Result:




![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/3e4de74f-28fe-4473-8aa1-89be4475e2fc)






### ▶️ 08. Country with the Highet Debt




```SQL
-- 08. Country with the Highet Debt
SELECT Country_Code, Country_Name, ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata
GROUP BY Country_Code, Country_Name
ORDER BY Total_Debt_Overall DESC
LIMIT 1; 
```




Result:



![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/b031ad4c-69f2-486e-a0ff-9fd26047a7aa)





### ▶️ 09. Average Amount of Debts Across Indicators


The countries are given debt amounts under various indicators. Now our goal is to find the average amount of debt of all indicators. 




```SQL
-- 09. Average Amount of Debts Across Indicators
SELECT Indicator_Code,Indicator_Name, AVG(Total_Debt) AS Average_of_Debt
FROM idsdata
GROUP BY Indicator_Code,Indicator_Name
ORDER BY Average_of_Debt DESC
LIMIT 10;  
```





Result:




![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/d71229f1-17a2-497d-bddf-64e881dd0c3e)






### ▶️ 10. The Highest Amount of External Debt Stocks




External Debt Stocks, as reported by the World Bank, refers to the total amount of debt owed by a country to foreign creditors. It includes both public and private debt obligations and represents the outstanding balance of external debt at a specific point in time.

The World Bank collects and reports data on external debt stocks for countries around the world. This data provides valuable insights into a country's debt position and its ability to meet its external debt obligations.


We need to find out the highest amount of debt in this category which country owes. The indicator code is `DT.DOD.DECT.CD`. 

We will find top 5 countries here for better understanding. 



```SQL
-- 10. The Highest Amount of External Debt Stocks


SELECT Country_Name,Indicator_Code, Indicator_Name, SUM(Total_Debt) AS Total_Debt_Owed
FROM idsdata
WHERE Indicator_Code = "DT.DOD.DECT.CD"
GROUP BY Country_Name, Indicator_Name, Indicator_Code
ORDER BY 4 DESC
```




Result:


![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/fa08e9b8-6987-42d6-a535-d84929bac02c)







### ▶️ 11. The Most Common Debt Indicator.





```SQL
-- 11. The Most Common Debt Indicators.
SELECT Indicator_Code, Indicator_Name, COUNT(Indicator_Code) 
FROM idsdata
GROUP BY Indicator_Code, Indicator_Name
ORDER BY 3 DESC
LIMIT 10; 
```




Result:




![image](https://github.com/zizanayub/SQL-Projects/assets/65456659/72ee1de9-ac85-4be3-895d-6a96a199b30c)







### ▶️ 12. Other Viable Debt Issues and Conclusion


According to analysis, in this big dataset, there are 214 different debt indicators. Different countries owe these amounts based on these indicators. We have found out some insights till now such as- maximum debt owed by country, top 10 countries by debt, top indicators, the count of indicators, etc. From the indicators list, we can make an idea about the economic condition of the countries who took debt from The World Bank.


In this README file, we analyzed about the debt owed by countries across the globe. We extracted few summary statistics from the data and found out some interesting facts and figuures. The findings were also validated to check if they were correct. 



Finally, we will find out the highest debt a country has according to a specific indicator. 



```SQL
-- The highest debt paying countries according to indicators.

SELECT Country_Name, Indicator_Code, Indicator_Name, MAX(Total_Debt) AS Maximum_Debt
FROM idsdata
GROUP BY Country_Name, Indicator_Code, Indicator_Name
ORDER BY 3 DESC;
```




Result:



