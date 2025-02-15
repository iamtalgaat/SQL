#View with full name
CREATE VIEW v_emp AS
SELECT first_name, last_name FROM employees;

SELECT * FROM v_emp;

#View with full name and current salary
CREATE VIEW v_emp_salary AS
SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
ORDER BY s.salary desc;

SELECT * FROM v_emp_salary;

#View with avg_salary in each department
CREATE VIEW v_dep_salary AS
SELECT de.dept_no, AVG(s.salary) AS avg_dept_salary
FROM dept_emp de
JOIN salaries s
ON de.emp_no = s.emp_no
GROUP BY de.dept_no
ORDER BY avg_dept_salary desc;

SELECT * FROM v_dep_salary;

#View with all employees from Sales department
CREATE VIEW v_emp_sales AS
SELECT e.*
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SELECT * FROM v_emp_sales;
