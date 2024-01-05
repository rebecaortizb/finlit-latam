**Import DTA File**
use "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/5. PE/1. STATA/PE_060623.dta"

**the below-mentioned code was not necessary to generate dummies. Gender 1 is Male and Gender 2 is Female**
gen gender=CUOTA_GENERO
gen gender_d=1 if gender==1
replace gender_d=0 if gender==2
tab gender_d, m

**This is useful if we use the dummies 1 and 2 but in this case we use 0 and 1**
recode gender (1=1) (2=0)
tab gender

drop age agesq age_range

**Generating an Age Variable**
gen age=D07
tab age

**Generating a variable for age square**
gen agesq=age*age

**Generating a variable for Age ranges**
gen age_range="18-24" if age<=24
replace age_range="25-34" if age>=25 & age<=34
replace age_range="35-44" if age>=35 & age<=44
replace age_range="45-54" if age>=45 & age<=54
replace age_range="55-64" if age>=55 & age<=64
replace age_range="65-74" if age>=65 & age<=74
replace age_range="75-84" if age>=75 & age<=84
replace age_range="85-More" if age>=85
tab age_range, m


gen saving=F03A
**the below-mentioned code was not necessary to generate dummies but it was necessary to set a binary variable for saving**
gen saving_d=1 if saving==1
replace saving_d=0 if saving!=1
tab saving_d

**Saving Habits**
**Have you been saving in the following modes?**
label variable F03B_1_Rp "Saving at home"
*Saves cash at home (piggy bank, "under the mattress") or in the wallet*
label variable F03B_2_Rp "savings or checking account"
*You leave money in a savings deposit account*
label variable F03B_3_Rp "give money to family"
*You give money to your family in order to save for you*
label variable F03B_4_Rp "informal savings group"
*You save in an informal savings group (for example, a board)*
label variable F03B_5_Rp "bonds, mutual funds, stocks"
*You buy financial investment products (such as bonds, mutual funds, shares, stocks, investments, etc.)*
label variable F03B_6_Rp "cryptocurrencies"
*Invests in cryptocurrencies (such as bitcoin, litecoin, dogecoin, etc.)*
label variable F03B_7_Rp "foreign currency"
*Saves in foreign currency*
label variable F03B_8_Rp "livestock or property"
*Saves in other ways (such as buying livestock or property)*
label variable F03B_9_Rp "Saves or invests with retirement in mind"
*Saves or invests with retirement in mind (do not consider AFP or ONP)*

**Generating a variable to establish wether an individual holds risky assets or not**
gen risky_assets=F03B_5_Rp
gen risky_assets1=1 if risky_assets==1
replace risky_assets1=0 if risky_assets!=1
tab risky_assets1, m

**Generating a variable to establish wether an individual holds risky assets or not**
gen risky_assets2=1 if F03B_6_Rp=="Sí"
replace risky_assets2=0 if F03B_6_Rp!="Sí"
tab risky_assets2, m

**Dummy for Question about bonds, mutual funds, stocks**
gen bonds_mutualfunds=F03B_5_Rp
replace bonds_mutualfunds=1 if bonds_mutualfunds=="1"
replace bonds_mutualfunds=0 if bonds_mutualfunds!="1"
tab bonds_mutualfunds
**There is no distintion between bonds, stocks, nor mutual funds. Furthermore, there are not many people investing in this financial instruments**

**Question about Foreign Currency**
gen fcurrency=F03B_7_Rp
replace fcurrency=1 if F03B_7_Rp=="Sí"
replace fcurrency=0 if F03B_7_Rp!="Sí"
tab fcurrency
**Very few people save in Foreign Currency. This could be due to lack of access and government controls**

**Here I am importing PE data**
**Finding a midpoint for monthly income**
gen monthly_income_d=D13A
replace monthly_income_d=. if D13A==99
tab D13A monthly_income_d, m

**Here I am importing PE data**
**Finding a midpoint for monthly income**
gen monthly_income_m=299 if monthly_income_d==1
replace monthly_income_m=450 if monthly_income_d==2
replace monthly_income_m=901 if monthly_income_d==3
replace monthly_income_m=1801 if monthly_income_d==4
replace monthly_income_m=3601 if monthly_income_d==5
replace monthly_income_m=7201 if monthly_income_d==6
replace monthly_income_m=9601 if monthly_income_d==7
tab monthly_income_m, m

