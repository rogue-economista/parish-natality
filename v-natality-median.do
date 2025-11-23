// visualize restricted NVSS Natality data medians by parish-year quartile, 1989-2005

global mainDir = "P:\1.SHolmes\parish-health-natality"
global rawDir = "$mainDir\raw"
global dictDir = "$mainDir\dict"
global stataDir = "$mainDir\data"
global bwtDir = "$stataDir\bwt"
global outputDir = "mainDir\output"
global medianDir = "$stataDir\quartiles-median"
cd "$mainDir"





// collapse each quartile by median birth weight for every year
forvalues x = 1/4 {
	use "$stataDir\quartiles-median\quartile-1.dta"
	collapse (median) dbwt_Q`x'_median=dbwt, by(YEAR)
	save "$bwtDir\quartiles\quartile-`x'-median.dta", replace

	clear all

}





// merge the median birth weight files together
forvalues x = 2/4 {
use "$stataDir\quartiles-median\quartile-1-median.dta"
	merge 1:1 YEAR using "$stataDir\quartiles-median\quartile-`x'-median.dta", nogenerate
	save "$stataDir\quartiles-median\quartiles-merged.dta", replace

}


******************************************************************************
************************ Quartile Graphs *************************************
************************    Median      **************************************
******************************************************************************


// Parish quartiles graph for Median Birth Weights

save "$stataDir\quartiles-median\quartiles-merged.dta"

twoway (line dbwt_Q1_median YEAR, lcolor(black) lwidth(medthick) lpattern(solid)) (line dbwt_Q2_median YEAR, lcolor(teal) lwidth(medthick) lpattern(longdash)) (line dbwt_Q3_median YEAR, lcolor(green) lwidth(thick) lpattern(dash_3dot)) (line dbwt_Q4_median YEAR, lcolor(red) lwidth(medium) lpattern(dash_dot_dot)), ytitle(`"Birth Weight (grams)"') ylabel(, format(%15.0gc)) xtitle(`"Year"') xline(1994) title(`"Median Birth Weight, Parish-Level"') subtitle(`"1987-2005"') legend(order(1 "1st Quartile" 2 "2nd Quartile" 3 "Quartile 3" 4 "Quartile 4")) scheme(cblind1)

graph save "Graph" "$outputDir\quartiles-median-bwt.gph"
graph export "$outputDir\quartiles-median-bwt.gph", as(jpg) name("Graph") quality(100)

clear all








