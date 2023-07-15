YT Resource: https://www.youtube.com/watch?v=M-4EpNdlSuY (Codebasics)


## 00. Learning Outcomes and Questions/Ideas

01. SQLALchemy and PyMySQL library.
02. What does SQLAlchemy do?
03. What does Object Relational Mapping (ORM) do?
04. What is Paradigm?
05. What is Abstraction?
06. How to connect engine through SQLAlchemy library in python?
07. How to read table and specific columns?
08. How to execute SQL query?
09. What does `inplace` parameter do while renaming dataframe?
10. What are the parameters in to_sql() function and what do they do each? (con, index, name, if_exists)
11. What does read_sql() function do? 



#### Idea:

01. Practical usage of `inplace` parameter.
02. More examples with breakdown of `to_sql()` function. 

## 01.01. Installing SQLAlchemy 

SQLAlchemy is a library that facilitates the communication between Python programs and databases. 


```python
pip install sqlalchemy
```

    Requirement already satisfied: sqlalchemy in c:\users\sy929\anaconda3\lib\site-packages (1.4.39)
    Requirement already satisfied: greenlet!=0.4.17 in c:\users\sy929\anaconda3\lib\site-packages (from sqlalchemy) (2.0.1)
    Note: you may need to restart the kernel to use updated packages.
    

## 01.02. PyMySQL

It allows Python programs to connect to and interact with MySQL databases.


```python
pip install pymysql
```

    Collecting pymysql
      Downloading PyMySQL-1.1.0-py3-none-any.whl (44 kB)
         -------------------------------------- 44.8/44.8 kB 221.3 kB/s eta 0:00:00
    Installing collected packages: pymysql
    Successfully installed pymysql-1.1.0
    Note: you may need to restart the kernel to use updated packages.
    

## 02. Installing Libraries


```python
import pandas as pd
import sqlalchemy
```

## 03. Create SQLAlchemy Engine

**01. What does SQLAlchemy Engine do?**

The SQLAlchemy Engine is a key component of the SQLAlchemy library, which is a popular Python SQL toolkit and Object-Relational Mapping (ORM) framework. The Engine provides a way to establish and manage connections to a database and perform various database operations.

(**Establish and manage connections to a database**)

**02. What does Object Relational Mapping (ORM) do?**

Object-Relational Mapping (ORM) is a programming technique that enables developers to work with relational databases using object-oriented programming (OOP) concepts and paradigms. 


ORM frameworks-

1. provide a layer of abstraction between the databases and object-oriented nature of programming languages. 
2. allow developers to interact with SQL databases using Classes and Objects instead of writing raw SQL queries.

(**Allows us to interact with SQL databases using OOP concepts**)


**03. What is paradigm?**

Fundamental principle and concept that guides the design and implementation of software system. 

(**Helps us in the design and development of software systems**)

**04. What is Abstraction?**

1. A concept in computer science that simplifies complex details.
2. Hiding unnecessary information.
3. Focuses on the essentials only. 

(**A concept in CSE that simplifies complex details and focuses only on the essentials**)



```python
engine = sqlalchemy.create_engine('mysql+pymysql://root:Zizaniut56@localhost:3306/codebasics')
```

## 04. Read Table in a Data Frame 


```python
df = pd.read_sql_table('customers',engine)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>phone_number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
    </tr>
    <tr>
      <th>5</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
    </tr>
  </tbody>
</table>
</div>



## 04.01. Read Specific Columns


```python
df = pd.read_sql_table('customers',engine,columns=["name"])
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Donald</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Shammim</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Modi</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Donald</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Shammim</td>
    </tr>
    <tr>
      <th>5</th>
      <td>Modi</td>
    </tr>
  </tbody>
</table>
</div>



## 05. Joining SQL Query


```python
df = pd.read_sql_query("SELECT * FROM customers",engine)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>phone_number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
    </tr>
    <tr>
      <th>5</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
    </tr>
  </tbody>
</table>
</div>




```python
query = """
SELECT *
FROM customers 
JOIN orders 
    ON customers.id = orders.customer_id

"""

