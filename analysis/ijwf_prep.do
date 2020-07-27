/*******************************************************************************/
*							       Prep		                          **    
/*******************************************************************************/
/*       1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
********************************************************************************
*  Program Name:   IJWF_Prep
*  Created by:     Angelo Sisante 
*  Created on:     9/15/2018 *Last Update*
*  Abstract:       
*
*  Files Created: none
*	
********************************************************************************/

/*******************************************************************************/
*							Pre-flight commands			                               
/*******************************************************************************/

set more off 
*Adequate Defensible Space
drop if own != 2 
tab defsp
sum defsp

*FIRE_RISK Chance a fire reaches a community 
gen fchcn_1 = . 
replace fchcn_1 = 0.00 if chcn_1 == 0
replace fchcn_1 = 0.125 if chcn_1 == 1 
replace fchcn_1 = 0.25 if chcn_1 == 2 
replace fchcn_1 = 0.375 if chcn_1 == 3
replace fchcn_1 = 0.5 if chcn_1 == 4
replace fchcn_1 = 0.625 if chcn_1 == 5
replace fchcn_1 = 0.75 if chcn_1 == 6
replace fchcn_1 = 0.875 if chcn_1 == 7
replace fchcn_1 = 1.000 if chcn_1 == 8 

gen fchcn_2 = . 
replace fchcn_2 = 0.00 if chcn_2 == 0
replace fchcn_2 = 0.125 if chcn_2 == 1 
replace fchcn_2 = 0.25 if chcn_2 == 2 
replace fchcn_2 = 0.375 if chcn_2 == 3
replace fchcn_2 = 0.5 if chcn_2 == 4
replace fchcn_2 = 0.625 if chcn_2 == 5
replace fchcn_2 = 0.75 if chcn_2 == 6
replace fchcn_2 = 0.875 if chcn_2 == 7
replace fchcn_2 = 1.000 if chcn_2 == 8 

gen fire_risk = (fchcn_1*fchcn_2)
label var fire_risk "Index of subjective chance of fire reaching community"
label value fire_risk fire_risk 

*EFFICACY Trust in Defensible Space
gen eff_1 = . 
replace eff_1 = 0.00 if all_1 == 8
replace eff_1 = 0.125 if all_1 == 7
replace eff_1 = 0.25 if all_1 == 6
replace eff_1 = 0.375 if all_1 == 5
replace eff_1 = 0.5 if all_1 == 4
replace eff_1 = 0.625 if all_1 == 3
replace eff_1 = 0.75 if all_1 == 2
replace eff_1 = 0.875 if all_1 == 1 
replace eff_1 = 1.00 if all_1 == 0

gen eff_2 = . 
replace eff_2 = 0.00 if all_2 == 8
replace eff_2 = 0.125 if all_2 == 7
replace eff_2 = 0.25 if all_2 == 6
replace eff_2 = 0.375 if all_2 == 5
replace eff_2 = 0.5 if all_2 == 4
replace eff_2 = 0.625 if all_2 == 3
replace eff_2 = 0.75 if all_2 == 2 
replace eff_2 = 0.875 if all_2 == 1 
replace eff_2 = 1.00 if all_2 == 0 

gen eff_3 = . 
replace eff_3 = 0.00 if all_3 == 8
replace eff_3 = 0.125 if all_3 == 7
replace eff_3 = 0.25 if all_3 == 6
replace eff_3 = 0.375 if all_3 == 5
replace eff_3 = 0.5 if all_3 == 4
replace eff_3 = 0.625 if all_3 == 3
replace eff_3 = 0.75 if all_3 == 2 
replace eff_3 = 0.875 if all_3 == 1 
replace eff_3 = 1.00 if all_3 == 0 

gen efficacy = (eff_1 + eff_2 + eff_3)/3
label var efficacy "Index of Efficacy all_1 - all_3: Trust in Defensible Space" 
label value efficacy efficacy 

*HHVL - In Data

*OWN_YRS - In Data
replace own_yrs = 66 if own_yrs == 145

*AGEHOME
gen agehome = . 
replace agehome = 1 if res_age == 1 
replace agehome = 3 if res_age == 2
replace agehome = 8.5 if res_age == 3
replace agehome = 15.5 if res_age == 4
replace agehome = 30 if res_age == 5 

