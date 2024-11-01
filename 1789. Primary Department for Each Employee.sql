SELECT e1.employee_id, e1.department_id
FROM Employee e1
LEFT JOIN Employee e2 
ON e1.employee_id = e2.employee_id 
AND e2.primary_flag = 'Y'
WHERE e1.primary_flag = 'Y'
   OR e2.employee_id IS NULL;
