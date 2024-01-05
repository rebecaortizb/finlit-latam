**Import DTA File**
use 

**Here I am importing data from the ECF (Financial Knowledge Survey from Chile)**
**First I will proceed by labeling the variables**
label variable sexo_tapa "gender"
label variable FED_tapa "age"
label variable fed_tramo "age range"

**Generating a variable for age square**
gen age=FED_tapa
gen agesq=age^2

**Generating a variable for Age ranges**
gen age_range="18-24" if age<=24
replace age_range="25-34" if age>=25 & age<=34
replace age_range="35-44" if age>=35 & age<=44
replace age_range="45-54" if age>=45 & age<=54
replace age_range="55-64" if age>=55 & age<=64
replace age_range="65-74" if age>=65 & age<=74
replace age_range="75-84" if age>=75 & age<=84
replace age_range="85-More" if age>=85
tab age_range

**Generating dummies for gender**
gen gender=1 if sexo_tapa=="Hombre"
replace gender=0 if sexo_tapa!="Hombre"
tab gender, m

**Generating a variable for income instability**
gen debt=1 if m2=="Sí le ha pasado"
replace debt=0 if m2!="Sí le ha pasado"
tab debt, m

**Financial Literacy Assessment**
*Financial literacy question 1 K1*
label variable k1 "finq1"
*Financial literacy question 1 K2*
label variable k2 "finq2"
*Financial literacy question 1 K3*
label variable K3_Codes2 "finq3"
*Financial literacy question 1 K4_a*
label variable K4_a "finq4"
*Financial literacy question 1 K4_b*
label variable K4_b "finq5"
*Financial literacy question 1 K6_a*
label variable K6_a "finq9"
*Financial literacy question 1 K6_b*
label variable K6_b "finq10"

*Financial literacy true of false question 1 K5_V1_K5*
label variable K5_V1_K5 "TF 1"
*Financial literacy true of false question 2 K5_V2_K5*
label variable K5_V2_K5 "TF 2"
*Financial literacy true of false question 3 K5_V3_K5*
label variable K5_V3_K5 "TF 3"

drop self_assessment self_assessment_d high_selfassess self_assessment_d_codes 

**Generating labels for the dummy variables for self-assessed FinLit**
gen self_assessment=1 if M1=="Peor"
replace self_assessment=2 if M1=="Igual"
replace self_assessment=3 if M1=="Mejor"
replace self_assessment=0 if M1=="No lo sabe (NO LEER)"
tab M1 self_assessment, m

**Generating labels for the dummy variables for self-assessed FinLit**
gen self_assessment_d="Low" if self_assessment<=2
replace self_assessment_d="Average" if self_assessment==3
replace self_assessment_d="High" if self_assessment>=4
replace self_assessment_d="Does not know/Does not reply" if self_assessment==0
tab self_assessment_d self_assessment, m

**Generating dummies for self-assessment**
gen self_assess=1 if self_assessment==1
replace self_assess=2 if self_assessment==2
replace self_assess=3 if self_assessment==3
replace self_assess=0 if self_assessment==0
tab self_assess self_assessment, m

**Creating a binary variable for individuals who self-assess themselves as highly financially literate**
gen high_selfassess=1 if self_assessment==3
replace high_selfassess=0 if self_assessment<=2
tab self_assessment high_selfassess, m

**This question might be too simple to use for the FL index w/ missing values**
gen finq1=1 if k1==200000
replace finq1=0 if k1!=200000
tab k1 finq1, m

**Question about Inflation**
**Replace "No responde" with missing. If the var is 99 is no responde, and if it is 97 is does not know**
gen finq2=1 if k2=="Menos de lo que podrían comprar hoy"
replace finq2=0 if k2!="Menos de lo que podrían comprar hoy"
tab k2 finq2, m

**Question about Interest (very easy)**
gen finq3=1 if K3_Codes2=="Nada / Ningún interés"
replace finq3=0 if K3_Codes2!="Nada / Ningún interés"
tab K3_Codes2 finq3, m

