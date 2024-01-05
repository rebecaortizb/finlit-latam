* Append *
clear all

use "/Users/Rebeca/Desktop/Corrected/AR1.dta", clear
append using "/Users/Rebeca/Desktop/Corrected/CH1.dta", force 
append using "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/2. CO/1. STATA/CO_060623.dta", force
append using "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/5. PE/1. STATA/PE_060623.dta", force

save "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/8. Append/dta/AR_CO_CH_PE.dta", replace

replace FL=FL_i if country=="PE"
tab FL FL_i, m

**Cat var for gender**
gen sex="Female" if gender==0
replace sex="Male" if gender!=0
tab country sex, m

**Asign FL_i quartiles 1, 2, 3, 4. Creating FL quartiles**
xtile FL_i_4 = FL_i, nq(4) 
tabstat FL_i, stat(n mean min max sd p50) by(FL_i_4)

**Generating dummy variables for occupational status categories**
encode country, gen(country_codes)

**Generating dummy variables for occupational status categories**
encode age_range, gen(age_range_codes)

**Generating variables for age groups**
gen age_group="1 Young" if age<=35
replace age_group="2 Middle-Aged" if age>=36 & age<=59
replace age_group="3 Old" if age>=60
tab age_group, m

**Generating variables for levels of education**
gen educ_level="Low" if education_y<=6
replace educ_level="Medium" if education_y>=7 & education_y<=14
replace educ_level="High" if education_y>=15
tab education_y educ_level, m

**Generating dummy variables for occupational status categories**
**Description of level finlit based on the number of correct answers. This is based on three selected FinLit questions found in the 3 countries studied**
encode educ_level, gen(educ_level_codes)
recode educ_level_codes (1=3) (2=1) (3=2)
label values educ_level_codes educ_level
label variable educ_level "education level"
tab educ_level_codes, m

**Generating dummy variables for occupational status categories**
**Description of level finlit based on the number of correct answers. This is based on three selected FinLit questions found in the 3 countries studied**
encode self_assessment_d, gen(self_assessment_d_codes)
recode self_assessment_d_codes (1=2) (2=0) (3=3) (4=1)
label values self_assessment_d_codes self_assessment
label variable self_assessment "self assessment"
tab self_assessment_d_codes, m

**Self assess desc**
gen self_assess_d="0 DNK/DNR" if self_assess==0
replace self_assess_d="1 Low" if self_assess==1
replace self_assess_d="2 Medium" if self_assess==2
replace self_assess_d="3 High" if self_assess==3
tab self_assess_d FL_i, m

**Self assess desc**
gen high_selfassess_d="No" if high_selfassess==0
replace high_selfassess_d="Yes" if high_selfassess==1
tab high_selfassess_d FL_i, m


drop monthly_income_4
**Asign monthly income quartiles 1, 2, 3, 4. Creating quartiles**
xtile monthly_income_4 = monthly_income, nq(4) 
tabstat monthly_income, stat(n mean min max sd p50) by(monthly_income_4)

**Asign education years quartiles 1, 2, 3, 4. Creating quartiles**
xtile education_y_4 = education_y, nq(4) 
tabstat education_y, stat(n mean min max sd p50) by(education_y_4)

**To check the accuracy of the output**
tab FL_i high_FL if country=="Argentina", r


**Descriptive Statistics**
**Histograms for Education_y, Ocupational_Status_g, Age Groups by country. Note: Create education groups (low, middle, high)**
kdensity education_y, by(country)
kdensity ocupational_status_g, by(country)
twoway  (kdensity education_y if country == "Argentina", color(gs10)) ///
            (kdensity education_y if country == "Colombia", color(emerald)) ///
            (kdensity education_y if country == "Chile", color(red)) ///
            (kdensity education_y if country == "Mexico", color(green)) ///
            (kdensity education_y if country == "Peru", color(black)), ///
			legend(order(1 "Argentina" 2 "Colombia" 3 "Chile" 4 "Mexico" 5 "Peru")) ///
            xtitle(Country) ///
            ytitle(education_y) ///
            bgcolor (white) graphregion(color(white))

**Histograms for Education_y, Occupational_Status_g, Age Groups by country. Note: Create education groups (low, middle, high)**
graph bar educ_level_codes, over(country) stack 
graph bar education_y, over(country) stack 
graph bar age_range_codes, over(country) stack 
graph bar age, over(country) stack 
			
**Then performance in each FinLit question and performance by country when we look at the index. In the end of code write "asyvars"**
graph bar FL_i, over(country) stack
graph bar finq1, over(country) stack 
graph bar finq2, over(country) stack 
graph bar finq3, over(country) stack 
graph bar finq4, over(country) stack 
graph bar finq5, over(country) stack 

preserve
collapse (mean) FL= FL_i, by( sex country)
graph bar FL, over(sex) over(country) asyvars
restore

preserve
collapse (mean) FL= FL_i, by( age_range country)
graph bar FL, over(age_range) over(country) asyvars
restore

preserve
collapse (mean) education_y= education_y, by( sex country)
graph bar education_y, over(sex) over(country) asyvars
restore

preserve
collapse (mean) trust= trust, by( sex country)
graph bar trust, over(sex) over(country) asyvars
restore