*Utility
gen c5 = choice_5 
recode c5 (0=0) (1=25) (2=50) (3=75) (4=100)
label define c5 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"
label values c5 c5

gen c6 = choice_6 
recode c6 (0=0) (1=25) (2=50) (3=75) (4=100)
label define c6 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"
label values c5 c6

gen c7 = choice_7 
recode c7 (0=0) (1=25) (2=50) (3=75) (4=100)
label define c7 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"
label values c7 c7

gen house_attr = c5
gen land_attr = c6

gen private = c7
label var private "Index of Privacy as a barrier to Defensible Space"
label values private private

*LOT - In Data

*Risk
gen risk_1 = 0 if subsample != . 
replace risk_1 = 1 if job == 1 & job1 == 1

gen risk_2 = 0 if subsample != . 
replace risk_2 = 1 if job == 1 & job1 == 0

gen risk_3 = 0 if subsample != . 
replace risk_3 = 1 if job == 2 & job2 == 0

gen risk_4 = 0 if subsample != . 
replace risk_4 = 1 if job == 2 & job2 == 1

tab1 risk_1 - risk_4

gen lrtol = . 
replace lrtol = -1.811 if risk_1 == 1 
replace lrtol = -1.693 if risk_2 == 1
replace lrtol = -1.575 if risk_3 == 1
replace lrtol = -1.419 if risk_4 == 1 

gen rtol = . 
replace rtol = 0.203 if risk_1 == 1
replace rtol = 0.228 if risk_2 == 1 
replace rtol = 0.257 if risk_3 == 1
replace rtol = 0.301 if risk_4 == 1 

gen risk_tolerance = rtol

*Income
gen income = . 
replace income = 10000 if inc == 1 
replace income = 19999 if inc == 2
replace income = 29999 if inc == 3
replace income = 42499 if inc == 4
replace income = 62499 if inc == 5
replace income = 87499 if inc == 6
replace income = 124999 if inc == 7
replace income = 174999 if inc == 8
replace income = 250000 if inc == 9


/*******************************************************************************/
*							Control Blocks Creation			                               
/*******************************************************************************/
*HEALTH
gen unhealthy = . 
replace unhealthy = 1 if health == 0 | health == 1 
replace unhealthy = 0 if health == 4 | health == 3 | health == 2

*ZONING 
gen zoning = . 
replace zoning = 1 if choice_1 == 4 | choice_1 == 3
replace zoning = 0 if choice_1 == 2 | choice_1 == 1 | choice_1 == 0

*TIME
gen time = . 
replace time = 1 if choice_3 == 4 | choice_3 == 3
replace time = 0 if choice_3 == 2 | choice_3 == 1 | choice_3 == 0 

*Insurance
gen insurance = 1 if ins == 1 | ins == 2
replace insurance = 0 if ins == 0 
tab insurance ins

*EXPERIENCE
gen ex_1 = . 
replace ex_1 = 1 if exp_1_12 == 1 | exp_1_11 == 1 | exp_1_10 == 1 | exp_1_08 == 1 
replace ex_1 = 0 if exp_1_07 == 1 | exp_1_0 == 1

gen ex_2 = . 
replace ex_2 = 1 if exp_2_12 == 1 | exp_2_11 == 1 | exp_2_10 == 1 | exp_2_08 == 1
replace ex_2 = 0 if exp_2_07 == 1 | exp_2_0 == 1 

gen ex_3 = . 
replace ex_3 = 1 if exp_3_12 == 1 | exp_3_11 == 1 | exp_3_10 == 1 | exp_3_08 == 1
replace ex_3 = 0 if exp_3_07 == 1 | exp_3_0 == 1

gen ex_4 = . 
replace ex_4 = 1 if exp_4_12 == 1 | exp_4_11 == 1 | exp_4_10 == 1 | exp_4_08 == 1 
replace ex_4 = 0 if exp_4_06 == 1 | exp_4_0 == 1 

gen ex = . 
replace ex = 1 if ex_1 == 1 | ex_2 == 1 | ex_3 == 1 | ex_4 == 1
replace ex = 0 if ex_1 == 0 | ex_2 == 0 | ex_3 == 0 | ex_4 == 0
/*******************************************************************************/
*							Summary Stats		                               
/*******************************************************************************/
sum insurance
sum ex_1
sum ex_2
sum ex_3
sum ex_4

sum fire_risk
sum efficacy 
sum own_yrs

