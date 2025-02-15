#1
WITH Monthly_Transactions AS (
    SELECT 
        ID_client,
        DATE_FORMAT(date_new, '%Y-%m') AS month,
        AVG(Sum_payment) AS avg_check,
        SUM(Sum_payment) AS total_monthly,
        COUNT(*) AS transaction_count
    FROM 
        transaction_info
    WHERE 
        date_new BETWEEN '2015-06-01' AND '2016-06-01'
    GROUP BY 
        ID_client, DATE_FORMAT(date_new, '%Y-%m')
),
Full_Year_Clients AS (
    SELECT 
        ID_client
    FROM 
        Monthly_Transactions
    GROUP BY 
        ID_client
    HAVING 
        COUNT(DISTINCT month) = 12
)
SELECT 
    mt.ID_client,
    mt.month,
    mt.avg_check,
    mt.total_monthly,
    mt.transaction_count
FROM 
    Monthly_Transactions mt
JOIN 
    Full_Year_Clients fyc ON mt.ID_client = fyc.ID_client
ORDER BY 
    mt.ID_client, mt.month;

#2
SELECT 
    DATE_FORMAT(date_new, '%Y-%m') AS month,
    AVG(Sum_payment) AS avg_check,
    COUNT(*) AS transaction_count,
    COUNT(DISTINCT ID_client) AS unique_clients
FROM 
    transaction_info
WHERE 
    date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY 
    month;


SELECT 
    c.Gender,
    COUNT(*) AS count,
    SUM(t.Sum_payment) AS total_payment
FROM 
    customer_info c
JOIN transaction_info t ON c.Id_client = t.Id_client
GROUP BY 
    Gender;
#3
WITH Age_Groups AS (
    SELECT 
        CASE 
            WHEN AGE IS NULL THEN 'Unknown'
            WHEN AGE BETWEEN 0 AND 9 THEN '0-9'
            WHEN AGE BETWEEN 10 AND 19 THEN '10-19'
            WHEN AGE BETWEEN 20 AND 29 THEN '20-29'
            WHEN AGE BETWEEN 30 AND 39 THEN '30-39'
            WHEN AGE BETWEEN 40 AND 49 THEN '40-49'
            WHEN AGE BETWEEN 50 AND 59 THEN '50-59'
            WHEN AGE BETWEEN 60 AND 69 THEN '60-69'
            WHEN AGE BETWEEN 70 AND 79 THEN '70-79'
            ELSE '80+'
        END AS age_group,
        c.ID_client,
        c.Total_amount
    FROM 
        customer_info c
),
Client_Transactions AS (
    SELECT 
        ID_client,
        COUNT(*) AS transaction_count,
        SUM(Sum_payment) AS total_payment
    FROM 
        transaction_info
    WHERE 
        date_new BETWEEN '2015-06-01' AND '2016-06-01'
    GROUP BY 
        ID_client
)
SELECT 
    ag.age_group,
    COUNT(ag.ID_client) AS client_count,
    COALESCE(AVG(ct.total_payment), 0) AS avg_total_payment,
    COALESCE(AVG(ct.transaction_count), 0) AS avg_transaction_count,
    ROUND(100 * COALESCE(SUM(ct.total_payment), 0) / (SELECT SUM(total_payment) FROM Client_Transactions), 2) AS percent_of_total_payment,
    ROUND(100 * COALESCE(SUM(ct.transaction_count), 0) / (SELECT SUM(transaction_count) FROM Client_Transactions), 2) AS percent_of_total_transactions
FROM 
    Age_Groups ag
LEFT JOIN 
    Client_Transactions ct ON ag.ID_client = ct.ID_client
GROUP BY 
    ag.age_group
ORDER BY 
    ag.age_group;

