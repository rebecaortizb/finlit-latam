**Import DTA File**
use "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/4. MX/1. STATA/MX_060623.dta"

**Creating dummy variables for gender**
gen gender_d=1 if gender==1
replace gender_d=0 if gender!=1
tab gender_d

label variable gender_d "gender"

**This is useful if we use the dummies 1 and 2 but in this case we use 0 and 1**
recode gender (1=1) (2=0)
tab gender

**the below-mentioned code was not necessary to generate dummies but it was necessary to set a binary variable for saving**
gen saving=0 if p4_10==1 |p4_10==8 | p4_10==9
replace saving=1 if p4_10<=5 & p4_10!=1 & p4_10!=8 & p4_10!=9
tab saving, m

**Generating a variable for Age square**
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

**Here I am importing MX data**
**Generating monthly income**
gen monthly_income_m=p3_8a*4.33 if p3_8b==1
replace monthly_income_m=p3_8a*2.165 if p3_8b==2
replace monthly_income_m=p3_8a if p3_8b==3
replace monthly_income_m=p3_8a/12 if p3_8b==4
replace monthly_income_m=0 if p3_8a==0
replace monthly_income_m=. if p3_8a==99888
tab monthly_income_m, m

**Monthly Income in USD. 1 USD =  20.50 MXP**
gen monthly_income=monthly_income_m/20.50
tab monthly_income, m

**Asign income quartiles 1, 2, 3, 4. Creating income quartiles**
xtile monthly_income_4 = monthly_income, nq(4) 
tabstat monthly_income, stat(n mean min max sd p50) by(monthly_income_4)

**Here I am translating Education (Highest Degree) Data**
label variable p3_1_1 "education"
gen education=p3_1_1
gen education_t="None​" if education==0
replace education_t="Preschool or Kinder​garten" if education==1
replace education_t="Primary​" if education==2
replace education_t="Secondary​" if education==3
replace education_t="Vocational​" if education==4
replace education_t="Basic Normal Education" if education==5
replace education_t="Baccalaureate​" if education==6
replace education_t="Technical Studies​​" if education==7
replace education_t="Bachelor's or Engineering (Professional)​​" if education==8
replace education_t="Master's or PhD​" if education==9
tab education_t

****Transforming Education Data into years of Education****
gen education_y=education
recode education_y (0=0) (1=2) (2=8) (3=11) (6 7=13) (4 5 8=14) (9=18)
label def Education 0 "None" 2 "Preschool or Kinder​garten" 8 "Primary​" 11 "Secondary​" 13 "Baccalaureate​ or Technical Studies​​" 14 "Vocational, Basic Normal Education or Bachelor's or Engineering (Professional)" 18 "Master's or PhD"
label values education_y education_y
label variable education "years of education"

**Here I am translating Occupational Status Data**
gen occupational_status=p3_5
gen occupational_status_t="Worked for at least one hour​" if occupational_status==1
replace occupational_status_t="Had a job, did not work​" if occupational_status==2
replace occupational_status_t="Looked for a job​" if occupational_status==3
replace occupational_status_t="Student​" if occupational_status==4
replace occupational_status_t="Homemaker​" if occupational_status==5
replace occupational_status_t="Retired​" if occupational_status==6
replace occupational_status_t="Disabled​"  if occupational_status==7
replace occupational_status_t="Did not work" if occupational_status==8
tab occupational_status_t

**Description of Occupational Status**
gen occupational_status_label="01 Worked for at least one hour" if occupational_status==1
replace occupational_status_label="02 Had a job, did not work​" if occupational_status==2
replace occupational_status_label="03 Looked for a job​" if occupational_status==3
replace occupational_status_label="04 Student" if occupational_status==4
replace occupational_status_label="05 Homemaker​" if occupational_status==5
replace occupational_status_label="06 Retired​" if occupational_status==6
replace occupational_status_label="07 Disabled" if occupational_status==7
replace occupational_status_label="08 Did not work" if occupational_status==8
tab occupational_status_label

**Generating dummy variables for occupational status categories**
encode occupational_status_t, gen(occupational_status_codes)

