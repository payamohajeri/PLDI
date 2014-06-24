#!/bin/bash

FunctionName=$1;
LineNumber=$2;
CallingType=$3;
AllLines=`wc -l ./$FunctionName/Instructions.txt | cut -d ' ' -f 1`;
NewValue=`sed -n $LineNumber'p' ./$FunctionName/Instructions.txt | cut -f 2`;
LocalParam=`sed -n $LineNumber'p' ./$FunctionName/Instructions.txt | cut -f 1`;
GlobalParam=`cat ./Calling/$FunctionName/$LocalParam | cut -f 3`;
case $CallingType in
	"VR")
		echo $NewValue > ./$FunctionName/Values/$LocalParam;
		;;
	"V")
		echo $NewValue > ./$FunctionName/Values/$LocalParam;
		;;
	"R")
		echo $NewValue > ./$FunctionName/Values/$LocalParam;
		;;
	"Ref")
		echo $NewValue > ./$FunctionName/Values/$LocalParam;
		echo $NewValue > ./Main/Values/$GlobalParam;
		;;
	*)
		echo "Unknown Calling Type !!! , Something in wrong !!!"
		;;
esac
