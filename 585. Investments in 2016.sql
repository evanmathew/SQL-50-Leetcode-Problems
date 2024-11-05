-- Problems:

/*
Table: Insurance

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.

 

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

    have the same tiv_2015 value as one or more other policyholders, and
    are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).

Round tiv_2016 to two decimal places.

The result format is in the following example.

 

Example 1:

Input: 
Insurance table:
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
+-----+----------+----------+-----+-----+
Output: 
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+
Explanation: 
The first record in the table, like the last record, meets both of the two criteria.
The tiv_2015 value 10 is the same as the third and fourth records, and its location is unique.

The second record does not meet any of the two criteria. Its tiv_2015 is not like any other policyholders and its location is the same as the third record, which makes the third record fail, too.
So, the result is the sum of tiv_2016 of the first and last record, which is 45.


*/


--------------------------------------------------------------------------

-- Answers:

WITH unique_lan_lon_values AS (
    SELECT i1.pid
    FROM Insurance i1
    JOIN Insurance i2 
    ON i1.lat = i2.lat AND i1.lon = i2.lon 
    AND i1.pid != i2.pid
), 
same_tiv_value AS (
    SELECT i1.pid
    FROM Insurance i1
    JOIN Insurance i2 
    ON i1.tiv_2015 = i2.tiv_2015 
    AND i1.pid != i2.pid
)

SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 
FROM Insurance
WHERE pid NOT IN (SELECT pid FROM unique_lan_lon_values)  
AND pid IN (SELECT pid FROM same_tiv_value);  
