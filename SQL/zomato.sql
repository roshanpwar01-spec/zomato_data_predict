use zomato;

CREATE TABLE restaurants (
    name VARCHAR(255),
    online_order VARCHAR(3),
    book_table VARCHAR(3),
    rate DECIMAL(2,1),
    votes INT,
    approx_cost INT,
    restaurant_type VARCHAR(50)
);
 select * from restaurants;
 
 -- Avg rating by restaurant type
 
 select restaurant_type,round(avg(rate),2) as avg_rating,
 count(*) as total from restaurants group by restaurant_type order by avg_rating DESC;
 
 -- Online order impact on rating
 
SELECT online_order, ROUND(AVG(rate),2) AS avg_rating, ROUND(AVG(votes),0) AS avg_votes
FROM restaurants GROUP BY online_order;

-- table booking impoct

select book_table, round(avg(rate),2) as avg_rating,
round(avg(approx_cost),0) as avg_cost 
from restaurants group by book_table;

-- Top 10 most-voted restaurants
SELECT name, votes, rate, restaurant_type FROM restaurants ORDER BY votes DESC LIMIT 10;

-- Cost bucket vs rating
SELECT 
  CASE WHEN approx_cost < 300 THEN 'Budget'
       WHEN approx_cost < 600 THEN 'Mid-range'
       ELSE 'Premium' END AS cost_bucket,
  ROUND(AVG(rate),2) AS avg_rating, COUNT(*) AS total
FROM restaurants GROUP BY cost_bucket;
