**Import DTA File for Colombia**
use "/Users/Rebeca/Desktop/1. Thesis/1. Microdata/2. CO/1. STATA/CO_060623.dta"

**Creating dummies for gender**
gen gender_d=CUOTA_GENERO
gen gender=1 if gender_d=="Masculino"
replace gender=0 if gender_d!="Masculino"
tab gender gender_d, m

**Creating labels for gender**
gen gender_label="Male" if gender_d=="Masculino"
replace gender_label="Female" if gender_d!="Masculino"
tab gender_label gender_d, m

drop age agesq age_range

**Generating an Age Variable**
gen age=D01_1
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

**the below-mentioned code was not necessary to generate dummies but it was necessary to set a binary variable for saving**
gen saving=1 if F03A=="Sí"
replace saving=0 if F03A!="Sí"
tab saving

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
label variable F03B_9_Rp "Saves or invests in a manner other than a retirement pension"
*Saves or invests with retirement in mind (do not consider AFP or ONP)*

**Generating a variable to establish wether an individual holds risky assets or not**
gen risky_assets1=1 if F03B_5_Rp=="Sí"
replace risky_assets1=0 if F03B_5_Rp!="Sí"
tab risky_assets1, m

**Generating a variable to establish wether an individual holds risky assets or not**
gen risky_assets2=1 if F03B_6_Rp=="Sí"
replace risky_assets2=0 if F03B_6_Rp!="Sí"
tab risky_assets2, m


**Question about Foreign Currency**
gen fcurrency=1 if F03B_7_Rp=="Sí"
replace fcurrency=0 if F03B_7_Rp!="Sí"
tab fcurrency
**Very few people save in Foreign Currency. This could be due to lack of access and government controls**


**Here I am importing CO data**
**Finding a midpoint for monthly income**
gen monthly_income_d=D13A
gen monthly_income_m=327000 if monthly_income_d=="Menos de $328.000"
replace monthly_income_m=575000 if monthly_income_d=="Entre $329.000 y $821.000"
replace monthly_income_m=1068000 if monthly_income_d=="Entre $822.000 y $1.314.000"
replace monthly_income_m=1971000 if monthly_income_d=="Entre $1.315.000 y $2.627.000"
replace monthly_income_m=3777000 if monthly_income_d=="Entre $2.628.000 y $4.926.000"
replace monthly_income_m=5747500 if monthly_income_d=="$ 4.927.000 y $ 6.568.000"
replace monthly_income_m=6569000 if monthly_income_d=="Más de $6.568.000"
tab monthly_income_m, m

**Monthly Income in USD. 1 USD =  $3.277,14 COP**
gen monthly_income=monthly_income_m/3277.14
tab monthly_income, m

**Asign income quartiles 1, 2, 3, 4. Creating income quartiles**
xtile monthly_income_4 = monthly_income, nq(4) 
tabstat monthly_income, stat(n mean min max sd p50) by(monthly_income_4)

**Here I am translating Education (Highest Degree) Data**
gen education=D09
gen education_t="No education/Initial education" if education=="Sin educación/ Educación Inicial"
replace education_t="Primary Incomp./Comp./Secondary Inc" if education=="Primaria Incomp./ Comp./ Secundaria Incompleta"
replace education_t="Complete Secondary/Higher Technical" if education=="Secundaria completa/ Superior Técnico Incompleta"
replace education_t="Higher Technical Complete" if education=="Superior Técnico Completa"
replace education_t="Higher Univ. Incomplete" if education=="Superior Univ. Incompleta"
replace education_t="Higher Univ. Complete" if education=="Superior Univ. Completa"
replace education_t="Master's or PhD" if education=="Post-Grado Universitario"
tab education_t, m

**Here I am generating dummies for Education Data**
gen education_d=0 if education=="Sin educación/ Educación Inicial"
replace education_d=1 if education=="Primaria Incomp./ Comp./ Secundaria Incompleta"
replace education_d=2 if education=="Secundaria completa/ Superior Técnico Incompleta"
replace education_d=3 if education=="Superior Técnico Completa"
replace education_d=4 if education=="Superior Univ. Incompleta"
replace education_d=5 if education=="Superior Univ. Completa"
replace education_d=6 if education=="Post-Grado Universitario"
tab education_t, m

**** Transforming Education Data into years of Education ****
gen education_y=education_d
recode education_y (0=1) (1=6) (2=11) (3=14) (4=15) (5=16) (6=18)
label def education 0 "No education/Initial education" 6 "Primary Incomp./ Comp./ Secondary Inc" 11 "Complete Secondary/Higher Technical" 14 "Higher Technical Complete" 15 "Higher Univ. Incomplete" 16 "Higher Univ. Complete" 18 "Master's or PhD"
label values education_y education_y
label variable education_y "years of education"
tab education_y, m

