/* List all emmployees */
SELECT * FROM employees LIMIT 10;

/* How many departments? */
SELECT COUNT(*) FROM departments;

/* How many times has Employee 10001 has a raise? */
SELECT COUNT(*) AS Number_of_raises FROM salaries
WHERE emp_no = 10001;

/* What title has 10006 has? */
SELECT title FROM titles
WHERE emp_no = 10006;

/***************** 5) Column Concat *****************/
SELECT CONCAT(emp_no, ' is  a ', title) AS "EmpTitle" FROM titles
LIMIT 5;

SELECT emp_no, 
		CONCAT(first_name, ' ', last_name) AS "Full Name"
FROM employees
LIMIT 5;

/************** 6) Types of Functions in SQL *************/
/*
Aggerate - operate on MANY records to produce ONE value, example: SUM of salaries
Scalar - operate on EACH record Independently, example: CONCAT , it doesn't return result of concat values as one value.
*/

/*********** 7) Aggregate Functions ************/
/*
AVG()
COUNT()
MIN()
MAX()
SUM()
*/
SELECT COUNT(*) FROM employees;

SELECT MIN(emp_no) FROM employees;

/* Get the highest salary avaliable */
SELECT MAX(salary) AS Max_Salary FROM salaries;

/* Get the total amount of salaries paid */
SELECT SUM(salary) AS Total_Salary_Paid FROM salaries;

/********** 9) Commenting your queries *******/
SELECT * FROM employees
WHERE first_name='Mayumi' AND last_name='Schueller';

/*********** 11) Filtering Data ***********/
/* Get the list of all female employees */
SELECT * FROM employees
WHERE gender = 'F'
LIMIT 10;

/********** 12) AND OR *************/
SELECT *
FROM employees
WHERE (first_name = 'Georgi' AND last_name='Facello' AND hire_date='1986-06-26')
OR (first_name='Bezalel' AND last_name='Simmel');

/* 13) How many female customers do we have from state of Oregon or New York? */
SELECT COUNT(*) AS "NumberOfFemaleCustomers" 
FROM customers
WHERE gender='F' AND (state LIKE 'OR' OR state LIKE 'NY');

/******** 15) NOT ***********/
/* How many customers aren't 55? */
SELECT COUNT(age) FROM customers
WHERE NOT age=55;


/***** 16) Comparison Operators *******/
/* 17) Exercises */
/* How many female customers do we have from the state of Oregon (OR)? */
SELECT COUNT(*)
FROM customers
WHERE gender='F' AND state='OR';

/* Who over the age of 44 has an income of 100 000 or more? */
SELECT * 
FROM customers
WHERE age > 44 AND income=100000;

/* Who between the ages of 30 and 50 has an income of less than 50 000? */
SELECT *
FROM customers
WHERE age BETWEEN 30 AND 50
AND income < 50000;

/* What is the average income between the ages of 20 and 50? */
SELECT AVG(income)
FROM customers
WHERE age BETWEEN 20 AND 50;


/***** 18) Logical Operators AND OR NOT *****/
/* 
Order of Operations 
FROM => WEHRE => SELECT 
*/

/***** 19) Operator Precedence ******/
/* 
(most importance to least importance)
Parentheses
Multiplication / Division
Subtraction / Addition
NOT
AND
OR
If operators have equal precedence, then the operators are evaluated directionally.
From Left to Right or Right to Left.
check Operators Precedence.png
*/

SELECT state, gender FORM customers
WHERE gender ='F' AND (state='NY' OR state='OR');

/****** 20) Operator Precedence 2 ********/
SELECT *
FROM customers
WHERE (
	income > 10000 AND state='NY'
	OR (
		(age > 20 AND age < 30)
		AND income <=20000
	)
) AND gender='F';

/*Select people either under 30 or over 50 with an income above 50000 that are from either Japan or Australia*/
SELECT *
FROM customers
WHERE (age < 30 OR age > 50)
AND income > 50000
AND (country = 'Japan' OR country = 'Australia');

/*What was our total sales in June of 2004 for orders over 100 dollars?*/
SELECT SUM(totalamount)
FROM orders
WHERE totalamount > 100
AND orderdate='2004/06';

/***** 22) Checking for NULL Values ****/
/*
	NULL = NULL (output: NULL)
	NULL != NULL (output: NULL)
	
No Matter what you do with NULL, it will always be NULL (subtract, add, equal, etc)
*/
SELECT NULL=NULL;
SELECT NULL <> NULL;

-- returns true
SELECT 1=1; 

/******** 23) IS Keyword *********/
SELECT * FROM departments
WHERE dept_name = '' IS FALSE; -- meaning FALSE, but not a good way to write it.

SELECT * FROM departments
WHERE dept_name = '' IS NOT FALSE; -- meaning TRUE, but not a good way to write it.

SELECT * FROM salaries
WHERE salary < 150000 IS FALSE; -- basically saying > 150000


/******* 24) NULL Value Substituion NULL Coalesce *****/
/*
	SELECT coalesce(<column>, 'Empty') AS column_alias
	FROM <table>
	
	
	SELECT coalesce(
		<column1>,
		<column2>,
		<column3>,
		'Empty') AS combined_columns
	FROM <table>
	
Coalsece returns first NON NULL value.
*/

-- default age at 20, if there is no age avaliable
SELECT SUM(COALESCE(age, 20))
FROM students;

/*Assuming a student's minimum age for the class is 15, what is the average age of a student?*/
SELECT AVG(COALESCE(age, 15)) AS avg_age
FROM students;

/*Replace all empty first or last names with a default*/
SELECT COALESCE(first_name, 'DEFAULT') AS first_name,
COALESCE(last_name, 'DEFAULT') AS last_name
FROM students;


/******* 28) BETWEEN AND ********/
/*
	SELECT <column>
	FROM <table>
	WHERE <column> BETWEEN X AND Y
*/


