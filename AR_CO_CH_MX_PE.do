* Append *
clear all

use "/Users/Rebeca/Desktop/Corrected/AR1.dta", clear
append using "/Users/Rebeca/Desktop/Corrected/CH1.dta", force 
append using "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/2. CO/1. STATA/CO_060623.dta", force
append using "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/5. PE/1. STATA/PE_060623.dta", force 
append using "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/4. MX/1. STATA/MX_060623.dta", force 

use "/Users/Rebeca/Desktop/Corrected/AP copy.dta"

, replace

**Generating dummy variables for countries**
encode country, gen(country_codes)

label def country 1 "Argentina" 2 "Chile" 3 "Colombia" 4 "Mexico" 5 "Peru"
label variable country country
label variable country "country"
tab country, m

**Cat var for gender**
gen sex="Female" if gender==0
replace sex="Male" if gender!=0
tab country sex, m

**Labelling levels of financial literacy**
label def gender 0 "Female" 1 "Male"
label values gender gender
label variable gender "gender"
tab gender, m

**Labelling levels of financial literacy**
gen FL=finq2+finq4+finq5
gen FL_i=finq2+finq4+finq5
label def FL_i 0 "1 None" 1 "2 Low" 2 "2 Medium" 3 "3 High"
label values FL_i FL_i
label variable FL_i "Financial Literacy"
tab FL_i, m

**Generating new low and high FL variables**
gen low_FL=1 if FL_i<=1
replace low_FL=0 if FL_i>=2

gen high_FL=1 if FL_i==3
replace high_FL=0 if FL_i<=2

**Asign FL_i quartiles 1, 2, 3, 4. Creating FL quartiles**
xtile FL_i_4 = FL_i, nq(4) 
tabstat FL_i, stat(n mean min max sd p50) by(FL_i_4)

**Generating dummy variables for occupational status categories**
encode age_range, gen(age_range_codes)

**Generating variables for age groups**
gen age_group="1 Young" if age<=35
replace age_group="2 Middle-Aged" if age>=36 & age<=59
replace age_group="3 Old" if age>=60
tab age_group, m

**Generating dummy variables for age groups**
encode age_group, gen(age_group_codes)
recode age_group_codes (1=2) (2=3) (3=1)

**Generating variables for levels of education**
gen educ_level="1 Low" if education_y<=6
replace educ_level="2 Medium" if education_y>=7 & education_y<=14
replace educ_level="3 High" if education_y>=15
tab education_y educ_level, m

**Generating dummy variables for occupational status categories**
**Description of level finlit based on the number of correct answers. This is based on three selected FinLit questions found in the 3 countries studied**
encode educ_level, gen(educ_level_codes)
recode educ_level_codes (1=3) (2=1) (3=2)
label variable educ_level_codes educ_level
label variable educ_level "education level"
tab educ_level_codes, m

**Asign monthly income quartiles 1, 2, 3, 4. Creating quartiles**
xtile monthly_income_4 = monthly_income, nq(4) 
tabstat monthly_income, stat(n mean min max sd p50) by(monthly_income_4)

**Asign education years quartiles 1, 2, 3, 4. Creating quartiles**
xtile education_y_4 = education_y, nq(4) 
tabstat education_y, stat(n mean min max sd p50) by(education_y_4)

**To check the accuracy of the output**
tab FL_i high_FL if country=="Mexico", r

**Organizing occupational status groups**
gen occupational_status_group="1 Employed" if occupational_status_g=="Employed"
replace occupational_status_group="2 Unemployed" if occupational_status_g=="Unemployed"
replace occupational_status_group="3 Retired" if occupational_status_g=="Retired"
replace occupational_status_group="4 Other" if occupational_status_g=="Other"
tab occupational_status_g occupational_status_group, m

encode occupational_status_group, gen(occupational_status_group_codes)

drop agesq
**Rescaling Variables**
gen agesq=((age-43)/17)^2

gen monthly_income_r=monthly_income/1000

**Self assess desc**
gen self_assess_d="0 DNK/DNR" if self_assess==0
replace self_assess_d="1 Low" if self_assess==1
replace self_assess_d="2 Medium" if self_assess==2
replace self_assess_d="3 High" if self_assess==3
tab self_assess_d FL_i, m

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
graph bar education_y, over(country) stack
graph bar age_group, over(country) stack 
graph bar sex, over(country) stack 
graph bar monthly_income_4, over(country) stack

**The code below works**
graph bar education_y, over(country) asyvars
			
**Then performance in each FinLit question and performance by country when we look at the index. In the end of code write "asyvars"**
graph bar FL_i, over(country) stack
graph bar finq1, over(country) stack 
graph bar finq2, over(country) stack 
graph bar finq3, over(country) stack 
graph bar finq4, over(country) stack 
graph bar finq5, over(country) stack

