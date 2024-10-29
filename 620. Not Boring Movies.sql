SELECT * FROM Cinema 
WHERE NOT (id%2 = 0) AND NOT description='boring'
ORDER BY rating DESC;
