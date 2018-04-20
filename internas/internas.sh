#!/bin/bash 

#NOTA: Observar que estamos re-definiendo nombre de funciones internas de bash

source () {

   FN_SOURCE=1
   printf "$FUNCNAME :
   Si queremos ejecutar un script en el shell en curso, es decir 
   sin crear un nuevo proceso, podemos hacerlo invocando source o . :
   Forma 1:    source script.sh [argumento1 argumento2..] 
   Forma 2:    . script.sh [argumento1 argumento2..]\n" 
   
   builtin source modulos.sh 
}


source 

for funct ;do 
  $funct
done 

for var in ${!FN_*};do 
   echo $var
done