**Monthly Income in USD. 1 USD =  3.38 PES**
gen monthly_income=monthly_income_m/3.38
tab monthly_income, m

**Asign income quartiles 1, 2, 3, 4. Creating income quartiles**
xtile monthly_income_4 = monthly_income, nq(4) 
tabstat monthly_income, stat(n mean min max sd p50) by(monthly_income_4)

**Here I am translating Education (Highest Degree) Data**
gen education=D09
gen education_t="No education/Initial education" if education==0
replace education_t="Primary Incomp./Comp./Secondary Inc" if education==1
replace education_t="Complete Secondary/Higher Technical" if education==2
replace education_t="Higher Technical Complete" if education==3
replace education_t="Higher Univ. Incomplete" if education==4
replace education_t="Higher Univ. Complete" if education==5
replace education_t="Post-Graduate University" if education==6
tab education_t

**** Transforming Education Data into years of Education ****
gen education_y=education
recode education_y (0=1) (1=6) (2=11) (3=14) (4=15) (5=16) (6=18)
label def education 0 "No education/Initial education" 6 "Primary Incomp./ Comp./ Secondary Inc" 11 "Complete Secondary/Higher Technical" 14 "Higher Technical Complete" 15 "Higher Univ. Incomplete" 16 "Higher Univ. Complete" 18 "Master's or PhD"
label values education_y education_y
label variable education "years of education"

tab gender_d education_y, r

**Here I am translating Occupational Status Data**
gen occupational_status=D10
tab occupational_status

**Here I am creating dummies for Occupational Status Data**
gen occupational_status_d=occupational_status
replace occupational_status_d=. if occupational_status==99
tab occupational_status_d

**Here I am creating translating Occupational Status Data**
gen occupational_status_t="Employer or Employer (with dependent workers)" if occupational_status==1
replace occupational_status_t="Independent / self-employed worker" if occupational_status==2
replace occupational_status_t="Technical or professional employee" if occupational_status==3
replace occupational_status_t="Unskilled worker / employee" if occupational_status==4
replace occupational_status_t="Unpaid family worker" if occupational_status==5
replace occupational_status_t="Household worker / Domestic employee" if occupational_status==6
replace occupational_status_t="Member of the Armed Forces and Police"  if occupational_status==7
replace occupational_status_t="Farmer / Farmer or Livestock Farmer" if occupational_status==8
replace occupational_status_t="Engaged in household and family chores" if occupational_status==9
replace occupational_status_t="Unable to work due to illness or ill health" if occupational_status==10
replace occupational_status_t="Not working and not looking for one either" if occupational_status==11
replace occupational_status_t="Student" if occupational_status==12
replace occupational_status_t="Other" if occupational_status==94
tab occupational_status_t, m

**Here I am creating labels for Occupational Status Data**
gen occupational_status_label="01 Employer or Employer (with dependent workers)" if occupational_status==1
replace occupational_status_label="02 Independent / self-employed worker" if occupational_status==2
replace occupational_status_label="03 Technical or professional employee" if occupational_status==3
replace occupational_status_label="04 Unskilled worker / employee" if occupational_status==4
replace occupational_status_label="05 Unpaid family worker" if occupational_status==5
replace occupational_status_label="06 Household worker / Domestic employee" if occupational_status==6
replace occupational_status_label="07 Member of the Armed Forces and Police"  if occupational_status==7
replace occupational_status_label="08 Farmer / Farmer or Livestock Farmer" if occupational_status==8
replace occupational_status_label="09 Engaged in household and family chores" if occupational_status==9
replace occupational_status_label="10 Unable to work due to illness or ill health" if occupational_status==10
replace occupational_status_label="11 Not working and not looking for one either" if occupational_status==11
replace occupational_status_label="12 Student" if occupational_status==12
replace occupational_status_label="94 Other" if occupational_status==94
tab occupational_status_label

**Generating dummy variables for occupational status categories**
encode occupational_status_t, gen(occupational_status_codes)

**Creating a variable named pension for retired individuals since there is not an occupational status for them**
gen pension=C1E1_2_Rp
replace pension=1 if C1E1_2_Rp==1
replace pension=0 if C1E1_2_Rp==2
replace pension=. if C1E1_2_Rp==97| C1E1_2_Rp==99
tab pension, m
 

