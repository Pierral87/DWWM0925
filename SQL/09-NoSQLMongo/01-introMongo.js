/* 

Pour installer MongoDB sur votre poste, se rendre sur la doc officielle : https://www.mongodb.com/try/download/community
Section Products => Community 

On ne va pas utiliser MongoAtlas mais le Community Version qui nous permet d'installer MongoDB en local et le tester avec son terminal intégré "MongoDB Compass / Mongosh"

Le Langage de requête de mongoDB est basé sur JavaScript et sa manipulation de fichiers JSON, donc nous écrirons ce support de cours sur un fichier .js pour profiter de la colorisation de VS Code 

// Concept d'organisation des éléments dans MongoDB 

// Base -> Collection -> Document 

// La base est créée via l'interface Compass 
    // Ensuite on crée une collection et à l'intérieur de cette collection on insère des documents 
    // Ici pas besoin de définir de structure à notre document, nous sommes entièrement libre, contrairement à MySQL où je dois fournir des colonnes, leur type etc 

    // On extrait de la BDD entreprise tables employes un fichier JSON pour pouvoir le réintégrer dans notre base MongoDB

    on oublie de faire un use entreprise avant de lancer quelconque requête 

    Via l'opération db.employes.insertOne() 
    Je peux insérer un enregistrement de mon choix et je remarque tout de suite que je ne suis pas obligé de respecter une structure particulière 


*/

// -----------------------------------------------------------------
// -----------------------------------------------------------------
// --------- REQUETES D'INSERTION ----------------------------------
// -----------------------------------------------------------------
// -----------------------------------------------------------------
// -----------------------------------------------------------------

// On dispose de plusieurs fonctions d'insertion 
    // insertOne() : Nous permet d'ajouter un document 
    // insertMany() : Nous permet d'ajouter plusieurs document d'un coup 

// ATTENTION MongoDB est sensible à la casse !!! (alors que MySQL non !!) Il va bien différencier une majuscule d'une minuscule 
    // Attention aux erreurs car cela impactera forcément nos requêtes par la suite 

    // use entreprise;
    // On insère un nouvel employé dans la table, résultat visible sur Compass après un refresh ;) 
    db.employes.insertOne(
        {
            id_employes : 991,
            nom : "Lacaze",
            prenom : "Pierral",
            age : 37,
            service : "Formation",
            salaire : 12000
        }
    )

    // On remarque l'id auto généré de MongoDB 
        // Le système d'id de MongoDB fonctionne différement des id auto increment que l'on connait en MySQL 
            // MongoDB utilise un encodage hexadécimal correspond à plusieurs informations notamment la date/heure de l'insertion, numéro de l'insertion 

    // On peut insérer plusieurs avec insertMany
    db.employes.insertMany(
        [
            {
                nom : "L'éponge",
                prenom : "Bob",
                age : 12,
                service : "restauration",
                salaire : 10
            },

            {
                nom : "Spirou",
                age : 15,
                service : "hotellerie",
                salaire : 800
            }
        ]
    )


// -----------------------------------------------------------------
// -----------------------------------------------------------------
// --------- REQUETES DE SELECTION ---------------------------------
// -----------------------------------------------------------------
// -----------------------------------------------------------------
// -----------------------------------------------------------------

// Affichage d'un seul élément de notre collection
db.employes.findOne();

// Affichage complet de toutes les données de la table
db.employes.find();

// Conditions / Critères de recherche : Selection avec une condition, équivalent au WHERE en MySQL 
// On fournit entre accolades {} les conditions que l'on souhaite appliquer 

// Affichage des employés du service informatique 
db.employes.find({service : "informatique"});

// Projection : Affichage des champs souhaités 
// Affichage des prénoms uniquement sur la sélection du service informatique 
db.employes.find({service : "informatique"}, {prenom : 1});
// Il m'affichera toujours l'_id auto généré de Mongo, si je souhaite l'enlever ? Je peux l'appeler dans la projection
db.employes.find({service : "informatique"}, {prenom : 1, _id : 0}); // Ici l'_id ne s'affichera pas 
// En MySQL l'équivalent serait SELECT prenom FROM employes WHERE service = "informatique";

