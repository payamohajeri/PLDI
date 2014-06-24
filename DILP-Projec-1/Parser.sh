#! /bin/bash
#Parser
LineNumbers=`wc -l ./Input.txt | cut -d ' ' -f 1`;
for i in `seq 1 $LineNumbers`
do
	mkdir -p ./Result/$i;
	./Scanner.sh $i;
	if (( $? == $((0)) )); then
		echo "Lexical Analyser Complete !";
		./Analyse.sh $i;
		if (( $? == $((0)) )); then
			echo "Syntactic Analyser Complete !";
			./Tree.sh $i;
			if (( $? == $((0)) )); then
				echo -n "Press Enter To Show Parse Tree.";
				read
				clear;
				cat ./Result/$i/Tree.txt;
			else
			exit 3;
			fi			
		else
		exit 2;
		fi
	else
	exit 1;
	fi
	echo -n "Press Enter to Parse Next Line Number "$(($i+1))" !";
	read;
done;
echo "Parser Complete !";
exit 0;
