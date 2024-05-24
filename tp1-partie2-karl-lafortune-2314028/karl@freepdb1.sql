//1.	R�digez les requ�tes qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
desc outils_emprunt;
desc outils_outil;
desc outils_usager;
//2.	R�digez la requ�te qui affiche la liste de tous les usagers, sous le format pr�nom � espace � nom de famille (indice : concat�nation). /2
select 
nom_famille || ' ' || prenom as "Nom et pr�nom de l'usager"
from outils_usager;
//3.	R�digez la requ�te qui affiche le nom des villes o� habitent les usagers, en ordre alphab�tique, le nom des villes va appara�tre seulement une seule fois. /2
select distinct
ville as "Nom de la Ville",
nom_famille || ' ' || prenom as "Nom et pr�nom de l'usager"
from outils_usager
order by ville;
//4.	R�digez la requ�te qui affiche toutes les informations sur tous les outils en ordre alphab�tique sur le nom de l�outil puis sur le code. /2
select *
from outils_outil
order by nom,code_outil;
//5.	R�digez la requ�te qui affiche le num�ro des emprunts qui n�ont pas �t� retourn�s. /2
select 
num_emprunt "Numero Emprunt"
from outils_emprunt
where date_retour is null;
//6.	R�digez la requ�te qui affiche le num�ro des emprunts faits avant 2014. /3
select 
num_emprunt "Numero Emprunt"
from outils_emprunt
where extract(YEAR FROM date_emprunt)<2014;
//7.	R�digez la requ�te qui affiche le nom et le code des outils dont la couleur d�but par la lettre � j � (indice : utiliser UPPER() et LIKE) /3
select 
code_outil as "Code de l'outil",
nom Nom,
caracteristiques Caract�ristiques
from outils_outil
where UPPER(caracteristiques) like '%J%';
//8.	R�digez la requ�te qui affiche le nom et le code des outils fabriqu�s par Stanley. /2
select
code_outil as "Code de l'outil",
nom Nom
from outils_outil
where UPPER(Fabricant)like 'S%';
//9.	R�digez la requ�te qui affiche le nom et le fabricant des outils fabriqu�s de 2006 � 2008 (ANNEE). /2
select
fabricant Fabricants,
nom Nom
from outils_outil
where annee between 2006 and 2008;
//10.	R�digez la requ�te qui affiche le code et le nom des outils qui ne sont pas de � 20 volt �. /3
select
code_outil as "Code de l'outil",
nom Nom
from outils_outil
where caracteristiques not like '%20 volt%';
//11.	R�digez la requ�te qui affiche le nombre d�outils qui n�ont pas �t� fabriqu�s par Makita. /2
select count(*) as "Nom d'outil non Makita"
from outils_outil
where upper(fabricant) <> 'MAKITA';
//12.	R�digez la requ�te qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l�usager, le num�ro d�emprunt, la dur�e de l�emprunt et le prix de l�outil (indice : n�oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5

select 
a.nom_famille ||' '|| a.prenom as "Nom et Prenom",
a.ville Ville,
a.num_usager "Numero usager",
b.num_emprunt "Numero Emprunt",
(b.date_retour-b.date_emprunt) as "Dur�e de l'emprunt",
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
//13.	R�digez la requ�te qui affiche le nom et le code des outils emprunt�s qui n�ont pas encore �t� retourn�s. /4
select 
a.code_outil,
a.nom Nom
from outils_outil a
inner join outils_emprunt b on a.code_outil = b.code_outil
where b.date_retour is null;
//14.	R�digez la requ�te qui affiche le nom et le courriel des usagers qui n�ont jamais fait d�emprunts. (Indice : IN avec sous-requ�te) /3
select 
a.prenom || ' ' || a.nom_famille as "Nom et Prenom",
a.courriel "Courriel"
from outils_usager a 
where  a.num_usager  not IN(select b.num_usager from outils_emprunt b);
//15.	R�digez la requ�te qui affiche le code et la valeur des outils qui n�ont pas �t� emprunt�s. (Indice : utiliser une jointure externe � LEFT OUTER, aucun NULL dans les nombres) /4
select
a.code_outil Code,
a.prix Valeur
from outils_outil a
left join outils_emprunt b on a.code_outil=b.code_outil
where b.code_outil is null; 
//16.	R�digez la requ�te qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est sup�rieur � la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
select 
nom Nom,
coalesce(prix,(select avg(prix) from outils_outil)) as "prix"
from outils_outil
where  prix > (select avg(prix) from outils_outil) AND fabricant = 'Makita';
//17.	R�digez la requ�te qui affiche le nom, le pr�nom et l�adresse des usagers et le nom et le code des outils qu�ils ont emprunt�s apr�s 2014. Tri�s par nom de famille. /4
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
//18.	R�digez la requ�te qui affiche le nom et le prix des outils qui ont �t� emprunt�s plus qu�une fois. /4

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


//19.	R�digez les trois requ�tes qui affiche le nom, l�adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant la m�thode indiqu�e ci-bas : /6
//    �	Une jointure
//    �	IN
//    �	EXISTS
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

//20.	R�digez la requ�te qui affiche la moyenne du prix des outils par marque. /3
SELECT 
    fabricant AS "Marque",
    AVG(prix) AS "Prix Moyen"
FROM 
    outils_outil
GROUP BY 
    fabricant
ORDER BY 
    "Prix Moyen" DESC;

//21.	R�digez la requ�te qui affiche la somme des prix des outils emprunt�s par ville, en ordre d�croissant de valeur. /4
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
//22.	R�digez la requ�te pour ins�rer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO outils_outil (code_outil, nom, fabricant, caracteristiques, annee, prix)
VALUES ('001', 'Perceuse', 'Makita', 'jaune', '2023', 150.00);

//23.	R�digez la requ�te pour ins�rer un nouvel outil en indiquant seulement son nom, son code et son ann�e. /2
INSERT INTO outils_outil (code_outil, nom, annee)
VALUES ('123', 'Scie circulaire', 2023);

//24.	R�digez la requ�te pour effacer les deux outils que vous venez d�ins�rer dans la table. /2
DELETE FROM outils_outil
WHERE code_outil IN ('123', '124');

//25.	R�digez la requ�te pour modifier le nom de famille des usagers afin qu�ils soient tous en majuscules. /2
UPDATE outils_usager
SET nom_famille = UPPER(nom_famille);
