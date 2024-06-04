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

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- JOIN

-- 1 - Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
SELECT DISTINCT
    P.*
FROM `players` AS P
    INNER JOIN `reviews` AS R ON P.id = R.`player_id`;

-- 2 - Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
SELECT DISTINCT
    V.`id` AS videogame_id,
    V.`name` AS videogame_name,
    T.`year` AS tournament_year
FROM
    `videogames` AS V
    INNER JOIN `tournament_videogame` AS TV ON V.id = TV.`videogame_id`
    INNER JOIN `tournaments` AS T ON T.id = TV.`tournament_id`
WHERE
    T.`year` = 2016;

-- 3 - Mostrare le categorie di ogni videogioco (1718)
SELECT
    C.`name` AS category_name,
    V.`name` AS videogame_name
FROM
    `categories` AS C
    INNER JOIN `category_videogame` CV ON C.`id` = CV.`category_id`
    INNER JOIN `videogames` AS V ON V.`id` = CV.`videogame_id`;

-- 4 - Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
SELECT DISTINCT
    SH.*
FROM
    `software_houses` AS SH
    INNER JOIN `videogames` AS V ON SH.`id` = V.`software_house_id`
WHERE
    YEAR(V.`release_date`) >= 2020;

-- 5 - Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
SELECT V.`name` AS videogame_name, A.`name` AS award_name
FROM
    `awards` AS A
    INNER JOIN `award_videogame` AS AV ON A.`id` = AV.`award_id`
    INNER JOIN `videogames` AS V ON V.`id` = AV.`videogame_id`;

-- 6 - Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
SELECT DISTINCT
    C.`name` AS category_name,
    P.`name` AS pegi_name,
    V.`name` AS videogame
FROM
    `videogames` AS V
    INNER JOIN `reviews` AS R ON V.`id` = R.`videogame_id`
    INNER JOIN `category_videogame` AS VC ON V.`id` = VC.`videogame_id`
    INNER JOIN `categories` AS C ON VC.`category_id` = C.`id`
    INNER JOIN `pegi_label_videogame` AS PV ON V.`id` = PV.`videogame_id`
    INNER JOIN `pegi_labels` AS P ON P.`id` = PV.`pegi_label_id`
WHERE
    R.`rating` IN (4, 5);

-- 7 - Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
SELECT DISTINCT
    V.`name` AS videogame
FROM
    `videogames` AS V
    JOIN `tournament_videogame` AS TV ON V.`id` = TV.`videogame_id`
    JOIN `tournaments` AS T ON T.`id` = TV.`tournament_id`
    JOIN `player_tournament` AS PT ON T.`id` = PT.`tournament_id`
    JOIN `players` AS P ON P.`id` = PT.`player_id`
WHERE
    P.`name` LIKE 'S%';

-- 8 - Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
SELECT DISTINCT
    T.city,
    V.`name`
FROM
    `tournaments` AS T
    JOIN `tournament_videogame` AS TV ON T.`id` = TV.`tournament_id`
    JOIN `videogames` AS V ON V.`id` = TV.`videogame_id`
    JOIN `award_videogame` AS AV ON V.`id` = AV.`videogame_id`
    JOIN `awards` AS A ON A.`id` = AV.`award_id`
WHERE
    A.`name` = 'Gioco dell\'anno'
    AND YEAR(V.`release_date`) = 2018;

-- 9 - Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (991)
SELECT DISTINCT
    P.`name` player_name,
    P.`lastname` AS player_lastname,
    V.`name` AS videogame,
    YEAR(V.`release_date`) AS videogame_release_date,
    T.`year` AS tournament_year
FROM
    `players` AS P
    JOIN `player_tournament` AS PT ON P.`id` = PT.`player_id`
    JOIN `tournaments` AS T ON T.`id` = PT.`tournament_id`
    JOIN `tournament_videogame` AS TV ON T.`id` = TV.`tournament_id`
    JOIN `videogames` AS V ON V.`id` = TV.`videogame_id`
    JOIN `award_videogame` AS AV ON V.`id` = AV.`videogame_id`
    JOIN `awards` AS A ON A.`id` = AV.`award_id`
WHERE
    A.`name` = 'Gioco più atteso'
    AND YEAR(V.`release_date`) = 2018
    AND T.`year` = 2019;