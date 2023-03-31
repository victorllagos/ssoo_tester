#!/bin/bash
#####################################
## Created by: Víctor Hernández L. ##
## Email: victorllagos@uc.cl       ##
#####################################

# Check if log file is created. If not, log is created
LOGFILE="./tests.log"

if [ ! -f $LOGFILE ]; then
	touch $LOGFILE
	printf "Logfile created in $(date -u)\n\n" >> $LOGFILE
fi

# Pre tests logs. Comment one of the next lines to save past logs or to rewrite logs

printf "$(date)\n\n" > $LOGFILE
#printf "$(date)\n\n" >> $LOGFILE

# Running make for last version
printf "Running Makefile\n\n" >> $LOGFILE 
printf "Makefile log\n\n" >> $LOGFILE
make >> $LOGFILE

# Running tests Makefile
printf "\nRunning Tests Makefile\n\n" >> $LOGFILE
cd ./testsT0 & make >> $LOGFILE

# Running tests
printf "\nRunning tests\n\n" >> $LOGFILE

printf "######################################\n\n" >> $LOGFILE

INPUTFOLDER="./testsT0/inputs/"

# Accept bash parameters for run specific file

if [ ! -z $2 ]; then
	printf "Error in command sh tester.sh: Too many arguments\n" >> $LOGFILE
elif [ ! -z $1  ] && [ $1 -gt 0 ] && [ $1 -lt 6 ]; then
	printf "Running only file ${INPUTFOLDER}input${1}.txt\n" >> $LOGFILE
	./fifoss "${INPUTFOLDER}test${1}.txt" "./testsT0/myoutputs/output${1}.csv" >> $LOGFILE 2>&1
elif [ ! -z $1 ]; then
	printf "Error in parameter. Parameter must be between {1, 5}\n" >> $LOGFILE
else
	i=1
	for f in ${INPUTFOLDER}*.txt
	do
		printf "Running test for file\n" >> $LOGFILE
		echo $f >> $LOGFILE
		printf "\n" >> $LOGFILE
		./fifoss "$f" "./testsT0/myoutputs/output${i}.csv" >> $LOGFILE 2>&1
		printf "\n#######################################\n\n" >> $LOGFILE
		((i=i+1))
	done
fi

cat ./tests.log
