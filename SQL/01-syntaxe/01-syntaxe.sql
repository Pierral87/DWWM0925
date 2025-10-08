-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
---------------- SYNTAXE MYSQL ------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

-- Ceci est un commentaire jusqu'à fin de la ligne 
/* 

    Ceci 
    commentaire
    sur plusieurs
    lignes

*/

-- Attention on évite de mettre les commentaires en SQL (sauf cas spécifiques, fonctions, procédures stockées) car cela peut géner l'import/export 
-- On les mettra plutôt dans le langage de programmation qui manipule le SQL (PHP pour nous)

-- On va manipuler le SQL : MySQL, c'est le plus répandu et le plus utilisé sur le web !  
-- On pourra facilement passer d'un SGBDR à l'autre car leurs syntaxes sont tout à fait identique (à quelques détails près), quelques autres SGBDR : PostgreSQL, SQLite, Oracle 

-- Lien utile, la documentation SQL : https://sql.sh/ 

-- Les requêtes ne sont pas sensibles à la casse, cependant, bonne convention d'écriture nous demande d'écrire les mots clés en majuscule
-- SELECT prenom FROM abonnes;

-- Chaque instruction doit se terminer par un ; 

-- Nous avons besoin de posséder un serveur local pour manipuler MySQL (ainsi que PHP plus tard)

    -- Pour Windows : on installe WAMP
    -- Pour Mac : on installe MAMP 



-- Pour se connecter à la console MySQL : 

    -- WAMP : Ouvrir le menu MySQL et Console MySQL
    -- MAMP : Ouvrir l'application "terminal" dans le terminal tapez ensuite le chemin d'accès à mysql 
                -- /Applications/MAMP/Library/bin/mysql -u root -p   (tapez entrée puis écrire root comme password)
                -- /Applications/MAMP/Library/bin/mysql80/bin/mysql -u root -p 


-- Pour créer une BASE 
CREATE DATABASE ma_bdd;

SHOW DATABASES; -- Pour voir la liste des bases de mon serveur 

CREATE DATABASE entreprise; -- Ici je créer la base entreprise 

SHOW TABLES; -- Pour voir les tables d'une base 
SHOW WARNINGS; -- Pour voir le details d'une erreur WARNING déclenchée

DROP DATABASE ma_bdd; -- Pour supprimer une BDD 
DROP TABLE nom_de_table; -- Pour supprimer une table 

