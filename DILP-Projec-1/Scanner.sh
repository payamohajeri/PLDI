#! /bin/bash
# Shebang !
#Lexical Analyzer
i=$1;
Line=`sed -n $i'p' ./Input.txt`;
Column=`sed -n $i'p' ./Input.txt | awk -F ' ' '{print NF}'`;
for j in `seq 1 $Column`
do
	Lexeme=`sed -n $i'p' ./Input.txt | cut -d ' ' -f $j`;
	grep -q -w $Lexeme ./Data/Analysis.txt;
	if (( $? == $((1)) )); then
		echo "Error in Line : "$'\t'$Line;
		echo "Can not find the right Token for \"$Lexeme\" in Line \"$i\" and Column \"$j\" (Unknown Type). it seems you are using new one !!!!";
		echo "Please help me to Update my Table.";
		echo -n "What is the right type for \"$Lexeme\", Enter \"1\" for Verb or \"2\" for Noun or \"3\" for Article : ";
		read temp;
		case $temp in
			1)	Token="VERB";
				;;
			2)	Token="NOUN";
				;;
			3)	Token="ARTICLE";
				;;
			*)	echo "ERROR !!!!"; exit 1;
				;;
		esac
		echo $Token$'\t'$Lexeme >> ./Data/Analysis.txt;
	fi
	Token=`grep -w $Lexeme ./Data/Analysis.txt | cut -d $'\t' -f 1`;
	echo $j$'\t'$Token$'\t'$Lexeme >> ./Result/$i/LexemeAnalyzer.txt;
done;
exit 0;