**Here I am grouping occupational status into three categories**
gen occupational_status_g="Employed" if occupational_status<=2
replace occupational_status_g="Unemployed" if occupational_status==3 | occupational_status==8
replace occupational_status_g="Retired" if occupational_status==6
replace occupational_status_g="Other" if occupational_status==4 | occupational_status==5 | occupational_status==7
tab occupational_status_g


**Generating dummy variables for occupational status categories**
encode occupational_status_g, gen(occupational_status_g_codes)

**Groups of Occupational Status dummies**
gen occupational_status_gd=1 if occupational_status_g=="Employed"
replace occupational_status_gd=2 if occupational_status_g=="Unemployed"
replace occupational_status_gd=3 if occupational_status_g=="Retired"
replace occupational_status_gd=4 if occupational_status_g=="Other"
replace occupational_status_gd=. if occupational_status_g=="."
tab occupational_status_gd


**Description of Groups of Occupational Status**
gen occupational_status_glabel="01 Employed" if occupational_status_gd==1
replace occupational_status_glabel="02 Unemployed" if occupational_status_gd==2
replace occupational_status_glabel="03 Retired" if occupational_status_gd==3
replace occupational_status_glabel="04 Other" if occupational_status_gd==4
replace occupational_status_glabel="." if occupational_status_gd==.
tab occupational_status_glabel

drop finq1 finq2 finq3 finq4 finq5 finq6 finq7

**This question might be too simple to use for the FL index w/ missing values**
gen finq3=1 if p13_1==1
replace finq3=0 if p13_1!=1
tab p13_1 finq3, m

**Question about Simple Interest**
gen finq4=1 if p13_2==2
replace finq4=0 if p13_2!=2
tab p13_2 finq4, m

**Question about Compound Interest**
gen finq5=1 if p13_3==1
replace finq5=0 if p13_3!=1
tab p13_3 finq5, m

**Question about Inflation**
gen finq2=1 if p13_4==3
replace finq2=0 if p13_4!=3
tab p13_4 finq2, m

**The following questions are about general knowledge on Risk and Diversification**
**Question on Inflation**
gen finq6=1 if p4_7_1==1
replace finq6=0 if p4_7_1!=1
tab p4_7_1 finq6, m
 
**Question on Risk**
gen finq7=1 if p4_7_2==1
replace finq7=0 if p4_7_2!=1
tab p4_7_2 finq7, m 

**Question on Diversification****
gen finq8=1 if p4_7_3==1
replace finq8=0 if p4_7_3!=1
tab p4_7_3 finq8, m

**Construct a new index with more questions**

drop FL FL_i FL_label FL_c FL_c1 FL_c2 
drop FL
drop FL_i 
drop FL_label
drop FL_c
drop FL_c1
drop FL_c2 

**Here I add questions about Inflation, Simple Interest and Compound Interest**
gen FL_i=finq2+finq4+finq5
label def FL_i 0 "None" 1 "Low" 2 "Medium" 3 "High"
label values FL_i FL_i
label variable FL_i "Financial Literacy"
tab FL_i

**Description of Financial Literacy**
gen FL_label="0 None" if FL_i==0
replace FL_label="1 Low" if FL_i==1
replace FL_label="2 Medium" if FL_i==2
replace FL_label="3 High" if FL_i==3
tab FL_label, m

**Generating a more comprehensive FinLit index**
gen FL_c=finq2+finq3+finq4+finq5
tab FL_c

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

**Generating a more comprehensive FinLit index**
gen FL_c2=finq2+finq3+finq4+finq6
tab FL_c2

**Generating a more comprehensive FinLit index**
gen FL_c1=finq2+finq3+finq4+finq5+finq6+finq7
tab FL_c1

**Here I am constructing a Low FinLit Variable for individuals who scored 0 or less in the selected questions**
gen low_FL1=1 if FL_c1<=2
replace low_FL1=0 if FL_c1>=3
tab low_FL1, m

**Max if I change the number of questions**
gen high_FL1=1 if FL_c1>=6
replace high_FL1=0 if FL_c1<=5
tab high_FL1, m


