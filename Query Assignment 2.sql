use sakila;

-- 1. Find out the number of documentaries with deleted scenes.

select count(*) 
	from film inner join film_list on film_id = FID
where 
	special_features like '%Deleted Scenes%' and 
	category = 'Documentary';
    
-- 2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.

select count(*)
	from staff inner join store on manager_staff_id = staff.staff_id
			inner join rental on rental.staff_id = staff.staff_id
            inner join inventory on inventory.inventory_id = rental.inventory_id
            inner join film_list on FID = film_id
where
	first_name = 'Jon' and
    last_name = 'Stephens' and
    category = 'Sci-Fi';
    
-- 3. Find out the total sales from Animation movies. 

select * from sales_by_film_category
where category = 'Animation';

-- 4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.

select category.name
	from customer inner join rental on rental.customer_id = customer.customer_id
				inner join inventory on inventory.inventory_id = rental.inventory_id
                inner join film on inventory.film_id = film.film_id
                inner join film_category on film.film_id = film_category.film_id
                inner join category on category.category_id = film_category.category_id
where
	first_name = 'PATRICIA' and
    last_name = 'JOHNSON'
group by 
	category.name
order by 
	sum(rental_duration) desc
limit 3;

-- 5. Find out the number of R rated movies rented by “SUSAN WILSON”.

select count(*)
	from customer inner join rental on rental.customer_id = customer.customer_id
				inner join inventory on inventory.inventory_id = rental.inventory_id
                inner join film on inventory.film_id = film.film_id
                inner join film_category on film.film_id = film_category.film_id
                inner join category on category.category_id = film_category.category_id
where
	first_name = 'SUSAN' and
    last_name = 'WILSON' and rating = 'R';
