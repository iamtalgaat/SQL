#Определение наивысшей текущей зарплаты в каждом отделе
SELECT s.emp_no, s.salary, de.dept_no, MAX(salary) OVER (PARTITION BY de.dept_no) AS max_salary_in_dept
FROM dept_emp de
JOIN salaries s
ON de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01';

#Сравнение зарплаты каждого сотрудника с средней зарплатой в их отделе
SELECT s.emp_no, s.salary, de.dept_no, AVG(salary) OVER (PARTITION BY de.dept_no) AS avg_salary_in_dept
FROM dept_emp de
JOIN salaries s
ON de.emp_no = s.emp_no
LIMIT 10000;

#Ранжирование сотрудников в отделе по стажу работы
SELECT e.emp_no, de.dept_no, e.hire_date, 
DENSE_RANK() OVER (PARTITION BY de.dept_no ORDER BY e.hire_date) AS experience_rank
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no;

#Нахождение следующей должности каждого сотрудника
SELECT emp_no, title, 
LEAD(title, 1, 'N/A') OVER (PARTITION BY emp_no ORDER BY emp_no) AS next_title
FROM titles;

#Определение начальной и последней зарплаты сотрудника
SELECT emp_no, salary AS current_salary,
FIRST_VALUE(salary) OVER (PARTITION BY emp_no ORDER BY from_date) AS first_salary,
LAST_VALUE(salary) OVER (PARTITION BY emp_no ORDER BY from_date) AS last_salary
FROM salaries;

#Вычислить скользящее среднее зарплаты для каждого сотрудника
SELECT emp_no, from_date, salary, 
AVG(salary) OVER (PARTITION BY emp_no ORDER BY salary ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM salaries
LIMIT 1000;