// EXERCICE : Tentez d'afficher la totalité des employés en affichant uniquement leur prénom et leur service 
db.employes.find({},{prenom : 1, service : 1, _id : 0});
// En MySQL l'équivalent serait SELECT prenom, service FROM employes;

// EXERCICE : Maintenant, affichons la liste des services 
db.employes.find({}, {service : 1, _id : 0});
// Ici on a la valeur du champs service pour chaque ligne 

// Si je veux la liste des service différent, comme en MySQL on a distinct 
db.employes.distinct("service");
// Cela nous renvoie une "liste" des services, sous forme de type : Array 
    // Un array / tableau array, c'est un type de données, qui permet de contenir plusieurs valeurs  

// En mongoDB les fonctions d'agrégation on appelle ça des "cursor modifier", cela permet d'intéragir avec le résultat
// Par exemple, la fonction count() 
db.employes.find({service : "informatique"}).count();
// 3  
// En Javascript "tout est objet" c'est pour ça que l'on continue une succession de . entre chaque élément
// objetDB.objetCollection.objetRetourReqFind.fonction();

// EXERCICE : Affichage du nombre de service distinct 
db.employes.distinct("service").length;
// Ici le distinct nous renvoie un array, le length c'est une fonction qu'on connait en JS qui nous retourne la longueur/taille d'un array, ce qui nous permet de compter le nombre de service 


// OPERATEURS DE COMPARAISON
// MongoDB possède tout un tas d'opérateur de comparaison qui nous permettent de manipuler nos requêtes en y appliquant des critères complexes 

// -- $eq    est égal
// -- $ne    est différent d'une valeur (not equal)
// -- $gt    est strictement supérieur à  (greater than) 
// -- $gte   est supérieur ou égal à (greather than/equal)
// -- $lt    est strictement inférieur à (lesser than)
// -- $lte   est inférieur ou égal à (lesser than/equal)
// -- $in    est égale à une des valeurs parmis une liste (in)
// -- $nin   est différent d'au moins des valeurs parmis une liste (not in)

// EXCLUSION 
// Tous les employés d'un service, sauf un, par exemple le service commercial 
db.employes.find({service : {$ne : "commercial"}});

// Les employés avec un salaire supérieur à 3000 
db.employes.find({salaire : {$gt : 3000}}, {prenom : 1, nom : 1, service : 1, salaire : 1}); // Ca ne me retourne pas grand chose.... Aïe... Les salaires sont en string dans ma collection à cause de l'export de données JSON de la table SQL   :(   
db.employes.find({salaire : {$gt : "3000"}}, {prenom : 1, nom : 1, service : 1, salaire : 1}); // Je peux faire la comparaison sur le champ en string, mais on perd en cohérence de la donnée, c'est un des inconvénients du NoSQL de ne pas avoir un schéma solide comme le MySQl

// La notion équivalente à BETWEEN
// Affichage des employés ayant été embauché entre 2015 et aujourd'hui
db.employes.find({
    date_embauche : {
        $gte :"2015-01-01",
         $lte : "2023-08-18"
        }
    });

// L'utilisation un objet Date est notre seule façon de manipuler une information équivalente au CURDATE() de MySQL, mais pour pouvoir le comparer convenablement dans notre base il faudrait que tous les champs date soit au format objetDate et non pas string
    db.employes.find({
        date_embauche : {
            $gte : new Date("2015-01-01"),
             $lte : new Date()
            }
        });

        
// IN & NOT IN  pour tester plusieurs valeurs 
// Affichage des employes des services commercial et comptabilite
db.employes.find({
    service: { $in: ["commercial", "comptabilite"] }
})

// L'inverse (les employés des services ne faisant pas parti ni de commercial ni de comptabilite):
db.employes.find({
    service: { $nin: ["commercial", "comptabilite"] }
})

