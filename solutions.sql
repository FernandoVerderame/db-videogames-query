-- SELECT

-- 1- Selezionare tutte le software house americane (3)
SELECT * FROM `software_houses` WHERE `country` = 'United States';

-- 2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)
SELECT * FROM `players` WHERE `city` = 'Rogahnland';

-- 3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)
SELECT * FROM `players` WHERE `name` LIKE '%a';

-- 4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)
SELECT * FROM `reviews` WHERE `player_id` = 800;

-- 5- Contare quanti tornei ci sono stati nell'anno 2015 (9)
SELECT COUNT(*) AS total_tournaments_2015
FROM `tournaments`
WHERE
    `year` = 2015;

-- 6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)
SELECT * FROM `awards` WHERE `description` LIKE '%facere%';

-- 7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)
SELECT DISTINCT
    `videogame_id` AS videogames_2_6
FROM `category_videogame`
WHERE
    `category_id` = 2
    OR `category_id` = 6;

-- 8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)
SELECT * FROM `reviews` WHERE `rating` >= 2 AND `rating` <= 4;

-- 9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
SELECT * FROM `videogames` WHERE YEAR(`release_date`) = 2020;

-- 10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da 5 stelle, mostrandoli una sola volta (443)
SELECT DISTINCT
    `videogame_id` AS videogame
FROM `reviews`
WHERE
    `rating` >= 5;

-- * * * * * * * * * * * BONUS * * * * * * * * * * *

-- 11 - Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3.16 circa)
SELECT COUNT(`videogame_id`) AS review_number, AVG(`rating`) AS avg_rating
FROM `reviews`
WHERE
    `videogame_id` = 412;

-- 12 - Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)
SELECT COUNT(*) AS videogames_number
FROM `videogames`
WHERE
    `software_house_id` = 1
    AND YEAR(`release_date`) = 2018;

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- GROUP BY

-- 1 - Contare quante software house ci sono per ogni paese (3)
SELECT
    `country`,
    COUNT(*) AS total_software_houses
FROM `software_houses`
GROUP BY
    `country`;

-- 2 - Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l 'ID) (500)
SELECT COUNT(*) AS total_reviews, `videogame_id`
FROM `reviews`
GROUP BY
    `videogame_id`;

-- 3 - Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
SELECT
    `pegi_label_id`,
    COUNT(*) AS total_videogames
FROM `pegi_label_videogame`
GROUP BY
    `pegi_label_id`;

-- 4 - Mostrare il numero di videogiochi rilasciati ogni anno (11)
SELECT YEAR(`release_date`) AS year, COUNT(*) AS released_videogames
FROM `videogames`
GROUP BY
    YEAR(`release_date`);

-- 5 - Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l 'ID) (7)
SELECT `device_id`, COUNT(*) AS total_videogames
FROM `device_videogame`
GROUP BY
    `device_id`;

-- 6 - Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l' ID) (500)
SELECT `videogame_id`, AVG(`rating`) AS avg_rating
FROM `reviews`
GROUP BY
    `videogame_id`
ORDER BY avg_rating DESC;