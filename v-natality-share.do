// visualize restricted NVSS Natality data share of category of birthweight by parish-year quartile, 1989-2005



global mainDir = "P:\1.SHolmes\parish-health-natality"
global rawDir = "$mainDir\raw"
global dictDir = "$mainDir\dict"
global stataDir = "$mainDir\data"
global bwtDir = "$stataDir\bwt"
global outputDir = "mainDir\output"
global shareDir = "$stataDir\quartiles-share"
cd "$mainDir"




******************************************************************************
************* Share of Extremely Low Birth Weight Infants ********************
******************************************************************************


// collapse each quartile with the share of extremely low birth weight for every year
// 
forvalues x = 1/4 {
	use "$shareDir\quartile-`x'.dta"
	collapse (percent) Exlow_Q`x'_share=bwt if bwt == 0, by(YEAR)
	save "$shareDir\quartile-`x'-share-ExLow.dta", replace

	clear all

}



// merge the extremely low birth weight share files together

use "$shareDir\quartile-1-share-ExLow.dta"
merge 1:1 YEAR using "$shareDir\quartile-2-share-ExLow.dta", nogenerate
save "$shareDir\quartiles-ExLow-merged.dta", replace

merge 1:1 YEAR using "$shareDir\quartile-3-share-ExLow.dta", nogenerate
save "$shareDir\quartiles-ExLow-merged.dta", replace

merge 1:1 YEAR using "$shareDir\quartile-4-share-ExLow.dta", nogenerate
save "$shareDir\quartiles-ExLow-merged.dta", replace






******************************************************************************
************************ Quartile Graphs *************************************
*******************   Share of Infants with **********************************
****************** Extremely Low Birth Weight ********************************
******************************************************************************


// Parish quartiles graph for share of extremely low birth weight babies

use "$shareDir\quartiles-ExLow-merged.dta"

twoway (line Exlow_Q1_share YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line Exlow_Q2_share YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line Exlow_Q3_share YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line Exlow_Q4_share YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Percentage"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Share of Extremely Low Weight Births, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-ExLow-share-bwt.gph"
graph export "$outputDir\quartiles-ExLow-share-bwt.gph", as(jpg) name("Graph") quality(100)

clear all




******************************************************************************
**************** Share of Very Low Birth Weight Infants **********************
******************************************************************************


// collapse each quartile with the share of very low birth weight for every year
// 
forvalues x = 1/4 {
	use "$shareDir\quartile-`x'.dta"
	collapse (percent) Vlow_Q`x'_share=bwt if bwt == 1, by(YEAR)
	save "$shareDir\quartile-`x'-share-VLow.dta", replace

	clear all

}



// merge the very low birth weight share files together

use "$shareDir\quartile-1-share-VLow.dta"
merge 1:1 YEAR using "$shareDir\quartile-2-share-VLow.dta", nogenerate
save "$shareDir\quartiles-VLow-merged.dta", replace

merge 1:1 YEAR using "$shareDir\quartile-3-share-VLow.dta", nogenerate
save "$shareDir\quartiles-VLow-merged.dta", replace

merge 1:1 YEAR using "$shareDir\quartile-4-share-VLow.dta", nogenerate
save "$shareDir\quartiles-VLow-merged.dta", replace






******************************************************************************
************************ Quartile Graphs *************************************
*******************   Share of Infants with **********************************
********************* Very Low Birth Weight **********************************
******************************************************************************


// Parish quartiles graph for share of very low birth weight babies

use "$shareDir\quartiles-Vlow-merged.dta"

twoway (line Vlow_Q1_share YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line Vlow_Q2_share YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line Vlow_Q3_share YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line Vlow_Q4_share YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Percentage"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Share of Very Low Weight Births, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-VLow-share-bwt.gph"
graph export "$outputDir\quartiles-VLow-share-bwt.gph", as(jpg) name("Graph") quality(100)

clear all





******************************************************************************
******************* Share of Low Birth Weight Infants ************************
******************************************************************************


// collapse each quartile with the share of low birth weight for every year
// 
forvalues x = 1/4 {
	use "$shareDir\quartile-`x'.dta"
	collapse (percent) Low_Q`x'_share=bwt if bwt == 2, by(YEAR)
	save "$shareDir\quartile-`x'-share-Low.dta", replace

	clear all

}



// merge the low birth weight share files together

use "$shareDir\quartile-1-share-Low.dta"
merge 1:1 YEAR using "$shareDir\quartile-2-share-Low.dta", nogenerate
save "$shareDir\quartiles-Low-merged.dta", replace

merge 1:1 YEAR using "$shareDir\quartile-3-share-Low.dta", nogenerate
save "$shareDir\quartiles-Low-merged.dta", replace

merge 1:1 YEAR using "$shareDir\quartile-4-share-Low.dta", nogenerate
save "$shareDir\quartiles-Low-merged.dta", replace






******************************************************************************
************************ Quartile Graphs *************************************
*******************   Share of Infants with **********************************
*********************** Low Birth Weight *************************************
******************************************************************************


// Parish quartiles graph for share of low birth weight babies

use "$shareDir\quartiles-Low-merged.dta"

twoway (line Low_Q1_share YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line Low_Q2_share YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line Low_Q3_share YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line Low_Q4_share YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Percentage"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Share of Low Weight Births, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-Low-share-bwt.gph"
graph export "$outputDir\quartiles-Low-share-bwt.gph", as(jpg) name("Graph") quality(100)

clear all