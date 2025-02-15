#2 ЗАДАНИЕ

#1) Goods type count
SELECT COUNT(DISTINCT goods_type) AS count
FROM t_tab1;

#2) Sum quantity and sum price of mobile phone
SELECT SUM(quantity) AS sum_quantity, SUM(amount) AS sum_price
FROM t_tab1
WHERE goods_type = 'MOBILE PHONE';

#3) List of employees whose salary more than 100000
SELECT name, salary
FROM t_tab2
WHERE salary > 100000;

#4) min/max salary/age
SELECT MIN(age) AS min_age, MAX(age) AS max_age, 
MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM t_tab2;

#5) AvgQuantity of keyboard/printer
SELECT AVG(quantity) AS avg_quantity
FROM t_tab1
WHERE goods_type IN ('KEYBOARD','PRINTER');

#6) Sum price of employees
SELECT seller_name, SUM(quantity*amount) AS sum_price
FROM t_tab1
GROUP BY seller_name;

#7) All information of Mike
SELECT t1.seller_name, t1.goods_type, t1.quantity, 
t1.amount, t2.salary, t2.age
FROM t_tab1 t1
JOIN t_tab2 t2
ON t1.seller_name = t2.name
WHERE t1.seller_name = 'Mike';

#8) The employee who hasn't sold anything
SELECT name, age
FROM t_tab2 t2
LEFT JOIN t_tab1 t1
ON t1.seller_name = t2.name
WHERE t1.id IS NULL;

#9) The name/salary of employee who is younger then 26
SELECT name, salary
FROM t_tab2
WHERE age < 26;

#10) Этот запрос выдает 0 строк, внизу будет правильная версия
SELECT * 
FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';

#Правильная версия
SELECT * 
FROM T_TAB1 t
RIGHT JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';