/******* 29) IN Keyword *******/
/*
	SELECT *
	FROM <table>
	WHERE <column> IN (value1, vlaue2, ...)
*/
SELECT *
FROM employees
WHERE emp_no IN (100001, 100006, 11008);


/******* 31) LIKE ***********/

SELECT first_name
FROM employees
WHERE first_name LIKE 'M%';

/*
	PATTERN MATCHING
	
	LIKE '%2'				: Fields that end with 2
	LIKE '%2%'				: Fields that have 2 anywhere in the value
	LIKE '_00%'				: Fields that have 2 zero's as the second and third character and anything after
	LIKE '%200%'			: Fields that have 200 anywhere in the value
	LIKE '2_%_%'			: Fields any values that start with 2 and are at least 3 characters in length
	LIKE '2___3'			: Find any values in a five-digit number that start with 2 and end with 3
*/

/****** CAST *******/
/* Postgres LIKE ONLY does text comparison so we must CAST whatever we use to TEXT */
CAST (salary AS text);  -- method 1
salary::text			-- method 2

/******** Case Insensitive Matching ILIKE *********/
name ILIKE 'BR%'; -- matching for br, BR, Br, bR

SELECT * FROM employees
WHERE first_name ILIKE 'G%GER';

SELECT * FROM employees
WHERE first_name LIKE 'g%'; -- returns nothing because casesensitive

SELECT * FROM employees
WHERE first_name ILIKE 'g%';


/*********** 33) Dates and Timezones **********/

/* Set current postgres's session to UTC */
SHOW TIMEZONE;

SET TIME ZONE UTC;

/********* 34) Setting up Timezones ***********/
ALTER USER postgres SET TIMEZONE='UTC';


/******** 35) How do we format Date and Time *********/
/* 
		Postgres uses IS0-8601
		YYYY-MM-DDTHH:MM:SS
		2021-05-04T11:01:45+08:00
*/


/******* 36) Timestamps ***********/
/* A timestamp is a date with time and timezone info */

SELECT NOW(); -- 2021-05-04 11:05:37.567804+08

CREATE TABLE timezones_tmp(
	ts TIMESTAMP WITHOUT TIME ZONE,
	tz TIMESTAMP WITH TIME ZONE
);

INSERT INTO timezones_tmp
VALUES(
	TIMESTAMP WITHOUT TIME ZONE '2000-01-01 10:00:00',
	TIMESTAMP WITH TIME ZONE '2000-01-01 10:00:00+00'
);

SELECT * FROM timezones_tmp;


/********* 37) Date Functions **********/

SELECT NOW(); 									/* 2021-05-04 11:17:30.418998+08 */

SELECT NOW()::date; 							/* 2021-05-04 */
SELECT NOW()::time; 							/* 11:18:22.483492 */

SELECT CURRENT_DATE; 							/* 2021-05-04 */
SELECT CURRENT_TIME; 							/* 11:19:11.726931+08:00 */

/********* Format Modifier *********/
/*
	D		: Day
	M		: Month
	Y 		: Year
	Check postgres doc for full details.
*/

SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy');   	/* 04/05/2021 */
SELECT TO_CHAR(CURRENT_DATE, 'ddd'); 			/* 124 */


/*********** 38) Date Difference and Casting ***********/

SELECT NOW() - '1800/01/01';               	/* 80842 days 10:11:08.965674 */
SELECT DATE '1800/01/01';  					/* 1800-01-01 */

SELECT AGE(DATE '1800/01/01');				/* 221 years 4 mons 3 days */
SELECT AGE(DATE '1990/06/30');

/* difference between two dates */
SELECT AGE(DATE '1992/11/13', DATE '1800/01/01');		/* 192 years 10 mons 12 days */


/*********** 40) Extracting Information ************/

SELECT EXTRACT (DAY FROM DATE '1992/11/13') AS DAY; 		/* 13 */
SELECT EXTRACT (MONTH FROM DATE '1992/11/13') AS MONTH;
SELECT EXTRACT (YEAR FROM DATE '1992/11/13') AS YEAR;


/******** ROUND A DATE (Date_Trunc) **********/
SELECT DATE_TRUNC('year', DATE '1992/11/13');			/* 1992-01-01 00:00:00+08 */
SELECT DATE_TRUNC('month', DATE '1992/11/13');			/* 1992-11-01 00:00:00+08 */
SELECT DATE_TRUNC('day', DATE '1992/11/13');			/* 1992-11-13 00:00:00+08 */


/********* 41) Intervals *********/
/* It can store and manipulate a period of time in years, months, days, hours, minutes, seconds, etc */
INTERVAL '1 year 2 months 3 days'
INTERVAL '2 weeks ago'
INTERVAL '1 year 3 hours 20 minutes'

/* <30 days before the given date */
SELECT * FROM orders
WHERE purchaseDate <= NOW() - INTERVAL '30 days';

SELECT NOW() - INTERVAL '30 days'; /* 2021-04-04 11:46:09.447478+08 */
SELECT NOW() - INTERVAL '1 year 2 months 3 days';
SELECT NOW() + INTERVAL '1 year';

/* Extracting intervals data */
-- returns 6 because nearly 6 years
SELECT EXTRACT (
	YEAR 
	FROM INTERVAL '5 years 20 months'
);

-- returns 8, because nearest rounded months is 8 (20 months % 12)
SELECT EXTRACT (
	MONTH 
	FROM INTERVAL '5 years 20 months'
);


/********** 43) DISTINCT *************/
/* 
	remove duplicates 
	SELECT
		DISTINCT <col1>, <col2>
	FROM <table>
*/

SELECT DISTINCT salary, from_date
FROM salaries
ORDER BY salary DESC;


/********* 45) Sorting Data ********/
/*
	SELECT * FROM Customers
	ORDER BY <column> [ASC/DESC]
*/

