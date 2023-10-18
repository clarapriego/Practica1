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

elif [[$opcio == 'lce' ]]; then
	llista3=$(grep -w -i "$codi_estat" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista3"

#opcio 9 lce
#Obtenir dades d'una ciutat de la WikiData
elif [[ $opcio == 'gwd' ]]

fi