// Plusieurs conditions : AND 
// Il suffit de spécifier les critères de selection les uns après les autres 
// On veut les employés du service commercial ayant un salaire inférieur ou égal à 2000
db.employes.find({
    service: "commercial",
    salaire: { $lte: "2000" }
});

// L'une ou l'autre d'un ensemble de conditions : OR 
// Affichage des employes des services commercial et comptabilite à nouveau
db.employes.find({
    $or: [
        { service: "commercial" },
        { service: "comptabilite" }
    ]
});

// EXERCICE : employes du service production ayant un salaire égal à 1900 ou 2300, VERIFIER vos résultats
db.employes.find({
    $or: [
        { service: "production" },
        { salaire: "1900" },
        { salaire: "2300" }
    ]
});
// Probleme ici, cela nous sort tous les employes de production, tous les employes ayant 1900, tous les employes ayant 2300

// Bonne réponse :
db.employes.find({
    service: "production",
    $or: [
        { salaire: "1900" },
        { salaire: "2300" }
    ]
});
// ou 
db.employes.find({
    service: "production",
    salaire: { $in: ["1900", "2300"] }
})



// Recherche de la valeur approchante par regex (expression regulière)  => Equivalent à LIKE en MySQL 
// Cela nous permet de rechercher une information sans l'écrire complètement 
// Affichage des prénoms commençant par la lettre "s"
db.employes.find({
    prenom: {
        $regex: "^s",
        $options: "i"  // Option "i" pour une recherche insensible à la casse
    }
});

// Affichage des prénoms finissant par les lettres "ie"
db.employes.find({
    prenom: {
        $regex: "ie$",
        $options: "i"  // Option "i" pour une recherche insensible à la casse
    }
});

// Affichage des prénoms contenant les lettres "ie" (début, fin, milieu)
db.employes.find({
    prenom: {
        $regex: "ie",
        $options: "i"  // Option "i" pour une recherche insensible à la casse
    }
});

// On a toujours besoin d'utiliser des recherches à valeur approchante, pour des champs de recherche de produits ou des filtres par exemple 


// CLASSEMENT DES RESULTATS avec sort()   --- équivalent à ORDER BY 

// Affichage des employes dans l'ordre alphabétique 
db.employes.find({}).sort({ nom: 1 });
// Par ordre alphabétique inversé 
db.employes.find({}).sort({ nom: -1 });

// Il est possible d'ordonner par plusieurs champs si jamais le premier a des valeurs similaires (par exemple à l'intérieur du bloc des 6 commerciaux, on veut ordonner ces 6 personnes en alphabétique par nom)
db.employes.find({}, {prenom : 1, nom : 1, service : 1}).sort({ service: 1, nom: 1 });

// On peut faire en sorte de renommer nos champs en manipulant la projection
db.employes.find({}, {nomComplet : {$concat: ["$nom", " ", "$prenom"]}, service : 1}).sort({ service: 1, nom: 1 });




// LIMITER UN NOMBRE DE RESULTAT avec limit() puis skip()

// Affichage des employes 3 par 3
db.employes.find({}).limit(3);

// skip() nous permet de sauter un certains nombre de résultat
db.employes.find({}).skip(3).limit(3);

db.employes.find({}).skip(6).limit(3);


// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// --  REQUETES DE MODIFICATION (On modifie un ou plusieurs documents) -------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

// Plusieurs fonctions sont disponibles 
// updateOne, updateMany, replaceOne

// updateOne pour modifier un seul document
//  on modifie le salaire d'un employe

// l'opérateur $set nous permet de modifier la valeur d'un champ 
db.employes.updateOne(
    { id_employes: 991 },
    { $set: { salaire: 2000 } }
)

// Plusieurs modifications sont possibles en une seule fois
db.employes.updateOne(
    { id_employes: 991 },
    {
        $set: {
            salaire: 2200,
            service: "web"
        }
    }
)

// updateMany pour modifier plusieurs documents en une seule opération
// On modifie plusieurs documents en changeant le service informatique par web
db.employes.updateMany(
    { service: "informatique" },
    { $set: { service: "web" } }
)

