      subroutine TempHour(tmaxday,tminday,lat,doy,thour)
        !--------------------------------------------------------------------------------------------------
        !--- Calculates the Hourly temperature based on Parton & Logan Model, 1981 
        !--- DOI: 10.1016/0002-1571(81)90105-9
        !
        ! Inputs: 
        ! Maximun Day Temperature [°C]  -> tmaxday 
        ! Minimum Day Temperature [°C]  -> tminday
        ! Latitude (decimals)           -> lat
        ! Day of year                   -> doy
        !
        ! Outputs:
        ! Hourly Temperature Array(24)  -> thour
        !
        ! Parameters: 
        ! a,b,c (Calibrated for 150cm height on São Paulo State, Brazil)
        ! VIANNA, M. S.; MARIN, F. R. . ESTIMATIVA DA TEMPERATURA DO AR HORÁRIA PARA O ESTADO DE SÃO PAULO. 
        ! In: XX Congresso Brasileiro de Agrometeorologia, 2017, Juazeiro. A Agrometeorologia na Solução de 
        ! Problemas Multiescala, 2017. v. XX.
        ! 
        ! Notes: Its a truncated function model (day-night) and can be calibrated for different heights.
        ! Author: Murilo Vianna (Feb-2018)
        !--------------------------------------------------------------------------------------------------
        
	      Implicit None	
	
            integer hour          ! Hour(1-24)
            integer doy           ! Day of Year
            real tsunset          ! Temperature related variables !oC        
            real decsol           ! astronomic variables
            real ahn              ! astronomic variables
            real timnight         ! time related variables
            real timday           ! time related variables
            real sunset           ! Time of Sunset
            real sunrise          ! Time of Sunrise
            real photop           ! Photoperiod
            real nigthp           ! Night time period
            real bb               ! Method Variable
            real be               ! Method Variable
            real bbd_iday         ! Method Variable
            real bbd_inight       ! Method Variable
            real bbd_inight2      ! Method Variable
            real bbe              ! Method Variable
            real ddy              ! Method Variable
            real tmaxday          ! Daily Maximum Temperature (°C) 
            real tminday          ! Daily Minimum Temperature (°C)
            real lat              ! Latitude (decimals)
            real thour(24)
            
            !Parameters and constants
            real d_2_r
            real r_2_d
            real :: pi  = 3.14159265
            
            real :: a   = 1.607 !Calibrated for Sao Paulo State   (original constants from Parton and Logan paper = 2.000)
            real :: b   = 2.762 !Calibrated for Sao Paulo State   (original constants from Parton and Logan paper = 2.200)
            real :: c   = 1.179 !Calibrated for Sao Paulo State   (original constants from Parton and Logan paper = -0.17)
            
            !--- Trigonometric parameters        
            d_2_r     = pi/180.
            r_2_d     = 180./pi
          		
		        !--- calculating photoperiod			
            decsol  = 23.45 * sin(((360./365.)*(doy-80.)*d_2_r))
		        photop  = acos((-tan((lat)*d_2_r))*(tan((decsol)*d_2_r))) * r_2_d * (2./15.)
            
		        nigthp  = 24. - photop
		        sunrise = 12. - photop/2.
		        sunset  = 12. + photop/2.
		
            bb      = 12. - photop / 2. + c
            be      = 12. + photop / 2.
            ddy     = photop - c
        
            !--- Calculating air temperature follow Parton & Logan (1981)				
            tsunset = (tmaxday-tminday)*sin(((pi*ddy)/(photop+2*a))) + tminday
            
            !Hourly Temp
		        do hour = 1,24
			    
                    bbd_iday    = hour - bb
                    bbe         = hour - be
                    bbd_inight2 = (24. + be) + hour
                
                    !Rescaling time to day-night time
                    if(hour .gt. sunset) then
                        bbd_inight  = hour - sunset
                    else
                        bbd_inight = (24. + hour) - sunset
                    endif
                    
                    !Check whether is day or night time
                    if(hour .ge. bb .and. hour .le. sunset) then
                        !Day time temperature
                        thour(hour) = (tmaxday - tminday) * sin(((pi * bbd_iday) / (photop + 2.*a))) + tminday                    
                    else
                        !Night time temperature                    
                        thour(hour) = tminday + (tsunset - tminday) * exp(-b * bbd_inight/(24. - photop))                    
                    endif						
		        enddo
            
	    return
	end subroutine TempHour    