preserve
collapse (mean) occupational_status_g_codes= occupational_status_g_codes, by( sex country)
graph bar occupational_status_g_codes, over(sex) over(country) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( sex country)
graph bar FL_i, over(sex) over(country) asyvars
restore

preserve
collapse (mean) FL= FL_i, by( age_range country)
graph bar FL, over(age_range) over(country) asyvars
restore

preserve
collapse (mean) FL= FL_i, by( age_group country)
graph bar FL, over(age_group) over(country) asyvars
restore

preserve
collapse (mean) FL_i= FL_i, by( educ_level country)
graph bar FL_i, over( educ_level) over(country) asyvars
restore

preserve
collapse (mean) education_y= education_y, by( sex country)
graph bar education_y, over(sex) over(country) asyvars
restore

preserve
collapse (mean) educ_level_codes= educ_level_codes, by( sex country)
graph bar educ_level_codes, over(sex) over(country) asyvars
restore

preserve
collapse (mean) trust= trust, by( sex country)
graph bar trust, over(sex) over(country) asyvars
restore

preserve
collapse (mean) trust= trust, by( age_group country)
graph bar trust, over( age_group) over(country) asyvars
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
collapse (mean) highdebt= high_debt, by( age_group country)
graph bar highdebt, over( age_group) over(country) asyvars
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
collapse (mean) highFL= high_FL, by( educ_level country)
graph bar highFL, over( educ_level) over(country) asyvars
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
collapse (mean) lowFL= low_FL, by(educ_level country)
graph bar lowFL, over( educ_level) over(country) asyvars
restore

preserve
collapse (mean) self_assess_= self_assess, by( sex country)
graph bar self_assess, over(sex) over(country) asyvars
restore

preserve
collapse (mean) self_assess= self_assess, by( age_group country)
graph bar self_assess, over( age_group) over(country) asyvars
restore

graph twoway scatter FL_i education_y
graph twoway lfit FL_i education_y
graph twoway (lfit FL_i education_y) (scatter FL_i education_y)
graph twoway (lfitci FL_i education_y) (scatter FL_i education_y)

graph twoway scatter monthly_income_r  FL_i
graph twoway lfit FL_i monthly_income_r
graph twoway (lfit FL_i monthly_income_r) (scatter FL_i monthly_income_r)
graph twoway (lfitci FL_i monthly_income_r) (scatter FL_i monthly_income_r)

graph box FL_i, over(country) over(sex)

gen Female=sex if sex=="Female"
gen Male=sex if sex=="Male"

**Search barmean options**

**Run the same regressions I have run before. This is with the 3 questions index**
reg high_debt i.country_codes high_FL age agesq gender education_y monthly_income_r i.occupational_status_group_codes trust
outreg2 using myfile1
asdoc regress high_debt i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust, save(St_W1)
asdoc regress high_debt i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust, nested save(St_W1) replace

reg high_debt i.country_codes low_FL age agesq gender education_y monthly_income_r i.occupational_status_group_codes trust
outreg2 using myfile2
asdoc regress high_debt i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust, append save(St_W1)
asdoc regress high_debt i.country_codes low_FL age agesq gender education_y monthly_income_r i.occupational_status_group_codes trust, nested save(St_W1) replace

**Regression of Trust on multiple controls**
reg trust i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile3
asdoc regress trust i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, append save(St_W1)
asdoc regress trust i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, nested save(St_W2) replace

reg trust i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile4
asdoc regress trust i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, append save(St_W1)
asdoc regress trust i.country_codes low_FL age agesq gender education_y monthly_income_r i.occupational_status_group_codes, nested save(St_W2) replace

**Regression of High and Low FL on multiple controls**
reg high_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile5
asdoc regress high_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes, append save(St_W1)
asdoc regress high_FL i.country_codes age agesq gender education_y monthly_income_r i.occupational_status_g_codes, nested save(St_W3) replace

reg low_FL i.country_codes age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile6
asdoc regress low_FL i.country_codes age agesq gender education_y monthly_income_r i.occupational_status_group_codes, nested save(St_W3) replace

**The output variable is not binary. It takes values from 0 to 3**
reg self_assess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile7
asdoc regress self_assess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes, nested save(St_W4) replace

reg self_assess i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
outreg2 using myfile8
asdoc regress self_assess i.country_codes low_FL age agesq gender education_y monthly_income_r i.occupational_status_group_codes, nested save(St_W4) replace

**Regression of high_selfassess**
reg high_selfassess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
outreg2 using myfile9
asdoc regress high_selfassess i.country_codes high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust, nested save(St_W5) replace

