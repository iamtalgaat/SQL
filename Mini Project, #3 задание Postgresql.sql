--1) Count of users who added audiobook 'Coraline'
SELECT COUNT(user_id) AS user_count
FROM audio_cards ac
JOIN audiobooks a
ON ac.audiobook_uuid = a.uuid
WHERE title = 'Coraline'
AND progress > duration - duration * 0.9;


--2) Total listening hours of the users
SELECT l.os_name, a.title, COUNT(DISTINCT l.user_id) AS user_count,
FLOOR(SUM((l.position_to - l.position_from)/3600.0)) AS total_listening_hours
FROM listenings l
JOIN audiobooks a
ON l.audiobook_uuid = a.uuid
WHERE l.is_test = 0
GROUP BY l.os_name, a.title;


--3) The most listened audiobook
SELECT a.title, COUNT(user_id) AS user_count
FROM audiobooks a
JOIN audio_cards ac
ON a.uuid = ac.audiobook_uuid
GROUP BY a.title
ORDER BY user_count DESC
LIMIT 1;


--4) The audiobook which was mostly listened till the end
SELECT a.title, COUNT(user_id) AS user_count
FROM audiobooks a
JOIN audio_cards ac
ON a.uuid = ac.audiobook_uuid
WHERE ac.state = 'finished'
GROUP BY a.title
ORDER BY user_count DESC
LIMIT 1;