sum agehome
sum house_attr
sum land_attr
sum private
sum lot

sum risk_tolerance
sum income
sum own_more

sum aspect
sum slope
sum fuel
sum brush
sum grs
sum tmbr
sum lghtn
sum wind

sum res
sum rx
sum road_more24

sum zoning
sum time
sum health
sum age

sum hh_work
sum hh_spend
sum iz_work
sum iz_spend
sum oz_work
sum oz_spend

gen fsi = . 
replace fsi = 1 if hh_work == 1 | hh_spend == 1 | iz_work == 1| iz_spend == 1 | oz_work == 1 | oz_spend == 1
replace fsi = 0 if fsi != 1 

gen money = 1 if hh_spend == 1 | iz_spend == 1 | oz_spend == 1
replace money = 0 if money != 1
gen time2 = 1 if hh_work == 1 | iz_work == 1 | oz_work == 1
replace time2 = 0 if time2 != 1 

sum defsp if fsi == 0 
sum fsi 
sum fsi if defsp == 1 
sum money 
sum money if defsp == 1
sum time2 
sum time2 if defsp == 1 

sum hh_spend if defsp == 1
sum hh_work if defsp == 1
sum iz_spend if defsp == 1
sum iz_work if defsp == 1
sum oz_spend if defsp == 1
sum oz_work if defsp == 1



/*******************************************************************************/
*							Community Summary Stats		                               
/*******************************************************************************/
tab returned if community == "Ely"
tab fsi if community == "Ely"
tab returned if community == "Lund"
tab fsi if community == "Lund"
tab returned if community == "Carvers"
tab fsi if community == "Carvers"
tab returned if community == "Cold Springs"
tab fsi if community == "Cold Springs"
tab returned if community == "Virginia City"
tab fsi if community == "Virginia City"
tab returned if community == "Spanish Springs"
tab fsi if community == "Spanish Springs"
tab returned if community == "Red Rock"
tab fsi if community == "Red Rock"
tab returned if community == "Spring Creek"
tab fsi if community == "Spring Creek"
tab returned if community == "Spring Valley"
tab fsi if community == "Spring Valley"
tab returned if community == "Elko"
tab fsi if community == "Elko"
tab returned if community == "Carlin"
tab fsi if community == "Carlin"
tab returned if community == "Topaz Lake"
tab fsi if community == "Topaz Lake"
tab returned if community == "Verdi"
tab fsi if community == "Verdi"
tab returned if community == "Sheridan Acres"
tab fsi if community == "Sheridan Acres"
tab returned if community == "Jarbidge"
tab fsi if community == "Jarbidge"
tab returned if community == "Mogul"
tab fsi if community == "Mogul"
tab returned if community == "Topaz Estates"
tab fsi if community == "Topaz Estates"

tab returned if community == "Eureka"
tab fsi if community == "Eureka"
tab returned if community == "Rancho Haven"
tab fsi if community == "Rancho Haven"
tab returned if community == "Austin"
tab fsi if community == "Austin"
tab returned if community == "Manhattan"
tab fsi if community == "Manhattan"
tab returned if community == "Kingston"
tab fsi if community == "Kingston"
tab returned if community == "Virginia Highlands"
tab fsi if community == "Virginia Highlands"

tab returned if community == "Incline Village"
tab fsi if community == "Incline Village"
tab returned if community == "Galena Forest"
tab fsi if community == "Galena Forest"
tab returned if community == "Saddlehorn Tumbleweed"
tab fsi if community == "Saddlehorn Tumbleweed"
tab returned if community == "West Washoe Valley"
tab fsi if community == "West Washoe Valley"
tab returned if community == "Tyrolian Village"
tab fsi if community == "Tyrolian Village"
tab returned if community == "Champagne Burgundy"
tab fsi if community == "Champagne Burgundy"
tab returned if community == "Chimney Rock"
tab fsi if community == "Chimney Rock"
tab returned if community == "Upper Tyner"
tab fsi if community == "Upper Tyner"
tab returned if community == "Allison Jennifer"
tab fsi if community == "Allison Jennifer"
tab returned if community == "Crystal Bay"
tab fsi if community == "Crystal Bay"

tab returned if community == "Battle Mountain"
tab fsi if community == "Battle Mountain"
tab returned if community == "Lamoille"
tab fsi if community == "Lamoille"




