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


