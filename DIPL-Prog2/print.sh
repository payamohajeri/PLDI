#!/bin/bash

FunctionName=$1;
echo "Printing Local Values of Function : $FunctionName ..."$'\n'
count=`ls -l ./$FunctionName/Values | wc -l`;
count=$(($count-1));
Numbers=`ls -l ./$FunctionName/Values | tail -$count | cut -d ' ' -f 8 | wc -l`;
for i in `seq 1 $Numbers`
do
	Name=`ls -l ./$FunctionName/Values | tail -$count | cut -d ' ' -f 8 | sed -n $i'p'`;
	Value=`cat ./$FunctionName/Values/$Name`;
	echo $Name$'\t'$'\t'$Value;
done
echo $'\n'"Press Enter To Continue."
read temp;
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
echo $'\n'"Press Enter To Continue."
read temp;
clear
