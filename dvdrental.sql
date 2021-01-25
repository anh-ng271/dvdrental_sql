--SQL project: Data Analysis of DVD Rental Company
--Name: Anh Nguyen
--Date: January 20, 2021

-- Dataset: the database has 15 tables 
--Objectives:
	-- What are the most and the least rented movie genres? What are the total sales of each genre? How many time peole rent each genre?
	-- Who are the top customers per ammount paid?
	-- Who are the inactive custommers? When was the last time they have made a rental? 
	-- How many rented films were returned late, early, and on time?
	-- What are the customer base by country?
	-- What are total sales by each store?

--Question 1: What are the most and the least rented film genres by demands? What are the total sales of each genre?
-- Category>film_category>film>inventory>rental>customer>payment
SELECT c.name AS genres, COUNT (cu.customer_id) AS total_demand
			FROM category c
			JOIN film_category fc
			USING (category_id)
			JOIN film f
			USING (film_id)
			JOIN inventory i
			USING (film_id)
			JOIN rental r
			USING (inventory_id)
		    JOIN customer cu 
			USING (customer_id)
			FULL JOIN payment p
		    USING (rental_id)		
			GROUP BY 1
			ORDER BY 2 DESC; 

--How many distinct cucstomers for each genre?
SELECT c.name AS genres, COUNT (DISTINCT cu.customer_id) AS total_demand
			FROM category c
			JOIN film_category fc
			USING (category_id)
			JOIN film f
			USING (film_id)
			JOIN inventory i
			USING (film_id)
			JOIN rental r
			USING (inventory_id)
			JOIN customer cu
			USING (customer_id)
			GROUP BY 1
			ORDER BY 2 DESC 
	  
--Question 1: What are the total sales of each store?
--Store>Staff>Payment
SELECT s.store_id, 
		SUM(p.amount) as total_sales
FROM store s
JOIN staff sf
USING (store_id)
JOIN payment p
USING (staff_id)
GROUP BY s.store_id;

	--What are the difference between store 1 and store 2 by sale per genre?

SELECT i.store_id AS store,
			c.name AS genres, SUM (p.amount) AS total_sales, 
			ROW_NUMBER () OVER (PARTITION BY i.store_id ORDER BY SUM (p.amount) DESC)
		    FROM category c
			JOIN film_category fc
			USING (category_id)
			JOIN film f
			USING (film_id)
			JOIN inventory i
			USING (film_id)
			JOIN rental r
			USING (inventory_id)
		    JOIN payment p 
		    USING (rental_id)
		    GROUP BY 1, 2
		    
-- Where are the customers from per store?
--Inventory>rental>customer>address>city>country

SELECT co.country, COUNT (DISTINCT cu.customer_id) AS total_customers, SUM(p.amount) total_sales
FROM country co 
	JOIN city ci
	USING (country_id)
	JOIN address addr
	USING (city_id)
	JOIN customer cu
	USING (address_id)
	JOIN rental r
	USING (customer_id)
	JOIN inventory i
	USING (inventory_id)
	FULL JOIN payment p
	USING (rental_id)
GROUP BY 1
ORDER BY 2 DESC, 3 DESC 

-- How many rented films are returned late, early, and on time for both stores and each store?

SELECT i.store_id,
	   COUNT (CASE WHEN r.date_differ > f.rental_duration THEN f.film_id END) AS returned_late, 
	   COUNT (CASE WHEN r.date_differ = f.rental_duration THEN f.film_id END) AS returned_on_time,
	   COUNT (CASE WHEN r.date_differ < f.rental_duration THEN f.film_id END) AS returned_early
FROM (SELECT *,
	 		EXTRACT ('day' FROM return_date - rental_date) AS date_differ	
			FROM rental) r
JOIN inventory i
USING (inventory_id)
JOIN film f
USING (film_id)
GROUP BY 1

-- Who are the top 10 customers spent the most on rental? List of their address
--country>city>customer>payment
SELECT cu.customer_id, 
       cu.first_name || ' ' || cu.last_name AS full_name, 
	   cu.email, 
	   ad.address,
	   ci.city, 
	   co.country, 
	   SUM (p.amount) AS amount_spent 
FROM country co
JOIN city ci
USING (country_id)
JOIN address ad
USING (city_id)
JOIN customer cu
USING (address_id)
JOIN payment p
USING (customer_id)
GROUP BY 1,2,3,4,5,6
HAVING SUM (p.amount) >= 150
ORDER BY 7 DESC 


--Who are the inactive customers? When was the last time they rented a movie?























