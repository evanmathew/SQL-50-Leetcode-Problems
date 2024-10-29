SELECT r.contest_id, ROUND((COUNT(DISTINCT r.user_id) / (SELECT COUNT(DISTINCT user_id) FROM Users)) * 100, 2) AS percentage
FROM Users u
LEFT JOIN Register r ON u.user_id = r.user_id 
GROUP BY r.contest_id
ORDER BY percentage DESC, contest_id ASC
