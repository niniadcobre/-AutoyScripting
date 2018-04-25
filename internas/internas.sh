#!/bin/bash 

#NOTA: Observar que estamos re-definiendo nombre de funciones internas de bash

set -eu 

DEBUG=1

source modulos.sh 

#Se requiere siempre al menos un argumento. ¿Cómo haría para cambiar este
#comportamiento para ejecutar todas las funciones disponibles?

[[ $# -eq 0 ]] && ayuda 

#La función interna getopts interpreta los parametros posicionales
#en búsqueda de opciones soportadas por el script. En nuestro caso
#las opciones soportadas son ahls 
while getopts ahls opt; do
  case $opt in
   a) ALL=1  ;;
   h) ayuda ;;
   l) LIST=1;;
   s) SUBCONJ=1 ;;
   *) LIST=1
  esac
done

#Creo el listado de funciones que fueron definidas en modulos.sh
#usamos la convención de que cada función definida tenga en ella 
#la variable FN_[nombre=nombredefuncion] 

funciones=$(declare -f |grep FN_ |sed 's/;//' ) 

if [[ -v ALL ]];then 
  echo "Ejecutando todas las funciones definidas: "
  for f in $funciones;do
     ${f#FN_*=}
  done
elif [[ -v LIST ]];then 
  echo "El listado de funciones definidas es: "
  for f in $funciones;do
     echo -n "${f#FN_*=} "
  done
  echo 
elif [[ -v SUBCONJ ]];then
   #Este for itera sobre los parámetros posicionales ante la falta de 
   #la sentencia [in ...]
   shift #Descarto la opción -s ($1), asumo que a continuación se provee el 
         #listado de funciones a ejecutar. 
   for funct ;do # ¿Sobre qué itera la variable funct?
     $funct
   done
fi  

#El siguiente código muestra el listado de funciones efectivamente 
#ejecutadas. 
[[ -v DEBUG ]] && { printf "\nFunciones que fueron ejecutadas: \n"; for var in ${!FN_*};do 
   echo $var
done }
