#Combining employees and managers
SELECT emp_no FROM employees
WHERE gender = 'M'
UNION ALL
SELECT emp_no FROM titles
WHERE title = 'Manager';

#Unique list of titles and dep_names
SELECT title AS unique_list FROM titles
UNION
SELECT dept_name FROM departments;

#Employees with salary more than 60K and less than 40K
SELECT e.first_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE e.emp_no IN (
SELECT s.emp_no FROM salaries AS s
WHERE s.salary > 60000)
UNION
SELECT e.first_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE e.emp_no IN (
SELECT s.emp_no FROM salaries AS s
WHERE s.salary < 40000);

#Combining current and ex employees
SELECT e.first_name, e.last_name, 'Текущий' AS status
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
WHERE to_date = '9999-01-01'
UNION
SELECT e.first_name, e.last_name, 'Бывший' AS status
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
WHERE to_date <> '9999-01-01';

#AVG salaries of managers and ordinary employees
SELECT e.first_name, e.last_name, 'Менеджер' AS type, AVG(s.salary) AS avg_salary
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE t.title = 'Manager'
GROUP BY e.emp_no
UNION
SELECT e.first_name, e.last_name,'Обычный сотрудник' AS type, AVG(s.salary) AS avg_salary
FROM employees e
JOIN titles t
ON e.emp_no = t.emp_no
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE t.title <> 'Manager'
GROUP BY e.emp_no;
