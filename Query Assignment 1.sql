use sakila;

-- 1. Find out the PG-13 rated comedy movies. DO NOT use the film_list table. 

select * 
	from film inner join film_category on film.film_id = film_category.film_id 
			inner join category on category.category_id = film_category.category_id
where 
	rating like 'PG-13' and
    category.name = 'Comedy';
    
-- 2. Find out the top 3 rented horror movies. 


select * 
	from film inner join film_category on film.film_id = film_category.film_id 
			inner join category on category.category_id = film_category.category_id
where 
    category.name = 'Horror'
order by 
	rental_duration desc, rental_rate
limit 3;
    
-- 3. Find out the list of customers from India who have rented sports movies.

select customer_list.*
	from customer_list inner join rental on rental.customer_id = customer_list.ID
			inner join inventory on inventory.inventory_id = rental.inventory_id
            inner join film_list on inventory.film_id = film_list.FID
where 
	country = 'India' and
    category = 'Sports';
    
-- 4.  Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.
select customer_list.*, film_list.title
	from customer_list inner join rental on rental.customer_id = customer_list.ID
			inner join inventory on inventory.inventory_id = rental.inventory_id
            inner join film_list on inventory.film_id = film_list.FID
            inner join film_actor on film_list.FID = film_actor.film_id
            inner join actor_info on actor_info.actor_id = film_actor.actor_id
where 
	country = 'Canada' and
    first_name = 'NICK' and last_name = 'WAHLBERG'; 
    
-- 5. Find out the number of movies in which “SEAN WILLIAMS” acted. 

select concat(first_name, concat(" ", last_name)) as full_name, count(*)
	from film_list inner join film_actor on film_list.FID = film_actor.film_id
				inner join actor_info on actor_info.actor_id = film_actor.actor_id
group by
	full_name
having
	full_name = 'SEAN WILLIAMS'
	;