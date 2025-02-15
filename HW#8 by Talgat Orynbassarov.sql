#Count of gender
SELECT gender, COUNT(gender) as count
FROM employees
GROUP BY gender
ORDER BY count desc;

#AVG Salary of the positions
SELECT t.title, ROUND(AVG(s.salary), 2) AS avg_salary
FROM titles t
JOIN salaries s
ON t.emp_no = s.emp_no
GROUP BY t.title
ORDER BY avg_salary DESC;

#Count of employees by months
SELECT MONTH(hire_date) AS hire_month, count(emp_no) AS count
FROM employees
GROUP BY MONTH(hire_date)
ORDER BY MONTH(hire_date);

#List of employees who's still working
SELECT e.first_name, e.last_name, d.dept_name, t.title
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
JOIN titles t
ON e.emp_no = t.emp_no
WHERE YEAR(t.to_date) = 9999;

#Same last_name
SELECT e1.emp_no, e1.first_name, e1.last_name, e2.emp_no as emp_no2, e2.first_name as first_name2, e2.last_name as last_name2
FROM employees e1
JOIN employees e2
ON e1.last_name = e2.last_name and e1.emp_no <> e2.emp_no;