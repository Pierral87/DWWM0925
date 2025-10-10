---------------------------------------------------------------------
---------------------------------------------------------------------
-------- POUR CONTINUER L'APPRENTISSAGE -----------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------


-- Requêtes préparées : Pour sécuriser nos requêtes 
-- Tables Temporaires & les Vues (Tables Virtuelles)
    -- Tables temporaires c'est utilisé pour stocker un calcul précis le temps de quelques requêtes 
    -- Tables Virtuelles/Vues utilisées pour modéliser des "fausses" tables qui contiennent les résultats par exemple d'une jointure complexe, ce qui évite de relancer la jointure à chaque requête, mais qui permet plutôt de lancer la requête directement sur la Vue 
-- Events & Triggers : Evènements & Déclencheurs 
    -- Evènements : Ce sont des instructions qui se lancent basé sur un ordre de temps, par exemple, une sauvegarde toutes les minutes, toutes les heures, tous les jours, une suppression tous les jours 
    -- Triggers : Ce sont des instructions qui se déclenchent après avoir compris qu'une action s'est passée ! Par exemple, lorsque je vois une suppression d'une ligne, alors j'insère cette ligne dans une autre table qui servira de "poubelle" / Ou encore, dès que je vois une modification sur une table, j'enregistre dans une autre, le détails de l'opération en question, cela me servira de table Journal/logs pour garder référence de chacune des opérations de ma table 
-- Modélisation UML : A voir en Merise 
-- Sécurité / Injection SQL : Comment se protéger d'une injection SQL (c'est à dire du code SQL qui serait écrit dans un formulaire HTML par exemple)
-- Cryptographie : Comment crypter/hasher/chiffrer des données pour protéger nos utilisateurs des fuites de BDDs


