//1.	Rédigez les requêtes qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
desc outils_emprunt;
desc outils_outil;
desc outils_usager;
//2.	Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
select 
nom_famille || ' ' || prenom as "Nom et prénom de l'usager"
from outils_usager;
//3.	Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
select distinct
ville as "Nom de la Ville",
nom_famille || ' ' || prenom as "Nom et prénom de l'usager"
from outils_usager
order by ville;
//4.	Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
select *
from outils_outil
order by nom,code_outil;
//5.	Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
select 
num_emprunt "Numero Emprunt"
from outils_emprunt
where date_retour is null;
//6.	Rédigez la requête qui affiche le numéro des emprunts faits avant 2014. /3
select 
num_emprunt "Numero Emprunt"
from outils_emprunt
where extract(YEAR FROM date_emprunt)<2014;
//7.	Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
select 
code_outil as "Code de l'outil",
nom Nom,
caracteristiques Caractéristiques
from outils_outil
where UPPER(caracteristiques) like '%J%';
//8.	Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
select
code_outil as "Code de l'outil",
nom Nom
from outils_outil
where UPPER(Fabricant)like 'S%';
//9.	Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
select
fabricant Fabricants,
nom Nom
from outils_outil
where annee between 2006 and 2008;
//10.	Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volt ». /3
select
code_outil as "Code de l'outil",
nom Nom
from outils_outil
where caracteristiques not like '%20 volt%';
//11.	Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
select count(*) as "Nom d'outil non Makita"
from outils_outil
where upper(fabricant) <> 'MAKITA';
//12.	Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5

select 
a.nom_famille ||' '|| a.prenom as "Nom et Prenom",
a.ville Ville,
a.num_usager "Numero usager",
b.num_emprunt "Numero Emprunt",
(b.date_retour-b.date_emprunt) as "Durée de l'emprunt",
c.prix
from outils_usager a
inner join outils_emprunt b
on a.num_usager =b.num_usager 
inner join outils_outil c
on b.code_outil = c.code_outil
WHERE 
    a.VILLE IN ('Vancouver', 'Regina')
    AND b.date_retour IS NOT NULL
    AND b.date_emprunt IS NOT NULL;
//13.	Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
select 
a.code_outil,
a.nom Nom
from outils_outil a
inner join outils_emprunt b on a.code_outil = b.code_outil
where b.date_retour is null;
//14.	Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (Indice : IN avec sous-requête) /3
select 
a.prenom || ' ' || a.nom_famille as "Nom et Prenom",
a.courriel "Courriel"
from outils_usager a 
where  a.num_usager  not IN(select b.num_usager from outils_emprunt b);
//15.	Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (Indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
select
a.code_outil Code,
a.prix Valeur
from outils_outil a
left join outils_emprunt b on a.code_outil=b.code_outil
where b.code_outil is null; 
//16.	Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
select 
nom Nom,
coalesce(prix,(select avg(prix) from outils_outil)) as "prix"
from outils_outil
where  prix > (select avg(prix) from outils_outil) AND fabricant = 'Makita';
//17.	Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
select
a.nom_famille Nom,
a.prenom Prenom,
a.adresse Adresse,
c.nom "Nom Outil",
c.code_outil "Code Outil"

from outils_usager a inner join outils_emprunt b on a.num_usager = b.num_usager
inner join outils_outil c on b.code_outil = c.code_outil
where extract(YEAR from b.date_emprunt)>2014
order by a.nom_famille;
//18.	Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4

SELECT 
    o.nom AS "Nom",
    o.prix AS "Prix"
FROM 
    outils_outil o
JOIN 
    (SELECT code_outil
     FROM outils_emprunt
     GROUP BY code_outil
     HAVING COUNT(code_outil) > 1) e ON o.code_outil = e.code_outil;


//19.	Rédigez les trois requêtes qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant la méthode indiquée ci-bas : /6
//    •	Une jointure
//    •	IN
//    •	EXISTS
SELECT DISTINCT
    u.nom_famille ||' '|| u.prenom as "Nom",
    u.adresse,
    u.ville
FROM 
    outils_usager u
JOIN 
    outils_emprunt e ON u.num_usager = e.num_usager;
    
    SELECT 
    nom_famille ||' '|| prenom as "Nom",

    adresse,
    ville
FROM 
    outils_usager
WHERE 
    num_usager IN (SELECT num_usager FROM outils_emprunt);
    SELECT 
   nom_famille ||' '|| u.prenom as "Nom" ,
    adresse,
    ville
FROM 
    outils_usager u
WHERE EXISTS (
    SELECT 1
    FROM outils_emprunt e
    WHERE e.num_usager = u.num_usager
);

//20.	Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT 
    fabricant AS "Marque",
    AVG(prix) AS "Prix Moyen"
FROM 
    outils_outil
GROUP BY 
    fabricant
ORDER BY 
    "Prix Moyen" DESC;

//21.	Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT 
    u.ville AS "Ville",
    SUM(o.prix) AS "Somme des Prix"
FROM 
    outils_usager u
JOIN 
    outils_emprunt e ON u.num_usager = e.num_usager
JOIN 
    outils_outil o ON e.code_outil = o.code_outil
GROUP BY 
    u.ville
ORDER BY 
    "Somme des Prix" DESC;
//22.	Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO outils_outil (code_outil, nom, fabricant, caracteristiques, annee, prix)
VALUES ('001', 'Perceuse', 'Makita', 'jaune', '2023', 150.00);

//23.	Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2
INSERT INTO outils_outil (code_outil, nom, annee)
VALUES ('123', 'Scie circulaire', 2023);

//24.	Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM outils_outil
WHERE code_outil IN ('123', '124');

//25.	Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE outils_usager
SET nom_famille = UPPER(nom_famille);
