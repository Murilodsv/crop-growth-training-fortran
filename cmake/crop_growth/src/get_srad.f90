subroutine get_srad(max_srad,min_srad,e_srad,doy,srad)

implicit none

	real, intent(out) :: srad
	real av_srad
	real, intent(in) ::  max_srad
	real, intent(in) ::  min_srad
	real, intent(in) ::  e_srad
	integer, intent(in) :: doy
	real r

	real :: pi = 3.14159265358979
	
	!------------!
	!--- Code ---!
	!------------!

	!--- Random number (0-1)
	CALL RANDOM_NUMBER(r)	
	
	!--- Normalize (-1,1)
	r = (r - 0.5) / 0.5

	!--- Overall Average SRAD
	av_srad = (max_srad + min_srad) / 2.d0

	!--- Daily Average srad
	srad = av_srad + cos((doy / 365.d0 * 2.d0) * pi) * (max_srad - av_srad)

	!--- Add Random Variation (e_srad)
	srad = srad + e_srad * r
	
	return

end subroutine get_srad
