clear

use "https://github.com/tvogl/econ121/raw/main/data/nhis2000.dta "

*Question 1

generate healthstatus = 0
replace healthstatus = 1 if health == 4
replace healthstatus = 1 if health == 5

summarize 

*Question 2

twoway (kdensity mort5 if healthstatus==1,bw(.07) lcolor(pink)) ///
       (kdensity mort5 if healthstatus==0,bw(.07) lcolor(blue)) ///
	   , legend(label(1 "Fair/Poor") label(0 "Other"))
