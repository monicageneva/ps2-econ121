clear

use "https://github.com/tvogl/econ121/raw/main/data/nhis2000.dta "


generate healthstatus = 0
replace healthstatus = 1 if health == 4
replace healthstatus = 1 if health == 5

summarize 
