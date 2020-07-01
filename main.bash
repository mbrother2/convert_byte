#!/bin/bash
_convert_byte(){
    OPTIND=1
    SUM_ARG=$(($#+1))
    while getopts 'v:a:ru' OPTION
    do
      case ${OPTION} in
        v)  VALUE=${OPTARG} ;;
        a)  AFTER=${OPTARG} ;;
        r)  ROUND=1 ;;
        u)  UNIT=1 ;;
      esac
    done
    if [ ${VALUE} -ge 1073741824 ]
    then
        DEVIDE=1073741824
        SUFFIX_UNIT="GB"
    elif [ ${VALUE} -ge 1048576 ]
    then
        DEVIDE=1048576
        SUFFIX_UNIT="MB"
    elif [ ${VALUE} -ge 1024 ]
    then
        DEVIDE=1024
        SUFFIX_UNIT="KB"
    else
        DEVIDE=1
        SUFFIX_UNIT="B"
    fi
    if [ $(( ${VALUE} % ${DEVIDE} )) -eq 0 ]
    then
        VALUE=$(( ${VALUE} / ${DEVIDE} ))
    else
        VALUE=`awk "BEGIN {printf \"%.${AFTER}f\n\", ${VALUE} / ${DEVIDE}}"`
    fi
    [[ "${ROUND}" == "1" ]] && VALUE=`echo ${VALUE} | awk '{print int($1+0.5)}'`
    [[ "${UNIT}" == "1" ]] && VALUE="${VALUE}${SUFFIX_UNIT}"
    echo $VALUE
}

# Example 
_convert_byte -v 12345 -a 2 -ru