**Here I am translating Occupational Status Data**
gen occupational_status=D10
replace occupational_status="." if D10=="No sabe" | D10=="No responde"
tab occupational_status, m

**Here I am creating dummies for Occupational Status Data**
gen occupational_status_d=1 if occupational_status=="Campesino / Agricultor o Ganadero"
replace occupational_status_d=2 if occupational_status=="Empleada doméstica"
replace occupational_status_d=3 if occupational_status=="Empleado técnico o profesional" 
replace occupational_status_d=4 if occupational_status=="Empleador o Patrono (con trabajadores a su cargo)" 
replace occupational_status_d=5 if occupational_status=="Miembro de las Fuerzas Armadas y Policiales" 
replace occupational_status_d=6 if occupational_status=="Obrero / Empleado No calificado"
replace occupational_status_d=7 if occupational_status=="Trabajador independiente / por cuenta propia"
replace occupational_status_d=8 if occupational_status=="No está trabajado y tampoco lo está buscando" 
replace occupational_status_d=9 if occupational_status=="Pensionado" 
replace occupational_status_d=10 if occupational_status=="Otro" 
replace occupational_status_d=11 if occupational_status=="Trabajador familiar no remunerado" 
replace occupational_status_d=12 if occupational_status=="Incapacitado para trabajador por enfermedad o mala salud" 
replace occupational_status_d=13 if occupational_status=="Estudiante" 
replace occupational_status_d=14 if occupational_status=="Dedicado a los quehaceres del hogar y la familia"
tab occupational_status_d, m

**Here I am creating translating Occupational Status Data**
gen occupational_status_t="Farmer" if occupational_status_d==1
replace occupational_status_t="Domestic Worker / Household Employee" if occupational_status_d==2
replace occupational_status_t="Technical or professional employee" if occupational_status_d==3
replace occupational_status_t="Employer (with dependents)" if occupational_status_d==4
replace occupational_status_t="Member of the Armed and Police Forces" if occupational_status_d==5
replace occupational_status_t="Unskilled Laborer/Employee" if occupational_status_d==6
replace occupational_status_t="Self-Employed / Self-Employed"  if occupational_status_d==7
replace occupational_status_t="Not employed and not seeking employment" if occupational_status_d==8
replace occupational_status_t="Retired" if occupational_status_d==9
replace occupational_status_t="Other" if occupational_status_d==10
replace occupational_status_t="Not working and not looking for one either" if occupational_status_d==11
replace occupational_status_t="Unable to work due to sickness or ill health" if occupational_status_d==12
replace occupational_status_t="Student" if occupational_status_d==13
replace occupational_status_t="Homemaker" if occupational_status_d==14
tab occupational_status_t, m

**Here I am creating labels for Occupational Status Data**
gen occupational_status_label="01 Farmer" if occupational_status_d==1
replace occupational_status_label="02 Domestic Worker / Household Employee" if occupational_status_d==2
replace occupational_status_label="03 Technical or professional employee" if occupational_status_d==3
replace occupational_status_label="04 Employer (with dependents)" if occupational_status_d==4
replace occupational_status_label="05 Member of the Armed and Police Forces" if occupational_status_d==5
replace occupational_status_label="06 Unskilled Laborer/Employee" if occupational_status_d==6
replace occupational_status_label="07 Self-Employed / Self-Employed"  if occupational_status_d==7
replace occupational_status_label="08 Not employed and not seeking employment" if occupational_status_d==8
replace occupational_status_label="09 Retired" if occupational_status_d==9
replace occupational_status_label="10 Other" if occupational_status_d==10
replace occupational_status_label="11 Not working and not looking for one either" if occupational_status_d==11
replace occupational_status_label="12 Unable to work due to sickness or ill health" if occupational_status_d==12
replace occupational_status_label="13 Student" if occupational_status_d==13
replace occupational_status_label="14 Homemaker" if occupational_status_d==14
tab occupational_status_label, m

**Generating dummy variables for occupational status categories**
encode occupational_status_t, gen(occupational_status_codes)


**Here I am grouping occupational status into three categories**
gen occupational_status_g="Employed" if occupational_status_d<=7
replace occupational_status_g="Unemployed" if occupational_status_d==8
replace occupational_status_g="Retired" if occupational_status_d==9
replace occupational_status_g="Other" if occupational_status_d>=10
tab occupational_status_g

**Generating dummy variables for occupational status categories**
encode occupational_status_g, gen(occupational_status_g_codes)

