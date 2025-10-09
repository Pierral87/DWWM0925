CREATE DATABASE bibliotheque;
USE bibliotheque;

CREATE TABLE abonne (
  id_abonne INT(3) NOT NULL AUTO_INCREMENT,
  prenom VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_abonne)
) ENGINE=InnoDB ;

INSERT INTO abonne (id_abonne, prenom) VALUES
(1, 'Guillaume'),
(2, 'Benoit'),
(3, 'Chloe'),
(4, 'Laura');


CREATE TABLE livre (
  id_livre INT(3) NOT NULL AUTO_INCREMENT,
  auteur VARCHAR(25) NOT NULL,
  titre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_livre)
) ENGINE=InnoDB ;

INSERT INTO livre (id_livre, auteur, titre) VALUES
(100, 'GUY DE MAUPASSANT', 'Une vie'),
(101, 'GUY DE MAUPASSANT', 'Bel-Ami '),
(102, 'HONORE DE BALZAC', 'Le pere Goriot'),
(103, 'ALPHONSE DAUDET', 'Le Petit chose'),
(104, 'ALEXANDRE DUMAS', 'La Reine Margot'),
(105, 'ALEXANDRE DUMAS', 'Les Trois Mousquetaires');

CREATE TABLE emprunt (
  id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
  id_livre INT(3) DEFAULT NULL,
  id_abonne INT(3) DEFAULT NULL,
  date_sortie DATE NOT NULL,
  date_rendu DATE DEFAULT NULL,
  PRIMARY KEY  (id_emprunt)
) ENGINE=InnoDB ;

INSERT INTO emprunt (id_emprunt, id_livre, id_abonne, date_sortie, date_rendu) VALUES
(1, 100, 1, '2016-12-07', '2016-12-11'),
(2, 101, 2, '2016-12-07', '2016-12-18'),
(3, 100, 3, '2016-12-11', '2016-12-19'),
(4, 103, 4, '2016-12-12', '2016-12-22'),
(5, 104, 1, '2016-12-15', '2016-12-30'),
(6, 105, 2, '2017-01-02', '2017-01-15'),
(7, 105, 3, '2017-02-15', NULL),
(8, 100, 2, '2017-02-20', NULL);


---------------------------------------------------------------------------
--------- Ici nouvelle base bibliotheque, base à 3 tables ----------------


-- 2 entités : abonne et livre
  -- un abonne emprunte des livres 
  -- un livre est emprunté par des abonnés
  -- Cardinalités ? Plusieurs à Plusieurs / Many to Many / n à m 

  -- Cette cardinalité induit : Un abonné peut emprunter plusieurs livres, et un livre peut être emprunté par plusieurs abonné 

  -- Dans le cadre d'une cardinalité Many to Many, nous avons la nécessité de créer une table intermédiaire que l'on appelle une table de jointure 
      -- Ici notre table de jointure = la table emprunt, elle me permet de répertorier les associations entre les abonnés et les livres 

    -- Quels sont les id_livres qui n'ont pas été rendu à la bibliothèque ? 
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;
-- ATTENTION la valeur NULL se teste avec IS NULL ou IS NOT NULL  (pas de = NULL)
+----------+
| id_livre |
+----------+
|      105 |
|      100 |
+----------+

-- Comment retrouver les titre des livres en me basant sur cette condition de la table emprunt ? Les titres se trouvent uniquement sur la table livre
-- 2 possibilités : 
  -- Requêtes imbriquées
  -- Requêtes en jointure 


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
------------------ REQUETES IMBRIQUEES (sur plusieurs tables ) -----------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- Quels sont les titres des livres qui n'ont pas été rendu à la bibliothèque ? 
-- SELECT titre FROM livre WHERE date_rendu IS NULL; -- On voudrait pouvoir faire ça... Mais pas possible...

-- Selectionnez les titres des livres des id_livre 105 et 100 
SELECT titre FROM livre WHERE id_livre IN (105, 100);

SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);
-- Ici un "=" ne fonctionne pas car la requête de second niveau me renvoie 2 résultats, un IN est ainsi obligatoire (sauf exception) 
+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+

-- Pour faire une requête imbriquée il me faut toujours un champ commun ! C'est à dire là, à partir de la table livre et ses id_livre, je transite sur la table emprunt qui elle aussi contient les id_livre, ce qui me permet de récupérer des id_livre sur la table emprunt des livres non rendu à la biblio et de transiter sur la table livre pour récupérer leurs titres ! 

-- EXERCICE 1: Quels sont les prénoms des abonnés n'ayant pas rendu un livre à la bibliotheque.
SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL);
+--------+
| prenom |
+--------+
| Benoit |
| Chloe  |
+--------+
-- EXERCICE 2: Nous aimerions connaitre le(s) n° des livres empruntés par Chloé
SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = "Chloe");
+----------+
| id_livre |
+----------+
|      100 |
|      105 |
+----------+
--------
-- SELECT id_livre FROM emprunt 
-- JOIN abonne ON emprunt.id_abonne = abonne.id_abonne 
-- WHERE prenom = "Chloe";

-- EXERCICE 3: Affichez les prénoms des abonnés ayant emprunté un livre le 07/12/2016.
SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt WHERE date_sortie = "2016-12-07");
+-----------+
| prenom    |
+-----------+
| Guillaume |
| Benoit    |
+-----------+
-- EXERCICE 4: combien de livre Guillaume a emprunté à la bibliotheque ?
SELECT COUNT(*) AS nombre_livres FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = "Guillaume");
+---------------+
| nombre_livres |
+---------------+
|             2 |
+---------------+
-- EXERCICE 5: Affichez la liste des abonnés ayant déjà emprunté un livre d'Alphonse Daudet
SELECT prenom FROM abonne WHERE id_abonne IN (
                                                SELECT id_abonne FROM emprunt WHERE id_livre IN (
                                                                                              SELECT id_livre FROM livre WHERE auteur = "Alphonse Daudet"));
+--------+
| prenom |
+--------+
| Laura  |
+--------+
-- EXERCICE 6: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque.
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = "Chloe"));
+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+
-- EXERCICE 7: Nous aimerions connaitre les titres des livres que Chloe n'a pas emprunté à la bibliotheque.
SELECT titre FROM livre WHERE id_livre NOT IN (SELECT id_livre FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = "Chloe"));
+-----------------+
| titre           |
+-----------------+
| Bel-Ami         |
| Le pere Goriot  |
| Le Petit chose  |
| La Reine Margot |
+-----------------+
-- EXERCICE 8: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque ET qui n'ont pas été rendu.
SELECT titre FROM livre WHERE id_livre IN        
                          (SELECT id_livre FROM emprunt WHERE id_abonne IN   (SELECT id_abonne FROM abonne WHERE prenom = "Chloe")  AND  date_rendu IS NULL);

     SELECT titre FROM livre WHERE id_livre IN        
                          (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne IN 
                                                    (SELECT id_abonne FROM abonne WHERE prenom = "Chloe"));
+-------------------------+
| titre                   |
+-------------------------+
| Les Trois Mousquetaires |
+-------------------------+                                                     
-- EXERCICE 9 :  Qui a emprunté le plus de livre à la bibliotheque ?
SELECT prenom FROM abonne WHERE id_abonne = (SELECT id_abonne FROM emprunt GROUP BY id_abonne ORDER BY COUNT(*) DESC LIMIT 1);
SELECT prenom FROM abonne WHERE id_abonne IN (SELECT id_abonne FROM emprunt GROUP BY id_abonne ORDER BY COUNT(*) DESC LIMIT 1); -- Ici IN ne fonctionne pas ! Limitation du langage  ERROR 1235 (42000): This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'


+------------+----------+-----------+-------------+------------+
| id_emprunt | id_livre | id_abonne | date_sortie | date_rendu |
+------------+----------+-----------+-------------+------------+