SELECT first_name, last_name
FROM employees
ORDER BY first_name, last_name DESC
LIMIT 10;

/******** Using Expressions *******/
SELECT DISTINCT last_name, LENGTH(last_name)
FROM employees
ORDER BY LENGTH(last_name) DESC;

/********* 46) Multi Tables SELECT *********/
SELECT e.emp_no, 
	CONCAT(e.first_name, e.last_name) AS full_name,
	s.salary,
	s.from_date, s.to_date
FROM employees as e, salaries as s
WHERE e.emp_no = s.emp_no
ORDER BY e.emp_no;


/******** 47) Inner JOIN ************/

SELECT e.emp_no, 
	CONCAT(e.first_name, e.last_name) AS full_name,
	s.salary,
	s.from_date, s.to_date
FROM employees as e
JOIN salaries as s ON s.emp_no = e.emp_no
ORDER BY e.emp_no;


/* 
we want to know the latest salary after title change of the employee
salary raise happen only after 2 days of title change
*/
SELECT e.emp_no,
		CONCAT(e.first_name, e.last_name) AS "Name",
		s.salary,
		t.title,
		t.from_date AS "Promoted on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
AND t.from_date = (s.from_date + INTERVAL '2 days')
ORDER BY e.emp_no ASC, s.from_date ASC;


/* we want to know the original salary and also the salary at a promotion */
SELECT e.emp_no,
		CONCAT(e.first_name, e.last_name) AS "Name",
		s.salary,
		COALESCE(t.title, 'no title change'),
		COALESCE(t.from_date::text, '-') AS "title take on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
AND (
	s.from_date = t.from_date								-- original salary
	OR t.from_date = (s.from_date + INTERVAL '2 days')		-- promoted salary
)
ORDER BY e.emp_no ASC, s.from_date ASC;


/********* 48) Self Join *********/
/*
	This usually can be done when a table has a foreign key referencing to its primary key
| id | name	| startDate | supervisorId|
| 1	 | David| 1990/01/01| 2 |
| 2  | Ric  | 1980/06/03|   |
*/

/* we want to see employee info with supervisor name */
SELECT a.id, a.name AS employee_name, a.startDate, 
		b.name AS supervisor_name
FROM employees a
JOIN employees b ON a.supervisorId = b.id;


/********* 49) OUTER JOIN **********/

/* Which employees are manager ? */
SELECT emp.emp_no, dept.emp_no
FROM employees emp
LEFT JOIN dept_manager dept ON emp.emp_no = dept.emp_no
WHERE dept.emp_no IS NOT NULL;

/* How many employees are NOT manager? */
SELECT COUNT(emp.emp_no)
FROM employees emp
LEFT JOIN dept_manager dept ON emp.emp_no = dept.emp_no
WHERE dept.emp_no IS NULL;

/* We want to know every salary raise and also know which ones were a promotion */
SELECT e.emp_no, s.salary, 
	COALESCE(t.title, 'No Title Change'),
	COALESCE(t.from_date::text, '-') AS "Title taken on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
LEFT JOIN titles t ON e.emp_no = t.emp_no
	AND (
			t.from_date = s.from_date 
			OR t.from_date = s.from_date + INTERVAL '2 days'
		)
ORDER BY e.emp_no, s.from_date;


/******** 50) Less Common Joins ************/

/***** Cross Join ******/
/*
	Create a combination of every row
*/
CREATE TABLE "cartesianA" (id INT);
CREATE TABLE "cartesianB" (id INT);

INSERT INTO "cartesianA" VALUES (1);
INSERT INTO "cartesianA" VALUES (2);
INSERT INTO "cartesianA" VALUES (3);

INSERT INTO "cartesianB" VALUES (1);
INSERT INTO "cartesianB" VALUES (2);
INSERT INTO "cartesianB" VALUES (4);
INSERT INTO "cartesianB" VALUES (5);
INSERT INTO "cartesianB" VALUES (20);
INSERT INTO "cartesianB" VALUES (30);

SELECT *
FROM "cartesianA"
CROSS JOIN "cartesianB";

/******** Full Outer Join ********/
/*
	Return results from Both whether they match or not
*/

SELECT *
FROM "cartesianA" a
FULL JOIN "cartesianB" b ON a.id = b.id; 


/*********** 52) USING Keyword ************/
/* Simplying the JOIN syntax */

SELECT emp.emp_no, emp.first_name, emp.last_name, d.dept_name
FROM employees emp
JOIN dept_emp dept USING(emp_no)								-- same as ON emp.emp_no = dept.emp_no
JOIN departments d USING(dept_no)





/******** 1) GROUP BY  **********/
/*
	When we group by, we apply the function PER GROUP,	NOT on the ENTIRE DATA SET.
	Group by use Split, Apply, Combine strategry.
*/

/* How many employees worked in each department ? */
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no
ORDER BY 1;

/*------------------------------------------------------------------------------------------------------------*/

/************ 2) HAVING Keyword *************/
/*
	"Having" applies filters to a group as a whole
	
	**** Order of Operations ****
		FROM
		WHERE
		GROUP BY
		HAVING
		SELECT
		ORDER
*/

/* How many employees worked in each department, but with employees more than 25000 ? */
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING COUNT(e.emp_no) > 25000
ORDER BY 1;

/* How many Female employees worked in each department, but with employees more than 25000 ? */
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE e.gender='F'
GROUP BY d.dept_name
HAVING COUNT(e.emp_no) > 25000
ORDER BY 1;

/*------------------------------------------------------------------------------------------------------------*/

/********** 3) Ordering Group Data **********/
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING COUNT(e.emp_no) > 25000
ORDER BY 2 DESC;


/********* 4) GROUP BY Mental Model ***********/

/* What are the 8 employees who got the most salary bumps? */
-- SELECT e.emp_no, CONCAT(e.first_name, e.last_name) AS "Name", s.salary, s.from_date, s.to_date
SELECT emp_no, MAX(from_date)
FROM salaries
GROUP BY emp_no;


