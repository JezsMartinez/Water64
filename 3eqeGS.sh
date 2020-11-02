#BASH

read -p "Enter how many molecules your system has: " total

declare -i x=$total 
declare -i y=1
z=$(( x - y ))

#Copy embedding potentials for the GS calculations
j=0
while [ $j -le $z ]
do
        cp ./water$j/eqe/neutral/water-"$x"_embedpot_MT_"$j"_alpha.pp ./water"$j"/eqeGS/neutral/
        cp ./water$j/eqe/charged/water-"$x"_embedpot_MT_"$j"_alpha.pp ./water"$j"/eqeGS/charged/
j=$(( $j + 1 ))
done
wait

#Running eEQ-GS

t=0
while [ $t -le $z ]
        do
        cd ./water$t/eqeGS/neutral/
        sbatch jobfile-eqe-n water.scf 1
        sleep 5 && cd ../../../
	cd ./water$t/eqeGS/charged/
        sbatch jobfile-eqe-c water.scf 1
        sleep 5 && t=$(( $t + 1 ))
        cd ../../../
done



