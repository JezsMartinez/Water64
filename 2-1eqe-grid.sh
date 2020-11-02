#BASH

#Obtain the embedding potential for Neutral and Charged

read -p "Enter how many molecules your system has: " total

declare -i x=$total
declare -i y=1
z=$(( x - y ))

#Neutral

t=0
while [ $t -le $z ]
        do
        cd ./water$t/eqe/neutral/
        sbatch jobfile-eqe-n water.scf $x
        sleep 10
	t=$(( $t + 1 ))
        cd ../../../
done