**Here I am grouping occupational status into three categories**
gen occupational_status_g="Employed" if occupational_status_d<=4 | occupational_status_d==6 | occupational_status_d==7 | occupational_status_d==8
replace occupational_status_g="Unemployed" if occupational_status_d==11
replace occupational_status_g="Other" if occupational_status_d==5 | occupational_status_d==9 | occupational_status_d==10 | occupational_status_d==12 | occupational_status_d==94
tab occupational_status_g


**Generating dummy variables for occupational status categories**
encode occupational_status_g, gen(occupational_status_g_codes)

**Groups of Occupational Status dummies**
gen occupational_status_gd=1 if occupational_status_g=="Employed"
replace occupational_status_gd=2 if occupational_status_g=="Unemployed"
replace occupational_status_gd=4 if occupational_status_g=="Other"
tab occupational_status_gd

**Description of Groups of Occupational Status**
gen occupational_status_glabel="01 Employed" if occupational_status_gd==1
replace occupational_status_glabel="02 Unemployed" if occupational_status_gd==2
replace occupational_status_glabel="03 Other" if occupational_status_gd==3
replace occupational_status_glabel="." if occupational_status_gd==.
tab occupational_status_glabel

**Individuals who currently have the following financial products**
gen financial_products_b=PROD1_B01

**Here I am translating Financial Products Data for the last two years**
gen financial_products_c=PROD1_C01
gen financial_products_t="Savings account" if financial_products==1
replace financial_products_t="Checking account" if financial_products==2
replace financial_products_t="Fixed-term deposits" if financial_products==3
replace financial_products_t="Savings in cooperatives" if financial_products==4
replace financial_products_t="Mutual funds" if financial_products==5
replace financial_products_t="Personal loan" if financial_products==6
replace financial_products_t="Car loans" if financial_products==7
replace financial_products_t="Credit card loans" if financial_products==8
replace financial_products_t="Credit union loan" if financial_products==9
replace financial_products_t="Mortgage loan" if financial_products==10
replace financial_products_t="Pawnshop loans" if financial_products==11
replace financial_products_t="Loan for the purchase of equipment, machinery, etc." if financial_products==12
replace financial_products_t="Loan for the purchase of merchandise" if financial_products==13
replace financial_products_t="Life insurance" if financial_products==16
replace financial_products_t="SOAT-Car Insurance" if financial_products==17
replace financial_products_t="Health insurance - EPS" if financial_products==18
replace financial_products_t="Health Insurance - ESSALUD" if financial_products==19
replace financial_products_t="Health insurance - SIS (Seguro Integral)" if financial_products==20
replace financial_products_t="Pension fund - AFP" if financial_products==21
replace financial_products_t="Pension fund - ONP" if financial_products==22
replace financial_products_t="Collective funds (e.g., pandero)" if financial_products==23
replace financial_products_t="Lenders" if financial_products==24
replace financial_products_t="None" if financial_products==996
replace financial_products_t="." if financial_products==997
replace financial_products_t="." if financial_products==999
tab financial_products_t

**Most recent financial product**
gen chosen_finprod=PROD1_D01
gen chosen_finprod_d=chosen_finprod
replace chosen_finprod_d=. if chosen_finprod>=97
tab chosen_finprod_d, m

gen chosen_finprod_t="Savings deposits" if chosen_finprod==1
replace chosen_finprod_t="Current account deposits" if chosen_finprod==2
replace chosen_finprod_t="Fixed-term deposits" if chosen_finprod==3
replace chosen_finprod_t="Savings in cooperatives and/or mutual funds" if chosen_finprod==4
replace chosen_finprod_t="Mutual funds" if chosen_finprod==5
replace chosen_finprod_t="Personal loans" if chosen_finprod==6
replace chosen_finprod_t="Vehicle loans" if chosen_finprod==7
replace chosen_finprod_t="Deposits in foreign currency accounts" if chosen_finprod==8
replace chosen_finprod_t="Credit card" if chosen_finprod==9
replace chosen_finprod_t="Loans from cooperatives and/or mutuals" if chosen_finprod==10
replace chosen_finprod_t="Mortgage loans" if chosen_finprod==11
replace chosen_finprod_t="Pawnshop loans" if chosen_finprod==12
replace chosen_finprod_t="Loan for purchase of equipment, machinery, etc" if chosen_finprod==13
replace chosen_finprod_t="Loans for the purchase of merchandise" if chosen_finprod==14
replace chosen_finprod_t="Microinsurance" if chosen_finprod==15
replace chosen_finprod_t="Credit insurance" if chosen_finprod==16
replace chosen_finprod_t="Life insurance" if chosen_finprod==17
replace chosen_finprod_t="SOAT-Vehicular insurance" if chosen_finprod==18
replace chosen_finprod_t="Health Insurance-EPS" if chosen_finprod==19
replace chosen_finprod_t="Health Insurance-ESSALUD" if chosen_finprod==20
replace chosen_finprod_t="Health Insurance-SIS" if chosen_finprod==21
replace chosen_finprod_t="Pension Fund - AFP" if chosen_finprod==22
replace chosen_finprod_t="Pension Fund - ONP" if chosen_finprod==23
replace chosen_finprod_t="Collective Funds (e.g. pandero)" if chosen_finprod==24
replace chosen_finprod_t="Don't know" if chosen_finprod==97
replace chosen_finprod_t="Not applicable" if chosen_finprod==98
replace chosen_finprod_t="No answer" if chosen_finprod==99
tab chosen_finprod_t

