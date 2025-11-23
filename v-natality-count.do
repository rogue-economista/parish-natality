// visualize restricted NVSS Natality data count of category of birthweight by parish-year quartile, 1989-2005



global mainDir = "P:\1.SHolmes\parish-health-natality"
global rawDir = "$mainDir\raw"
global dictDir = "$mainDir\dict"
global stataDir = "$mainDir\data"
global bwtDir = "$stataDir\bwt"
global outputDir = "mainDir\output"
global countDir = "$stataDir\quartiles-count"
cd "$mainDir"




******************************************************************************
************* Count of Extremely Low Birth Weight Infants ********************
******************************************************************************



// collapse each quartile with the count of extremely low birth weight for every year
forvalues x = 1/4 {
	use "$countDir\quartile-`x'.dta"
	collapse (count) Exlow_Q`x'_count=bwt if bwt == 0, by(YEAR)
	save "$countDir\quartile-`x'-count-ExLow.dta", replace

	clear all

}





// merge the extremely low birth weight count files together

use "$countDir\quartile-1-count-ExLow.dta"
merge 1:1 YEAR using "$countDir\quartile-2-count-ExLow.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace

merge 1:1 YEAR using "$countDir\quartile-3-count-ExLow.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace

merge 1:1 YEAR using "$countDir\quartile-4-count-ExLow.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace



******************************************************************************
************************ Quartile Graphs *************************************
*******************   Count of Infants with **********************************
****************** Extremely Low Birth Weight ********************************
******************************************************************************


// Parish quartiles graph for extremely low birth weight counts

use "$countDir\quartiles-merged.dta"

twoway (line Exlow_Q1_count YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line Exlow_Q2_count YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line Exlow_Q3_count YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line Exlow_Q4_count YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Number of Infants"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Count of Extremely Low Weight Births, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-ExLow-bwt.gph"
graph export "$outputDir\quartiles-ExLow-bwt.gph", as(jpg) name("Graph") quality(100)

clear all










******************************************************************************
*************** Count of Very Low Birth Weight Infants ***********************
******************************************************************************



// collapse each quartile with the count of very low birth weight for every year
forvalues x = 1/4 {
	use "$countDir\quartile-`x'.dta"
	collapse (count) Vlow_Q`x'_count=bwt if bwt == 1, by(YEAR)
	save "$countDir\quartile-`x'-count-VLow.dta", replace

	clear all

}





// merge the very low birth weight count files together

use "$countDir\quartile-1-count-VLow.dta"
merge 1:1 YEAR using "$countDir\quartile-2-count-VLow.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace

merge 1:1 YEAR using "$countDir\quartile-3-count-VLow.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace

merge 1:1 YEAR using "$countDir\quartile-4-count-VLow.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace



******************************************************************************
************************ Quartile Graphs *************************************
*******************   Count of Infants with **********************************
********************* Very Low Birth Weight **********************************
******************************************************************************


// Parish quartiles graph for very low birth weight counts

use "$countDir\quartiles-merged.dta"

twoway (line Vlow_Q1_count YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line Vlow_Q2_count YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line Vlow_Q3_count YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line Vlow_Q4_count YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Number of Infants"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Count of Very Low Weight Births, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-VLow-bwt.gph"
graph export "$outputDir\quartiles-VLow-bwt.gph", as(jpg) name("Graph") quality(100)

clear all












******************************************************************************
****************** Count of Low Birth Weight Infants *************************
******************************************************************************



// collapse each quartile with the count of low birth weight for every year
forvalues x = 1/4 {
	use "$countDir\quartile-`x'.dta"
	collapse (count) Low_Q`x'_count=bwt if bwt == 2, by(YEAR)
	save "$countDir\quartile-`x'-count-Low.dta", replace

	clear all

}





// merge the low birth weight count files together

use "$countDir\quartile-1-count-Low.dta"
merge 1:1 YEAR using "$countDir\quartile-2-count-Low.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace

merge 1:1 YEAR using "$countDir\quartile-3-count-Low.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace

merge 1:1 YEAR using "$countDir\quartile-4-count-Low.dta", nogenerate
save "$countDir\quartiles-merged.dta", replace



******************************************************************************
************************ Quartile Graphs *************************************
*******************   Count of Infants with **********************************
*********************** Low Birth Weight *************************************
******************************************************************************


// Parish quartiles graph for low birth weight counts

use "$countDir\quartiles-merged.dta"

twoway (line Low_Q1_count YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line Low_Q2_count YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line Low_Q3_count YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line Low_Q4_count YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Number of Infants"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Count of Low Weight Births, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-Low-bwt.gph"
graph export "$outputDir\quartiles-VLow-bwt.gph", as(jpg) name("Graph") quality(100)

clear all

