#!/bin/bash  
# Piense si la línea anterior tiene sentido para un archivo que sólo define
# funciones. Piense qué sucedería si en lugar de invocar el script con source, 
# lo hacemos con ./modulos.sh o con  bash modulos.sh 
# Pregunta: ¿Cuando una función es definida, las sentencias que la componen son # efectivamente ejecutadas?

printf "Definiendo las funciones guardadas en $0 ...\n"

alias () {
   FN_ALIAS=1
   printf "$FUNCNAME: 
   En esta función definiremos alias que estarán disponibles durante 
   la ejecución del script. Recordar que si definimos alias en archivos
   como ser /etc/profile, .bashrc, etc. estos afectarán al funcionamiento. 
   Definiendo alias: \n"
   builtin alias pf='ps -ef' 

   #Pregunta: ¿Persisten los alias fuera de la función? ¿y fuera del script
   #principal?¿Qué sucede con los alias declarados en el proceso padre?

}

break () {
   FN_BREAK=1
   local -u resp 
   printf "$FUNCNAME: 
   Permite interrumpir CICLOS (infinitos o no), terminando todas las
   iteraciones siguientes del mismo. Probando break...\n"
   until ! : ;do 
     printf "Ciclo infinito usando until ¿Quisiera que se termine? S/N: "
     read resp
     [[ "$resp" == "S" ]] && builtin break 1
     for ((;;));do 
        printf "Ciclo infinito usando for... ¿Quiere que se termine todo? S/N: "
        read resp
        [[ "$resp" == "S" ]] && builtin break 2
        printf "Ciclo infinito usando for... ¿Quiere que se termine solo este ciclo? S/N: "
        read resp
        [[ "$resp" == "S" ]] && builtin break 1
      done
    done    
    #Nota de color... mientras testeaba esta función olvidé poner la palabra 
    #builtin ¿Qué creen que sucedió? \0/
}

continue () {
   FN_CONTINUE=1
   local -u resp 
   printf "$FUNCNAME: 
   Permite interrumpir ITERACIONES individuales, todas las sentencias que 
   siguen a continue, dentro de un ciclo, seran omitidas y se reanuda en 
   la próxima iteración. Probando continue...\n"
   while :;do 
     printf "Las sentencias a continuación son sorprendentes... ¿quiere verlas? S/N"
     read resp
     [[ "$resp" == "N" ]] && builtin continue
     printf "¿No más sorpresas? S/N"
     read resp
     [[ "$resp" == "N" ]] && builtin break
   done    
}
