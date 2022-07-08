	
-- 1. Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq 
	SELECT c.name as NOME, c.area as AREA
	FROM countries c 
	WHERE name LIKE 'P%' AND area > 1000
	;
	
-- 2. Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
    SELECT *
    FROM countries c 
    WHERE TIMESTAMPDIFF(YEAR, national_day , CURDATE()) > 100
    ;
    
 -- 3. Selezionare il nome delle regioni del continente europeo, in ordine alfabetico 
   SELECT r.name, c.name
   FROM regions r  
   INNER JOIN continents c 
   ON c.continent_id 
   WHERE c.name = 'Europe'
   ORDER BY c.name 
   ;
 
 -- 4. Contare quante lingue sono parlate in Italia
   SELECT COUNT(c.country_id), c.name
   FROM countries c 
   INNER JOIN country_languages cl 
   ON c.country_id = cl.country_id 
   INNER JOIN languages l 
   ON cl.country_id = l.language_id 
   WHERE c.name = 'Italy'
   ;
   
-- 5. Selezionare quali nazioni non hanno un national day 
   SELECT name, national_day 
   FROM countries
   WHERE national_day IS NULL 
   ;
  
--  6. Per ogni nazione selezionare il nome, la regione e il continente
   SELECT c.name, r.name ,c2.name
   FROM countries c 
   INNER JOIN regions r
   ON c.region_id  = r.region_id 
   INNER JOIN continents c2 
   ON r.region_id = c2.continent_id 
   ;
  
--  7. Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
   UPDATE countries  
   SET  national_day = '1946-06-02' WHERE name = 'Italy'
   ;

--  8. Per ogni regione mostrare il valore dell'area totale 
    SELECT r.name, SUM(c.area)  
    FROM regions r 
    INNER JOIN countries c 
    ON r.region_id = c.region_id 
    GROUP BY r.name 
   ;
   
-- 9. Selezionare le lingue ufficiali dell'Albania
   SELECT c.name, cl.official, l.`language` 
   FROM country_languages cl 
   INNER JOIN countries c 
   ON cl.country_id = c.country_id 
   INNER JOIN languages l 
   ON l.language_id = cl.language_id 
   WHERE c.name = 'Albania' AND cl.official = 1
   ;
   
--  10. Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
   SELECT c.name, avg(cs.gdp) 
   FROM country_stats cs 
   INNER JOIN countries c 
   ON cs.country_id = c.country_id 
   WHERE c.name = 'United Kingdom' AND cs.`year` >= 2000 AND cs.`year` <= 2010
   
-- 11. Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
   SELECT c.name, c.area, l.`language` 
   FROM countries c
   INNER JOIN country_languages cl
   ON c.country_id = cl.country_id
   INNER JOIN `languages` l 
   ON l.language_id = cl.language_id
   WHERE l.`language` LIKE 'Hindi'
   ORDER BY c.area DESC;

-- 12. Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire dal continente che ne ha di più
   SELECT c.name as continent, COUNT(c2.country_id) as countries_over_10k
   FROM continents c
   INNER JOIN regions r
   ON c.continent_id = r.continent_id 
   INNER JOIN countries c2
   ON c2.region_id = r.region_id 
   WHERE c2.area > 10000
   GROUP BY continent
   ORDER BY countries_over_10k DESC
   


  
   
   
  
    
 
  
  