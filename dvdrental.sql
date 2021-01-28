--SQL project: Data Analysis of DVD Rental Company
--Name: Anh Nguyen
--Date: January 20, 2021

--Question 1a: What are the total sales of each store?
--Store>Staff>Payment
SELECT s.store_id, 
	SUM(p.amount) as total_sales
FROM store s
JOIN staff sf
USING (store_id)
JOIN payment p
USING (staff_id)
GROUP BY s.store_id;

-- Question 1b: What are weekly sales of each store?
SELECT  sub.week,
	SUM (CASE WHEN sub.store = 1 THEN sub.sale ELSE NULL END) AS store_1_sales,
	SUM (CASE WHEN sub.store = 2 THEN sub.sale ELSE NULL END) AS store_2_sales
FROM
	(SELECT s.store_ID AS store, DATE_TRUNC ('week', p.payment_date) as week, p.amount AS sale
		FROM store s
		JOIN staff sf
		USING (store_id)
		JOIN payment p
		USING (staff_id)) sub
GROUP BY 1
ORDER BY 1;
		  	       
-- Quetion 1c: Which genres are the most popular by each store
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
		       
--Question 2a: What are the most and the least rented film genres by demands? What are the total sales of each genre?
-- Category>film_category>film>inventory>rental>customer>payment
SELECT c.name AS genres, COUNT (cu.customer_id) AS total_demand, SUM(p.amount) as total_sales
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

--Question 2b: How many distinct cucstomers for each genre?
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
			ORDER BY 2 DESC; 
       
-- Question 3a: How many rented films are returned late, early, and on time for both stores and each store?
--rental>inventory>film
SELECT i.store_id,
	   COUNT (CASE WHEN r.date_differ > f.rental_duration THEN f.film_id END) AS returned_late, 
	   COUNT (CASE WHEN r.date_differ = f.rental_duration THEN f.film_id END) AS returned_on_time,
	   COUNT (CASE WHEN r.date_differ < f.rental_duration THEN f.film_id END) AS returned_early
FROM (SELECT *, EXTRACT ('day' FROM return_date - rental_date) AS date_differ	
	FROM rental) r
JOIN inventory i
USING (inventory_id)
JOIN film f
USING (film_id)
GROUP BY 1	
		       
-- Question 3b: Where are the customers from per store?
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
LIMIT 10;

-- Question 3c: Who are the top 10 customers spent the most on rental? List of their address
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
ORDER BY 7 DESC; 
