cmake_minimum_required(VERSION "3.10.2")

project("crop_growth")

enable_language(Fortran)

set(CMAKE_Fortran_COMPILER "gfortran")

IF(NOT CMAKE_Fortran_COMPILER_SUPPORTS_F90)
    MESSAGE(FATAL_ERROR "Fortran compiler does not support F90")
ENDIF(NOT CMAKE_Fortran_COMPILER_SUPPORTS_F90)

# Add the source files
set(
    source_list
    	"crop_growth.f90"
      "get_srad.f90"
      "ipar_calc.f90"
    )

add_executable("${PROJECT_NAME}" ${source_list})

install(TARGETS "${PROJECT_NAME}" DESTINATION bin)  # ${CMAKE_INSTALL_PREFIX}/bin
install(FILES ${source_list} DESTINATION src)       # ${CMAKE_INSTALL_PREFIX}/src
