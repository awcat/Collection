#!/bin/bash
set -e
exec 1>filecopy_logs.txt 2>&1
loc_1=/e/Downloads
loc_2=/tmp/DCA
cd $loc_1

main() {
  for i in $(basename "$loc_1/*"); do
     echo "checking $i ..."
     if [ -e $loc_2/"$i" ]; then
	echo "File $i is in folder $loc_2, checking size..."
	t=$(ls -N "$loc_2/$i")
	echo "file name: $t"
	n1="$(wc -c $loc_1/"$i" | awk '{print $1}')"
        n2="$(wc -c "$t" | awk '{print $1}')"
	controllo
        echo "File 1: $n1"
        echo "File 2: $n2"
      	if [ $n1 -gt $n2 ]; then
           echo "Adding $i ..."
	   copy_phase
	else
	   echo "No need to copy it..."
	fi
     else
	echo "File $1 not in target folder $loc_2. Copying it..."
	copy_phase
     fi
  done
}

controllo() {
   if [ $? == 0 ]; then
        echo "File Name OK"
     else
        echo "Error!"
        exit 1
     fi
}
copy_phase() {
     cp $loc_1/"$i" $loc_2/"$i"
     if [ $? == 0 ]; then
	echo "$i" > copied_files.txt
        echo "File $i ... Copied successfully!"
     else
        echo "Could not copy file $i!"
	exit 1
     fi
}

main "$@"; exit