**Question about Simple Interest**
gen finq4=1 if K4_a==102000
replace finq4=0 if K4_a!=102000
tab K4_a finq4, m

**Question about Compound Interest**
gen finq5=1 if K4_b=="Más de $110.000"
replace finq5=0 if K4_b!="Más de $110.000"
tab K4_b finq5, m

*Financial literacy true of false question 1 K7_1*
gen finq6=1 if K5_V1_K5=="Verdadero"
replace finq6=0 if K5_V1_K5!="Verdadero"
tab K5_V1_K5 finq6, m

*Financial literacy true of false question 2 K7_2*
gen finq7=1 if K5_V2_K5=="Verdadero"
replace finq7=0 if K5_V2_K5!="Verdadero"
tab K5_V2_K5 finq7, m

*Financial literacy true of false question 3 K7_3*
gen finq8=1 if K5_V3_K5=="Verdadero"
replace finq8=0 if K5_V3_K5!="Verdadero"
tab K5_V3_K5 finq8, m

**This question might be too simple to use for the FL index w/o missing values**
**This question might be too simple to use for the FL index**
gen finq1=1 if K2==200000
replace finq1=0 if K2!=200000
replace finq1=. if K2==99
tab K2 finq1, m

**Question about Inflation**
**Replace "No responde" with missing. If the var is 99 is no responde, and if it is 97 is does not know**
gen finq2=1 if K3=="Menos de lo que podrían comprar hoy"
replace finq2=0 if K3!="Menos de lo que podrían comprar hoy"
replace finq2=. if K3=="No responde"
tab K3 finq2, m

**Question about Interest (very easy)**
gen finq3=1 if K4==0
replace finq3=0 if K4!=0
replace finq3=. if K4==99
tab K4 finq3, m

**Question about Simple Interest**
gen finq4=1 if K5==102000
replace finq4=0 if K5!=102000
replace finq4=. if K5==99
tab K5 finq4, m

**Question about Compound Interest**
gen finq5=1 if K6=="Más de $110.000"
replace finq5=0 if K6!="Más de $110.000"
replace finq5=. if K6=="No responde"
tab K6 finq5, m

**Here I add questions about Inflation, Simple Interest and Compound Interest**
**Dummies for finlit by adding up the number of correct answers**
gen FL_d=finq2+finq4+finq5
tab FL_d, m

**Description of level finlit based on the number of correct answers. This is based on three selected FinLit questions found in the 3 countries studied**
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
tab FL_label, m

**Generating a more comprehensive FinLit index with five questions taken into consideration**
gen FL_c=finq1+finq2+finq3+finq4+finq5
tab FL_c, m

**Generating a more comprehensive FinLit index with five questions taken into consideration**
gen FL_c2=finq2+finq3+finq4+finq5
tab FL_c2, m

**Here I am constructing a Low FinLit Variable for individuals who scored 0 or less in the selected questions**
gen low_FL3=1 if FL_c<=2
replace low_FL3=0 if FL_c>=3
tab low_FL3, m

**Max if I change the number of questions**
gen high_FL=1 if FL_c>=4
replace high_FL=0 if FL_c<=3
tab high_FL, m

**Generating a more comprehensive FinLit index with five questions taken into consideration**
gen FL_c1=finq1+finq2+finq3+finq4+finq5+finq6+finq7
tab FL_c1, m

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


**Creating a variable for level of indebtedness of the individual**
label variable M0_V4_M0 "Level of Indebtedness"
gen level_indebtedness=5 if M0_V4_M0=="1.-Completamente en desacuerdo"
replace level_indebtedness=4 if M0_V4_M0=="2"
replace level_indebtedness=3 if M0_V4_M0=="3"
replace level_indebtedness=2 if M0_V4_M0=="4"
replace level_indebtedness=1 if M0_V4_M0=="5.-Completamente de acuerdo"
replace level_indebtedness=. if M0_V4_M0=="99.-NR "
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

