#List of Managers
SELECT d.emp_no, d.dept_no, e.first_name, e.last_name, e.hire_date
FROM dept_manager d
JOIN employees e
ON d.emp_no = e.emp_no;

#The time period When Markovitch was Manager
SELECT e.first_name, e.last_name, d.dept_no, t.*
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
JOIN dept_manager d
ON e.emp_no = d.emp_no
WHERE last_name = 'Markovitch'
HAVING title = 'Manager';

#List of employees whose first name starts with M and last name ends with N
SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
WHERE first_name LIKE 'M%' AND last_name LIKE '%N'
ORDER BY hire_date;

#MIN/MAX salary of employees with temporary table
DROP TEMPORARY TABLE IF EXISTS salaries_temp;
CREATE TEMPORARY TABLE salaries_temp
SELECT emp_no, MIN(salary) AS min_salary, MAX(salary) AS max_salary FROM salaries
GROUP BY emp_no;

SELECT * FROM salaries_temp;

SELECT e.first_name, e.last_name, s.*
FROM employees e
JOIN salaries_temp s
ON e.emp_no = s.emp_no;
