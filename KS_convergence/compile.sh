color=$(tput setaf 2)
normal=$(tput sgr0)

start=`date +%s%N`

FILE=$1
BIB=$2

# rm $FILE.aux

if [[ $BIB -eq -1 ]]; then
	xelatex -no-pdf -interaction=batchmode $FILE.tex &&
	xelatex -no-pdf -interaction=batchmode $FILE.tex &&
	xelatex -no-pdf -interaction=batchmode $FILE.tex &&
	rm $FILE.aux &
	rm $FILE.bbl &
	rm $FILE.blg &
	rm $FILE.brf &
	rm $FILE.log &
	rm $FILE.out &
	rm $FILE.toc &
	rm $FILE.xdv
	printf "\n ${color}compilation three times and cleanup done\n time needed: $((($(date +%s%N)-$start)/1000000)) milliseconds${normal} \n\n"
elif [[ $BIB -eq 0 ]]; then
	xelatex -no-pdf -interaction=batchmode $FILE.tex &&
	xelatex -no-pdf -interaction=batchmode $FILE.tex &&
	bibtex $FILE.aux &&
	bibtex $FILE.aux &&
	xelatex -no-pdf -interaction=batchmode $FILE.tex &&
	xelatex $FILE.tex &&
	printf "\n bibliography updated\n ${color}compilation done\n time needed: $((($(date +%s%N)-$start)/1000000)) milliseconds${normal} \n\n"
else
	for i in {2..$BIB}
	do
		xelatex -no-pdf -interaction=batchmode $FILE.tex &&
	done

	xelatex $FILE.tex &&

	if [ $BIB -eq 1 ]; then
		printf "\n ${color}compilation done once\n time needed: $((($(date +%s%N)-$start)/1000000)) milliseconds${normal} \n\n"
	else
		if [ $BIB -eq 2 ]; then
			printf "\n ${color}compilation done twice\n time needed: $((($(date +%s%N)-$start)/1000000)) milliseconds${normal} \n\n"
		else
			printf "\n ${color}compilation done $BIB times\n time needed: $((($(date +%s%N)-$start)/1000000)) milliseconds${normal} \n\n"
		fi
	fi
fi