**Generating dummies for saving**
gen saving=1 if p196!="Sí"
replace saving=0 if p196=="Sí"
tab saving, m

**Here I am importing CH data**
**Finding a midpoint for monthly income**
gen monthly_income_m=249000 if D7_a=="Menos de $250.000."
replace monthly_income_m=375000 if D7_a=="De $250.000 a $500.000"
replace monthly_income_m=625000 if D7_a=="De $500.001 a $750.000"
replace monthly_income_m=875000 if D7_a=="De $750.001 a $1.000.000"
replace monthly_income_m=1200000 if D7_a=="De $1.000.001 a $1.400.000"
replace monthly_income_m=1600000 if D7_a=="De $1.400.001. a $1.800.000"
replace monthly_income_m=1800000 if D7_a=="Más de $1.800.000"
replace monthly_income_m=. if D7_a=="No responde"
tab monthly_income_m, m
sum monthly_income_m, d

**Monthly Income in USD. 1 USD =  875,66 CHP**
gen monthly_income=monthly_income_m/875.66
tab monthly_income, m

**Asign income quartiles 1, 2, 3, 4. Creating income quartiles**
xtile monthly_income_4 = monthly_income, nq(4) 
tabstat monthly_income, stat(n mean min max sd p50) by(monthly_income_4)

**Here I am translating Occupational Status Data**
gen occupational_status="Unemployed" if D5=="Estoy desempleado"
replace occupational_status="Student" if D5=="Estoy estudiando"
replace occupational_status="Retired" if D5=="Estoy jubilado (recibo pensión)"
replace occupational_status="Homemaker" if D5=="Me dedico a los que haceres del hogar y la familia"
replace occupational_status="Cannot work due to illness" if D5=="No estoy trabajando por incapacidad, o enfermedad prolongada"
replace occupational_status="Does not reply" if D5=="No responde"
replace occupational_status="Other" if D5=="Otro"
replace occupational_status="Business-owner w/ employees" if D5=="Soy dueño o socio de un negocio propio y tengo al menos un empleado"
replace occupational_status="Self-employed w/o employees" if D5=="Soy trabajador por cuenta propia, soy mi propio jefe y no tengo empleados"
replace occupational_status="Full-time job" if D5=="Trabajo a tiempo completo como empleado"
replace occupational_status="Part-time job" if D5=="Trabajo a tiempo parcial como empleado"
replace occupational_status="Passive income" if D5=="Vivo de la renta de mis inmuebles, utilidades, intereses y/o dividendos de algún negocio"
tab occupational_status, m

**Here I am creating dummy variables for Occupational status**
gen occupational_status_d=1 if occupational_status=="Business-owner w/ employees"
replace occupational_status_d=2 if occupational_status=="Self-employed w/o employees"
replace occupational_status_d=3 if occupational_status=="Full-time job"
replace occupational_status_d=4 if occupational_status=="Part-time job"
replace occupational_status_d=5 if occupational_status=="Unemployed"
replace occupational_status_d=6 if occupational_status=="Retired"
replace occupational_status_d=7 if occupational_status=="Student"
replace occupational_status_d=8 if occupational_status=="Homemaker"
replace occupational_status_d=9 if occupational_status=="Cannot work due to illness"
replace occupational_status_d=10 if occupational_status=="Other"
replace occupational_status_d=11 if occupational_status=="Passive income"
replace occupational_status_d=. if occupational_status=="Does not reply"
tab occupational_status_d, m