**Translation of Financial Products**
gen chosen_finprod=CG
replace chosen_finprod="Credit Card Installment Purchases" if CG=="Compra en cuotas con tarjeta de crédito"
replace chosen_finprod="Fixed-term deposits" if CG=="Depósitos a plazo fijo"
replace chosen_finprod="Savings bank deposits" if CG=="Depósitos en caja de ahorro"
replace chosen_finprod="Deposits in current account" if CG=="Depósitos en cuenta corriente"
replace chosen_finprod="Deposits in foreign currency accounts" if CG=="Depósitos en cuentas en moneda extranjera"
replace chosen_finprod="Financing of credit card balances" if CG=="Financiamiento de saldo de tarjeta de crédito"
replace chosen_finprod="None" if CG=="Ninguno"
replace chosen_finprod="No answer" if CG=="No responde"
replace chosen_finprod="Don't know" if CG=="No sabe"
replace chosen_finprod="Other (ESP):" if CG=="Otros (ESP):"
replace chosen_finprod="Loans from cooperatives and/or mutuals" if CG=="Prestamos de cooperativas y/o mutuales"
replace chosen_finprod="Loans from the employer" if CG=="Prestamos del empleador"
replace chosen_finprod="Loans with mortgage collateral" if CG=="Préstamos con garantía hipotecaria"
replace chosen_finprod="Loans secured by collateral" if CG=="Préstamos con garantía prendaria"
replace chosen_finprod="Commercial loans" if CG=="Préstamos de comercios"
replace chosen_finprod="Personal loans" if CG=="Préstamos personales"
replace chosen_finprod="Credit cards" if CG=="Tarjeta de crédito"
replace chosen_finprod="Debit card" if CG=="Tarjeta de débito"
tab chosen_finprod

**Here I am translating Financial Products Data**
gen financial_products="Credit card installment purchases​" if DE=="Compra en cuotas con tarjeta de crédito"
replace financial_products="Fixed-term deposits" if DE=="Depósitos a plazo fijo"
replace financial_products="Savings account deposits​" if DE=="Depósitos en caja de ahorro"
replace financial_products="Deposits in current accounts​" if DE=="Depósitos en cuenta corriente"
replace financial_products="Deposits in foreign currency accounts​" if DE=="Depósitos en cuentas en moneda extranjera"
replace financial_products="Financing of credit card balance" if DE=="Financiamiento de saldo de tarjeta de crédito"
replace financial_products="Productive micro-credits" if DE=="Microcréditos productivos"
replace financial_products="Not applicable​" if DE=="No aplica"
replace financial_products="No response​" if DE=="No responde"
replace financial_products="Does not know" if DE=="No sabe"
replace financial_products="Others (SPEC):" if DE=="Otros (ESP):"
replace financial_products="Loans from cooperatives and/or mutuals" if DE=="Prestamos de cooperativas y/o mutuales"
replace financial_products="Employer loans" if DE=="Prestamos del empleador"
replace financial_products="Loans with mortgage collateral" if DE=="Préstamos con garantía hipotecaria"
replace financial_products="Loans secured by collateral​" if DE=="Préstamos con garantía prendaria"
replace financial_products="Commercial loans​" if DE=="Préstamos de comercios"
replace financial_products="Personal loans" if DE=="Préstamos personales"
replace financial_products="Credit cards" if DE=="Tarjeta de crédito"
replace financial_products="Debit Card" if DE=="Tarjeta de débito"
tab financial_products

**Here I am translating Financial Products Data**
gen financial_product_1=p5_4_1
label var financial_product_1 "1 account or payroll card (where your salary is deposited)"
gen financial_product_2=p5_4_2
label var financial_product_2 "2 pension account or card (where they deposit their pension)"
gen financial_product_3=p5_4_3
label var financial_product_3 "3 account or card to receive government support"
gen financial_product_4=p5_4_4
label var financial_product_4 "4 savings account"
gen financial_product_5=p5_4_5
label var financial_product_5 "5 check account"
gen financial_product_6=p5_4_6
label var financial_product_6 "6 fixed-term deposits (you can only withdraw on certain dates)"
gen financial_product_7=p5_4_7
label var financial_product_7 "7 mutual fund (own shares in a brokerage firm)"
gen financial_product_8=p5_4_8
label var financial_product_8 "8 online account or application such as Mercado Pago or Albo"
gen financial_product_9=p5_4_9
label var financial_product_9 "9 Other​"

