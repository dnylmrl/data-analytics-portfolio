-- ===================================================================================================================
-- 01_exploration.sql
-- Initial Data Exploration
-- ===================================================================================================================

-- Query 1: Row count and target variable distribution
-- Question: How many customers are in the dataset, and what percentage
--           experienced serious financial distress?

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN seriousdlqin2yrs = 1 THEN 1 ELSE 0 END) AS customers_with_distress,
    SUM(CASE WHEN seriousdlqin2yrs = 0 THEN 1 ELSE 0 END) AS customers_without_distress,
    ROUND(100.0 * SUM(CASE WHEN seriousdlqin2yrs = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS distress_rate
FROM credit_data;

-- ===================================================================================================================

-- Query 2: Missing data
-- Question: Which columns have missing values and what percentage is missing?

-- monthlyincome (19.82%) and numberofdependents (2.62%) are the only columns
-- with NULLs. These will be excluded automatically from aggregate functions.

SELECT 
	'id' AS column_name,
    COUNT(*) - COUNT(id) AS null_count,
    ROUND(100.0 * (COUNT(*) - COUNT(id)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'seriousdlqin2yrs' AS column_name,
	COUNT(*) - COUNT(seriousdlqin2yrs) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(seriousdlqin2yrs)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'revolvingutilizationofunsecuredlines' AS column_name,
	COUNT(*) - COUNT(revolvingutilizationofunsecuredlines) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(revolvingutilizationofunsecuredlines)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'age' AS column_name,
	COUNT(*) - COUNT(age) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(age)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'numberoftime30_59dayspastduenotworse' AS column_name,
	COUNT(*) - COUNT(numberoftime30_59dayspastduenotworse) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(numberoftime30_59dayspastduenotworse)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'debtratio' AS column_name,
	COUNT(*) - COUNT(debtratio) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(debtratio)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'monthlyincome' AS column_name,
	COUNT(*) - COUNT(monthlyincome) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(monthlyincome)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'numberofopencreditlinesandloans' AS column_name,
	COUNT(*) - COUNT(numberofopencreditlinesandloans) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(numberofopencreditlinesandloans)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'numberoftimes90dayslate' AS column_name,
	COUNT(*) - COUNT(numberoftimes90dayslate) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(numberoftimes90dayslate)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'numberrealestateloansorlines' AS column_name,
	COUNT(*) - COUNT(numberrealestateloansorlines) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(numberrealestateloansorlines)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'numberoftime60_89dayspastduenotworse' AS column_name,
	COUNT(*) - COUNT(numberoftime60_89dayspastduenotworse) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(numberoftime60_89dayspastduenotworse)) / COUNT(*), 2) AS null_percent
FROM credit_data

UNION ALL

SELECT 
	'numberofdependents' AS column_name,
	COUNT(*) - COUNT(numberofdependents) as null_count,
	ROUND(100.0 * (COUNT(*) - COUNT(numberofdependents)) / COUNT(*), 2) AS null_percent
FROM credit_data

ORDER BY null_percent DESC

-- ===================================================================================================================

-- Query 3: Basic statistics on key numeric columns
-- Question: What are the min, max, and average values for key predictors?

-- Notable anomalies: age min = 0, debtratio max = 329664, 
-- revolvingutilization max = 50708. These suggest outliers or data entry
-- errors. Noted but not removed -- outside of exploratory scope.

SELECT
	'age' AS column_name,
	MIN(age) AS min,
	MAX(age) AS max,
	ROUND(AVG(age), 2) AS avg
FROM credit_data

UNION ALL

SELECT
	'debtratio' AS column_name,
	MIN(debtratio) AS min,
	MAX(debtratio) AS max,
	ROUND(AVG(debtratio), 2) AS avg
FROM credit_data

UNION ALL

SELECT
	'monthlyincome' AS column_name,
	MIN(monthlyincome) AS min,
	MAX(monthlyincome) AS max,
	ROUND(AVG(monthlyincome), 2) AS avg
FROM credit_data

UNION ALL

SELECT
	'revolvingutilizationofunsecuredlines' AS column_name,
	MIN(revolvingutilizationofunsecuredlines) AS min,
	MAX(revolvingutilizationofunsecuredlines) AS max,
	ROUND(AVG(revolvingutilizationofunsecuredlines), 2) AS avg
FROM credit_data

-- ===================================================================================================================

-- Query 4: Late payment distribution by severity
-- Question: What percentage of customers have at least one late payment?

-- 30-59 days is most common (15.99%). 
-- 90+ days (5.56%) slightly exceeds 60-89 days (5.07%) 

-- Only 6.68% reached serious distress despite 15.99% having late payments.

SELECT
	'numberoftime30_59dayspastduenotworse' AS dlq_stage,
	SUM(CASE WHEN numberoftime30_59dayspastduenotworse >= 1 THEN 1 ELSE 0 END) AS Count,
	ROUND(100.0 * SUM(CASE WHEN numberoftime30_59dayspastduenotworse >= 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS percent
FROM credit_data

UNION ALL

SELECT
	'numberoftime60_89dayspastduenotworse' AS dlq_stage,
	SUM(CASE WHEN numberoftime60_89dayspastduenotworse >= 1 THEN 1 ELSE 0 END) AS Count,
	ROUND(100.0 * SUM(CASE WHEN numberoftime60_89dayspastduenotworse >= 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS percent
FROM credit_data

UNION ALL

SELECT
	'numberoftimes90dayslate' AS dlq_stage,
	SUM(CASE WHEN numberoftimes90dayslate >= 1 THEN 1 ELSE 0 END) AS Count,
	ROUND(100.0 * SUM(CASE WHEN numberoftimes90dayslate >= 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
		AS percent
FROM credit_data

ORDER BY dlq_stage ASC