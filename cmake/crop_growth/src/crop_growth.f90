program crop_growth

	implicit none

	integer d
	integer ndays
	integer dap
	integer	doy

	real	srad	! Solar Radiation
	real	lai
	real	k
	real	ipar
	real	rue
	real	dw
	real	w
	real	r

	!--- Initialization and parameters setup
	w	= 0.d0
	ndays	= 120
	k	= 0.75
	rue	= 3.2
	dap	= 1
	doy	= 280

	!--- Daily loop
	do d = 1, ndays

		!--- Initialize Rates
		dw = 0.d0

		!--- Solar Radiation
		call get_srad(25.,15.,2.,doy,srad)

		!--- LAI
		lai = -0.3 + 0.1219 * dap - 0.000725 * dap ** 2.d0
		lai = max(0.1,lai)

		!--- iPAR
		call ipar_calc(srad,lai,k,ipar)

		!--- Growth Rate
		dw = ipar * rue

		!--- Integration
		w = w + dw

		!--- write outputs
		write(*,*) doy, dap, srad, lai, w

		!--- Time-Control
		dap = dap + 1
		doy = doy + 1
		if(doy .gt. 365) doy = 1

	end do

	!--- End of program
	write(*,*) 'Simulations End'

end program crop_growth
