#!/bin/sh

#Recherche des nom d'entreprises basé sur les fichiers Coordonnees.txt et TypesEntreprises.txt
docker run -v `pwd`/files:/files r-pro-scraper entreprises /files/ /files/

#Ajout des entreprises à la db
docker run -v `pwd`/files:/ r-pro-etl

#Recherche de commentaires sur les entreprises
docker run -v `pwd`/files:/files r-pro-scraper commentaires /files/ "Server=localhost;Port=33062;Database=projetsynthese;Uid=root;Pwd=HdntL3T8Wnsuasp6;"

#Ajout des commentaires à la db
docker run -v `pwd`/files:/ r-pro-etl