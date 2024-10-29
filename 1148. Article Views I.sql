select DISTINCT author_id AS id from Views 
where viewer_id = author_id
order by author_id asc