/*------------------------------------------------------------------------------------------------------------*/

/*********** 5) GROUPING SETS**********/

/******* UNION / UNION ALL *********/
/*
	SELECT col1, SUM(col2)
	FROM table
	GROUP BY col1
	
	UNION / UNION ALL
	
	SELECT SUM(col2)
	FROM table
	
	
 	UNION ALL doesn't remove DUPLICATE Records.
*/
SELECT NULL AS "prod_id", sum(ol.quantity)
FROM orderlines AS ol

UNION

SELECT prod_id AS "prod_id", sum(ol.quantity)
FROM orderlines AS ol
GROUP BY prod_id
ORDER BY prod_id DESC;

/*------------------------------------------------------------------------------------------------------------*/

/*********** GROUPING SETS ***********/
/* 
	A Subclause of GROUP BY that allows you to define multiple grouping
	It is very useful when we want to combine multiple grouping 
*/

-- same result as using above UNION code, but in same query
-- here we are combining Two Sets (one for getting Total, one for per each product)
SELECT prod_id, sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
	GROUPING SETS(
		(),
		(prod_id)
	)
ORDER BY prod_id DESC;


/* we can add in multiple groups as we need */
SELECT prod_id, orderlineid, sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
	GROUPING SETS(
		(),
		(prod_id),
		(orderlineid)
	)
ORDER BY prod_id DESC, orderlineid DESC;

/*------------------------------------------------------------------------------------------------------------*/

/************ GROUPING SETS for info from High Level to Details Level ***********/

SELECT
	EXTRACT(YEAR FROM orderdate) AS "YEAR",
	EXTRACT(MONTH FROM orderdate) AS "MONTH",
	EXTRACT(DAY FROM orderdate) AS "DAY",
	SUM(quantity)AS "TOTAL QUANTITY"
FROM orderlines
GROUP BY 
	GROUPING SETS(
		(EXTRACT(YEAR FROM orderdate)), 		-- yearly
		(EXTRACT(MONTH FROM orderdate)), 		-- monthly
		(EXTRACT(DAY FROM orderdate)),			-- daily
		(
			EXTRACT(YEAR FROM orderdate),		-- month and year
			EXTRACT(MONTH FROM orderdate)
		),
		(
			EXTRACT(MONTH FROM orderdate),		-- month and day
			EXTRACT(DAY FROM orderdate)
		),
		(
			EXTRACT(YEAR FROM orderdate),		-- year, month and day
			EXTRACT(MONTH FROM orderdate),
			EXTRACT(DAY FROM orderdate)
		),
		()										-- nothing in particular (TOTAL AMOUNT)
	)
ORDER BY 1,2,3;

/*------------------------------------------------------------------------------------------------------------*/

/************			6) ROLLUP			***************/

/* roll up can provide a very similar result as above using grouping sets, but with less code */
SELECT
	EXTRACT(YEAR FROM orderdate) AS "YEAR",
	EXTRACT(MONTH FROM orderdate) AS "MONTH",
	EXTRACT(DAY FROM orderdate) AS "DAY",
	SUM(quantity)AS "TOTAL QUANTITY"
FROM orderlines
GROUP BY 
	ROLLUP(
		EXTRACT(YEAR FROM orderdate),
		EXTRACT(MONTH FROM orderdate),
		EXTRACT(DAY FROM orderdate)
	)
ORDER BY 1,2,3;

/*------------------------------------------------------------------------------------------------------------*/

/******************** 8/9) WINDOW Functions ******************/
/*
	Window functions CREATE a NEW COLUMN based on functions performed on a SUBSET or "WINDOW" of the data.
	
	window_function(agr1, agr2) OVER(
		[PARTITION BY partition_expression]
		[ORDER BY sort_expression [ASC | DESC] [NULLS {FIRST | LAST}]]
	)
*/

-- Here we can see in the result that max salary is 158,220. Because query returns all data, then LIMIT say cut it off for 100 rows only. 
-- That's why OVER() is calculated on the window or subset of data (in this case the entire data were returned).
SELECT *,
	MAX(salary) OVER()
FROM salaries
LIMIT 100;

-- in this case, the maximum salary is 69,999. Because of WHERE conditions, the data were filtered out.
-- and OVER() is using on that subset or window of the returned data (in this case the results of WHERE filtered data).
SELECT 
	*,
	MAX(salary) OVER() 
FROM salaries
WHERE salary < 70000
ORDER BY salary DESC;


/******************** 10) PARTITON BY ******************/
/*
	Divide Rows into Groups to apply the function against (Optional)
*/

/* Employee salary compairing average salary of departments */
SELECT 
	s.emp_no, s.salary,d.dept_name,
	AVG(s.salary)
	OVER(
		PARTITION BY(d.dept_name)
	)
FROM salaries s
JOIN dept_emp de ON s.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no;


/******************** 11) ORDER BY ******************/
/*
	ORDER BY changes the FRAME of the window
	It tells SQL to take into account of everything before up until to this point (becoming Cumulative)
*/
-- against the window of entire data
SELECT emp_no,
	COUNT(salary) OVER()
FROM salaries;

-- using PARTION BY
-- Counting salary by each unique emp_no partion
SELECT emp_no,
	COUNT(salary) OVER(
		PARTITION BY(emp_no)
	)
FROM salaries;


-- using ORDER BY
-- Count number are becoming Cumulative
SELECT emp_no,
	COUNT(salary) OVER(
		ORDER BY emp_no
	)
FROM salaries;


