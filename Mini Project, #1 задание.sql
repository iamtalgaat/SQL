#1 ЗАДАНИЕ

CREATE DATABASE users_adverts;

CREATE TABLE users (
	date DATE,
    user_id VARCHAR(100),
    view_adverts INT NOT NULL
    );
    
#1) Unique users between 2023-11-07 and 2023-11-15
SELECT COUNT(DISTINCT user_id) AS count
FROM users
WHERE date BETWEEN '2023-11-07' AND '2023-11-15';

#2) User with max seen adverts
SELECT user_id, MAX(view_adverts) AS Max_view_adverts
FROM users
GROUP BY user_id
ORDER BY Max_view_adverts DESC
LIMIT 1;

#3) The date with the max avg number of view adverts
SELECT date, AVG(view_adverts) AS avg_view_adverts
FROM users
GROUP BY date
HAVING COUNT(DISTINCT user_id) > 500
ORDER BY Avg_view_adverts DESC
LIMIT 1;

#4) Active days of users
SELECT user_id, COUNT(DISTINCT date) AS active_days
FROM users
GROUP BY user_id
ORDER BY active_days DESC;

#5) Avg count of view adverts of the users who is active 5 different days
WITH user_daily_ad_views AS (
	SELECT user_id, date, COUNT(view_adverts) AS daily_ad_views
    FROM users
    GROUP BY user_id, date),
user_average_ad_views AS (
	SELECT user_id, AVG(daily_ad_views) AS avg_daily_ad_views,
    COUNT(date) AS active_days
    FROM user_daily_ad_views
    GROUP BY user_id
    HAVING COUNT(date) >= 5)
SELECT user_id, avg_daily_ad_views
FROM user_average_ad_views
ORDER BY avg_daily_ad_views DESC
LIMIT 1;


