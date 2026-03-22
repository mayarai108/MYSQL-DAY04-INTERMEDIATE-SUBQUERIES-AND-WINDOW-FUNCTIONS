-- =============================================
-- *********SUBQUERIES AND WINDOW FUNCTIONS ****

-- =====================================
-- ***********USE DATABASE *************
-- ===================================
   USE company;

-- =========================================
-- TABLE: employees_2025
-- =========================================

CREATE TABLE employees_2025 (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    dept_id INT,
    salary INT
);

-- =========================================
-- INSERT DATA
-- =========================================
INSERT INTO employees_2025 VALUES
(1, 'Rahul', 'IT', 101, 40000),
(2, 'Amit', 'HR', 102, 25000),
(3, 'Neha', 'Finance', 103, 30000),
(4, 'Simran', 'IT', 101, 45000),
(5, 'Karan', 'HR', 102, 28000);
-- ===========================================
-- ***********SUBQUERIES***********************
-- ============================================
-- =========================================
-- Q1: Find employees whose salary is greater than average salary
-- =========================================
SELECT name, salary
FROM employees_2025
WHERE salary > (
    SELECT AVG(salary)
    FROM employees_2025
);

-- =========================================
-- Q2: Find employee(s) with highest salary
-- =========================================
SELECT name, salary
FROM employees_2025
WHERE salary = (
    SELECT MAX(salary)
    FROM employees_2025
);

-- =========================================
-- Q3: Find employees who work in same department as employees_2024
-- =========================================
SELECT name, department
FROM employees_2025
WHERE department IN (
    SELECT department
    FROM employees_2024
);
-- =========================================
-- Q4: Find employees whose salary is greater than
--     average salary of their department (Correlated Subquery)
-- =========================================
SELECT name, salary, department
FROM employees_2025 e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees_2025 e2
    WHERE e1.department = e2.department
);


-- =========================================
-- Q5: Find departments where average salary
--     is greater than overall average salary
-- =========================================
SELECT department, AVG(salary) AS dept_avg_salary
FROM employees_2025
GROUP BY department
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees_2025
);

-- =================================================
-- *************WINDOWS FUNCTIONS ******************
-- =================================================

-- 1.ROW_NUMBER
SELECT name,department,salary,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY  salary DESC)AS RN
FROM employee_2025;
-- 2.RANK()
SELECT name,department,salary,
RANK() OVER(PARTITION BY department ORDER BY  salary DESC)AS r
FROM employee_2025;

-- 3.DENSE_RANK()
SELECT name,department,salary,
DENSE_RANK() OVER(PARTITION BY department ORDER BY  salary DESC)AS r
FROM employee_2025;
-- 4.SUM()
SELECT name,department,salary,
SUM(salary) OVER(PARTITION by department) AS sum_running
FROM employee_2025;
-- 5.total_running()
SELECT name,department,salary,
SUM(salary) OVER(PARTITION by department) AS total_running
FROM employee_2025;
-- 6.LAG() AND LEAD()
SELECT name,department,salary,
LAG(salary) OVER(ORDER BY emp_id)AS PREV_SAL,
LEAD(salary) OVER(ORDER BY emp_id)AS NEXT_SAL
FROM employee_2025;


 
