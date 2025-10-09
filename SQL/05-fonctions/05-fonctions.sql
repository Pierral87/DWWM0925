------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
----------------------- FONCTIONS PREDEFINIES --------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------


-- DOC SQL : https://sql.sh/ 
-- Ici quelques exemples de fonctions prédéfinies de MySQL

-- Il en existe quelques dizaines (c'est assez peu comparé à un "vrai" langage de programmation tel que JS ou PHP qui en contiennent des centaines/milliers)

-- ATTENTION jamais d'espace entre le nom de la fonction et les parenthèses 

USE bibliotheque;

SELECT DATABASE(); -- Me retourne le nom de la base actuellement sélectionnée

-----------------------------------------------------------------
-- Quelques fonctions de chaine de caractère 

-- CONCAT() : Permet de concaténer (faire suivre) des informations 

SELECT CONCAT ("a", "b", "c");

SELECT CONCAT(id_abonne, " - ", prenom) FROM abonne; -- Je mets à la suite dans une seule colonne du résultat, l'id et le prenom de l'abonne 

SELECT CONCAT_WS(" - ", "a", "b", "c"); -- CONCAT_WS  (With Separator) me permet de faire suivre des informations en les séparant par le séparateur que je fourni en premier paramètre, ici un tiret 

SELECT SUBSTRING("bonjour", 4); -- Permet de couper une chaine de caractères, plusieurs possibilités de syntaxe (voir doc)

SELECT UPPER("coucou"); -- Permet de renvoyer la chaine de caractères tout en majuscule

SELECT LENGTH("bonjour"); -- Me retourne le nombre de caractères 

--------------------------------------------------------------------
-- Quelques fonctions en rapport avec les dates 

DATE_ADD -- Permet d'ajouter un intervale de temps à un type date 
SELECT DATE_ADD(CURDATE(), INTERVAL 21 DAY);
SELECT DATE_ADD(CURDATE(), INTERVAL 2 WEEK);
SELECT DATE_ADD(CURDATE(), INTERVAL 2 MONTH);
SELECT DATE_ADD(CURDATE(), INTERVAL 2 YEAR);

SELECT CURDATE(); -- La date du jour 
SELECT CURTIME(); -- L'heure de maintenant
SELECT NOW();     -- La date et l'heure
SELECT CURRENT_TIMESTAMP; -- le Timestamp c'est l'an 0 informatique, c'est l'horodatage UNIX, le nombre de seconde écoulées depuis le 1er Janvier 1970, au travers desquelles on représente une date 
                            -- Dans certains SGBD, on a pas NOW(), mais on a CURRENT_TIMESTAMP

SELECT UNIX_TIMESTAMP(NOW());

DATE_FORMAT() 
    -- DATE_FORMAT est une fonction qui nous permet de formater au format de notre choix, une date par défaut le format c'est YYYY-MM-DD, on peut par exemple le formater en DD/MM/YYYY
        -- Voir doc pour le format 
        -- DATE_FORMAT(date, format)

SELECT DATE_FORMAT(NOW(), "%d/%m/%Y");
