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
	llistat=$(grep -w -i -n "$codi_pais" cities.csv | cut -d ',' -f3 | cut -d ',' -f5)
	echo "$llistat"

#opcio 6 (lcp)
elif [[ $opcio == 'lcp' ]]; then
	llista=$(grep -w -i "$codi_pais" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista"

#opcio 7 (ecp)
elif [[ $opcio == 'ecp' ]]; then
	llista2=$(grep -w -i "$codi_pais" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista2" >> codi_pais.csv

#opcio 8 (lce)
elif [[$opcio == 'lce' ]]; then
	llista3=$(grep -w -i "$codi_estat" cities.csv | cut -d ',' -f2 | cut -d ',' -f11)
	echo "$llista3"

#opcio 9 (

fi
