SELECT * FROM idsproject.idsdata;

-- Use International Debt Statistics Database
USE idsproject; 



-- 01. Find out all the columns of IDS table (Limit first 10 rows)
SELECT *
FROM idsdata
LIMIT 10; 



-- 02. Number of Distinct Countries
SELECT COUNT(DISTINCT Country_Name) Total_Countries
FROM idsdata; 



-- 03. DIstinct Debt Indicators.
SELECT DISTINCT Indicator_Code AS distinct_debt_indicators, Indicator_Name
FROM idsdata
ORDER BY distinct_debt_indicators; 





-- 03.01. DIstinct Debt Indicators Count
SELECT COUNT(DISTINCT Indicator_Code) AS distinct_debt_indicators_count
FROM idsdata;




-- 04. Total Debt by all countries
SELECT ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata;


SELECT SUM(Total_Debt) AS Total_Debt_Overall
FROM idsdata; 



-- 04.01 Total Debt by each country
SELECT Country_Code, Country_Name, ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata
GROUP BY Country_Code, COuntry_Name
ORDER BY Total_Debt_Overall DESC; 



-- 08. Country with the Highet Debt
SELECT Country_Code, Country_Name, ROUND(SUM(Total_Debt)/1000000,2) AS Total_Debt_Overall
FROM idsdata
GROUP BY Country_Code, Country_Name
ORDER BY Total_Debt_Overall DESC
LIMIT 1; 




-- 09. Average Amount of Debts Across Indicators
SELECT Indicator_Code,Indicator_Name, AVG(Total_Debt) AS Average_of_Debt
FROM idsdata
GROUP BY Indicator_Code,Indicator_Name
ORDER BY Average_of_Debt DESC
LIMIT 10;  





-- 10. The Highest Amount of External Debt Stocks


SELECT Country_Name,Indicator_Code, Indicator_Name, SUM(Total_Debt) AS Total_Debt_Owed
FROM idsdata
WHERE Indicator_Code = "DT.DOD.DECT.CD"
GROUP BY Country_Name, Indicator_Name, Indicator_Code
ORDER BY 4 DESC
LIMIT 5; 




-- 11. The Most Common Debt Indicators.
SELECT Indicator_Code, Indicator_Name, COUNT(Indicator_Code) 
FROM idsdata
GROUP BY Indicator_Code, Indicator_Name
ORDER BY 3 DESC
LIMIT 10; 


-- The highest debt paying countries according to indicators.

SELECT Country_Name, Indicator_Code, Indicator_Name, MAX(Total_Debt) AS Maximum_Debt
FROM idsdata
GROUP BY Country_Name, Indicator_Code, Indicator_Name
ORDER BY 4 DESC
LIMIT 10; 