/********************************* FRAME Clause *******************************************************/
/*
	When using Frame clause in a window function, we can create a SUB-RANGE or FRAME
	
	For example: when we use ORDER BY, we look at the PARTATIONED data in a different len (FRAME).
	
	NOTE: 
	Without ORDER BY, by default the framing is usually ALL PARTITION ROWs (Entire Window)
	With ORDER BY, by default the framing is usually everything before the CURRENT ROW AND the CURRENT ROW (Cumulatively)
	
	|----------------------------------------------------------------------------------------------------
	|			Keys						| 			Meaning 										|
	|---------------------------------------|-----------------------------------------------------------|
	|	ROWS or RANGE						|	Whether you want to use a RANGE or ROWS as a FRAME		|
	|	PRECEDING							|	Rows Before the CURRENT ONE								|
	|	FOLLOWING							|	Rows After the CURRENT ONE								|
	| 	UNBOUNDED PRECEDING or FOLLOWING	|	Returns All Before and After							|
	|	CURRENT ROW							|	Your Current Row										|
	-----------------------------------------------------------------------------------------------------
*/

-- In this case, we can see that every salary is unique. Because we are using ORDER BY, each row is cumulativly
-- counted within the partition of each employee's window. As a result, it like like 1, (1+1 becomes 2), etc.
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
	)
FROM Salaries;


-- This one returns the same results as using PARTION BY only. The reason is we are looking at the data through the lends of Range.
-- For range using unbounded precedning and following, we are comparing against data with the entire data within that Partition.
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	)
FROM Salaries;

-- same reults as RANGE results
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	)
FROM Salaries;


-- same like ORDER BY
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	)
FROM Salaries;

/*------------------------------------------------------------------------------------------------------------*/

/************* 13) Solving for Current Salary ***********/
-- using GROUP BY isn't a good way to solve this problem because we need to pass in a lot of condition in GROUP BY clause.
SELECT emp_no, salary, to_date
FROM salaries
GROUP BY emp_no, salary, to_date
ORDER BY to_date DESC
LIMIT 10;

-- using window function for this problem
-- within frame, we compare the salary with salary of following and preceding one along the way.
-- LAST VALUE returns that very last value that won the salary comparing competition.
-- We order by from date Ascending order, so we knew ahead that the current salary should be the one on the most bottom.
SELECT 
	DISTINCT e.emp_no, e.first_name, d.dept_name,
	LAST_VALUE(s.salary) OVER(
		PARTITION BY e.emp_no
		ORDER BY s.from_date
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	) AS "Current Salary"
FROM salaries s
JOIN employees e USING(emp_no)
JOIN dept_emp de USING (emp_no)
JOIN departments d USING (dept_no)
ORDER BY emp_no;

-- checking out the unique salary for each employees
SELECT emp_no, salary, from_date, to_date,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY to_date
	)
FROM salaries;

/*-------------------------------------------------------------------------------------------------------------*/


/************************************	 WINDOW FUNCTIONS 	****************************************************/
/*
	---------------------------------------------------------------------------------------------------------------------
	|	Function				|		Purpose																			|
	----------------------------|---------------------------------------------------------------------------------------|
	|	SUM / MIN / MAX / AVG	|	Get the sum, min, .. of all the records in the partition							|
	|	FIRST_VALUE				|	Return the value evaluated against the first row within the partition.				|
	|	LAST_VALUE				|	Return the value evaluated against the last row within the partition.				|
	|	NTH_VALUE				| 	Return the value evaluated against the nth row in ordered partition.				|
	| 	PERCENT_RANK			|	Return the relative rank of the current row (rank-1) / (total rows - 1)				|
	|	RANK					|	Rank the current row within its partition with gaps.								|
	|	ROW_NUMBER				|	Number the current row within its partition starting from 1. (regardelss of framing)|
	|	LAG / LEAD				|	Access the values from the previous or next row.									|
	--------------------------------------------------------------------------------------------------------------------
*/

/************* 14) FIRST_VALUE ***********/

/* I want to know how my price compares to the item with the LOWEST price in the SAME category */
SELECT 
	prod_id, price, category,
	FIRST_VALUE(price) OVER(
		PARTITION BY category
		ORDER BY price
	) AS "Cheapest in the category"
FROM products
ORDER BY category, prod_id;

-- getting the same result using MIN which is easier, not needing ORDER BY too.
SELECT 
	prod_id, price, category,
	MIN(price) OVER(
		PARTITION BY category
	) AS "Cheapest in the category"
FROM products
ORDER BY category, prod_id;


/************* 15) LAST VALUE ****************/

/* I want to know how my price to the item with the HIGHEST PRICE in the SAME category */
SELECT 
	prod_id, price, category,
	LAST_VALUE(price) OVER(
		PARTITION BY category
		ORDER BY price
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	) AS "Most Expensive Price in Category"
FROM products
ORDER BY category, prod_id;

-- using MAX
SELECT 
	prod_id, price, category,
	MAX(price) OVER(
		PARTITION BY category
	) AS "Highest Price in Category"
FROM products
ORDER BY category, prod_id;


/****************** 16) SUM ************************/

/* I want to see how much Cumulatively a customer has ordered at our store */
SELECT 
	customerid, orderid, orderdate, netamount,
	SUM(netamount) OVER(
		PARTITION BY customerid
		ORDER BY orderid
	) AS "Cumulative Spending"
FROM orders
ORDER BY customerid, orderid;


/**************** 17) ROW_NUMBER ****************/
-- ROW_NUMBER ignores the framing
-- no need to put parameters in ROW_NUMBER() function

/* I want to know where my product is positioned in the category by price */
SELECT 
	category, prod_id, price,
	ROW_NUMBER() OVER(
		PARTITION BY category
		ORDER BY price
	) AS "Position in category by price"
FROM products
ORDER BY category

/*------------------------------------------------------------------------------------------------------------*/

/********************* 19) Conditional Statements ***********************/

/********** CASE ************/
/*
	SELECT a,
		CASE
			WHEN a=1 THEN 'one'
			WHEN a=2 THEN 'two'
			ELSE 'other'
		END
	FROM test;
*/

