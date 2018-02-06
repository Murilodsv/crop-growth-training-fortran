!----------------------------------------------------------------------------------------
      real function AScurv(df,x,min,max,shp,mid,asy)
      !--- Growth Function with asymetry (optional)
      !--- Asymptote Curve and its first derivative (df=1)
      !--- Author: Murilo S. Vianna
      !--- Feb-2018
      !--- Why using this function to describe growth -> doi: 10.1093/aob/mcg029
      
      implicit none
      
      integer df    ! Equation form: 0 = integral, 1 = 1st derivative
      real  x       ! X Value
      real  min     ! Minimum Value
      real  max     ! Maximum Value
      real  shp     ! Function Shape
      real  mid     ! X Value in which y = (max - min) / 2.
      real  asy     ! Asymetry
      
      select case(df)
      case(0)
          !Integral form
          AScurv = max + ((min - max) / ((1.d0 + (x/mid)**shp)**asy))
          
      case(1)
          !1st derivative
          AScurv = -asy * (min-max) * ((1.d0+(x/mid)**shp)**(-asy-1.d0)) * (shp*(x/mid)**(shp-1.d0)) * (1.d0/mid)
          
      end select 
      return
      end
!----------------------------------------------------------------------------------------
