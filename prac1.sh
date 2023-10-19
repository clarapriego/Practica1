#!/bin/bash
read -p "Opció: " opcio
codi_pais="XX"
codi_estat="XX"


#opcio 1 (q)
#Sortir de la aplicació/tancar el programa

if [[ $opcio == 'q' ]]; then
	echo "Sortint de l'aplicació"

#opcio 2 (lp)
#Llistar els països que hi ha en l'arxiu
#Per mostrar només una vegada els països ho indiquem amb el 'cut'

elif [[ $opcio == 'lp' ]]; then
	cat citiespaises2.csv

#opcio 3 (sc)
#Seleccionar un dels països introduïnt-lo amb el teclat
#El programa llegeix el pais i el busca amb 'grep' per poder imprimir després només la columna del codi que és la 7

elif [[ $opcio == 'sc' ]]; then
	read -p "Introdueix pais: " pais
	codi_pais=$(grep -w "$pais" cities.csv | awk -F ',' 'NR==1 {print $7}')
	echo $codi_pais
	if [[ $pais == '\n' ]]; then
		codi_pais=$codi_pais
		echo $codi_pais
	fi

#opcio 4 (se)
#Seleccionar un dels estats introduïnt-lo amb el teclat
#Busquem el pais peer després imprimir el codi d'aquest

elif [[ $opcio == 'se' ]]; then
	read -p "Introdueix estat: " estat
	if [[ $estat == '\n' ]]; then
		codi_estat=$codi_estat
	fi

	linea_pais=$(grep -w -i -n "$codi_pais" cities.csv | cut -d ':' -f1)
	if [[ -v $linea_pais ]];
	then
		codi_estat=$codi_estat
	else
		codi_estat=$(awk 'NR == $linea_pais {print $4}' cities.csv)
	
	echo $codi_estat
	fi

#opcio 5 (le)
#Llista dels estats del país seleccionat previament amb l'opcio 'sc'
#Busquem el codi del pais per després només imprimir la columna dels estats i dels codis corresponents

elif [[ $opcio == 'le' ]]; then
	llistat=$(grep -w -i -n "$codi_pais" cities.csv | cut -d ',' -f3 | cut -d ',' -f5)
	echo "$llistat"

#opcio 6 (lcp)
#Llista de les poblacions del país seleccionat anteriorment
#Fem la mateixa busqueda que a l'opció anteiror i aquest cop volem les columnes 2 (poblacions) i 11 (poblacions)

elif [[ $opcio == 'lcp' ]]; then
	llista=$(grep -w -i "$codi_pais" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista"

#opcio 7 (ecp)
#Extreu les poblacions del país ja seleccionat per guardar-les
#En aquesta opcio fem el mateix d'abans, però el 'echo' el coloquem en un arxiu nou

elif [[ $opcio == 'ecp' ]]; then
	llista2=$(grep -w -i "$codi_pais" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista2" >> codi_pais.csv

#opcio 8 (lce)
#Llista de les poblacions de l'estat seleccionat abans
#Una versió semblant a la 6 però ara fem el 'grep' del codi de l'estat

elif [[ $opcio == 'lce' ]]; then
	llista3=$(grep -w -i "$codi_estat" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista3"

#opcio 9 (lce)
#Extreure les poblacions de l'estat seleccionat abans
#L'únic que fem és pasar el 'echo' que hem fet en l'opció anterior al nou arxiu

elif [[ $opcio == 'lce' ]]; then
	llista4=$(grep -w -i "$codi_estat" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista4" >> <$codi_pais>_<$codi_estat>.csv

#opcio 10 (gwd)
#Obtenir dades d'una ciutat de la WikiData
#Primer mirem que la poblacio sorrespon a l'estat seleccionat
#Després guardem el wikidata de la poblacio en una variable per poder guardar-ho en l'arxiu

elif [[ $opcio == 'gwd' ]]; then
	codi_poblacio='XX'
	read -p "Introdueix població: " poblacio
        linea_poblacio=$(grep -w -i -n "$poblacio" cities.csv | cut -d ':' -f1)
        if [[ $linea_poblacio == $linea_pais ]];
        then
                codi_poblacio=$codi_poblacio
        else
                codi_poblacio=$(awk 'NR == $linea_poblacio {print $11}' cities.csv)
		curl -o $codi_poblacio https://www.wikidata.org/wiki/Special:EntityData/<$codi_poblacio>.json
	fi

#opcio 11 (est)
#Obtenir estadístiques apartir de l'arxiu

elif [[ $opcio == 'est' ]]; then
	nord=0
	sud=0
	est=0
	oest=0
	no_ubic=0
	no_wiki=0

	latituts=$(awk -F ',' '{print $9}')
	longituts=$(awk -F ',' '{print $9}')
	
	while IFS = read -r linia1;
	do
		if [[ $linia1 -gt 0 ]]; then
			nord=$nord+1
		elif [[ 0 -gt $linia1 ]]; then
			sud=$sud+1
	done < $latituts
	
	while IFS = read -r linia2;
	do
		if [[ $linia2 -gt 0 ]]; then
			est=$est+1
		if [[ 0 -gt $linia2 ]]; then
			oest=oest+1

	echo "Nord $nord Sud $sud Est $est Oest $oest No ubic $no_ubic No Wikidata $no_wiki \n"

fi