-- 1) CASE statement can be used anywhere
SELECT 
	orderid, customerid,
	CASE
		WHEN customerid=1 THEN 'my first customer'
		ELSE 'not my first customer'
	END AS "customer status",
	netamount
FROM orders
ORDER BY customerid;

-- 2) using CASE in combination with WHERE
SELECT
	orderid, customerid, netamount
FROM orders
WHERE
	CASE
		WHEN customerid > 10 THEN netamount < 100
		ELSE netamount > 100
	END
ORDER BY customerid;


-- 3) using CASE statement with Aggregate function

/* doing gesture of good faith, refunding 100$ for that order where spending is less than 100$ */
SELECT
	SUM(
		CASE
			WHEN netamount < 100 THEN -100
			ELSE netamount
		END
	) AS "Returns",
	SUM(netamount) AS "Normal Total",
FROM orders;

/* ----------------------------------------------------------------------------------------------------------- */

/******************* 20) NULL IF *******************/
/*
	Use NULLIF to fill in empty spots with a NULL value to avoid divide by zero issues
	
	NULLIF(val1, val2)
	
	if value 1 is equal to value 2, return NULL
*/

SELECT NULLIF(0, 0); -- returns null

SELECT NULLIF('ABC', 'DEF'); -- returns ABC


/* ----------------------------------------------------------------------------------------------------------- */


/******************** 21) VIEWS *********************/
/*
	Views allow you to store the results and query of previously run queries.
	
	There are 2 types of views: 1) Materialized and 2) Non-Materialized Views.
	
	1) Materialzed View - stores the data PHYSICIALLY AND PERIODICALLY UPDATES it when tables change.
	2) Non-Materialized View - Query gets RE-RUN each time the view is called on.
	
*/

/*************** 	22) VIEW syntax **************/
/*
	+ views are OUTPUT of query we ran.
	+ views act like TABLES you can query them.
	+ (Non-Materialized View): views tak VERY LITTLE SPACE to store. We only store the definition of the view, NOT ALL the data that it returns.	
*/

-- Create a view
CREATE VIEW view_name 
AS query;

-- Update a view
CREATE OR REPLACE view_name
AS query;

-- Rename a view
ALTER VIEW exisitng_view_name RENAME TO new_view_name;

-- Delete a view
DROP VIEW IF EXISTS view_name;

/*************** 23) Using VIEWS ******************/

-- get the last salary change of each employee
CREATE VIEW last_salary_change AS
	SELECT e.emp_no,
		MAX(s.from_date)
	FROM salaries s
	JOIN employees e USING(emp_no)
	JOIN dept_emp de USING(emp_no)
	JOIN departments d USING(dept_no)
	GROUP BY e.emp_no
	ORDER BY e.emp_no;

-- query entire data from that view
SELECT * FROM last_salary_change;

-- combine with view to get the latest salary of each employee
SELECT 
	s.emp_no, d.dept_name, s.from_date, s.salary
FROM last_salary_change lsc
JOIN salaries s USING(emp_no)
JOIN dept_emp de USING(emp_no)
JOIN departments d USING(dept_no)
WHERE s.from_date = lsc.max
ORDER BY s.emp_no;

/*--------------------------------------------------------------------------------------------------------------*/

/**************** 24) Indexes ****************/
/*
	Index is the construct to improve Querying Performance.
	
	Think of it like a table of contents, it helps you find where a piece of data is.
	
	Pros: Speed up querying
	Cons: Slows down data Insertion and Updates
	
	***** Types of Indexes *****
	- Single Column
	- Multi Column
	- Unique
	- Partial
	- Implicit Indexes (done by default)
*/

-- Create an index
CREATE UNIQUE INDEX idx_name
ON table_name(column1, column2, ...);

-- Delete an index
DELETE INDEX idx_name;

/*
	 **** When to Use Indexes *****
	 - Index Foreign Keys
	 - Index Primary Keys and Unique Columns
	 - Index on Columns that end up in the ORDER BY/WHERE clause VERY OFTEN.
	 
	 ***** When NOT to use Indexes ******
	 - Don't add Index just to add Index
	 - Don't use Index on Small Table
	 - Don't use on Tables that are UPDATED FREQUENTLY.
	 - Don't use on Columns that can contain NULL values
	 - Don't use on Columns that have Large Values.
*/


/***************** 25) Indexes Types ******************/

/*
	Single Column Index 	: 	retrieving data that satisfies ONE condition.
	Multi Column Index		:	retrieving data that satisfies MULIPLE Conditions.
	UNIQUE					: 	For Speed and Integrity
	PARTIAL					: 	Index Over a SUBSET of a Table (CREATE INDEX name ON table (<expression);)
	IMPLICIT				: 	Automatically creaed by the database: (Primary Key, Unique Key)
*/

EXPLAIN ANALYZE
SELECT "name", district, countrycode
FROM city
WHERE countrycode IN ('TUN', 'BE', 'NL');

-- Single Index
CREATE INDEX idx_countrycode
ON city(countrycode);


-- Partial Index
CREATE INDEX idx_countrycode
ON city(countrycode) WHERE countrycode IN ('TUN', 'BE', 'NL');

EXPLAIN ANALYZE
SELECT "name", district, countrycode
FROM city
WHERE countrycode IN ('PSE', 'ZWE', 'USA');


/************************** 26) Index Algorithms *********************/
/*
	POSTGRESQL provides Several types of indexes:
		B-TREE
		HASH
		GIN
		GIST
	Each Index types use different algorithms.
*/

-- we can extend which algorithm to use while creating index
CREATE UNIQUE INDEX idx_name
ON tbl_name USING <method> (column1, column2, ...)


-- by default, it is created using B-TREE
CREATE INDEX idx_countrycode
ON city(countrycode);

-- but we can specify which algorithm to use (example: HASH)
CREATE INDEX idx_countrycode
ON city USING HASH (countrycode);