df = pd.read_sql_query (query,engine)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>phone_number</th>
      <th>id</th>
      <th>name</th>
      <th>amount</th>
      <th>customer_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
      <td>2</td>
      <td>Google Pixel</td>
      <td>950</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
      <td>1</td>
      <td>Yoga Mat</td>
      <td>20</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
      <td>3</td>
      <td>Fossil Watch</td>
      <td>120</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
      <td>2</td>
      <td>Google Pixel</td>
      <td>950</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
      <td>1</td>
      <td>Yoga Mat</td>
      <td>20</td>
      <td>2</td>
    </tr>
    <tr>
      <th>5</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
      <td>3</td>
      <td>Fossil Watch</td>
      <td>120</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>



## 06. Rename the dataframe


1. First, take a csv file. 
2. Work on that CSV file to rename the column name. 


```python
df = pd.read_csv('01. customers.csv')
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Customer Name</th>
      <th>Customer Phone</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>rafael nadal</td>
      <td>4567895647</td>
    </tr>
    <tr>
      <th>1</th>
      <td>maria sharapova</td>
      <td>434534545</td>
    </tr>
    <tr>
      <th>2</th>
      <td>vladimir putin</td>
      <td>89345345</td>
    </tr>
    <tr>
      <th>3</th>
      <td>kim un jong</td>
      <td>123434456</td>
    </tr>
    <tr>
      <th>4</th>
      <td>jeff bezos</td>
      <td>934534543</td>
    </tr>
    <tr>
      <th>5</th>
      <td>rahul gandhi</td>
      <td>44324222</td>
    </tr>
  </tbody>
</table>
</div>



`Customer Name` and `Customer Phone` these two column names are not allowed. Best, we should rename their names as "name" and "phone_number"


```python
df.rename(
columns = {
    'Customer Name' : 'name',
    'Customer Phone' : 'phone_number'
}, inplace = True

)


df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>name</th>
      <th>phone_number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>rafael nadal</td>
      <td>4567895647</td>
    </tr>
    <tr>
      <th>1</th>
      <td>maria sharapova</td>
      <td>434534545</td>
    </tr>
    <tr>
      <th>2</th>
      <td>vladimir putin</td>
      <td>89345345</td>
    </tr>
    <tr>
      <th>3</th>
      <td>kim un jong</td>
      <td>123434456</td>
    </tr>
    <tr>
      <th>4</th>
      <td>jeff bezos</td>
      <td>934534543</td>
    </tr>
    <tr>
      <th>5</th>
      <td>rahul gandhi</td>
      <td>44324222</td>
    </tr>
  </tbody>
</table>
</div>



## 07. What does `inplace` do?

`inplace` takes 'True' or 'False'. 

1. If 'True', this parameter executes modification directly on the original objects.  
2. But, if 'False' (Default Value), a new modified object is created and returned, leaving the original object unchanged. If modified, the new object is created and it is returned as a separate object. 

## 08. to_sql()


Parameters:

1. **name:** Database table name,
2. **con:** connection, Here we have created a connection named engine earlier.
3. **if_exists:** There are 3 options. Append, Replace, Fail (
   Fail: If table exists, do nothing.
   Replace: If table exists, drop it. Recreate it. Insert data.
   Append: If table exists, insert data. Create if doesn't exist.
  
4. **Index: False.** Because, we don't want serial no. 0,1,2,.....


```python
df.to_sql(
    name='codebasics.customers',
    con=engine,
    if_exists='replace',
    index=False
)
```




    6



## 09. read_sql()

read_sql() is a wrapper of read_sql_table() and read_sql_query(). It brings up the convenience only in the SQL query execution through Python. 


```python
df = pd.read_sql('customers',engine)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>phone_number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>Donald</td>
      <td>1899999</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2</td>
      <td>Shammim</td>
      <td>1988888</td>
    </tr>
    <tr>
      <th>5</th>
      <td>3</td>
      <td>Modi</td>
      <td>898938398</td>
    </tr>
  </tbody>
</table>
</div>




```python
df = pd.read_sql('SELECT * FROM orders',engine)
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>name</th>
      <th>amount</th>
      <th>customer_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>Yoga Mat</td>
      <td>20</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>Google Pixel</td>
      <td>950</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>Fossil Watch</td>
      <td>120</td>
      <td>3</td>
    </tr>
  </tbody>
</table>
</div>


