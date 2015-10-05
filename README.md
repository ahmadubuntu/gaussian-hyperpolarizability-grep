# gaussian-hyperpolarizability-grep
extract hyperpolarizability (and polarizability and dipole moment) components from Gaussian 09 output.

1) You must use POLAR and #P keywords in the root section of your Gaussian input.
2) Run Gaussian:  g09 < yourinput.com > youroutput.log
3) Make executable hyper-grep.sh: chmod +x hyper-grep.sh
4) and then run hyper-grep:  ./hyper-grep.sh youroutput.log
   or : ./hyper-grep.sh youroutput.log > polar.csv
5) now you can open this *.csv file with LibreOffice or OpenOffice.

Note that if you want to open it via Microsoft Office, 
it is better to open *.csv with Liber/Open Office and then save it as *.xlsx



Auther: Ahmad Abdolmaleki (ahmadubuntu)
Email: ahmadubuntu@gmail.com
Home of this code: https://github.com/ahmadubuntu/gaussian-hyperpolarizability-grep
