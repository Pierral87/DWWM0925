-- UNION permet de fusionner des résultats en un seul 
-- En gros, le résultat de deux requêtes différentes peut être "UNION" dans un seul résultat
-- ATTENTION, le nombre de champs attendus doit être le même dans les requêtes concernées 

SELECT prenom AS liste_personnes FROM abonne 
UNION
SELECT auteur FROM livre;
+-------------------+
| liste_personnes   |
+-------------------+
| Guillaume         |
| Benoit            |
| Chloe             |
| Laura             |
| Pierre-Alex       |
| GUY DE MAUPASSANT |
| HONORE DE BALZAC  |
| ALPHONSE DAUDET   |
| ALEXANDRE DUMAS   |
+-------------------+
-- UNION applique un DISTINCT automatiquement pour sortir les doublons 

-- Pour avoir tous les doublons : 
-- UNION ALL 
SELECT prenom AS liste_personnes FROM abonne 
UNION ALL
SELECT auteur FROM livre;
+-------------------+
| liste_personnes   |
+-------------------+
| Guillaume         |
| Benoit            |
| Chloe             |
| Laura             |
| Pierre-Alex       |
| GUY DE MAUPASSANT |
| GUY DE MAUPASSANT |
| HONORE DE BALZAC  |
| ALPHONSE DAUDET   |
| ALEXANDRE DUMAS   |
| ALEXANDRE DUMAS   |
+-------------------+