clear

use "https://github.com/tvogl/econ121/raw/main/data/nhis2000.dta "

*Question 1

generate healthstatus = (health == 4 | health == 5)
summarize 

*Question 2

twoway (lpoly mort5 age if healthstatus==1, degree(1) bw(1) lcolor(pink)) ///
       (lpoly mort5 age if healthstatus==0, degree(1) bw(1) lcolor(blue)) ///
		,legend(label(1 "Fair/Poor") label(2 "Other"))

*Question 3

*part a

generate faminc_lt20 = (faminc_gt75 == 0 & faminc_20t75 == 0)
graph bar mort5 healthstatus,over(faminc_lt20)
graph bar mort5 healthstatus,over(faminc_gt75)
graph bar mort5 healthstatus,over(faminc_20t75)

*part b
gen var lt_hs = (edyrs < 12)
graph bar mort5 healthstatus,over(edyrs)