TRUNCATE nom_de_table; -- Pour vider une table (attention c'est une instruction de structure)
DELETE FROM nom_de_table; -- Pour vider une table (requête classique action)

DESC nom_de_table; -- Pour avoir une DESCription de la structure de la table 

CREATE DATABASE entreprise; 
USE entreprise;


-- Création d'une table employes dans la base entreprise
CREATE TABLE employes (
  id_employes int NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

-- Insertions dans la table employes 
INSERT INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES
(350, 'Jean-pierre', 'Laborde', 'm', 'direction', '2010-12-09', 5000),
(388, 'Clement', 'Gallet', 'm', 'commercial', '2010-12-15', 2300),
(415, 'Thomas', 'Winter', 'm', 'commercial', '2011-05-03', 3550),
(417, 'Chloe', 'Dubar', 'f', 'production', '2011-09-05', 1900),
(491, 'Elodie', 'Fellier', 'f', 'secretariat', '2011-11-22', 1600),
(509, 'Fabrice', 'Grand', 'm', 'comptabilite', '2011-12-30', 2900),
(547, 'Melanie', 'Collier', 'f', 'commercial', '2012-01-08', 3100),
(592, 'Laura', 'Blanchet', 'f', 'direction', '2012-05-09', 4500),
(627, 'Guillaume', 'Miller', 'm', 'commercial', '2012-07-02', 1900),
(655, 'Celine', 'Perrin', 'f', 'commercial', '2012-09-10', 2700),
(699, 'Julien', 'Cottet', 'm', 'secretariat', '2013-01-05', 1390),
(701, 'Mathieu', 'Vignal', 'm', 'informatique', '2013-04-03', 2500),
(739, 'Thierry', 'Desprez', 'm', 'secretariat', '2013-07-17', 1500),
(780, 'Amandine', 'Thoyer', 'f', 'communication', '2014-01-23', 2100),
(802, 'Damien', 'Durand', 'm', 'informatique', '2014-07-05', 2250),
(854, 'Daniel', 'Chevel', 'm', 'informatique', '2015-09-28', 3100),
(876, 'Nathalie', 'Martin', 'f', 'juridique', '2016-01-12', 3550),
(900, 'Benoit', 'Lagarde', 'm', 'production', '2016-06-03', 2550),
(933, 'Emilie', 'Sennard', 'f', 'commercial', '2017-01-11', 1800),
(990, 'Stephanie', 'Lafaye', 'f', 'assistant', '2017-03-01', 1775);


--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
-------------- REQUETES DE SELECTION (On questionne la BDD) --------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


-- Affichage complet des données d'une table 
SELECT * FROM employes;

-- Affichage de certains champs spécifiques (dans l'ordre que je souhaite)
SELECT id_employes, nom, prenom, service FROM employes; 

-- Exercice : Affichez la liste des différents services de la table employes 
SELECT service FROM employes;
-- Pour éviter les doublons, on utilise DISTINCT 
SELECT DISTINCT service FROM employes;
+---------------+
| service       |
+---------------+
| direction     |
| commercial    |
| production    |
| secretariat   |
| comptabilite  |
| informatique  |
| communication |
| juridique     |
| assistant     |
+---------------+

-- CONDITION WHERE 
-- Affichage des employés du service informatique 
SELECT * FROM employes WHERE service = "informatique";
+-------------+---------+--------+------+--------------+---------------+---------+
| id_employes | prenom  | nom    | sexe | service      | date_embauche | salaire |
+-------------+---------+--------+------+--------------+---------------+---------+
|         701 | Mathieu | Vignal | m    | informatique | 2013-04-03    |    2500 |
|         802 | Damien  | Durand | m    | informatique | 2014-07-05    |    2250 |
|         854 | Daniel  | Chevel | m    | informatique | 2015-09-28    |    3100 |
+-------------+---------+--------+------+--------------+---------------+---------+

-- BETWEEN 
-- Affichage des employés ayant été embauché entre 2015 et aujourd'hui 
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND "2025-10-07";
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND NOW(); -- fonction NOW() nous retourne la date et l'heure d'aujourd'hui, de l'instant
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND CURDATE(); -- fonction CURDATE() nous retourne la date du jour 
+-------------+-----------+---------+------+--------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service      | date_embauche | salaire |
+-------------+-----------+---------+------+--------------+---------------+---------+
|         854 | Daniel    | Chevel  | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie  | Martin  | f    | juridique    | 2016-01-12    |    3550 |
|         900 | Benoit    | Lagarde | m    | production   | 2016-06-03    |    2550 |
|         933 | Emilie    | Sennard | f    | commercial   | 2017-01-11    |    1800 |
|         990 | Stephanie | Lafaye  | f    | assistant    | 2017-03-01    |    1775 |
+-------------+-----------+---------+------+--------------+---------------+---------+

SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2025-10-07 14:43:23 |
+---------------------+

-- LIKE la valeur approchante 
-- Like nous permet de recherche une information sans qu'elle soit entièrement défini (saisie partielle) 
-- Affichage des prénoms commençant par la lettre "s"
SELECT prenom FROM employes WHERE prenom LIKE "s%";
-- % : signifie "peu importe"
+-----------+
| prenom    |
+-----------+
| Stephanie |
+-----------+

-- Affichage des prénoms finissant par les lettres "ie"
SELECT prenom FROM employes WHERE prenom LIKE "%ie";
+-----------+
| prenom    |
+-----------+
| Elodie    |
| Melanie   |
| Nathalie  |
| Emilie    |
| Stephanie |
+-----------+

-- Affichage des prénoms contenant les lettres "ie"
SELECT prenom FROM employes WHERE prenom LIKE "%ie%";
+-------------+
| prenom      |
+-------------+
| Jean-pierre |
| Elodie      |
| Melanie     |
| Julien      |
| Mathieu     |
| Thierry     |
| Damien      |
| Daniel      |
| Nathalie    |
| Emilie      |
| Stephanie   |
+-------------+

-- BDD immobilière 

-- id     -- type     -- code_postal
---------------------------------------
-- 1      -- appart   -- 64000
-- 2      -- appart   -- 64130 
-- 3      -- maison   -- 31000

-- Dans le formulaire de recherche qui lancerait des requêtes, l'utilisateur, grâce à like, pourrait saisir uniquement le département plutôt que le code postal entier 
-- SELECT * FROM appart WHERE code_postal LIKE "64%";

-- EXCLUSION
-- Tous les employés sauf ceux d'un service particulier, par exemple sauf le service commercial 
SELECT * FROM employes WHERE service != "commercial";   -- != différent de 
+-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction     | 2010-12-09    |    5000 |
|         417 | Chloe       | Dubar    | f    | production    | 2011-09-05    |    1900 |
|         491 | Elodie      | Fellier  | f    | secretariat   | 2011-11-22    |    1600 |
|         509 | Fabrice     | Grand    | m    | comptabilite  | 2011-12-30    |    2900 |
|         592 | Laura       | Blanchet | f    | direction     | 2012-05-09    |    4500 |
|         699 | Julien      | Cottet   | m    | secretariat   | 2013-01-05    |    1390 |
|         701 | Mathieu     | Vignal   | m    | informatique  | 2013-04-03    |    2500 |
|         739 | Thierry     | Desprez  | m    | secretariat   | 2013-07-17    |    1500 |
|         780 | Amandine    | Thoyer   | f    | communication | 2014-01-23    |    2100 |
|         802 | Damien      | Durand   | m    | informatique  | 2014-07-05    |    2250 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique     | 2016-01-12    |    3550 |
|         900 | Benoit      | Lagarde  | m    | production    | 2016-06-03    |    2550 |
|         990 | Stephanie   | Lafaye   | f    | assistant     | 2017-03-01    |    1775 |
+-------------+-------------+----------+------+---------------+---------------+---------+

-- Les opérateurs de comparaison : 
    --  =   est égal à 
    --  !=  est différent de 
    --  >   strictement supérieur
    --  >=  supérieur ou égal 
    --  <   strictement inférieur 
    --  <=  inférieur ou égal 

    -- Les employés ayant un salaire supérieur à 3000 
    SELECT nom, prenom, service, salaire FROM employes WHERE salaire > 3000;
+----------+-------------+--------------+---------+
| nom      | prenom      | service      | salaire |
+----------+-------------+--------------+---------+
| Laborde  | Jean-pierre | direction    |    5000 |
| Winter   | Thomas      | commercial   |    3550 |
| Collier  | Melanie     | commercial   |    3100 |
| Blanchet | Laura       | direction    |    4500 |
| Chevel   | Daniel      | informatique |    3100 |
| Martin   | Nathalie    | juridique    |    3550 |
+----------+-------------+--------------+---------+

-- ORDER BY pour ordonner les résultats 
-- Affichage des employés dans l'ordre alphabétique 
SELECT * FROM employes ORDER BY nom;
SELECT * FROM employes ORDER BY nom ASC; -- ASC pour ascendant (cas par défaut, ici ordre alphabétique)

-- Ordre inversé : DESC pour descendant 
SELECT * FROM employes ORDER BY nom DESC;

-- Il est possible d'ordonner sur plusieurs champs. Si le premier order by a des valeurs similaires (par exemple service), on se basera sur le champs suivant
-- Ordonner d'abord par service, puis par nom 
SELECT service, nom, prenom FROM employes ORDER BY service;
SELECT service, nom, prenom FROM employes ORDER BY service, nom;
+---------------+----------+-------------+
| service       | nom      | prenom      |
+---------------+----------+-------------+
| assistant     | Lafaye   | Stephanie   |
| commercial    | Collier  | Melanie     |
| commercial    | Gallet   | Clement     |
| commercial    | Miller   | Guillaume   |
| commercial    | Perrin   | Celine      |
| commercial    | Sennard  | Emilie      |
| commercial    | Winter   | Thomas      |
| communication | Thoyer   | Amandine    |
| comptabilite  | Grand    | Fabrice     |
| direction     | Blanchet | Laura       |
| direction     | Laborde  | Jean-pierre |
| informatique  | Chevel   | Daniel      |
| informatique  | Durand   | Damien      |
| informatique  | Vignal   | Mathieu     |
| juridique     | Martin   | Nathalie    |
| production    | Dubar    | Chloe       |
| production    | Lagarde  | Benoit      |
| secretariat   | Cottet   | Julien      |
| secretariat   | Desprez  | Thierry     |
| secretariat   | Fellier  | Elodie      |
+---------------+----------+-------------+

-- LIMIT pour limiter le nombre de résultat (exemple pagination)
-- Affichage des employés 3 par 3 
-- LIMIT position_de_depart, nb_de_ligne 
-- La position de départ d'un LIMIT, c'est ce qu'on appelle le offset
SELECT * FROM employes LIMIT 0, 3;   -- ligne 0  1   2 
+-------------+-------------+---------+------+------------+---------------+---------+
| id_employes | prenom      | nom     | sexe | service    | date_embauche | salaire |
+-------------+-------------+---------+------+------------+---------------+---------+
|         350 | Jean-pierre | Laborde | m    | direction  | 2010-12-09    |    5000 |
|         388 | Clement     | Gallet  | m    | commercial | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter  | m    | commercial | 2011-05-03    |    3550 |
+-------------+-------------+---------+------+------------+---------------+---------+
SELECT * FROM employes LIMIT 3, 3;  -- ligne 3  4  5
+-------------+---------+---------+------+--------------+---------------+---------+
| id_employes | prenom  | nom     | sexe | service      | date_embauche | salaire |
+-------------+---------+---------+------+--------------+---------------+---------+
|         417 | Chloe   | Dubar   | f    | production   | 2011-09-05    |    1900 |
|         491 | Elodie  | Fellier | f    | secretariat  | 2011-11-22    |    1600 |
|         509 | Fabrice | Grand   | m    | comptabilite | 2011-12-30    |    2900 |
+-------------+---------+---------+------+--------------+---------------+---------+
SELECT * FROM employes LIMIT 6, 3;
+-------------+-----------+----------+------+------------+---------------+---------+
| id_employes | prenom    | nom      | sexe | service    | date_embauche | salaire |
+-------------+-----------+----------+------+------------+---------------+---------+
|         547 | Melanie   | Collier  | f    | commercial | 2012-01-08    |    3100 |
|         592 | Laura     | Blanchet | f    | direction  | 2012-05-09    |    4500 |
|         627 | Guillaume | Miller   | m    | commercial | 2012-07-02    |    1900 |
+-------------+-----------+----------+------+------------+---------------+---------+

-- Egalement, il est possible de ne donner qu'un seul param au LIMIT, dans ce cas la position de départ sera toujours 0 et le param que l'on renseigne sera le nombre de lignes
SELECT * FROM employes LIMIT 3;
+-------------+-------------+---------+------+------------+---------------+---------+
| id_employes | prenom      | nom     | sexe | service    | date_embauche | salaire |
+-------------+-------------+---------+------+------------+---------------+---------+
|         350 | Jean-pierre | Laborde | m    | direction  | 2010-12-09    |    5000 |
|         388 | Clement     | Gallet  | m    | commercial | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter  | m    | commercial | 2011-05-03    |    3550 |
+-------------+-------------+---------+------+------------+---------------+---------+

-- Affichage des employés avec leur salaire annuel 
SELECT nom, prenom, service, salaire * 12 FROM employes;
-- La même requête mais en renommant le champ du calcul (en lui donnant un alias)
SELECT nom, prenom, service, salaire * 12 AS salaire_annuel FROM employes;

-- Les conventions de nommage :
    -- camelCase : salaireAnnuelDeJeanPierre   : on commence par une minuscule et chaque nouveau mot débute par une majuscule 
    -- PascalCase : SalaireAnnuel : majuscule à chaque mot même le premier
    -- snake_case : salaire_annuel : tout en minuscule on sépare les mots par des underscores/tiret-bas 
    -- kebab-case : salaire-annuel : tout en miscule on sépare les mots par des tirets 

+----------+-------------+---------------+----------------+
| nom      | prenom      | service       | salaire_annuel |
+----------+-------------+---------------+----------------+
| Laborde  | Jean-pierre | direction     |          60000 |
| Gallet   | Clement     | commercial    |          27600 |
| Winter   | Thomas      | commercial    |          42600 |
| Dubar    | Chloe       | production    |          22800 |
| Fellier  | Elodie      | secretariat   |          19200 |
| Grand    | Fabrice     | comptabilite  |          34800 |
| Collier  | Melanie     | commercial    |          37200 |
| Blanchet | Laura       | direction     |          54000 |
| Miller   | Guillaume   | commercial    |          22800 |
| Perrin   | Celine      | commercial    |          32400 |
| Cottet   | Julien      | secretariat   |          16680 |
| Vignal   | Mathieu     | informatique  |          30000 |
| Desprez  | Thierry     | secretariat   |          18000 |
| Thoyer   | Amandine    | communication |          25200 |
| Durand   | Damien      | informatique  |          27000 |
| Chevel   | Daniel      | informatique  |          37200 |
| Martin   | Nathalie    | juridique     |          42600 |
| Lagarde  | Benoit      | production    |          30600 |
| Sennard  | Emilie      | commercial    |          21600 |
| Lafaye   | Stephanie   | assistant     |          21300 |
+----------+-------------+---------------+----------------+
-- AS nous permet de donner un surnom à la colonne lors de la récupération, on préfèrera utiliser la convention de nommage "snake_case"

-------------------------------------------------------------------------
-------------------------------------------------------------------------
------------------- Fonctions d'agrégation ------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------


-- SUM() pour avoir la somme
-- La masse salariale annuelle de l'entreprise 
SELECT SUM(salaire * 12) AS masse_salariale FROM employes;
+-----------------+
| masse_salariale |
+-----------------+
|          623580 |
+-----------------+

-- AVG() la moyenne
-- Affichage du salaire moyen de l'entreprise 
SELECT AVG(salaire) AS salaire_moyen FROM employes;
+---------------+
| salaire_moyen |
+---------------+
|       2598.25 |
+---------------+

-- ROUND() pour arrondir
-- ROUND(valeur) => arrondi à l'entier
-- ROUND(valeur, 1) => arrondi avec une décimale
SELECT ROUND(AVG(salaire)) AS salaire_moyen FROM employes; -- Arrondi à l'entier 
SELECT ROUND(AVG(salaire), 1) AS salaire_moyen FROM employes; -- Arrondi à 1 décimale 

-- COUNT() permet de compter le nombre de ligne d'une requête 
-- Le nombre d'employés dans l'entreprise : 
-- ATTENTION un COUNT() ne compte pas une ligne si la valeur du champ que l'on spécifie entre parenthèse est NULL...
    -- On utilise COUNT() pour compter toujours toutes les lignes (même si on rajoute des conditions WHERE), donc on mettra toujours * entre les parenthèses
SELECT COUNT(*) AS nombre_employes FROM employes;

SELECT COUNT(*) AS nombre_commerciaux FROM employes WHERE service = "commercial";
+--------------------+
| nombre_commerciaux |
+--------------------+
|                  6 |
+--------------------+

-- MIN() & MAX() 
-- pour sortir la valeur minimum d'un champ, et l'autre pour sortir la valeur maximum d'un champ 

-- salaire minimum 
SELECT MIN(salaire) AS salaire_mini FROM employes;
+--------------+
| MIN(salaire) |
+--------------+
|         1390 |
+--------------+
-- salaire maximum
SELECT MAX(salaire) AS salaire_max FROM employes;
+-------------+
| salaire_max |
+-------------+
|        5000 |
+-------------+

-- EXERCICE : Affichez le salaire minimum ainsi que le prenom de l'employé ayant ce salaire 
SELECT prenom, MIN(salaire) FROM employes; -- Pas d'erreur, mais le résultat est FAUX
-- MIN() c'est une fonction d'agrégation, elle ne peut retourner qu'un seul résultat !!! 
-- La requête a une réponse qui n'est pas cohérente 
    -- On récupère le premier prénom de la table puis le MIN() salaire, donc le prenom ne correspond simplement pas 

-- 2 solutions 

    -- 1 - requête imbriquée
    SELECT prenom, salaire FROM employes WHERE salaire = (SELECT MIN(salaire) AS salaire_mini FROM employes);
+--------+---------+
| prenom | salaire |
+--------+---------+
| Julien |    1390 |
+--------+---------+

    -- 2 - avec un order by et un limit 
    SELECT prenom, salaire FROM employes ORDER BY salaire ASC LIMIT 1;
+--------+---------+
| prenom | salaire |
+--------+---------+
| Julien |    1390 |
+--------+---------+

-- IN & NOT IN pour tester plusieurs valeurs  
-- Affichage des employés des services commercial et comptabilite 
SELECT * FROM employes WHERE service = "commercial" OR service = "comptabilite";
SELECT * FROM employes WHERE service IN ("commercial", "comptabilite");
+-------------+-----------+---------+------+--------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service      | date_embauche | salaire |
+-------------+-----------+---------+------+--------------+---------------+---------+
|         388 | Clement   | Gallet  | m    | commercial   | 2010-12-15    |    2300 |
|         415 | Thomas    | Winter  | m    | commercial   | 2011-05-03    |    3550 |
|         509 | Fabrice   | Grand   | m    | comptabilite | 2011-12-30    |    2900 |
|         547 | Melanie   | Collier | f    | commercial   | 2012-01-08    |    3100 |
|         627 | Guillaume | Miller  | m    | commercial   | 2012-07-02    |    1900 |
|         655 | Celine    | Perrin  | f    | commercial   | 2012-09-10    |    2700 |
|         933 | Emilie    | Sennard | f    | commercial   | 2017-01-11    |    1800 |
+-------------+-----------+---------+------+--------------+---------------+---------+
-- L'inverse NOT IN  
SELECT * FROM employes WHERE service NOT IN ("commercial", "comptabilite");
+-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+
|         350 | Jean-Pierre | Laborde  | m    | direction     | 2010-12-09    |    5000 |
|         417 | Chloe       | Dubar    | f    | production    | 2011-09-05    |    1900 |
|         491 | Elodie      | Fellier  | f    | secretariat   | 2011-11-22    |    1600 |
|         592 | Laura       | Blanchet | f    | direction     | 2012-05-09    |    4500 |
|         699 | Julien      | Cottet   | m    | secretariat   | 2013-01-05    |    1390 |
|         701 | Mathieu     | Vignal   | m    | informatique  | 2013-04-03    |    2500 |
|         739 | Thierry     | Desprez  | m    | secretariat   | 2013-07-17    |    1500 |
|         780 | Amandine    | Thoyer   | f    | communication | 2014-01-23    |    2100 |
|         802 | Damien      | Durand   | m    | informatique  | 2014-07-05    |    2250 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique     | 2016-01-12    |    3550 |
|         900 | Benoit      | Lagarde  | m    | production    | 2016-06-03    |    2550 |
|         990 | Stephanie   | Lafaye   | f    | assistant     | 2017-03-01    |    1775 |
+-------------+-------------+----------+------+---------------+---------------+---------+

-- Plusieurs conditions : AND 
-- On veut un employé du service commercial ayant un salaire inférieur ou égal à 2000 
SELECT * FROM employes WHERE service = "commercial" AND salaire <= 2000;

-- Pas de soucis pour sauter des lignes en SQL 
SELECT *                        -- Ce que je souhaite afficher
FROM employes                   -- De quel table
WHERE service = "commercial"    -- Quelle condition
AND salaire <= 2000;            -- Encore une autre condition, etc.
+-------------+-----------+---------+------+------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service    | date_embauche | salaire |
+-------------+-----------+---------+------+------------+---------------+---------+
|         627 | Guillaume | Miller  | m    | commercial | 2012-07-02    |    1900 |
|         933 | Emilie    | Sennard | f    | commercial | 2017-01-11    |    1800 |
+-------------+-----------+---------+------+------------+---------------+---------+

-- L'un ou l'autre d'un ensemble de conditions : OR 
-- EXERCICE : Je souhaite récupérer les employés du service production ayant un salaire égal à 1900 ou 2300 
                    -- Vérifiez bien les résultats 

-- Ici problème, cela nous sort quelqu'un du service commercial ? 
    -- En fait, les deux conditions autour de AND sont liées entre elles mais celle du OR est indépendante ! Pour y rémédier, des parenthèses !
    -- Ou sinon le mieux, on utilise IN ! 
SELECT * FROM employes WHERE service = "production" AND salaire = 1900 OR salaire = 2300;

SELECT * FROM employes WHERE service = "production" AND salaire = 1900 OR service = "production" AND salaire = 2300;
SELECT * FROM employes WHERE service = "production" AND (salaire = 1900 OR salaire = 2300);

-- Ici la meilleure solution 
SELECT * FROM employes WHERE service = "production" AND salaire IN (1900, 2300);

-- GROUP BY pour regrouper selon un ou des champs (généralement on utilise GROUP BY avec des fonctions d'agrégation)
-- Nombre d'employés par service 
SELECT COUNT(*), service FROM employes; -- Résultat incorrect ! Le COUNT() ne me retourne qu'une seule ligne, et la requête me sort le premier service qu'elle trouve 

-- Avec GROUP BY il est possible de demander de nous renvoyer le COUNT() en regroupant par service 

SELECT COUNT(*) AS nombre_employes, service FROM employes GROUP BY service;
+-----------------+---------------+
| nombre_employes | service       |
+-----------------+---------------+
|               2 | direction     |
|               6 | commercial    |
|               2 | production    |
|               3 | secretariat   |
|               1 | comptabilite  |
|               3 | informatique  |
|               1 | communication |
|               1 | juridique     |
|               1 | assistant     |
+-----------------+---------------+

-- Ci dessous une requête SELECT * FROM employes ORDER BY service (juste pour visualiser les resultats)
-- Lorsqu'on appelle un GROUP BY, il est capable "d'éclater" un résultat, pour isoler des lignes blocs par blocs (ici blocs par service)
    -- Grâce à cet "éclatement" on va être capable d'appliquer une fonction d'agrégation par bloc ! 
+-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+

|         990 | Stephanie   | Lafaye   | f    | assistant     | 2017-03-01    |    1775 |


|         388 | Clement     | Gallet   | m    | commercial    | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter   | m    | commercial    | 2011-05-03    |    3550 |
|         547 | Melanie     | Collier  | f    | commercial    | 2012-01-08    |    3100 |
|         627 | Guillaume   | Miller   | m    | commercial    | 2012-07-02    |    1900 |
|         655 | Celine      | Perrin   | f    | commercial    | 2012-09-10    |    2700 |
|         933 | Emilie      | Sennard  | f    | commercial    | 2017-01-11    |    1800 |


|         780 | Amandine    | Thoyer   | f    | communication | 2014-01-23    |    2100 |

|         509 | Fabrice     | Grand    | m    | comptabilite  | 2011-12-30    |    2900 |

|         350 | Jean-Pierre | Laborde  | m    | direction     | 2010-12-09    |    5000 |
|         592 | Laura       | Blanchet | f    | direction     | 2012-05-09    |    4500 |


|         701 | Mathieu     | Vignal   | m    | informatique  | 2013-04-03    |    2500 |
|         802 | Damien      | Durand   | m    | informatique  | 2014-07-05    |    2250 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2015-09-28    |    3100 |

|         876 | Nathalie    | Martin   | f    | juridique     | 2016-01-12    |    3550 |

|         417 | Chloe       | Dubar    | f    | production    | 2011-09-05    |    1900 |
|         900 | Benoit      | Lagarde  | m    | production    | 2016-06-03    |    2550 |


|         491 | Elodie      | Fellier  | f    | secretariat   | 2011-11-22    |    1600 |
|         699 | Julien      | Cottet   | m    | secretariat   | 2013-01-05    |    1390 |
|         739 | Thierry     | Desprez  | m    | secretariat   | 2013-07-17    |    1500 |
+-------------+-------------+----------+------+---------------+---------------+---------+

SELECT COUNT(*) AS nombre_employes, service FROM employes GROUP BY service HAVING COUNT(*) > 2;


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--------------------- REQUETES D'INSERTION (Action : enregistrement) ------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


-- id_employes étant la clé primaire en auto increment, elle ne peut pas être vide, donc si je cite le champ, je dois mettre NULL et il se génèrera automatiquement
INSERT INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES (NULL, "Pierra", "Lacaze", "m", "Web", NOW(), 12000);
-- Le mieux est de ne pas citer ce champ, de toute façon il est géré automatiquement par MySQL, il prends +1 à chaque nouvelle insertion
-- Ci dessous, meilleure formule
INSERT INTO employes (prenom, nom, sexe, service, date_embauche, salaire) VALUES ("Pierra", "Lacaze", "m", "Web", NOW(), 12000);

-- Il est possible de ne pas préciser les champs. Cependant, on est dans ce cas obligé de nommer l'intégralité des champs et surtout dans le même ordre que la structure ! Au risque de recevoir les mauvaises valeurs dans les mauvais champs 
INSERT INTO employes VALUES (NULL, "Lacaze", "Pierra", "m", "Web", NOW(), 12000);


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--------------------- REQUETES DE MODIFICATION (Action : modification) ----------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- On modifie le salaire d'un employé 
-- On utilise le mot clé SET pour définir le champ concerné et sa nouvelle valeur, ensuite on cible un ou plusieurs enregistrements grâce aux conditions WHERE (même chose que pour les requêtes SELECT)
UPDATE employes SET salaire = 1200 WHERE id_employes = 991;

-- Plusieurs modifications sont possibles en une seule fois 
UPDATE employes SET salaire = 2000, service = "informatique" WHERE id_employes = 992;

-- REPLACE 
-- ATTENTION - Il ne faut JAMAIS utiliser l'outil REPLACE 
-- Comment se comporte REPLACE ? S'il ne trouve pas la ligne en question, il va insérer, s'il trouve la ligne il va "modifier"
REPLACE INTO employes VALUES (994, "Polo", "Lolo", "m", "Web", "2022-01-01", 2000); -- Ici il insère, car il ne connait pas l'id 994
REPLACE INTO employes VALUES (994, "Polo", "Lolo", "m", "Web", "2022-01-01", 20000); -- Ici il "modifie" la ligne en changeant son salaire

-- ATTENTION, quand il trouve la ligne, il supprime celle qu'il trouve et réinsère une nouvelle 
    -- Les conditions peuvent être grave en fonction de la gestion de nos associations de tables et contraintes d'intégrité, avec la relation CASCADE (réaction en chaine), cela pourrait induire des suppressions non souhaitées


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--------------------- REQUETES DE SUPPRESSION (Action : modification) -----------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

DELETE FROM employes; -- Cette requête supprime toutes les données de la table 

-- Suppression des entrées de la table id 991
DELETE FROM employes WHERE id_employes = 991;
-- Ci dessous je supprime tous les employés du service informatique
DELETE FROM employes WHERE service = "informatique";
-- Ci dessous, je supprime tous les employés du service informatique SAUF celui qui a l'id 701 
DELETE FROM employes WHERE service = "informatique" AND id_employes != 701;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--------------------- EXERCICES : -----------------------------------------------------------------
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- 1 -- Afficher la profession de l'employé 547.
SELECT service FROM employes WHERE id_employes = 547;
+------------+
| service    |
+------------+
| commercial |
+------------+
-- 2 -- Afficher la date d'embauche d'Amandine.	
SELECT date_embauche FROM employes WHERE prenom = "Amandine";
+---------------+
| date_embauche |
+---------------+
| 2014-01-23    |
+---------------+
-- 3 -- Afficher le nom de famille de Guillaume	
SELECT nom FROM employes WHERE prenom = "Guillaume";
+--------+
| nom    |
+--------+
| Miller |
+--------+
-- 4 -- Afficher le nombre de personne ayant un n° id_employes commençant par le chiffre 5.	
SELECT COUNT(*) AS nombre_employes FROM employes WHERE id_employes LIKE "5%";
+-----------------+
| nombre_employes |
+-----------------+
|               3 |
+-----------------+
-- 5 -- Afficher le nombre de commerciaux.
SELECT COUNT(*) AS nombre_commerciaux FROM employes WHERE service = "commercial";
+--------------------+
| nombre_commerciaux |
+--------------------+
|                  6 |
+--------------------+
-- 6 -- Afficher le salaire moyen des informaticiens 
SELECT ROUND(AVG(salaire)) AS salaire_moyen_informatique FROM employes WHERE service = "informatique";
+--------------------+
| salaire_moyen      |
+--------------------+
| 2616.6666666666665 |
+--------------------+
+---------------+
| salaire_moyen |
+---------------+
|          2617 |
+---------------+
-- 7 -- Afficher les 5 premiers employés après avoir classé leur nom de famille par ordre alphabétique. 
SELECT * FROM employes ORDER BY nom ASC LIMIT 0, 5;
SELECT * FROM employes ORDER BY nom ASC LIMIT 5;
SELECT * FROM employes ORDER BY nom LIMIT 5;
+-------------+---------+----------+------+--------------+---------------+---------+
| id_employes | prenom  | nom      | sexe | service      | date_embauche | salaire |
+-------------+---------+----------+------+--------------+---------------+---------+
|         592 | Laura   | Blanchet | f    | direction    | 2012-05-09    |    4500 |
|         854 | Daniel  | Chevel   | m    | informatique | 2015-09-28    |    3100 |
|         547 | Melanie | Collier  | f    | commercial   | 2012-01-08    |    3100 |
|         699 | Julien  | Cottet   | m    | secretariat  | 2013-01-05    |    1390 |
|         739 | Thierry | Desprez  | m    | secretariat  | 2013-07-17    |    1500 |
+-------------+---------+----------+------+--------------+---------------+---------+
-- 8 -- Afficher le coût des commerciaux sur 1 année.	
SELECT SUM(salaire * 12) AS cout_commerciaux FROM employes WHERE service = "commercial";
+------------------+
| cout_commerciaux |
+------------------+
|           184200 |
+------------------+
-- 9 -- Afficher le salaire moyen par service. 
SELECT service, ROUND(AVG(salaire)) AS salaire_moyen FROM employes GROUP BY service;
SELECT service, ROUND(AVG(salaire), 2) AS salaire_moyen FROM employes GROUP BY service;

+---------------+---------------+
| service       | salaire_moyen |
+---------------+---------------+
| direction     |          4750 |
| commercial    |          2558 |
| production    |          2225 |
| secretariat   |          1497 |
| comptabilite  |          2900 |
| informatique  |          2617 |
| communication |          2100 |
| juridique     |          3550 |
| assistant     |          1775 |
+---------------+---------------+
-- 10 -- Afficher le nombre de recrutement sur l'année 2010
SELECT COUNT(*) AS nb_recrutement_2010 FROM employes WHERE YEAR(date_embauche) = 2010;
SELECT COUNT(*) AS recrutement_2010 FROM employes WHERE date_embauche BETWEEN "2010-01-01" AND "2010-12-31";
SELECT COUNT(*) AS recrutement_2010 FROM employes WHERE date_embauche LIKE "2010%";
SELECT COUNT(*) AS recrutement_2010 FROM employes WHERE date_embauche >= "2010-01-01" AND date_embauche <= "2010-12-31";
+---------------------+
| nb_recrutement_2010 |
+---------------------+
|                   2 |
+---------------------+
-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2015 a 2017
SELECT ROUND(AVG(salaire)) AS salaire_moyen_recrutement_2015_217 FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND "2017-12-31"; 
+------------------------------------+
| salaire_moyen_recrutement_2015_217 |
+------------------------------------+
|                               2555 |
+------------------------------------+
-- 12 -- Afficher le nombre de service différent 
SELECT COUNT(DISTINCT service) AS nombre_services FROM employes;
+-----------------+
| nombre_services |
+-----------------+
|               9 |
+-----------------+
-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)
SELECT * FROM employes WHERE service NOT IN ("production", "secretariat");
+-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction     | 2010-12-09    |    5000 |
|         388 | Clement     | Gallet   | m    | commercial    | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter   | m    | commercial    | 2011-05-03    |    3550 |
|         509 | Fabrice     | Grand    | m    | comptabilite  | 2011-12-30    |    2900 |
|         547 | Melanie     | Collier  | f    | commercial    | 2012-01-08    |    3100 |
|         592 | Laura       | Blanchet | f    | direction     | 2012-05-09    |    4500 |
|         627 | Guillaume   | Miller   | m    | commercial    | 2012-07-02    |    1900 |
|         655 | Celine      | Perrin   | f    | commercial    | 2012-09-10    |    2700 |
|         701 | Mathieu     | Vignal   | m    | informatique  | 2013-04-03    |    2500 |
|         780 | Amandine    | Thoyer   | f    | communication | 2014-01-23    |    2100 |
|         802 | Damien      | Durand   | m    | informatique  | 2014-07-05    |    2250 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique     | 2016-01-12    |    3550 |
|         933 | Emilie      | Sennard  | f    | commercial    | 2017-01-11    |    1800 |
|         990 | Stephanie   | Lafaye   | f    | assistant     | 2017-03-01    |    1775 |
+-------------+-------------+----------+------+---------------+---------------+---------+
-- 14 -- Afficher conjointement le nombre d'homme et de femme dans l'entreprise
SELECT sexe, COUNT(*) AS nombre FROM employes GROUP BY sexe;
+------+--------+
| sexe | nombre |
+------+--------+
| m    |     11 |
| f    |      9 |
+------+--------+
-- 15 -- Afficher les commerciaux ayant été recrutés avant 2012 de sexe masculin et gagnant un salaire supérieur a 2500 €
SELECT * 
FROM employes 
WHERE YEAR(date_embauche) < 2012 
AND salaire > 2500 
AND sexe = "m" 
AND service = "commercial";
+-------------+--------+--------+------+------------+---------------+---------+
| id_employes | prenom | nom    | sexe | service    | date_embauche | salaire |
+-------------+--------+--------+------+------------+---------------+---------+
|         415 | Thomas | Winter | m    | commercial | 2011-05-03    |    3550 |
+-------------+--------+--------+------+------------+---------------+---------+
-- 16 -- Qui a été embauché en dernier
SELECT * FROM employes ORDER BY date_embauche DESC LIMIT 1;
SELECT * FROM employes ORDER BY date_embauche DESC;

SELECT * FROM employes WHERE date_embauche = (SELECT MAX(date_embauche) FROM employes);
+-------------+-----------+--------+------+-----------+---------------+---------+
| id_employes | prenom    | nom    | sexe | service   | date_embauche | salaire |
+-------------+-----------+--------+------+-----------+---------------+---------+
|         990 | Stephanie | Lafaye | f    | assistant | 2017-03-01    |    1775 |
+-------------+-----------+--------+------+-----------+---------------+---------+
-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé 
SELECT * FROM employes WHERE service = "commercial" ORDER BY salaire DESC LIMIT 1;
SELECT * FROM employes WHERE service = "commercial" AND salaire = (SELECT MAX(salaire) FROM employes WHERE service = "commercial");
+-------------+--------+--------+------+------------+---------------+---------+
| id_employes | prenom | nom    | sexe | service    | date_embauche | salaire |
+-------------+--------+--------+------+------------+---------------+---------+
|         415 | Thomas | Winter | m    | commercial | 2011-05-03    |    3550 |
+-------------+--------+--------+------+------------+---------------+---------+
-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire
SELECT prenom FROM employes WHERE service = "comptabilite" AND salaire = (SELECT MAX(salaire) AS salaire_maximum FROM employes WHERE service = "comptabilite");
SELECT prenom FROM employes WHERE service = "comptabilite" ORDER BY salaire DESC LIMIT 1;
+---------+
| prenom  |
+---------+
| Fabrice |
+---------+
-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier
SELECT prenom FROM employes WHERE service = "informatique" AND date_embauche = (SELECT MIN(date_embauche) FROM employes WHERE service = "informatique");
+---------+
| prenom  |
+---------+
| Mathieu |
-- 20 -- Augmenter chaque employé de 100 €
UPDATE employes SET salaire = salaire + 100;
-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes WHERE service = "secretariat";