#! /bin/bash
#clear
# This script used for greping static Hyperpolarizablity for w=0.0 from gaussian output and converting it to electreostatic unit.
# usage: ./gp.sh gaussian-output.out [unit]
# for using this script you must use "polar" keyword in gaussian input file (for mp2 or higher level of calculation you should use Polar=cubic or Polar=EnOnly or Polar=DubleNumber) and "p" (for additional print) after # symbole,e.g:
#         #p b3lyp/6-311++g(d,p) polar


#find polarizability and hyperpolarizabilty block in gaussian output and find Betta tensor components in it
infile=$1

#===============================================================================================================================================================
#   Hyperpolarizability (beta) [au, esu]
#===============================================================================================================================================================
bxxx=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "1p" | awk '{print $2}'`  ; 
bxxy=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "4p" | awk '{print $2}'`  ; 
bxyy=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "5p" | awk '{print $2}'`  ; 
byyy=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "5p" | awk '{print $3}'`  ; 
bxxz=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "8p" | awk '{print $2}'`  ; 
bxyz=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "9p" | awk '{print $2}'`  ; 
byyz=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "9p" | awk '{print $3}'`  ; 
bxzz=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "10p" | awk '{print $2}'` ; 
byzz=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "10p" | awk '{print $3}'` ; 
bzzz=`cat $infile | grep -A 12 "SCF Static Hyperpolarizability" | tail -10 | sed -n "10p" | awk '{print $4}'` ; 

# convert componnets to standard representation
bxxx=`echo ${bxxx} | sed 's/D/\*10\^/' | sed 's/+//'`
bxxy=`echo ${bxxy} | sed 's/D/\*10\^/' | sed 's/+//'`
bxyy=`echo ${bxyy} | sed 's/D/\*10\^/' | sed 's/+//'`
byyy=`echo ${byyy} | sed 's/D/\*10\^/' | sed 's/+//'`
bxxz=`echo ${bxxz} | sed 's/D/\*10\^/' | sed 's/+//'`
bxyz=`echo ${bxyz} | sed 's/D/\*10\^/' | sed 's/+//'`
byyz=`echo ${byyz} | sed 's/D/\*10\^/' | sed 's/+//'`
bxzz=`echo ${bxzz} | sed 's/D/\*10\^/' | sed 's/+//'`
byzz=`echo ${byzz} | sed 's/D/\*10\^/' | sed 's/+//'`
bzzz=`echo ${bzzz} | sed 's/D/\*10\^/' | sed 's/+//'`
Btot=$(echo "scale=8; sqrt(((($bxxx)+($bxyy)+($bxzz))^2+(($byyy)+($byzz)+($bxxy))^2+(($bzzz)+($bxxz)+($byyz))^2))" | bc -l)
btot_esu=$(echo "scale=8; ($Btot)*(8.6393)" | bc -l);
#===============================================================================================================================================================



#===============================================================================================================================================================
# polarizability (alpha) [au, esu]
#===============================================================================================================================================================
axx=`cat $infile | grep -A 4 "SCF Polarizability" | tail -3 | sed -n "1p" | awk '{print $2}'`  ;
axy=`cat $infile | grep -A 4 "SCF Polarizability" | tail -3 | sed -n "2p" | awk '{print $2}'`  ;
ayy=`cat $infile | grep -A 4 "SCF Polarizability" | tail -3 | sed -n "2p" | awk '{print $3}'`  ;
axz=`cat $infile | grep -A 4 "SCF Polarizability" | tail -3 | sed -n "3p" | awk '{print $2}'`  ;
ayz=`cat $infile | grep -A 4 "SCF Polarizability" | tail -3 | sed -n "3p" | awk '{print $3}'`  ;
azz=`cat $infile | grep -A 4 "SCF Polarizability" | tail -3 | sed -n "3p" | awk '{print $4}'`  ;

# convert componnets to standard representation
axx=`echo ${axx} | sed 's/D/\*10\^/' | sed 's/+//'`
axy=`echo ${axy} | sed 's/D/\*10\^/' | sed 's/+//'`
ayy=`echo ${ayy} | sed 's/D/\*10\^/' | sed 's/+//'`
axz=`echo ${axz} | sed 's/D/\*10\^/' | sed 's/+//'`
ayz=`echo ${ayz} | sed 's/D/\*10\^/' | sed 's/+//'`
azz=`echo ${azz} | sed 's/D/\*10\^/' | sed 's/+//'`

atot_iso=$(echo "scale=8; (($axx)+($ayy)+($azz))" | bc -l)
atot_aniso=$(echo "scale=8; (sqrt(2)*sqrt((($axx-$ayy)^2+($ayy-$azz)^2+($azz-$axx)^2+6*(($axx)^2))))" | bc -l)

atot_iso_esu=$(echo "scale=8; ($atot_iso)*(0.1482)" | bc -l);
atot_aniso_esu=$(echo "scale=8; ($atot_aniso)*(0.1482)" | bc -l);
#===============================================================================================================================================================



#===============================================================================================================================================================
# dipole moment (mu) [Debye]
#===============================================================================================================================================================
mux=`cat $infile | grep -A 1 "Dipole moment" | tail -1 | sed -n "1p" | awk '{print $2}'`  ;
muy=`cat $infile | grep -A 1 "Dipole moment" | tail -1 | sed -n "1p" | awk '{print $4}'`  ;
muz=`cat $infile | grep -A 1 "Dipole moment" | tail -1 | sed -n "1p" | awk '{print $6}'`  ;
mu_tot=`cat $infile | grep -A 1 "Dipole moment" | tail -1 | sed -n "1p" | awk '{print $8}'`  ;

# convert componnets to standard representation
mux=`echo ${mux} | sed 's/D/\*10\^/' | sed 's/+//'`
muy=`echo ${muy} | sed 's/D/\*10\^/' | sed 's/+//'`
muz=`echo ${muz} | sed 's/D/\*10\^/' | sed 's/+//'`
mu_tot=`echo ${mu_tot} | sed 's/D/\*10\^/' | sed 's/+//'`

#===============================================================================================================================================================



#===============================================================================================================================================================
# print data
#===============================================================================================================================================================

printf  "Structure,μx,μy,μz,μ0,αxx,αxy,αyy,αxz,αyz,αzz,|α0|,Δα,|α0|(esu),Δα(esu),βxxx,βxxy,βxyy,βyyy,βxxz,βxyz,βyyz,βxxz,βyzz,βzzz,β0,β0(esu)\n"

printf  "%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s,=%s\n" $infile $mux $muy $muz $mu_tot $axx $axy $ayy $axz $ayz $azz $atot_iso $atot_aniso $atot_iso_esu*10^-24 $atot_aniso_esu*10^-24 $bxxx $bxxy $bxyy $byyy $bxxz $bxyz $byyz $bxxz $byzz $bzzz $Btot $btot_esu*10^-33
