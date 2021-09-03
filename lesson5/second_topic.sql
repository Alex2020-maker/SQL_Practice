
-- Практическое задание теме “Агрегация данных”

USE computer_shop;

-- Подсчитайте средний возраст пользователей в таблице users

SELECT
	ROUND(AVG(
		(YEAR(CURRENT_DATE) - YEAR(birthday_at)) - 
		(DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday_at, '%m%d')) 
		)) AS age
 FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.


SELECT 
    weekday(date_format(birthday_at, '2021-%m-%d')) AS day_number, count(*) AS birthdays_qnty
FROM users
GROUP BY weekday(date_format(birthday_at, '2021-%m-%d'))
ORDER BY day_number;


-- Подсчитайте произведение чисел в столбце таблицы
USE test_tbl;

select round(exp((sum(log(value))))) as summ from tbl;