reg high_selfassess i.country_codes low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
outreg2 using myfile10
asdoc regress high_selfassess i.country_codes low_FL age agesq gender education_y monthly_income_r i.occupational_status_group_codes trust, nested save(St_W5) replace

	**How to store a regression in Word**
	eststo:reg y on x
	**How to make a histogram**
	graph bar X, over(Y) stack title("Frequency of X by Y")
	**How to save as worddoc. Do this before creating the tables**
	asdoc tab country sex, row replace St(W1)
	asdoc tab country age_group, row replace St(W1)
	asdoc tab country educ_level, row replace St(W1)
	asdoc tab country education_y, row replace St(W1)
	asdoc tab country monthly_income_r, row replace St(W1)
	asdoc tab country occupational_status_group, row replace St(W1) replace
	asdoc tab country trust, row save St(W1) replace
	asdoc tab country high_debt, row save St(W1) replace
	asdoc tab country high_FL, row save St(W1) replace
	asdoc tab country low_FL, row save St(W1) replace
	asdoc tab country self_assess, row save St(W1) replace
	asdoc tab country high_selfassess, row save St(W1) replace
	asdoc tab sex educ_level,row save St(W1) replace
	asdoc tab sex monthly_income_4,row save St(W1) replace
	asdoc tab sex self_assess, row save St(W1) replace
	asdoc tab sex high_debt, row save St(W1) replace
	asdoc tab sex high_FL, row save St(W1) replace
	asdoc tab sex low_FL, row save St(W1) replace
	asdoc tab sex trust, row save St(W1) replace
	asdoc tab age_group self_assess, row save St(W1) replace
	asdoc tab age_group high_debt, row save St(W1) replace
	asdoc tab age_group high_FL, row save St(W1) replace
	asdoc tab age_group low_FL, row save St(W1) replace
	asdoc tab age_group trust, row save St(W1) replace
	
	**Performance in Financial Literacy Questions by country**
	asdoc tab country finq1, row save St(W1) replace
	asdoc tab country finq2, row save St(W1) replace
	asdoc tab country finq3, row save St(W1) replace
	asdoc tab country finq4, row save St(W1) replace
	asdoc tab country finq5, row save St(W1) replace
	asdoc tab country FL_i, row save St(W1) replace
	asdoc tab self_assess_d FL_i, row save St(W1) replace

**Notes**
* Figures: bar plot of two variables

    global graph_opts1 ///
           bgcolor(white) ///
           graphregion(color(white)) ///
           legend(region(lc(none) fc(none))) ///
           ylab(,angle(0) nogrid) ///
           title(, justification(left) color(black) span pos(11)) ///
           subtitle(, justification(left) color(black))

    use "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/8. Append/dta/AR_CO_CH_MX_PE.dta", clear

    graph bar gender ///
        , ///
          over(type) ///
          asy ///
          bargap(20) ///
          over(study) ///
          over(case) ///
          nofill ///
          blabel(bar, format(%9.2f)) ///
          ${graph_opts1} ///
          bar(1 , lc(black) lw(thin) fi(100)) ///
          bar(2 , lc(black) lw(thin) fi(100)) ///
          legend(r(1) ///
          order(0 "Measurement:" 1 "Standardized Patient" 2 "Clinical Vignette")) ///
          ytit("Providers ordering correct treatment {&rarr}", ///
               placement(bottom) ///
               justification(left)) ///
          ylab(${pct})
	
**Notes. Source: https://stats.oarc.ucla.edu/stata/faq/how-can-i-make-a-bar-graph-with-error-bars/**

use "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/8. Append/dta/AR_CO_CH_MX_PE.dta", clear

preserve
collapse (mean) meanFL_i= FL_i (sd) sdFL_i=FL_i (count) n=FL_i, by(country_codes sex)

generate hiFL_i = meanFL_i + invttail(n-1,0.025)*(sdFL_i / sqrt(n))
generate loFL_i = meanFL_i - invttail(n-1,0.025)*(sdFL_i / sqrt(n))

graph bar meanFL_i, over(country_codes) over(sex)
graph bar meanFL_i, over(country_codes) over(sex) asyvars 

graph twoway (bar meanFL_i country_codes) (rcap hiFL_i loFL_i country_codes), by(sex)

restore

generate sexcountry = country_codes    if sex == "Female"
replace  sexcountry = country_codes+5  if sex == "Male"
sort sexcountry
list sexcountry sex country_codes, sepby(sex)

twoway (bar meanFL_i sexcountry)
twoway (bar meanFL_i sexcountry) (rcap hiFL_i loFL_i sexcountry)

twoway (bar meanFL_i sexcountry if country_codes==1) ///
       (bar meanFL_i sexcountry if country_codes==2) ///
       (bar meanFL_i sexcountry if country_codes==3) ///
       (bar meanFL_i sexcountry if country_codes==4) ///
	   (bar meanFL_i sexcountry if country_codes==5) ///
       (rcap hiFL_i loFL_i gender), ///
       legend(row(1) order(1 "Argentina" 2 "Colombia" 3 "Chile" 4 "Mexico" 5 "Peru") ) ///
       xlabel( 0 "None" 1 "Low" 2 "Middle" 3 "High", noticks) ///
       xtitle("Financial Literacy Disaggregated by Country and Gender") ytitle("Mean Writing Score")
	   
