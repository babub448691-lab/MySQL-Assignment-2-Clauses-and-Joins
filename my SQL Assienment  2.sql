-- MySQL Assignment 2 - Querying Data
-- Schema (from Assignment 1, after recreation with constraints):
--   departments(department_id, department_name)
--   location(location_id, location)
--   employees(employee_id, employee_name, gender, age, hire_date,
--             designation, department_id, location_id, salary)
USE employee;




-- =========================
-- 1. Distinct Values
-- =========================
SELECT DISTINCT salary FROM employees;

-- =========================
-- 2. Alias (AS)
-- =========================
SELECT age AS Employee_Age, salary AS Employee_Salary
FROM employees;

-- =========================
-- 3. WHERE clause & operators
-- =========================
SELECT *
FROM employees
WHERE salary > 50000
  AND hire_date < '2016-01-01';

-- Fill missing designation with 'Data Scientist'
-- (If Workbench shows "safe update mode" error, first run: SET SQL_SAFE_UPDATES = 0;)
UPDATE employees
SET designation = 'Data Scientist'
WHERE designation IS NULL OR designation = '';

-- =========================
-- SORTING AND GROUPING
-- =========================
-- 1. ORDER BY
SELECT *
FROM employees
ORDER BY department_id ASC, salary DESC;

-- 2. LIMIT
SELECT *
FROM employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date
LIMIT 5;

-- 3. Aggregate functions
SELECT SUM(e.salary) AS Total_Finance_Salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

SELECT MIN(age) AS Minimum_Age FROM employees;

-- 4. GROUP BY
SELECT l.location, MAX(e.salary) AS Max_Salary
FROM employees e
JOIN location l ON e.location_id = l.location_id
GROUP BY l.location;

SELECT designation, AVG(salary) AS Avg_Salary
FROM employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

-- 5. HAVING
-- Departments with fewer than 3 employees (LEFT JOIN so empty departments also show)
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS Emp_Count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;

-- Locations with female employees whose average age is below 30
SELECT l.location, AVG(e.age) AS Avg_Age
FROM employees e
JOIN location l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;

-- =========================
-- JOINS
-- =========================
-- 1. INNER JOIN
SELECT e.employee_name, e.designation, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 2. LEFT JOIN
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS Total_Employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 3. RIGHT JOIN
SELECT l.location, e.employee_name
FROM employees e
RIGHT JOIN location l ON e.location_id = l.location_id;
SET SQL_SAFE_UPDATES = 0;