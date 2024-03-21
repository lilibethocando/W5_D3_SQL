--Week 5 - Wednesday Questions

--1. List all customers with their address who live in Texas (use JOINs)

SELECT c.first_name, c.last_name, a.district
FROM customer c 
JOIN address a ON c.address_id = a.address_id 
WHERE district = 'Texas';

--2. List all payments of more than $7.00 with the customer’s first and last name

SELECT c.first_name, c.last_name, p.amount AS Amount
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
WHERE p.amount > 7; --There are 1406 payments with amount greater than $7.00

--3. Show all customer names who have made over $175 in payments (usesubqueries)

SELECT concat(c.first_name,' ', c.last_name) AS Name, sum(p.amount) AS "Total amount"
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY Name
HAVING  sum(p.amount) > 175
ORDER BY "Total amount" DESC;

--Answer:
--Name, Total amount
--Eleanor Hunt	211.55
--Karl Seal	208.58
--Marion Snyder	194.61
--Rhonda Kennedy	191.62
--Clara Shaw	189.60
--Tommy Collazo	183.63

--4. List all customers that live in Argentina (use multiple joins)

SELECT concat(c.first_name,' ', c.last_name) AS Name
FROM customer c 
JOIN address a ON c.address_id = a.address_id 
JOIN city c2 ON a.city_id = c2.city_id 
JOIN country c3 ON c2.country_id = c3.country_id 
WHERE c3.country = 'Argentina';

--5. Show all the film categories with their count in descending order

SELECT c.category_id , c."name", count(fc.film_id) 
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id
ORDER BY count(fc.film_id) DESC;


--6. What film had the most actors in it (show film info)?

SELECT f.film_id, f.title, count(fa.actor_id) 
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id 
GROUP BY f.film_id
ORDER BY count(fa.actor_id) DESC
LIMIT 1;

--7. Which actor has been in the least movies?


SELECT concat(a.first_name,' ', a.last_name), count(f.film_id) 
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id 
GROUP BY a.actor_id 
ORDER BY count(f.film_id)
LIMIT 1;

--8. Which country has the most cities?

SELECT c2.country_id, c2.country, count(c.city_id) 
FROM city c 
JOIN country c2 ON c.country_id = c2.country_id 
GROUP BY c2.country_id 
ORDER BY count(c.city_id) DESC
LIMIT 3;

--9. List the actors who have been in between 20 and 25 films.
SELECT concat(a.first_name,' ', a.last_name), count(f.film_id) 
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id 
GROUP BY a.actor_id 
HAVING count(f.film_id) BETWEEN 20 AND 25
ORDER BY count(f.film_id) DESC;
