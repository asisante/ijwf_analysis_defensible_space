/*******************************************************************************/
*							       Analysis		                          **    
/*******************************************************************************/
/*       1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
********************************************************************************
*  Program Name:   IJWF_analysis
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

*Defensible Space
*(1)
probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more
mfx
*(2)
probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx
mfx
*(3)
probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind
mfx
*(4)
probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj zoning time unhealthy
mfx
*(5)
probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx

*Individual Fire Safe Investments
probit fsi fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx
probit money fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx
probit time2 fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx

probit hh_spend fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx
probit hh_work fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx
probit iz_spend fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx
probit iz_work fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx
probit oz_spend fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx
probit oz_work fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mfx

/*******************************************************************************/
*							MICE 		                               
/*******************************************************************************/

mi set mlong
mi register imputed own_yrs income age own_more agehome zoning time unhealthy 
mi impute chained (logit) zoning time unhealthy own_more (truncreg, ll(0)) own_yrs agehome age income, add(30) aug

*Defensible Space
*(1)
mi estimate: probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more
mimrgns, dydx(*) atmeans predict(pr)
*(2)
mi estimate: probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx
mimrgns, dydx(*) atmeans predict(pr)
*(3)
mi estimate: probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind
mimrgns, dydx(*) atmeans predict(pr)
*(4)
mi estimate: probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
*(5)
mi estimate: probit defsp fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)

*Individual Fire Safe Investments
mi estimate: probit fsi fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
mi estimate: probit money fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
mi estimate: probit time2 fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)

mi estimate: probit hh_spend fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
mi estimate: probit hh_work fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
mi estimate: probit iz_spend fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
mi estimate: probit iz_work fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
mi estimate: probit oz_spend fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
mi estimate: probit oz_work fire_risk efficacy hhvl own_yrs agehome house_attr land_attr private lot risk_tolerance income own_more brush grs pj road_more24 res rx fuel aspect slope elevdiff lghtn wind zoning time unhealthy
mimrgns, dydx(*) atmeans predict(pr)
