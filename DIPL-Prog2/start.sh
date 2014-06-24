#!/bin/bash

./parser.sh;
CallNumbers=`wc -l ./Main/FunctionCall.txt | cut -d ' ' -f 1`;
for i in `seq 1 $CallNumbers`
do
	FunctionName=`sed -n $i'p' ./Main/FunctionCall.txt | cut -f 1`;
	echo "*********************************************"
	echo "Before Function : $FunctionName"
	echo "*********************************************"
	./print.sh $FunctionName;
	mkdir -p ./Calling/$FunctionName;
	Column=`sed -n $i'p' ./Main/FunctionCall.txt | awk -F $'\t' '{print NF}'`;
	Parameters=`sed -n $i'p' ./Main/FunctionCall.txt | cut -f 3-$(($Column-1))`;
	Number=1;
	for j in `seq 3 $(($Column-1))`
	do
		FunctionParameter=`cat ./$FunctionName/Prameters/$Number`;
		PassingParameter=`sed -n $i'p' ./Main/FunctionCall.txt | cut -f $j`;
		PassingType=`cat ./Main/Variables/$PassingParameter | cut -f 1`;
		CallingType=`cat ./$FunctionName/Prameters/$FunctionParameter`;
		echo $CallingType$'\t'$PassingType$'\t'$PassingParameter >> ./Calling/$FunctionName/$FunctionParameter;
		echo $FunctionParameter$'\t'"->"$'\t'$CallingType$'\t'$PassingType$'\t'$PassingParameter;
		Number=$(($Number+1));
		if [[ $CallingType != "R" ]]; then
			NewValue=`cat ./Main/Values/$PassingParameter`;
			echo $NewValue > ./$FunctionName/Values/$FunctionParameter;
		fi
	done
	echo $'\n'"Press Enter To Continue.";
	read temp;
	echo "*********************************************"
	echo "Defenition of Function : $FunctionName"
	echo "*********************************************"
	./print.sh $FunctionName;
	InstructionNumbers=`wc -l ./$FunctionName/Instructions.txt | cut -d ' ' -f 1`;
	for k in `seq 1 $InstructionNumbers`
	do
		echo "*********************************************"
		echo "Inside Function : $FunctionName"
		echo "Instruction Line Number : $k"
		echo "*********************************************"
		echo $'\n'"Press Enter To Continue.";
		read temp;
		Parameter=`sed -n $k'p' ./$FunctionName/Instructions.txt | cut -f 1 `;
		CallingType=`cat ./$FunctionName/Prameters/$Parameter`;
		./instruction.sh $FunctionName $k $CallingType;
		./print.sh $FunctionName;
	done
	cd ./Calling/$FunctionName/
	FunctionParameter=`grep -H -w "R" * | cut -d ':' -f 1`;
	PassingParameter=`grep -H -w "R" * | cut -f 3`;
	cd ../../
	NewValue=`cat ./$FunctionName/Values/$FunctionParameter`;
	echo $NewValue > ./Main/Values/$PassingParameter;
	cd ./Calling/$FunctionName/
	FunctionParameter=`grep -H -w "VR" * | cut -d ':' -f 1`;
	PassingParameter=`grep -H -w "VR" * | cut -f 3`;
	cd ../../
	NewValue=`cat ./$FunctionName/Values/$FunctionParameter`;
	echo $NewValue > ./Main/Values/$PassingParameter;
	echo "*********************************************"
	echo "After Function : $FunctionName"
	echo "*********************************************"
	echo "Printing Global Main Values ..."$'\n';
	count=`ls -l ./Main/Values | wc -l`;
	count=$(($count-1));
	Numbers=`ls -l ./Main/Values | tail -$count | cut -d ' ' -f 8 | wc -l`;
	for i in `seq 1 $Numbers`
	do
		Name=`ls -l ./Main/Values | tail -$count | cut -d ' ' -f 8 | sed -n $i'p'`;
		Value=`cat ./Main/Values/$Name`;
		echo $Name$'\t'$'\t'$Value;
	done
	echo $'\n'"Press Enter To Go To Next Function."
	read temp;
done
echo "FINISH !"
