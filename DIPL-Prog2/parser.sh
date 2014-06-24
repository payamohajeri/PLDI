#!/bin/bash

# <-> Call By Value-Result VR
# ->  Call By Value V
# <-  Call By Result R
# &   Call By Refrence Ref

# Types : int, String, Bool

cat ./Input.txt | tr ';' $'\n' | sed -e 's/^[ \t]*//' > ./InputTemp.txt;
cat ./InputTemp.txt | sed '/^$/d' > ./InputTemp2.txt;
cat ./InputTemp2.txt | sed '/^[//]/d' > ./InputEdited.txt; 
rm ./InputTemp.txt;
rm ./InputTemp2.txt;
FunctionNumbers=`grep -w "function" -n ./InputEdited.txt | cut -d ":" -f 1 | wc -l`;
for i in `seq 1 $FunctionNumbers`
do
	DeclerationLine=`grep -w "function" -n ./InputEdited.txt | cut -d ":" -f 1 | sed -n $i'p'`;
	Column=`sed -n $DeclerationLine'p' ./InputEdited.txt | tr ' ' $'\t' | awk -F $'\t' '{print NF}'`;
	ParameterNumbers=`sed -n $DeclerationLine'p' ./InputEdited.txt | tr ' ' $'\t' | cut -f 4-$(($Column-1)) | tr ',' $'\t' | tr -s $'\t' | tr $'\t' $'\n' | wc -l`;
	FunctionName=`sed -n $DeclerationLine'p' ./InputEdited.txt | tr ' ' $'\t' | cut -f 2`;
	mkdir $FunctionName;
	mkdir -p ./$FunctionName/Prameters;
	mkdir -p ./$FunctionName/Values;
	for j in `seq 1 $ParameterNumbers`
	do
		Parameter=`sed -n $DeclerationLine'p' ./InputEdited.txt | tr ' ' $'\t' | cut -f 4-$(($Column-1)) | tr ',' $'\t' | tr -s $'\t' | tr $'\t' $'\n' | sed -n $j'p'`;
		CallSituation=`sed -n $DeclerationLine'p' ./InputEdited.txt | tr ' ' $'\t' | cut -f 4-$(($Column-1)) | tr ',' $'\t' | tr -s $'\t' | tr $'\t' $'\n' | sed -n $j'p' | sed 's/.\{1\}$//'`;		
		Variable=`sed -n $DeclerationLine'p' ./InputEdited.txt | tr ' ' $'\t' | cut -f 4-$(($Column-1)) | tr ',' $'\t' | tr -s $'\t' | tr $'\t' $'\n' | sed -n $j'p' | awk '{print substr($0,length,1)}'`;
		case $CallSituation in
			"<->")
				echo "VR" >> ./$FunctionName/Prameters/$Variable;
				;;
			"->")
				echo "V" >> ./$FunctionName/Prameters/$Variable;
				;;
			"<-")
				echo "R" >> ./$FunctionName/Prameters/$Variable;
				;;
			"&")
				echo "Ref" >> ./$FunctionName/Prameters/$Variable
				;;
			*)
				echo "Something is WRONG!!, you have a mistake in your declration of function number : $i and prameter : $j Variable : $Variable . ";
				echo "Press Enter to Exit !"
				read temp;
				exit
				;;
		esac
		echo "-1" > ./$FunctionName/Values/$Variable;
		echo $Variable >> ./$FunctionName/Prameters/$j;
	done
	BeginLine=$(($DeclerationLine+1));
	End=End;
	LineCounter=1;
	x=a;
	while [[ $End != $x ]]
	do
		LineNumber=$(($LineCounter+$BeginLine));
		sed -n $LineNumber'p' ./InputEdited.txt | tr '=' $'\t' >> ./$FunctionName/Instructions.txt;
		x=`sed -n $(($LineNumber+1))'p' ./InputEdited.txt`;
		LineCounter=$(($LineCounter+1));
	done
done
mkdir ./Main;
MainLine=`grep -w -n "main" ./InputEdited.txt | cut -d ":" -f 1`;
MainBegin=$(($MainLine+1));
End=End;
Call=call;
LineCounter=1;
y=b;
while [[ $End != $y ]]
do
	LineNumber=$(($LineCounter+$MainBegin));
	y=`sed -n $(($LineNumber+1))'p' ./InputEdited.txt`;
	z=`sed -n $LineNumber'p' ./InputEdited.txt | cut -f 1`;
	if [[ $Call != $z ]]; then
		sed -n $LineNumber'p' ./InputEdited.txt | tr ' ' $'\t' | tr '=' $'\t' >> ./Main/Instructions.txt;
	else
		sed -n $LineNumber'p' ./InputEdited.txt | tr ',' $'\t' | tr ' ' $'\t' | tr -s $'\t' | cut -f 2- >> ./Main/FunctionCall.txt
	fi
	LineCounter=$(($LineCounter+1));
done
mkdir -p ./Main/Variables;
mkdir -p ./Main/Values;
MainNumbers=`wc -l ./Main/Instructions.txt | cut -d ' ' -f 1`;
for i in `seq 1 $MainNumbers`
do
	Type=`sed -n $i'p' ./Main/Instructions.txt | cut -f 1`;
	Value=`sed -n $i'p' ./Main/Instructions.txt | cut -f 3`;
	Name=`sed -n $i'p' ./Main/Instructions.txt | cut -f 2`;
	echo $Type$'\t'$Value >> ./Main/Variables/$Name;
	echo $Value >> ./Main/Values/$Name;
done
echo "Prasing Completed.";
echo "Press Enter To Continue ...";
read temp;
