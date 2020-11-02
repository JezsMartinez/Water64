read -p "Enter how many molecules your system has: " total
read -p "Enter how many atoms have one of your molecules: " pattern

declare -i x=$total
declare -i d=1
declare -i y=$pattern
z=$(( x - d ))
a=$(( x * y ))

g=0
while [ $g -le $z ]
        do
        rm -r ./water$g/eqe/neutral/tmp*
        rm -r ./water$g/eqe/neutral/out.*
        rm -r ./water$g/eqe/neutral/water-"$x"_embedpot_MT_Hartree_"$g"_alpha.pp
        rm -r ./water$g/eqe/neutral/water-"$x"_embedpot_MT_localparts_"$g"_alpha.pp
        rm -r ./water$g/eqe/charged/tmp*
        rm -r ./water$g/eqe/charged/out.*
        rm -r ./water$g/eqe/charged/water-"$x"_embedpot_MT_Hartree_"$g"_alpha.pp
        rm -r ./water$g/eqe/charged/water-"$x"_embedpot_MT_localparts_"$g"_alpha.pp
g=$(( $g + 1 ))
done

