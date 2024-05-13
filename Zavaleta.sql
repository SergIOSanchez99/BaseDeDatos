USE sakila;
/*1.  Elaborar una consulta que me permita saber la cantidad de películas
alquiladas por año, agrupados por categoría (nota: se desea saber la cantidad
de películas, no la cantidad de alquileres de esa película)*/

SELECT 
	'Practica01_Preg01',
    YEAR(r.rental_date) AS Año,
    cat.name AS  'Tipo de categoria',
    COUNT(DISTINCT f.film_id) AS 'Cantidad de peliculas alquiladas por año'
FROM 
    rental r
INNER JOIN 
    inventory i ON r.inventory_id = i.inventory_id
INNER JOIN 
    film f ON i.film_id = f.film_id
INNER JOIN 
    film_category  fcat ON f.film_id = fcat.film_id
INNER JOIN 
    category cat ON fcat.category_id = cat.category_id
GROUP BY cat.name,  YEAR(r.rental_date)
ORDER BY YEAR(r.rental_date),f.film_id DESC;
/*
2.  Generar
una consulta que obtenga la información de las películas que duran entre 80 y
120 minutos y categorice el presupuesto de acuerdo a la cantidad de actores en bajo
(1 a 2), medio (3 a 5) y alto más de 5,se requiere solo de aquellas películas alquiladas
por clientes que viven en la India.
*/

SELECT 
	'Practica01_Preg02',
    f.title AS Pelicula,
    f.length AS Duracion,
    co.country as 'Pais',
    COUNT(DISTINCT fa.actor_id) AS Cantidad_de_actores,
    CASE
        WHEN f.length BETWEEN 80 AND 120 THEN
            CASE
                WHEN COUNT(DISTINCT fa.actor_id) BETWEEN 1 AND 2 THEN 'BAJO'
                WHEN COUNT(DISTINCT fa.actor_id) BETWEEN 3 AND 5 THEN 'MEDIO'
                ELSE 'ALTO'
            END
        ELSE NULL
    END AS Presupuesto
FROM 
    film f
JOIN
    film_actor fa ON f.film_id = fa.film_id 
JOIN
    actor ac ON fa.actor_id = ac.actor_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    customer c ON r.customer_id = c.customer_id
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id
WHERE 
    co.country = 'India' 
    AND f.length BETWEEN 80 AND 120
GROUP BY
    f.title,f.length
ORDER BY
    Cantidad_De_Actores;

SELECT *
From actor
where last_name like 'A%'
order by last_name;
