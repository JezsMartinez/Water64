#BASH

#Creating all the folder and files needed

read -p "Enter file name: " fname
read -p "Enter how many atoms have one of your molecules: " pattern
read -p "Enter how many molecules your system has: " total

declare -i x=$total
declare -i y=1
z=$(( x - y ))

for n in $(seq -w 0 $z);
    do
    mkdir water"$n"
    mkdir ./water"$n"/eqe
    mkdir ./water"$n"/eqe/charged
    cp    ./files/jobfile-eqe-c ./water"$n"/eqe/charged/
    cp    ./files/H.pbe-rrkjus.UPF ./water"$n"/eqe/charged/
    cp    ./files/O.pbe-rrkjus.UPF ./water"$n"/eqe/charged/
    mkdir ./water"$n"/eqe/neutral
    cp    ./files/jobfile-eqe-n ./water"$n"/eqe/neutral/
    cp    ./files/H.pbe-rrkjus.UPF ./water"$n"/eqe/neutral/
    cp    ./files/O.pbe-rrkjus.UPF ./water"$n"/eqe/neutral/
    mkdir ./water"$n"/eqeGS
    mkdir ./water"$n"/eqeGS/charged
    cp    ./files/jobfile-eqe-c ./water"$n"/eqeGS/charged/
    cp    ./files/H.pbe-rrkjus.UPF ./water"$n"/eqeGS/charged/
    cp    ./files/O.pbe-rrkjus.UPF ./water"$n"/eqeGS/charged/
    mkdir ./water"$n"/eqeGS/neutral
    cp    ./files/jobfile-eqe-n ./water"$n"/eqeGS/neutral/
    cp    ./files/H.pbe-rrkjus.UPF ./water"$n"/eqeGS/neutral/
    cp    ./files/O.pbe-rrkjus.UPF ./water"$n"/eqeGS/neutral/

#Creating .scf for charged and neutral
	if [ -f "$fname" ]
	then
		result=$(split -l $pattern $fname -d water.scf_)
    		result=$(split -l $pattern $fname -d water.scf_)
	echo "$result"
	fi
		for i in $(seq -w 0 $z);
		do
		echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    fde_split_mix = .true.
/
&electrons
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF
K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278 

ATOMIC_POSITIONS angstrom"| cat - water.scf_$i > temp && mv temp water.scf_$i
		cp water.scf_$i ./water"$n"/eqe/charged/water.scf_"$i".in
		cp water.scf_$i ./water"$n"/eqe/neutral/water.scf_"$i".in
		cp water.scf_00 ./water"$n"/eqe/neutral/water.scf_0.in
		cp water.scf_00 ./water"$n"/eqe/charged/water.scf_0.in
		done
			for e in {1..9};
			do
			cp water.scf_0$e ./water"$n"/eqe/charged/water.scf_"$e".in
			cp water.scf_0$e ./water"$n"/eqe/neutral/water.scf_"$e".in
			done
done
wait

#Varying the pick up molecule in Neutral

r=0
while [ $r -le 09 ]
	do
	sed -i water0$r/eqe/neutral/water.scf_0$r.in -re '1,36d'
	echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    fde_split_mix = .true.
    fde_print_embedpot = .false.
    fde_print_embedpot_MT = .true.
    fde_print_screened_longrange_electrostatics = .true.
/
&electrons
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF

K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278 

ATOMIC_POSITIONS angstrom"| cat - ./water0$r/eqe/neutral/water.scf_0$r.in > temp && mv temp ./water0$r/eqe/neutral/water.scf_0$r.in
   r=$(( $r + 01 ))
done

g=10
while [ $g -le $z ]
        do
        sed -i water$g/eqe/neutral/water.scf_$g.in -re '1,36d'
        echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    fde_split_mix = .true.    
    fde_print_embedpot = .false.
    fde_print_embedpot_MT = .true.
    fde_print_screened_longrange_electrostatics = .true.
/
&electrons
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF

K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278 

ATOMIC_POSITIONS angstrom"| cat - ./water$g/eqe/neutral/water.scf_$g.in > temp && mv temp ./water$g/eqe/neutral/water.scf_$g.in
   g=$(( $g + 01 ))
done
wait

#Varying the pick up molecule in Charged

w=10
while [ $w -le $z ]
   do
   sed -i water$w/eqe/charged/water.scf_$w.in -re '1,36d'
   echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    fde_split_mix = .true.
    fde_print_embedpot = .false.
    occupations = 'smearing'
    smearing = 'gaussian'
    degauss = 0.004
    fde_print_embedpot_MT = .true.
    fde_screen_fragment = .true.
/
&electrons
    fde_frag_charge = 1.0
    extpot_name = 'water-"$x"_screen_longrange.pp'
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF

K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278 

ATOMIC_POSITIONS angstrom"| cat - ./water$w/eqe/charged/water.scf_$w.in > temp && mv temp ./water$w/eqe/charged/water.scf_$w.in
   w=$(( $w + 01 ))
done

w=0
while [ $w -le 09 ]
   do
   sed -i water0$w/eqe/charged/water.scf_0$w.in -re '1,36d'
   echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    fde_split_mix = .true.
    fde_print_embedpot = .false.
    occupations = 'smearing'
    smearing = 'gaussian'
    degauss = 0.004
    fde_print_embedpot_MT = .true.
    fde_screen_fragment = .true.
