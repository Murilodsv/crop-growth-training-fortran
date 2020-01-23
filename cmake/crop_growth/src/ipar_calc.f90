subroutine ipar_calc(srad,lai,k,ipar)

implicit none

	real srad
	real lai
	real k
	real ipar

	ipar = srad * 0.5d0 * (1.d0 - exp(-k * lai))

	return

end subroutine ipar_calc