/*************************** When to use which Algorithms? *************************/
/*
			********* B-TREE ***********
			Default Algorithm
			Best Used for COMPARISONS with
				<, >
				<=, >=
				=
				BETWEEN
				IN
				IS NULL
				IS NOT NULL
				
				
			**********  HASH **********
			Can only handle Equality = Operations.	
			
			
			*********** GIN (Generalized Inverted Index) ************
			Best used when Multiple Values are stored in a Single Field.
			
			
			*********** GIST (Generalized Search Tree) ***********
			Useful in Indexing Geometric Data and Full-Text Search.
*/

-- testing for HASH
EXPLAIN ANALYZE
SELECT "name", district, countrycode
FROM city
WHERE countrycode='BEL' OR countrycode='TUN' OR countrycode='NL';


/* ----------------------------------------------------------------------------------------------------------- */

/********************** 27) Subqueries ************************/
/*
	Subqueries can be used in SELECT, FROM, HAVING, WHERE.
	
	For HAVING and WHERE clause, subquery must return SINGLE value record.
*/

SELECT 
	title, price, 
	(SELECT AVG(price) FROM products) AS "global average price"
FROM products;


-- Subquery can returns A Single Result or Row Sets
SELECT 
	title, price, 
	(SELECT AVG(price) FROM products) AS "global average price" -- return single result
FROM (
	SELECT * FROM products -- return row sets
) AS "products_sub";

/************ 29) Types of Subqueries *************/
/*
	Single Row
	Multiple Row
	Multiple Column
	Correlated
	Nested
*/

-- Single Row: returns Zero or One Row
SELECT emp_no, salary
FROM salaries
WHERE salary > (
	SELECT AVG(salary) FROM salaries
);

-- Multiple Row: returns One or More Rows
SELECT title, price, category
FROM products
WHERE category IN (
	SELECT category FROM categories
	WHERE categoryname IN ('Comedy', 'Family', 'Classics')
);

-- Multiple Columns: returns ONE or More columns
SELECT emp_no, salary, dea.avg AS "Department average salary"
FROM salaries s
JOIN dept_emp as de USING(emp_no)
JOIN(
	SELECT dept_no, AVG(salary) FROM salaries AS s2
	JOIN dept_emp AS de2 USING(emp_no)
	GROUP BY dept_no
) AS dea USING (dept_no)
WHERE salary > dea.avg;


-- Correlated: Reference ONE or More columns in the OUTER statement - Runs against Each Row
/* Get the most recent salary of employee */
SELECT emp_no, salary AS "most recent salary", from_date
FROM salaries AS s
WHERE from_date = (
	SELECT MAX(s2.from_date) AS max
	FROM salaries AS s2
	WHERE s2.emp_no = s.emp_no
)
ORDER BY emp_no;


-- Nested : Subquery in Subquery
SELECT orderlineid, prod_id, quantity
FROM orderlines
JOIN(
	SELECT prod_id
	FROM products
	WHERE category IN(
		SELECT category FROM categories
		WHERE categoryname IN('Comedy', 'Family', 'Classics')
	)
) AS limited USING(prod_id);

/*************** 30) Using Subqueries ************/
SELECT 
	first_name,
	last_name,
	birth_date,
	AGE(birth_date)
FROM employees
WHERE AGE(birth_date) > (SELECT AVG(AGE(birth_date)) FROM employees);


/* Show the salary with title of the employee using Subquery, instead of JOIN */
SELECT emp_no, salary, from_date,
	(SELECT title FROM titles AS t 
	 WHERE t.emp_no=s.emp_no AND t.from_date=s.from_date)	
FROM salaries s
ORDER BY emp_no;

EXPLAIN ANALYZE
SELECT emp_no, salary AS "most recent salary", from_date
FROM salaries AS s
WHERE from_date = (
	SELECT MAX(s2.from_date) AS max
	FROM salaries AS s2
	WHERE s2.emp_no = s.emp_no
)
ORDER BY emp_no;


/********************** 32) Subqueries Operators *******************/
/*
		EXISTS : Check if the subquery returns any rows
*/
SELECT firstname, lastname, income
FROM customers AS c
WHERE EXISTS(
	SELECT * FROM orders as o
	WHERE c.customerid = o.customerid AND totalamount > 400
) AND income > 90000

/* 
	IN : Check if the value is equal to any of the rows in the return (NULL yields NULL)
	NOT IN : Check if the value is NOT equal to any of the rows in the return (NULL yields NULL)
*/
SELECT prod_id
FROM products
WHERE category IN(
	SELECT category FROM categories
	WHERE categoryname IN ('Comedy', 'Family', 'Classics')
);


SELECT prod_id
FROM products
WHERE category IN(
	SELECT category FROM categories
	WHERE categoryname NOT IN ('Comedy', 'Family', 'Classics')
);

/*
		ANY / SOME : check each row against the operator and if any comparison matches, return TRUE.
*/

SELECT prod_id
FROM products
WHERE category = ANY(
	SELECT category FROM categories
	WHERE categoryname IN ('Comedy', 'Family', 'Classics')
);

/*
			ALL : check each row against the operator and if all comparisions match, return true.
*/
SELECT prod_id, title, sales
FROM products
JOIN inventory as i USING(prod_id)
WHERE i.sales > ALL(
	SELECT AVG(sales) FROM inventory
	JOIN products as p1 USING(prod_id)
	GROUP BY p1.category
);

/*
	Single Value Comparison
*/
SELECT prod_id
FROM products
WHERE category = (
	SELECT category FROM categories
	WHERE categoryname IN ('Comedy')
);





/************************ 5) Template Databases ****************/
/*
	In General, there are 2 templates; Template0 and Template1.
	Template0 is kinda like safty net and used it to create Template1.
	You don't want to mess up with Template0.
*/