**Groups of Occupational Status dummies**
gen occupational_status_gd=1 if occupational_status_g=="Employed"
replace occupational_status_gd=2 if occupational_status_g=="Unemployed"
replace occupational_status_gd=3 if occupational_status_g=="Retired"
replace occupational_status_gd=4 if occupational_status_g=="Other"
tab occupational_status_gd

**Description of Groups of Occupational Status**
gen occupational_status_glabel="01 Employed" if occupational_status_gd==1
replace occupational_status_glabel="02 Unemployed" if occupational_status_gd==2
replace occupational_status_glabel="03 Retired" if occupational_status_gd==3
replace occupational_status_glabel="04 Other" if occupational_status_gd==4
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
tab level_indebtedness

**Creating a variable for level of indebtedness of the individual**
label variable S01_9_Rp "Level of Indebtedness"
gen level_indebtedness=1 if S01_9_Rp=="1 Completamente en desacuerdo"
replace level_indebtedness=2 if S01_9_Rp=="2"
replace level_indebtedness=3 if S01_9_Rp=="3"
replace level_indebtedness=4 if S01_9_Rp=="4"
replace level_indebtedness=5 if S01_9_Rp=="5 Completamente de acuerdo"
replace level_indebtedness=. if S01_9_Rp=="NR "
tab level_indebtedness, m

**Description of Level of Indebtedness**
gen level_indebtedness_d="1 low" if level_indebtedness==1
replace level_indebtedness_d="2 low medium" if level_indebtedness==2
replace level_indebtedness_d="3 medium" if level_indebtedness==3
replace level_indebtedness_d="4 medium high" if level_indebtedness==4
replace level_indebtedness_d="5 high" if level_indebtedness==5
tab level_indebtedness_d, m

**Grouping individuals into high level of debt**
gen high_debt=1 if level_indebtedness>=4
replace high_debt=0 if level_indebtedness<=3
replace high_debt=. if level_indebtedness==.
tab high_debt, m

tab chosen_finprod_d level_indebtedness, r

drop self_assessment self_assessment_d high_selfassess self_assessment_d_codes 

**Generating dummy variables for self-assessed FinLit**
gen self_assessment=1 if K01=="Muy bajo"
replace self_assessment=2 if K01=="Bastante bajo"
replace self_assessment=3 if K01=="Sobre el promedio"
replace self_assessment=4 if K01=="Bastante alto"
replace self_assessment=5 if K01=="Muy alto"
replace self_assessment=0 if K01=="No lo sabe" | K01=="No precisa"
tab K01 self_assessment, m

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

drop finq1 finq1_i finq2 finq2_i finq3 finq3_i finq4 finq4_i finq5 finq5_i

**This question might be too simple to use for the FL index w/ missing values**
gen finq1_i=K02
gen finq1=1 if finq1_i==200000
replace finq1=0 if finq1_i!=200000
tab finq1_i finq1, m

**Question about Inflation**
gen finq2_i=K03
gen finq2=1 if finq2_i=="Menos de lo que ellos pueden comprar hoy"
replace finq2=0 if finq2_i!="Menos de lo que ellos pueden comprar hoy"
tab finq2_i finq2, m

**Question about Interest (very easy)**
gen finq3_i=K04
gen finq3=1 if finq3_i=="No se paga interés / no /  nada"
replace finq3=0 if finq3_i!="No se paga interés / no /  nada"
tab finq3_i finq3, m

**Question about Simple Interest. In this case, individuals were not given options but they had to write down the correct answer**
gen finq4_i=K05
gen finq4=1 if finq4_i==102000
replace finq4=0 if finq4_i!=102000
tab finq4_i finq4, m

**Question about Compound Interest**
gen finq5_i=K06
gen finq5=1 if finq5_i=="Más de 110.000 pesos"
replace finq5=0 if finq5_i!="Más de 110.000 pesos"
tab finq5_i finq5, m

drop FL_d FL_i FL_label FL_4q FL_c FL_c2 

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
gen trust_d=1 if S03_7_Rp=="1 Para nada"
replace trust_d=2 if S03_7_Rp=="2"
replace trust_d=3 if S03_7_Rp=="3"
replace trust_d=4 if S03_7_Rp=="4"
replace trust_d=5 if S03_7_Rp=="5 Totalmente"
replace trust_d=. if S03_7_Rp=="NR" | S03_7_Rp=="No es relevante" | S03_7_Rp=="No sabe"
tab trust_d, m

**Generating dummies for Trust. Double-check if selected ranges are correct**
gen trust=1 if trust_d>=3
replace trust=0 if trust_d<=2
tab trust_d trust, m

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
gen country="Colombia"

