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

//part a
gen faminc_lt20 = (faminc_gt75 == 0 & faminc_20t75 == 0)
gen famincs=0 if faminc_lt20==1
replace famincs =1 if faminc_20t75==1
replace famincs =2 if faminc_gt75==1
drop if famincs==.

label define famincs_lbl 0 "<20k" 1 "20k-75k" 2 ">75k"
label values famincs famincs_lbl
graph bar mort5 healthstatus,over(famincs) legend(label(1 "5-Year Mortality") label(2 "Fair/Poor Health Condition"))

//part b
recode edyrs (1/11=1 "lt_highschool") (12=2 "highschool") (13/15=3 "some_college") (16=4 "college") (17/40=5 "postgrad"), gen(edyr) label(edyr) 
graph bar mort5 healthstatus, over(edyr)


*Question 4
gen male = 2 - sex
gen hsgrad = (edyrs >= 12 & edyrs < 16)
gen collegegrad = (edyrs >= 16)

// Linear Probability Models:
reg mort5 age hsgrad collegegrad faminc_20t75 faminc_gt75 male white black hisp other, r
reg healthstatus age hsgrad collegegrad faminc_20t75 faminc_gt75 male white black hisp other, r

// Probit Models:
probit mort5 age hsgrad collegegrad faminc_20t75 faminc_gt75 male white black hisp other, r
margins, dydx(*)
probit healthstatus age hsgrad collegegrad faminc_20t75 faminc_gt75 male white black hisp other, r
margins, dydx(*)

// Logit Models:
logit mort5 age hsgrad collegegrad faminc_20t75 faminc_gt75 male white black hisp other, r
mfx compute
logit healthstatus age hsgrad collegegrad faminc_20t75 faminc_gt75 male white black hisp other, r
mfx compute


*Question 5 :

di -1.379686 + .3186471

*Question 7 :

reg uninsured age hsgrad collegegrad faminc_20t75 faminc_gt75 male white black hisp other, r