/******** Create Own Templates **********/
CREATE DATABASE mysuperdupertemplate;
--connect to that db and run
CREATE TABLE superdupertable();
--after creating the database and connect to it, you will see that table.
CREATE DATABASE mysuperduperdatabase WITH mysuperdupertemplate;


/*--------------------------------------------------------------------------------------------------------------*/

/*********** 6) Creating a Database **************/
/*
		TEMPLATE			: template01
		ENCODING			: UTF8
		CONNECTION_LIMIT	: 100
		OWNER				: Current User
*/
CREATE DATABASE db_name
	[[WITH] [OWNER [=] user_name]
	 		[TEMPLATE [=] template]
	 		[ENCODING [=] encoding]
	 		[LC_COLLATE [=] lc_collate]
	 		[LC_CTYPE [=] lc_ctype]
	 		[TABLESPACE [=] tablespace]
	 		[CONNECTION LIMIT [=] connlimit]]
			
			
-- to store ZTM db to store courses
CREATE DATABASE ZTM;

-- Create Schema
CREATE SCHEMA Sales;


/*--------------------------------------------------------------------------------------------------------------*/

/*********** 9) Creating Role **************/
CREATE ROLE readonly WITH LOGIN ENCRYPTED PASSWORD 'readonly';

-- to check all avaliable roles
>> \du

/*
By default, when you create a new database - only Superuser and creater of the db can access to it. Other users must be given access to it, if required.
*/

/************ 10) Creating users and Configuring Login *************/

-- create role and user
CREATE ROLE test_role_with_login WITH LOGIN ENCRYPTED PASSWORD 'password';

CREATE USER test_user_with_login WITH ENCRYPTED PASSWORD 'password';

\du

/************ Another way of creating user *********/
-- if you are not connected with postgre, there is binary command that we can use, just follow on screen questions.
createuser --interactive 

/******* Altering Role *********/
AlTER ROLE test_interactive WITH ENCRYPTED PASSWORD 'password';

/*--------------------------------------------------------------------------------------------------------------*/

/******** Checking hba and config file location *****/
-- login with root user
SHOW hba_file;
SHOW config_file;

/*--------------------------------------------------------------------------------------------------------------*/

/******** 11/12) Privileges *********/
GRANT ALL PRIVILEGES ON <table> TO <user>;
GRANT ALL ON ALL TABLES [IN SCHEMA <schema>] TO <user>;
GRANT [SELECT, UPDATE, INSERT, ...] ON <table> [IN SCHEMA <schema>] TO <user>;

-- grant select to our test user
GRANT SELECT ON titles TO test_user_with_login;

-- revoke privileges from test user
REVOKE SELECT ON titles FROM test_user_with_login;

-- Grant all access
GRANT ALL ON ALL TABLES IN SCHEMA public TO test_user_with_login;

-- Revoke all access
REVOKE ALL ON ALL TABLES IN SCHEMA public TO test_user_with_login;

-- Create a role with privileges and grant that role a specific user
CREATE ROLE employee_read;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO employee_read;
GRANT employee_read TO test_user_with_login;
GRANT employee_read TO test_user_with_login;
REVOKE employee_read FROM test_user_with_login;


/*--------------------------------------------------------------------------------------------------------------*/

/******** 13) Best Practices For Role Management *********/

/*
	When managing Roles and Permissions, always go with the "Principle Of Least Privilege".
	Give no Privilege at all at first. Then stack on privileges as required.
	
	Don't use Super/Admin by default.
	
*/

/*--------------------------------------------------------------------------------------------------------------*/

/************ 15) Storing Texts **********/
CREATE TABLE test(
	fixed char(4),
	variable varchar(20),
	unlimited text
);

INSERT INTO test VALUES(
	'abcd',
	'efghijklm',
	'This is super unlimited'
);


/************ 16) Storing Numbers **********/

CREATE TABLE test(
	four float4,
	eight float8,
	big decimal
);

INSERT INTO test VALUES(
	1.123456789,
	1.123456789123456789,
	1.123456789123456789123456789123456789123456789123456789
);

/************ 17) Storing Arrays **********/
CREATE TABLE test(
	four char(2)[],
	eight text[],
	big float64[]
);

INSERT INTO test VALUES(
	ARRAY['ab', 'cd', 'ef'],
	ARRAY['test', 'sunny', 'goblin'],
	ARRAY[1.23, 3.45, 6.78, 9.2345234]
);

/*--------------------------------------------------------------------------------------------------------------*/

/************ 19) Create Tables **************/

CREATE TABLE <name> (
	<col1> TYPE [Constraint],
	table_constraint [Constraint]
)[INHERITS <existing_table>];

-- create table for ztm db
-- first need to create extension, otherwise we can't use uuid_generate_v4() function.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE student(
	student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	date_of_birth DATE NOT NULL
);

-- check the existing tables
>> \dt

-- check the newly created student table
>> \d student

/*--------------------------------------------------------------------------------------------------------------*/

/************ 21) Column Constraints **************/

/*
			NOT NULL			: cannot be Null
			PRIMARY KEY			: column will be primary key
			UNIQUE				: can only contain unique values (Null is Unique)
			CHECK				: apply a special condition check against the values in the column
			REFERENCES			: used in Foreign Key referencing
*/







USE SQLTestDB;
GO
BACKUP DATABASE SQLTestDB
TO DISK = 'c:\tmp\SQLTestDB.bak'
   WITH FORMAT,
      MEDIANAME = 'SQLServerBackups',
      NAME = 'Full Backup of SQLTestDB';
GO


--If you want to do with powerShell
/*
$credential = Get-Credential
$container = 'https://<myStorageAccount>blob.core.windows.net/<myContainer>'
$fileName = '<myDatabase>.bak'
$server = '<myServer>'
$database = '<myDatabase>'
$backupFile = $container + '/' + $fileName

Backup-SqlDatabase -ServerInstance $server -Database $database -BackupFile $backupFile -Credential $credential
*/