**Individuals assign a score to their Level of Indebtedness"
gen level_indebtedness=S01_9_Rp
replace level_indebtedness=0 if S01_9_Rp==99
tab level_indebtedness

**Description of level_indebtedness**
gen level_indebtedness_d="1 low" if level_indebtedness==1
replace level_indebtedness_d="2 low medium" if level_indebtedness==2
replace level_indebtedness_d="3 medium" if level_indebtedness==3
replace level_indebtedness_d="4 medium high" if level_indebtedness==4
replace level_indebtedness_d="5 high" if level_indebtedness==5
replace level_indebtedness_d="." if level_indebtedness==.
tab level_indebtedness_d, m

tab chosen_finprod_d level_indebtedness, r

 drop self_assessment_m self_assessment self_assessment_d high_selfassess self_assessment_d_codes 

**Generating dummy variables for self-assessed FinLit**
gen self_assessment_m=K01
gen self_assessment=1 if self_assessment_m==5
replace self_assessment=2 if self_assessment_m==4
replace self_assessment=3 if self_assessment_m==3
replace self_assessment=4 if self_assessment_m==2
replace self_assessment=5 if self_assessment_m==1
replace self_assessment=0 if self_assessment_m==97 | self_assessment_m==99
tab self_assessment_m self_assessment, m

**Generating labels for the dummy variables for self-assessed FinLit**
gen self_assessment_d="Low" if self_assessment<=2
replace self_assessment_d="Average" if self_assessment==3
replace self_assessment_d="High" if self_assessment>=4
replace self_assessment_d="Does not know/Does not reply" if self_assessment==0
tab self_assessment_d self_assessment, m

**Generating dummies for self-assessment**
gen self_assess=1 if self_assessment<=2
replace self_assess=2 if self_assessment==3
replace self_assess=3 if self_assessment>=4
replace self_assess=0 if self_assessment==0
tab self_assess self_assessment, m

**Creating a binary variable for individuals who self-assess themselves as highly financially literate**
gen high_selfassess=1 if self_assessment>=4
replace high_selfassess=0 if self_assessment<=3
tab self_assessment high_selfassess, m

**Creating a binary variable for individuals who self-assess themselves as highly financially literate**
gen high_selfassess=1 if self_assessment>=4
replace high_selfassess=0 if self_assessment<=3
tab self_assessment high_selfassess, m

**Grouping individuals into high level of debt**
gen high_debt=1 if level_indebtedness>=4
replace high_debt=0 if level_indebtedness<=3
replace high_debt=. if level_indebtedness==.
tab high_debt, m

drop finq1 finq1_i finq2 finq2_i finq3 finq3_i finq4 finq4_i finq5 finq5_i finq6 finq6_i finq7 finq7_i finq8 finq8_i

**This question might be too simple to use for the FL index w/ missing values**
gen finq1_i=K02
gen finq1=1 if finq1_i==200
replace finq1=0 if finq1_i!=200
tab finq1_i finq1, m

**Question about Inflation**
gen finq2_i=K03
gen finq2=1 if finq2_i==3
replace finq2=0 if finq2_i!=3
tab finq2_i finq2, m

**Question about Interest (very easy)**
gen finq3_i=K04
gen finq3=1 if finq3_i==1
replace finq3=0 if finq3_i!=1
tab finq3_i finq3, m

