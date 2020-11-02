#BASH

#Obtain the embedding potential for Neutral and Charged

read -p "Enter how many molecules your system has: " total
read -p "Enter how many atoms have one of your molecules: " pattern

declare -i x=$total
declare -i d=1
declare -i y=$pattern
z=$(( x - d ))
a=$(( x * y ))

#Charged

j=0
while [ $j -le $z ]
        do
        cp ./water$j/eqe/neutral/water-"$x"_screen_longrange.pp ./water"$j"/eqe/charged/
        cd ./water$j/eqe/charged/
        sbatch jobfile-eqe-c water.scf $x
        sleep 10
	j=$(( $j + 1 ))
        cd ../../../
done
