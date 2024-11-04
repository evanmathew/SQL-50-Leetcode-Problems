/*
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.

 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.

Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 

 

Write a solution to:

    Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
    Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

The result format is in the following example.
*/

--------------------------------------------------------------------------------------------------

--Answers

WITH count_rating_user AS(
    SELECT u.user_id ,u.name, COUNT(mr.movie_id) AS counted_reviews
    FROM Users u
    LEFT JOIN MovieRating mr ON mr.user_id = u.user_id
    GROUP BY u.user_id),


highest_avg_rating AS(
    SELECT m.title, AVG(mr.rating) AS avg_rating
    FROM Movies m
    LEFT JOIN Movierating mr ON mr.movie_id=m.movie_id
    WHERE MONTH(mr.created_at) = 2 AND YEAR(mr.created_at) = 2020
    GROUP BY m.movie_id
    ORDER BY m.title  
)

SELECT results
FROM (
    SELECT name AS results
    FROM count_rating_user
    WHERE counted_reviews = (SELECT MAX(counted_reviews) FROM count_rating_user)
    ORDER BY name
    LIMIT 1
) AS top_user

UNION ALL

SELECT results
FROM (
    SELECT title AS results
    FROM highest_avg_rating
    WHERE avg_rating = (SELECT MAX(avg_rating) FROM highest_avg_rating)
    ORDER BY title
    LIMIT 1
) AS top_movie;