|          1 |      100 |         1 | 2016-12-07  | 2016-12-11 |
|          5 |      104 |         1 | 2016-12-15  | 2016-12-30 |        2


|          2 |      101 |         2 | 2016-12-07  | 2016-12-18 |
|          6 |      105 |         2 | 2017-01-02  | 2017-01-15 |        3
|          8 |      100 |         2 | 2017-02-20  | NULL       |



|          3 |      100 |         3 | 2016-12-11  | 2016-12-19 |       2
|          7 |      105 |         3 | 2017-02-15  | NULL       |



|          4 |      103 |         4 | 2016-12-12  | 2016-12-22 |        1
+------------+----------+-----------+-------------+------------+


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
------------------ REQUETES EN JOINTURE  ---------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- Une jointure est toujours possible 
-- Une imbriquée est possible uniquement si les champs que l'on récupère proviennent d'une seule table ! 

-- Avec des requêtes imbriquées on parcourt les tables une à une par le champs commun (la primary key, les foreign key etc)
-- Avec des requêtes en jointure, on mélange les champs de sorties, les tables, les conditions sans que cela pose problème 

-- Nous aimerions connaître les dates de sorties et les dates de rendu pour l'abonne Guillaume 
   -- En imbriquée, pas possible d'afficher le prenom en même temps que les date, pourquoi ? Prenom = table abonne, date = table emprunt 

-- En imbriquée je suis limité à ça, afficher simplement les dates 
   SELECT date_sortie, date_rendu FROM emprunt WHERE id_abonne IN (SELECT id_abonne FROM abonne WHERE prenom = "Guillaume");
+-------------+------------+
| date_sortie | date_rendu |
+-------------+------------+
| 2016-12-07  | 2016-12-11 |
| 2016-12-15  | 2016-12-30 |
+-------------+------------+

-- En jointure ? Pas de soucis  

-- Une première syntaxe de jointure ici 
SELECT abonne.prenom, emprunt.date_sortie, emprunt.date_rendu    -- Ce que je veux afficher 
FROM abonne, emprunt                      -- Les tables que je veux utiliser
WHERE abonne.prenom = "Guillaume"                -- Mes conditions, ici prenom Guillaume
AND abonne.id_abonne = emprunt.id_abonne; -- Ici la création de la jointure (on indique les champs qui se correspondent)
+-----------+-------------+------------+
| prenom    | date_sortie | date_rendu |
+-----------+-------------+------------+
| Guillaume | 2016-12-07  | 2016-12-11 |
| Guillaume | 2016-12-15  | 2016-12-30 |
+-----------+-------------+------------+

-- On peut indiquer des alias (raccourci) de table pour l'écriture des jointures et l'appel des champs 
SELECT a.prenom, e.date_sortie, e.date_rendu    
FROM abonne a, emprunt e                                    -- Ici je défini que la table abonne est maintenant nommée a et la table emprunt maintenant nommée e                       
WHERE a.prenom = "Guillaume"               
AND a.id_abonne = e.id_abonne; 

-- Il vaut toujours mieux citer les préfixes de table pour éviter les ambiguités ! 

-- Autres syntaxes pour les jointures via les INNER JOIN ou JOIN 
-- Avec cette méthode on joint les tables une par une 
SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
JOIN abonne a ON e.id_abonne = a.id_abonne   -- On peut utiliser JOIN
WHERE a.prenom = "Guillaume";

SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
INNER JOIN abonne a ON e.id_abonne = a.id_abonne   -- Ou INNER JOIN c'est pareil !   Avec la syntaxe ON on fait correspondre un champ et un autre sur deux tables différentes (même s'ils ont des noms différents)
WHERE a.prenom = "Guillaume";

SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
JOIN abonne a USING (id_abonne)                 -- On peut utiliser USING uniquement sur le champ commun entre deux tables est écrit exactement de la même manière 
WHERE a.prenom = "Guillaume";