/
&electrons
    fde_frag_charge = 1.0
    extpot_name = 'water-"$x"_screen_longrange.pp'
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF

K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278 

ATOMIC_POSITIONS angstrom"| cat - ./water0$w/eqe/charged/water.scf_0$w.in > temp && mv temp ./water0$w/eqe/charged/water.scf_0$w.in
   w=$(( $w + 01 ))
done
wait

#Set eEQ inputs for GS calculations 
#Neutral

if [ -f "$fname" ]
then
        result=$(split -l $pattern $fname -d water.scf_)
        result=$(split -l $pattern $fname -d water.scf_)
echo "$result"
fi

i=0
while [ $i -le 09 ]
	do
	echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    assume_isolated = 'mt'
    fde_split_mix = .true.
/
&electrons
    extpot_name = 'water-"$x"_embedpot_MT_"$i"_alpha.pp'
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF
K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278

ATOMIC_POSITIONS angstrom"| cat - water.scf_0$i > temp && mv temp water.scf_0$i
                cp water.scf_0$i ./water"0$i"/eqeGS/neutral/water.scf_0.in
		i=$(( $i + 01 ))
		done

i=10
while [ $i -le $z ]
	do
        echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    assume_isolated = 'mt'
    fde_split_mix = .true.
/
&electrons
    extpot_name = 'water-"$x"_embedpot_MT_"$i"_alpha.pp'
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF
K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278

ATOMIC_POSITIONS angstrom"| cat - water.scf_$i > temp && mv temp water.scf_$i
                cp water.scf_$i ./water"$i"/eqeGS/neutral/water.scf_0.in
		i=$(( $i + 01 ))
		done

#Charged

if [ -f "$fname" ]
then
	result=$(split -l $pattern $fname -d water.scf_)
        result=$(split -l $pattern $fname -d water.scf_)
echo "$result"
fi

i=0
while [ $i -le 09 ]
	do
	echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    assume_isolated = 'mt'
    occupations = 'smearing'
    smearing = 'gaussian'
    degauss = 0.004
    fde_split_mix = .true.
/
&electrons
    fde_frag_charge = 1.0
    extpot_name = 'water-"$x"_embedpot_MT_"$i"_alpha.pp'
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF

K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278

ATOMIC_POSITIONS angstrom"| cat - water.scf_0$i > temp && mv temp water.scf_0$i
                cp water.scf_0$i ./water"0$i"/eqeGS/charged/water.scf_0.in
		i=$(( $i + 01 ))
                done
i=10
while [ $i -le $z ]
        do
        echo "&control
    prefix = 'water-$x'
    calculation = 'scf'
    restart_mode = 'from_scratch'
    pseudo_dir = './'
    verbosity = 'high'
/
&system
    ibrav = 0
    a = 0.0
    nat = 3
    ntyp = 2
    ecutwfc = 40
    ecutrho = 400
    fde_kin_funct = 'revAPBEK'
    nosym = .true.
    assume_isolated = 'mt'
    occupations = 'smearing'
    smearing = 'gaussian'
    degauss = 0.004
    fde_split_mix = .true.
/
&electrons
    fde_frag_charge = 1.0
    extpot_name = 'water-"$x"_embedpot_MT_"$i"_alpha.pp'
    diagonalization = 'david'
    conv_thr = 1e-8
    mixing_beta = 0.7
    electron_maxstep = 400
/
ATOMIC_SPECIES
O   15.999     O.pbe-rrkjus.UPF
H   1.00794    H.pbe-rrkjus.UPF

K_POINTS (automatic)
1 1 1 0 0 0

CELL_PARAMETERS angstrom
12.4278 0.0 0.0
0.0 12.4278 0.0
0.0 0.0 12.4278

ATOMIC_POSITIONS angstrom"| cat - water.scf_$i > temp && mv temp water.scf_$i
                cp water.scf_$i ./water"$i"/eqeGS/charged/water.scf_0.in
                i=$(( $i + 01 ))
                done
wait

#File to ADF grid and eqe
mkdir ./water00/creating_ADFGRID
cp    ./files/jobfile-adfgrid ./water00/creating_ADFGRID/
cp    ./files/FDE_ADF_exportGrid.pyadf ./water00/creating_ADFGRID/
cp    ./files/H.pbe-rrkjus.UPF ./water00/eqe/neutral
cp    ./files/O.pbe-rrkjus.UPF ./water00/eqe/neutral

#Cleaning everything
       rm water.scf_* 
for k in $(seq -w 0 $z);
        do
        mv ./water"$k"/eqe/charged/water.scf_00.in ./water"$k"/eqe/charged/water.scf_0.in
	mv ./water"$k"/eqe/neutral/water.scf_00.in ./water"$k"/eqe/neutral/water.scf_0.in
        for l in {1..9};
                do
                mv ./water"$k"/eqe/charged/water.scf_0$l.in ./water"$k"/eqe/charged/water.scf_$l.in
		mv ./water"$k"/eqe/neutral/water.scf_0$l.in ./water"$k"/eqe/neutral/water.scf_$l.in
        done
done
	for m in {0..9};
                do
                mv ./water0$m ./water$m
	done	
