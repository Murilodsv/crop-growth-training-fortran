#!/bin/bash

gfortran -c get_srad.f90
gfortran -c ipar_calc.f90
gfortran crop_growth.f90 get_srad.o ipar_calc.o -o crop_growth.o

./crop_growth.o
