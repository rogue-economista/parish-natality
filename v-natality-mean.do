// visualize restricted NVSS Natality data means by parish-year quartile, 1989-2005



global mainDir = "P:\1.SHolmes\parish-health-natality"
global rawDir = "$mainDir\raw"
global dictDir = "$mainDir\dict"
global stataDir = "$mainDir\data"
global bwtDir = "$stataDir\bwt"
global outputDir = "mainDir\output"
global meanDir = "$stataDir\quartiles-mean"
cd "$mainDir"





// collapse each quartile by mean birth weight for every year
forvalues x = 1/4 {
	use "$meanDir\quartile-`x'.dta"
	collapse (mean) dbwt_Q`x'_mean=dbwt, by(YEAR)
	save "$meanDir\\quartile-`x'-mean.dta", replace

	clear all

}





// merge the mean birth weight files together

use "$stataDir\quartiles-mean\quartile-1-mean.dta"
merge 1:1 YEAR using "$stataDir\quartiles-mean\quartile-2-mean.dta", nogenerate
save "$stataDir\quartiles-mean\quartiles-merged.dta", replace

merge 1:1 YEAR using "$stataDir\quartiles-mean\quartile-3-mean.dta", nogenerate
save "$stataDir\quartiles-mean\quartiles-merged.dta", replace

merge 1:1 YEAR using "$stataDir\quartiles-mean\quartile-4-mean.dta", nogenerate
save "$stataDir\quartiles-mean\quartiles-merged.dta", replace



******************************************************************************
************************ Quartile Graphs *************************************
************************       Mean      *************************************
******************************************************************************


// Parish quartiles graph for Mean Birth Weights

use "$stataDir\quartiles-mean\quartiles-merged.dta"

twoway (line dbwt_Q1_mean YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line dbwt_Q2_mean YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line dbwt_Q3_mean YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line dbwt_Q4_mean YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Birth Weight (grams)"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Mean Birth Weight, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-mean-bwt.gph"
graph export "$outputDir\quartiles-mean-bwt.gph", as(jpg) name("Graph") quality(100)

clear all








