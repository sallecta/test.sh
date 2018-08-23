#!/bin/bash          

if [ "$1" = "" ]
    then
        echo no input filename        
        exit
fi

fileIn=$1
fileOut="out_"$1
#rm $fileOut

if [ -e $fileIn ]
    then
        #echo "file input exists"

        mkdir --parents tmp

        #cmdTestnOutput="$(ls -llmn)"\t\t
        cmdRunOutput="$((/usr/bin/time -f 'seconds: %e; max resident memory: %M KB ' ./streamFileCopyfrom $fileIn)2>tmp/time.txt )"
        cmdCompOutput="$(cmp -s $fileIn $fileOut && echo 'identical' || echo 'different')"
        cmdGetSizeOutput="$(stat --printf="%s" $fileIn)"
        cmdGetTimeTestsOutput="$(cat tmp/time.txt)"
        echo "-------------------"
        echo "${cmdRunOutput}"
        echo "-------------------"
        echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::"
        echo "|||||||||||||||||||||||||||||||||||||||||||||||||||::"
        echo -e "\t\t\t\t\t\t|||::"
        echo -e " file size: ${cmdGetSizeOutput}\t\t\t\t|||::"
        echo -e " copy result: ${cmdCompOutput}\t\t\t\t|||::"
        echo -e " ${cmdGetTimeTestsOutput}\t|||::"
        echo -e "\t\t\t\t\t\t|||::"
        echo "|||||||||||||||||||||||||||||||||||||||||||||||||||::"
        echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::"
     
        rm --force --recursive tmp

    else
        echo "file input does not exist."
    fi


 