// replaceOne pour remplacer un document existant par un autre
// Cela efface entièrement le document d'origine pour le remplacer par le document fourni
db.employes.replaceOne(
    { id_employes: 991 },
    {
        id_employes: 991,
        prenom: "Polo",
        nom: "Lac",
        service: "vente",
        salaire: 2500
    }
)
// Contrairement à MySQL et la fonction REPLACE(), comme MongoDB ne gère pas le système de relation et contraintes, cette opération n'est pas problématique

// On peut supprimer totalement un champ d'un document avec $unset 
db.employes.updateOne(
    { id_employes: 991 },
    { $unset: { salaire: "" } }
 );
// on $set pour l'y remettre
 db.employes.updateOne(
    { id_employes: 991 },
    { $set: { salaire: 1800 } }
 );

// On peut renommer simplement un champ sans en modifier sa valeur 
// On champ le nom du champ service par departement
db.employes.updateMany(
    {},
    { $rename: { service: "departement" } }
 );
 db.employes.updateMany(
    {},
    { $rename: { departement: "service" } }
 );

// On utilise aussi souvent l'opérateur de modification $currentDate pour mettre un champ sur la valeur de l'instant T  (pas utilisable facilement lors d'une insertion et selection, donc approprié aux updates)
 db.employes.updateOne(
    { id_employes: 991 },
    { $currentDate: { date_modification: true } }
 );

 db.employes.updateOne(
    { id_employes: 991 },
    { $currentDate: { date_embauche: true } }
 );


// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// --  REQUETES DE SUPPRESSION (On supprime un ou plusieurs documents) -------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

// Deux fonctions concernent les suppressions : deleteOne(), deleteMany()
// Suppression de l'employé 991 
db.employes.deleteOne({ id_employes: 991 });

// Suppression de tous les employés ayant un id supérieur à 990 
db.employes.deleteMany({ id_employes: { $gt: 990 } });

// Suppression de tous les informaticiens sauf celui possédant l'id 701
db.employes.deleteMany({
    service: "informatique",
    id_employes: { $ne: 701 }
})

// Suppression de deux employés qui n'ont pas de point commun
db.employes.deleteMany({
    id_employes: { $in: [701, 630] }
})

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------
// -- EXERCICES :
// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

// -- 1 -- Afficher la profession de l'employé 547.
// -- 2 -- Afficher la date d'embauche d'Amandine.	
// -- 3 -- Afficher le nom de famille de Guillaume	
// -- 4 -- Afficher le nombre de personne ayant un n° id_employes commençant par le chiffre 5.	
// -- 5 -- Afficher tous les employés du service commercial.
// -- 6 -- Afficher le nombre de commerciaux.
// -- 7 -- Afficher les 5 premiers employés après avoir classé leur nom de famille par ordre alphabétique. 
// -- 8 -- Afficher le nombre de recrutement sur l'année 2010.	
// -- 9 -- Afficher tous les employés sauf ceux du service production et secrétariat.
// -- 10 -- Afficher les commerciaux ayant été recrutés avant 2012 de sexe masculin et gagnant un salaire supérieur a 2500 €
// -- 11 -- Qui a été embauché en dernier
// -- 12 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
// -- 13 -- Afficher le prénom du comptable gagnant le meilleur salaire
// -- 14 -- Afficher le prénom de l'informaticien ayant été recruté en premier
// -- 15 -- Modifier à 2800 le salaire de l'employé 990
// -- 16 -- Modifier le service de tous les employés masculins du service "secretariat" pour le mettre à "administration".
// -- 17 -- Modifier le service de l'employé avec l'ID 876 pour le mettre à "communication" et son salaire à 2800.
// -- 18 -- Supprimer les employés du service administration
// -- 19 -- Supprimer tous les employés dont le nom commence par "D"
// -- 20 -- Supprimer tous les employés féminins du service "secretariat" avec un salaire inférieur à 1600.



