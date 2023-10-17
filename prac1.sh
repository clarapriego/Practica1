#!/bin/bash
read -p "Opció: " opcio
codi_pais="XX"
codi_estat="XX"


#opcio 1 (q)
if [[ $opcio == 'q' ]]; then
	echo "Sortint de l'aplicació"

#opcio 2 (lp)
elif [[ $opcio == 'lp' ]]; then
	cat citiespaises2.csv

#opcio 3 (sc)

elif [[ $opcio == 'sc' ]]; then
	read -p "Introdueix pais: " pais
	codi_pais=$(grep -w "$pais" cities.csv | awk -F ',' 'NR==1 {print $7}')
	echo $codi_pais
	if [[ $pais == '\n' ]]; then
		codi_pais=$codi_pais
		echo $codi_pais
	fi

#opcio 4 (se)

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

elif [[ $opcio == 'le' ]]; then
	llistat=$(grep -w -i -n "$codi_pais" cities.csv | cut -d
	echo "aun no"
fi