preserve
collapse (mean) trust= trust, by( age_range country)
graph bar trust, over( age_range) over(country) asyvars
restore

preserve
collapse (mean) highdebt= high_debt, by( sex country)
graph bar highdebt, over(sex) over(country) asyvars
restore

preserve
collapse (mean) highdebt= high_debt, by( age_range country)
graph bar highdebt, over( age_range) over(country) asyvars
restore

preserve
collapse (mean) highFL= high_FL, by( sex country)
graph bar highFL, over(sex) over(country) asyvars
restore

preserve
collapse (mean) highFL= high_FL, by( age_range country)
graph bar highFL, over( age_range) over(country) asyvars
restore

preserve
collapse (mean) lowFL= low_FL, by( sex country)
graph bar lowFL, over(sex) over(country) asyvars
restore

preserve
collapse (mean) lowFL= low_FL, by( age_range country)
graph bar lowFL, over( age_range) over(country) asyvars
restore

preserve
collapse (mean) self_assess= self_assess, by( sex country)
graph bar self_assess, over(sex) over(country) asyvars
restore

preserve
collapse (mean) self_assess= self_assess, by( age_range country)
graph bar self_assess, over( age_range) over(country) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( sex self_assessment_d)
graph bar FL_i, over( sex) over(self_assessment_d) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( age_group self_assessment_d)
graph bar FL_i, over(age_group) over(self_assessment_d) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( self_assessment_d  sex)
graph bar FL_i, over(self_assessment_d ) over(sex) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( age_range self_assessment_d)
graph bar FL_i, over(age_range) over(self_assessment_d) asyvars
restore


preserve
collapse (mean) self_assess= self_assess, by( FL_i country)
graph bar self_assess, over( FL_i ) over(country) asyvars
restore

preserve
collapse (mean) self_assess= self_assess, by( FL_i sex)
graph bar self_assess, over( FL_i ) over(sex) asyvars
restore

preserve
collapse (mean) self_assess= self_assess, by( FL_i age_group)
graph bar self_assess, over( FL_i ) over(age_group) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( self_assess_d country)
graph bar FL_i, over( self_assess ) over(country) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( self_assess_d sex)
graph bar FL_i, over( self_assess_d ) over(sex) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( self_assess_d age_group)
graph bar FL_i, over( self_assess_d ) over(age_group) asyvars
restore

preserve
collapse (mean) high_selfassess= high_selfassess, by( FL_i country)
graph bar high_selfassess, over( FL_i ) over(country) asyvars
restore

preserve
collapse (mean) high_selfassess= high_selfassess, by( FL_i sex)
graph bar high_selfassess, over( FL_i ) over(sex) asyvars
restore

preserve
collapse (mean) high_selfassess= high_selfassess, by( FL_i age_group)
graph bar high_selfassess, over( FL_i ) over(age_group) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( high_selfassess_d country)
graph bar FL_i, over( high_selfassess_d) over(country) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by(high_selfassess_d sex)
graph bar FL_i, over(high_selfassess_d) over(sex) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by(high_selfassess_d age_group)
graph bar FL_i, over(high_selfassess_d) over(age_group) asyvars
restore

**Search barmean options**

asdoc tab country self_assessment_d, row save (self_assess) replace

**Run the same regressions I have run before. This is with the 3 questions index**
reg high_debt i.country_codes high_FL age agesq gender education_y monthly_income_4 i.occupational_status_g_codes trust
outreg2 using myfile1
asdoc regress high_debt i.country_codes high_FL age agesq gender education_y monthly_income_4 i.occupational_status_g_codes trust, save(St_W1)
asdoc regress high_debt i.country_codes high_FL age agesq gender education_y monthly_income_4 i.occupational_status_g_codes trust, nested save(St_W1) replace

reg high_debt i.country_codes low_FL age agesq gender education_y monthly_income_4 i.occupational_status_g_codes trust
outreg2 using myfile2
asdoc regress high_debt i.country_codes low_FL age agesq gender education_y monthly_income_4 i.occupational_status_g_codes trust, append save(St_W1)
asdoc regress high_debt i.country_codes low_FL age agesq gender education_y monthly_income_4 i.occupational_status_g_codes trust, append nested save(St_W1)

**Regression of Trust on multiple controls**
reg trust i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile3
asdoc regress trust i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, append save(St_W1)
asdoc regress trust i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, nested save(St_W2) replace

reg trust i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile4
asdoc regress trust i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, append save(St_W1)
asdoc regress trust i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, append nested save(St_W2)

**Regression of High and Low FL on multiple controls**
reg high_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile5
asdoc regress high_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes, append save(St_W1)
asdoc regress high_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes, nested save(St_W3) replace

reg low_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile6
asdoc regress low_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes, append nested save(St_W3)

**The output variable is not binary. It takes values from 0 to 3**
reg self_assess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile7
asdoc regress self_assess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, nested save(St_W4) replace

reg self_assess i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile8
asdoc regress self_assess i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, append nested save(St_W4)

**Regression of high_selfassess**
reg high_selfassess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
outreg2 using myfile9
asdoc regress high_selfassess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust, nested save(St_W5) replace

reg high_selfassess i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
outreg2 using myfile10
asdoc regress high_selfassess i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust, append nested save(St_W5)