**Description of Occupational Status**
gen occupational_status_label="01 Business-owner w/ employees" if occupational_status_d==1
replace occupational_status_label="02 Self-employed w/o employees" if occupational_status_d==2
replace occupational_status_label="03 Full-time job" if occupational_status_d==3
replace occupational_status_label="04 Part-time job" if occupational_status_d==4
replace occupational_status_label="05 Unemployed" if occupational_status_d==5
replace occupational_status_label="06 Retired" if occupational_status_d==6
replace occupational_status_label="07 Student" if occupational_status_d==7
replace occupational_status_label="08 Homemaker" if occupational_status_d==8
replace occupational_status_label="09 Cannot work due to illness" if occupational_status_d==9
replace occupational_status_label="10 Other" if occupational_status_d==10
replace occupational_status_label="11 Passive income" if occupational_status_d==11	
tab occupational_status_label, m

**Generating dummy variables for occupational status categories**
encode occupational_status, gen(occupational_status_codes)

**This line was deleted: "replace occupational_status_label="10 Does not reply" if occupational_status_d==10" because it no longer exists**

**Here I am grouping occupational status into three categories**
gen occupational_status_g="Employed" if occupational_status_d<=4
replace occupational_status_g="Unemployed" if occupational_status_d==5
replace occupational_status_g="Retired" if occupational_status_d==6
replace occupational_status_g="Other" if occupational_status_d>=7
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

gen education=D4
label variable education "highest degree"

**Here I am creating dummy variables for Education (Highest Degree) Data**
*this is a draft because the dummy variable 3 cannot be created since the error "invalid name" appears*
gen education_d=1 if education=="Sin nivel educativo / sin instrucción"
replace education_d=2 if education=="Preescolar"
replace education_d=3 if education=="Primaria incompleta"
replace education_d=4 if education=="Primaria completa"
replace education_d=5 if education=="Secundaria incompleta"
replace education_d=6 if education=="Secundaria completa"
replace education_d=7 if education=="Técnica superior incompleta"
replace education_d=8 if education=="Técnica superior completa"
replace education_d=9 if education=="Universitaria incompleta"
replace education_d=10 if education=="Universitaria completa"
replace education_d=11 if education=="Maestría / Doctorado"
tab education_d, m

**Here I am translating Education (Highest Degree) Data**
gen education_t="None​" if education=="No asistí a la escuela"
replace education_t="Pre-school" if education=="Preescolar"
replace education_t="Primary ​incomplete​" if education=="Primaria incompleta"
replace education_t="Primary complete" if education=="Primaria completa"
replace education_t="Secondary ​incomplete" if education=="Secundaria incompleta"
replace education_t="Secondary complete​" if education=="Secundaria completa"
replace education_t="Higher technical incomplete" if education=="Técnica superior incompleta"
replace education_t="Higher technical complete" if education=="Técnica superior completa"
replace education_t="University incomplete​" if education=="Universitaria incompleta"
replace education_t="University complete" if education=="Universitaria completa"
replace education_t="Master's or PhD​" if education=="Maestría / Doctorado"
tab education_t, m
sum education_t, detail

**Generating dummy variables for occupational status categories**
encode education_t, gen(education_t_codes)

**** Transforming Education Data into years of Education ****
gen education_y=education_d
recode education_y (1 2=0) (2=3) (4=6) (5=9) (6=12) (7=14) (8 9=15) (10=16) (11=18) 
label def education 0 "None / Pre-school" 3 "Primary incomplete​" 6 "Primary complete​" 9 "Secondary incomplete​" 12 "Secondary complete​" 14 "Terciario incompleta" 15 "Tertiary complete​ and University incomplete" 16 "University complete​"  18 "Master's or PhD"
label values education_y education_y
label variable education_y "years of education"

tab gender education_y, r
fre education_y

**Here I am creating dummy variables for Trust Data**
gen trust_d=K6_a
gen trust=0 if K6_a=="No se encuentra cubierto / asegurado"
replace trust=1 if K6_a=="Sí, se encuentra cubierto / asegurado completamente" | K6_a=="Sí, se encuentra cubierto / asegurado parcialmente"
replace trust=. if K6_a=="No sabe" | K6_a=="No responde"
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
gen country="Chile"
