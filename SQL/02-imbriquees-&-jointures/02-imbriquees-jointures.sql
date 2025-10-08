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
-- EXERCICE 2: Nous aimerions connaitre le(s) n° des livres empruntés par Chloé
-- EXERCICE 3: Affichez les prénoms des abonnés ayant emprunté un livre le 07/12/2016.
-- EXERCICE 4: combien de livre Guillaume a emprunté à la bibliotheque ?
-- EXERCICE 5: Affichez la liste des abonnés ayant déjà emprunté un livre d'Alphonse Daudet
-- EXERCICE 6: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque.
-- EXERCICE 7: Nous aimerions connaitre les titres des livres que Chloe n'a pas emprunté à la bibliotheque.
-- EXERCICE 8: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque ET qui n'ont pas été rendu.
-- EXERCICE 9 :  Qui a emprunté le plus de livre à la bibliotheque ?




