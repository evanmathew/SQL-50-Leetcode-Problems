WITH CTE AS (
SELECT person_name, SUM(weight) OVER( ORDER BY turn ASC) AS total_weight 
FROM Queue
)

SELECT person_name 
FROM CTE
WHERE total_weight<=1000
ORDER BY total_weight DESC
LIMIT 1