**Question about Simple Interest. In this case, individuals were not given options but they had to write down the correct answer**
gen finq4_i=K05
gen finq4=1 if finq4_i==102
replace finq4=0 if finq4_i!=102
tab finq4_i finq4, m

**Question about Compound Interest**
gen finq5_i=K06
gen finq5=1 if finq5_i==1
replace finq5=0 if finq5_i!=1
tab finq5_i finq5, m

*Financial literacy true of false question 1 K7_1*
gen finq6_i=K07_1_Rp
gen finq6=1 if finq6_i==1
replace finq6=0 if finq6_i!=1
tab finq6_i finq6, m

*Financial literacy true of false question 2 K7_2*
gen finq7_i=K07_2_Rp
gen finq7=1 if finq7_i==1
replace finq7=0 if finq7_i!=1
tab finq7_i finq7, m

*Financial literacy true of false question 3 K7_3*
gen finq8_i=K07_3_Rp
gen finq8=1 if finq8_i==1
replace finq8=0 if finq8_i!=1
tab finq8_i finq8, m

drop FL_d FL_i FL_label FL_4q FL_c

**Here I add questions about Inflation, Simple Interest and Compound Interest**
gen FL_d=finq2+finq4+finq5
tab FL_d

gen FL_i=finq2+finq4+finq5
label def FL_i 0 "None" 1 "Low" 2 "Medium" 3 "High"
label values FL_i FL_i
label variable FL_i "Financial Literacy"
tab FL_i, m
sum FL_i

**Description of Financial Literacy**
gen FL_label="0 None" if FL_i==0
replace FL_label="1 Low" if FL_i==1
replace FL_label="2 Medium" if FL_i==2
replace FL_label="3 High" if FL_i==3
tab FL_label

**Is there any difference on the effect that different types of Financial knowledge might have on indebtedness or Trust**
**Generating a more comprehensive FinLit index with 4 questions**
gen FL_4q=finq2+finq3+finq4+finq5
tab FL_4q, m

**Generating a more comprehensive FinLit index**
gen FL_c=finq1+finq2+finq3+finq4+finq5
tab FL_c, m

**Generating a more comprehensive FinLit index**
gen FL_c1=finq1+finq2+finq3+finq4+finq5+finq6+finq7
tab FL_c1, m

**Generating a more comprehensive FinLit index**
gen FL_c2=finq2+finq3+finq4+finq5
tab FL_c2, m

drop  low_FL high_FL

**Here I am constructing a Low FinLit Variable for individuals who scored 0 or less in the selected questions**
gen low_FL=1 if FL_i==0
replace low_FL=0 if FL_i>=1
tab low_FL, m

**Max if I change the number of questions**
gen high_FL=1 if FL_i>=2
replace high_FL=0 if FL_i<=1
tab high_FL, m

**Here I am constructing a Low FinLit Variable for individuals who scored 0 or less in the selected questions**
gen low_FL1=1 if FL_c<=2
replace low_FL1=0 if FL_c>=3
tab low_FL1, m

**Max if I change the number of questions**
gen high_FL1=1 if FL_c>=4
replace high_FL1=0 if FL_c<=3
tab high_FL1, m

corr FL age gender_d education
reg FL age gender_d i.education
histogram monthly_income_4, bin(8)
histogram education_y, bin(8)
plot gender_d education_y

corr FL_i age agesq gender_d education_y monthly_income employment_status

**Here I am creating dummy variables for Trust Data**
gen trust_d=S03_7_Rp
replace trust_d=. if S03_7_Rp>=97
tab trust_d

**Generating dummies for Trust. Double-check if selected ranges are correct**
gen trust=1 if trust_d>=3
replace trust=0 if trust_d<=2
tab trust

**Run the same regressions I have run before. This is with the 3 questions index**
reg high_debt high_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg high_debt high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
reg high_debt low_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg high_debt low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust

reg trust high_FL age agesq gender education_y monthly_income i.occupational_status_codes
reg trust high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
reg trust low_FL age agesq gender education_y monthly_income i.occupational_status_codes
reg trust low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes

**For this one it is not a binary dependent variable so the logit model cannot be applied**
reg self_assessment high_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg self_assessment high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
reg self_assessment low_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg self_assessment low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust

**Regression for high_selfassess**
reg high_selfassess high_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg high_selfassess high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
reg high_selfassess low_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg high_selfassess low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust

**Making variable names uniform accross countries**
drop country
gen country="Peru"

