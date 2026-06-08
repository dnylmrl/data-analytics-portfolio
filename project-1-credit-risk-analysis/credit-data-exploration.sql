-- Query 1: Total number of borrowers
SELECT COUNT(*) FROM credit_data;

-- Query 2: Default vs non-default count
SELECT SeriousDlqin2yrs, COUNT(*) FROM credit_data GROUP BY SeriousDlqin2yrs;

-- Query 3: Average age
SELECT AVG(age) FROM credit_data;

-- Query 4: Min and max age
SELECT MIN(age), MAX(age) FROM credit_data;

-- Query 5: Borrowers by age group
SELECT 
    CASE 
        WHEN age < 30 THEN '20s'
        WHEN age < 40 THEN '30s'
        WHEN age < 50 THEN '40s'
        WHEN age < 60 THEN '50s'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS count
FROM credit_data
GROUP BY age_group
ORDER BY age_group;