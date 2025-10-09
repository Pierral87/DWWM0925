-- Les transactions sont possibles avec le moteur de DB : InnoDB 
-- Les transactions nous permettent de créer un environnement de travail, une sorte de zone tampon temporaire afin d'exécuter des requêtes pour ensuite soit les valider ou au contraire les annuler 
-- On s'en sert souvent en web lorsqu'une opération est composée de plusieurs requêtes qui sont liés, par exemple virement bancaire, j'enlève de l'argent à Pierre pour donner à Paul.
    -- Il faut absolument que toutes les requêtes d'une transaction fonctionnent, sinon on les annulera !  


-- On manipule généralement avec notre langage back, mais c'est une fonctionnalité qui existe déjà dans le MySQL brut que l'on peut manipuler avec la console 


USE entreprise; 


START TRANSACTION; -- Démarre la transaction 

SELECT * FROM employes; -- Je vérifie mes données

-- On va appliquer une modification à la table 

UPDATE employes SET salaire = +100; -- Ici je me trompe dans ma requête... Au lieu d'augmenter tout le monde de 100€, je mets tout le monde à 100€ !!! 
                                    -- Heureusement je suis dans une transaction, donc je peux ROLLBACK (annuler), cette opération et revenir dans l'état d'origine avant transaction 

ROLLBACK;  -- L'instruction qui me permet d'annuler toutes les requêtes de la transaction
COMMIT;     -- L'instruction qui me permet de valider toutes les requêtes de la transaction


-- Il existe aussi des transactions avec des "savepoint" qui en gros, permettent de faire des ROLLBACK à un moment précis de la transaction, pour retenter des actions
    -- On lancera des instructions de type ROLLBACK TO point1;