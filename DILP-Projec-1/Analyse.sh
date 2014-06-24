#! /bin/bash
#Syntactic Analysis
i=$1;
count=0;
TokensNumber=`wc -l ./Result/$i/LexemeAnalyzer.txt | cut -d ' ' -f 1`;
if (( $TokensNumber != $((5)) )); then
	echo "you must have \"5\" Word in a sentence (acording to given grammar) but you hava \"$TokensNumber\".";
	count=$(($count + 1));
	echo "Do you still want to continue ??? (Press Enter for continue or Press \"Ctrl\" + \"C\" for Exit.)"
	read x;
fi
for j in `seq 1 5`
do
	Token=`sed -n $j'p' ./Result/$i/LexemeAnalyzer.txt | cut -f 2`;
	case $j in
		1)	if [ "$Token" != "ARTICLE" ]; then
				echo "your First (1) Word is incorrect, it must be Article but it is \"$Token\" ! ";
				count=$(($count + 1));
			fi
			;;
		2)	if [ "$Token" != "NOUN" ]; then
				echo "your Second (2) Word is incorrect, it must be Noun but it is \"$Token\" ! ";
				count=$(($count + 1));
			fi
			;;
		3)	if [ "$Token" != "VERB" ]; then
				echo "your Third (3) Word is incorrect, it must be Verb but it is \"$Token\" ! ";
				count=$(($count + 1));
			fi
			;;
		4)	if [ "$Token" != "ARTICLE" ]; then
				echo "your Fourth (4) Word is incorrect, it must be Article but it is \"$Token\" ! ";
				count=$(($count + 1));
			fi
			;;
		5)	if [ "$Token" != "NOUN" ]; then
				echo "your Fifth (5) Word is incorrect, it must be Noun but it is \"$Token\" ! ";
				count=$(($count + 1));
			fi
			;;
		*)	echo "it Seems We have Problem here.";
			exit 2;
			;;
	esac
done;
if (( $count != $((0)) )); then
	echo "You Have $count Error(s) in your Line $i."
	exit 1;
else
	exit 0;
fi
