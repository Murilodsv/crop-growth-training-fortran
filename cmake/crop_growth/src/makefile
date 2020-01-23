crop_growth_mf : get_srad.o ipar_calc.o
	gfortran crop_growth.f90 get_srad.o ipar_calc.o \
                 -o crop_growth_mf

get_srad.o : get_srad.f90
	gfortran -c get_srad.f90

ipar_calc.o : ipar_calc.f90
	gfortran -c ipar_calc.f90

clean :
	rm get_srad.o ipar_calc.o