**Generating a variable to establish wether an individual holds risky assets or not**
gen risky_assets=1 if p5_4_7==1
replace risky_assets=0 if p5_4_7==2
tab risky_assets, m


**Do you have the following financial products? 1 means yes, 2 means no"
**departmental or department store credit card or self-service store credit card**
label variable p6_2_1 "store credit card"
tab p6_2_1
**bank credit card**
label variable p6_2_2 "bank credit card"
tab p6_2_2
**Payroll credit**
label variable p6_2_3 "Payroll credit"
tab p6_2_3
**personal credit**
label variable p6_2_4 "personal credit"
tab p6_2_4
**automobile credit**
label variable p6_2_5 "automobile credit"
tab p6_2_5
**housing credit such as INFONAVIT, FOVISSSTE, bank or other institution**
label variable p6_2_6 "housing credit"
tab p6_2_6
**group, communal or solidarity credit (such as Compartamos)**
label variable p6_2_7 "group, communal or solidarity credit"
tab p6_2_7
**credit contracted through the Internet or an application such as Prestadero, Doopla or Playbusiness**
label variable p6_2_8 "credit through the Internet or app"
tab p6_2_8
**Other**
label variable p6_2_9 "Other"
tab p6_2_9

label variable p6_6 "Taking into account all the debts you have, do you consider..."
gen level_indebtedness=p6_6
replace level_indebtedness=1 if p6_6==1
replace level_indebtedness=2 if p6_6==3
replace level_indebtedness=3 if p6_6==2
replace level_indebtedness=0 if p6_6==4
replace level_indebtedness=. if p6_6==9
tab level_indebtedness

**Generating a description for level of indebtedness**
gen level_indebtedness_t="1 can pay them within the required period" if level_indebtedness==1
replace level_indebtedness_t="2 can pay only some of them within the required period" if level_indebtedness==2
replace level_indebtedness_t="3 cannot pay them within the required period" if level_indebtedness==3
replace level_indebtedness_t="0 No debts" if level_indebtedness==0
tab level_indebtedness_t
**I assigned . (missing) to the individuals who did not reply to the question**

**Description of level_indebtedness**
gen level_indebtedness_d="1 low" if level_indebtedness==1
replace level_indebtedness_d="2 medium" if level_indebtedness==2
replace level_indebtedness_d="3 high" if level_indebtedness==3
replace level_indebtedness_d="0 none" if level_indebtedness==0
tab level_indebtedness_d

**Grouping individuals into high level of debt**
gen high_debt=1 if level_indebtedness>=2
replace high_debt=0 if level_indebtedness<=1
replace high_debt=. if level_indebtedness==.
tab high_debt

tab FL_i level_indebtedness_d, r
 

tab financial_product_1 level_indebtedness, r
tab financial_product_2 level_indebtedness, r
tab financial_product_3 level_indebtedness, r
tab financial_product_4 level_indebtedness, r
tab financial_product_5 level_indebtedness, r
tab financial_product_6 level_indebtedness, r
tab financial_product_7 level_indebtedness, r
tab financial_product_8 level_indebtedness, r
tab financial_product_9 level_indebtedness, r

label variable FL ""

sum FL

histogram monthly_income, bin(80)

reg monthly_income gender_d age i.highest_degree i.employment

**Here I am creating dummy variables for Trust Data**
gen trust=p11_1_3
replace trust=0 if p11_1_3==2
replace trust=1 if p11_1_3==1
replace trust=. if p11_1_3==9
tab trust, m

**Run the same regressions I have run before. This is with the 3 questions index**
reg high_debt high_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg high_debt high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust
reg high_debt low_FL age agesq gender education_y monthly_income i.occupational_status_codes trust
reg high_debt low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes trust

reg trust high_FL age agesq gender education_y monthly_income i.occupational_status_codes
reg trust high_FL age agesq gender education_y monthly_income i.occupational_status_g_codes
reg trust low_FL age agesq gender education_y monthly_income i.occupational_status_codes
reg trust low_FL age agesq gender education_y monthly_income i.occupational_status_g_codes

**Making variable names uniform accross countries**
drop country
gen country="Mexico"
