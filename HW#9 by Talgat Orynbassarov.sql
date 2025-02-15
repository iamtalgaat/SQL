#All employees who worked in several departments
SELECT first_name, last_name FROM employees
WHERE emp_no IN (
SELECT emp_no FROM dept_emp
GROUP BY emp_no
HAVING COUNT(dept_no) > 1)
ORDER BY first_name;

#Highest paid employee
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE (e.emp_no, s.salary) IN (
SELECT e.emp_no, MAX(s.salary) AS salary
FROM salaries AS s
JOIN employees AS e
ON s.emp_no = e.emp_no
GROUP BY e.emp_no)
ORDER BY salary desc
LIMIT 1;

#All departments with more than 100 employees
SELECT dept_name FROM departments
WHERE dept_no IN (
SELECT dept_no FROM dept_emp
WHERE emp_no > 100
GROUP BY dept_no
)
;

#All employees who have never been a manager
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
SELECT emp_no FROM titles
WHERE title <> 'Manager'
GROUP BY emp_no
)
;

#Highest paid employees in each department
SELECT e.first_name, e.last_name, de.dept_no, s.salary
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE (de.dept_no, s.salary) IN (
SELECT de.dept_no, MAX(s.salary) AS salary
FROM dept_emp AS de
JOIN salaries AS s
ON de.emp_no = s.emp_no
GROUP BY de.dept_no)
ORDER BY s.salary DESC;

#All departments with an avg salary more than the total avg salary of the company
SELECT de.dept_no, dept_name, AVG(salary) AS avg_dept_salary
FROM dept_emp de
JOIN departments d
ON de.dept_no = d.dept_no
JOIN salaries s
ON de.emp_no = s.emp_no
GROUP BY de.dept_no, d.dept_name
HAVING avg_dept_salary > (SELECT AVG(salary) FROM salaries)
ORDER BY avg_dept_salary DESC; 





