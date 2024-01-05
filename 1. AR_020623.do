**Import DTA File**
use "/Users/Rebeca/Desktop/Corrected/AR1.dta"

**Here I am importing data from the ECF (Financial Knowledge Survey from Argentina)**
**First I will proceed by labeling the variables**
label variable SbjNum "subject number"
label variable FECHA "date"
label variable D1 "gender"
label variable D2 "region"
label variable D7 "age"
label variable D7a "age group"
label variable F1 "decisionmaker"
*Does the individual set a budget for family expenses*
label variable F2a "budget"
*Does the individual use their money based on their budget*
label variable F2b "use of money"
*frequency with which you follow your budget*
label variable F2c "budget compliance"
*assesing whether the individual has been saving the last 12 months**
label variable F3a "saving"

**Saving Habits**
**Have you been saving in the following modes?**
*Saving at home (piggy bank or under the mattress)*
label variable F3_1_F3 "Saving at home"
*Leaves an amount of money in your savings or checking account*
label variable F3_2_F3 "savings or checking account"
*Deposit money in a savings account*
label variable F3_3_F3 "savings account"
*Gives money to family to save on their behalf*
label variable F3_4_F3 "Gives money to family"
*Saves in "circles" (informal savings clubs)*
label variable F3_5_F3 "informal savings clubs"
*Purchases financial investment products, other than pension funds (such as bonds, mutual funds, stocks, etc.)*
label variable F3_6_F3 "bonds, mutual funds, stocks"
*Or in some other way (including remittances, purchasing livestock or property)*
label variable F3_7_F3 "some other way"
*Have not been actively saving (includes I do not save/have no money to save)*
label variable F3_8_F3 "Have not been saving"
*Saving in foreign currency*
label variable F3_9_F3 "foreign currency"

**Generating a variable to establish wether an individual holds risky assets or not**
gen risky_assets=1 if F3_6_F3=="Sí"
replace risky_assets=0 if F3_6_F3!="Sí"
tab risky_assets, m

**Generating a variable for age square**
gen age=D7
gen agesq=D7*D7

**Generating a variable for Age ranges**
gen age_range="18-24" if D7<=24
replace age_range="25-34" if D7>=25 & D7<=34
replace age_range="35-44" if D7>=35 & D7<=44
replace age_range="45-54" if D7>=45 & D7<=54
replace age_range="55-64" if D7>=55 & D7<=64
replace age_range="65-74" if D7>=65 & D7<=74
replace age_range="75-84" if D7>=75 & D7<=84
replace age_range="85-More" if D7>=85
tab age_range

**Dummy for Question about bonds, mutual funds, stocks**
gen bonds_mutualfunds=1 if F3_6_F3=="Sí"
replace bonds_mutualfunds=0 if F3_6_F3!="Sí"
tab bonds_mutualfunds, m
**There is no distintion between bonds, stocks, nor mutual funds. Furthermore, there are not many people investing in this financial instruments**

**Question about Foreign Currency**
gen fcurrency=1 if F3_9_F3=="Sí"
replace fcurrency=0 if F3_9_F3!="Sí"
tab fcurrency
**Very few people save in Foreign Currency. This could be due to lack of access and government controls**

*is the individual able to cover this large expenses without asking for a loan*
label variable F4 "large expenses"
*did the individual set objectives for the use of their savings*
label variable F5 "financial objectives"
*what is the main financial objective this ind set for the use of their savings*
label variable F6 "main financial objective"
*what is another financial objective this ind set for the use of their savings*
label variable F6_Codes "coded main financial objective"

**SECTION ON FINANCIAL PRODUCTS**
*here we find info about knowledge of business loans, personal loans, mortgages, etc*
label variable C1a01 "knowledge of finprod"
*here we find info about owning business loans, personal loans, mortgages, etc*
label variable C1b01 "owning finprod"
*here we find info about owning business loans, personal loans, mortgages, etc in the past two years*
label variable C1c01 "owning finprod in the last two years"
*here we find info about the most recently chosen finprod*
label variable C1d "chosen finprod"

****Here I am translating Financial Products Data**
**This refers to the knowledge of financial product**
gen know_findprod="Credit card installment purchases​" if C1a01=="Compra en cuotas con tarjeta de crédito"
replace know_findprod="Fixed-term deposits" if C1a01=="Depósitos a plazo fijo"
replace know_findprod="Savings account deposits​" if C1a01=="Depósitos en caja de ahorro"
replace know_findprod="Deposits in current accounts​" if C1a01=="Depósitos en cuenta corriente"
replace know_findprod="Deposits in foreign currency accounts​" if C1a01=="Depósitos en cuentas en moneda extranjera"
replace know_findprod="Financing of credit card balance" if C1a01=="Financiamiento de saldo de tarjeta de crédito"
replace know_findprod="Productive micro-credits" if C1a01=="Microcréditos productivos"
replace know_findprod="Not applicable​" if C1a01=="No aplica"
replace know_findprod="No response​" if C1a01=="No responde"
replace know_findprod="Does not know" if C1a01=="No sabe"
replace know_findprod="Others (SPEC):" if C1a01=="Otros (ESP):"
replace know_findprod="Loans from cooperatives and/or mutuals" if C1a01=="Prestamos de cooperativas y/o mutuales"
replace know_findprod="Employer loans" if C1a01=="Prestamos del empleador"
replace know_findprod="Loans with mortgage collateral" if C1a01=="Préstamos con garantía hipotecaria"
replace know_findprod="Loans secured by collateral​" if C1a01=="Préstamos con garantía prendaria"
replace know_findprod="Commercial loans​" if C1a01=="Préstamos de comercios"
replace know_findprod="Personal loans" if C1a01=="Préstamos personales"
replace know_findprod="Credit cards" if C1a01=="Tarjeta de crédito"
replace know_findprod="Debit Card" if C1a01=="Tarjeta de débito"
tab know_findprod, m


****Here I am translating Financial Products Data**
**This refers to owning a financial product**
gen own_findprod="Credit card installment purchases​" if C1b01=="Compra en cuotas con tarjeta de crédito"
replace own_findprod="Fixed-term deposits" if C1b01=="Depósitos a plazo fijo"
replace own_findprod="Savings account deposits​" if C1b01=="Depósitos en caja de ahorro"
replace own_findprod="Deposits in current accounts​" if C1b01=="Depósitos en cuenta corriente"
replace own_findprod="Deposits in foreign currency accounts​" if C1b01=="Depósitos en cuentas en moneda extranjera"
replace own_findprod="Financing of credit card balance" if C1b01=="Financiamiento de saldo de tarjeta de crédito"
replace own_findprod="Productive micro-credits" if C1b01=="Microcréditos productivos"
replace own_findprod="Not applicable​" if C1b01=="No aplica"
replace own_findprod="No response​" if C1b01=="No responde"
replace own_findprod="Does not know" if C1b01=="No sabe"
replace own_findprod="Others (SPEC):" if C1b01=="Otros (ESP):"
replace own_findprod="Loans from cooperatives and/or mutuals" if C1b01=="Prestamos de cooperativas y/o mutuales"
replace own_findprod="Employer loans" if C1b01=="Prestamos del empleador"
replace own_findprod="Loans with mortgage collateral" if C1b01=="Préstamos con garantía hipotecaria"
replace own_findprod="Loans secured by collateral​" if C1b01=="Préstamos con garantía prendaria"
replace own_findprod="Commercial loans​" if C1b01=="Préstamos de comercios"
replace own_findprod="Personal loans" if C1b01=="Préstamos personales"
replace own_findprod="Credit cards" if C1b01=="Tarjeta de crédito"
replace own_findprod="Debit Card" if C1b01=="Tarjeta de débito"
tab own_findprod, m


****Here I am translating Financial Products Data**
**This refers to owning a financial product in the last two years**
gen own_findprod_2y="Credit card installment purchases​" if C1c01=="Compra en cuotas con tarjeta de crédito"
replace own_findprod_2y="Fixed-term deposits" if C1c01=="Depósitos a plazo fijo"
replace own_findprod_2y="Savings account deposits​" if C1c01=="Depósitos en caja de ahorro"
replace own_findprod_2y="Deposits in current accounts​" if C1c01=="Depósitos en cuenta corriente"
replace own_findprod_2y="Deposits in foreign currency accounts​" if C1c01=="Depósitos en cuentas en moneda extranjera"
replace own_findprod_2y="Financing of credit card balance" if C1c01=="Financiamiento de saldo de tarjeta de crédito"
replace own_findprod_2y="Productive micro-credits" if C1c01=="Microcréditos productivos"
replace own_findprod_2y="Not applicable​" if C1c01=="No aplica"
replace own_findprod_2y="No response​" if C1c01=="No responde"
replace own_findprod_2y="Does not know" if C1c01=="No sabe"
replace own_findprod_2y="Others (SPEC):" if C1c01=="Otros (ESP):"
replace own_findprod_2y="Loans from cooperatives and/or mutuals" if C1c01=="Prestamos de cooperativas y/o mutuales"
replace own_findprod_2y="Employer loans" if C1c01=="Prestamos del empleador"
replace own_findprod_2y="Loans with mortgage collateral" if C1c01=="Préstamos con garantía hipotecaria"
replace own_findprod_2y="Loans secured by collateral​" if C1c01=="Préstamos con garantía prendaria"
replace own_findprod_2y="Commercial loans​" if C1c01=="Préstamos de comercios"
replace own_findprod_2y="Personal loans" if C1c01=="Préstamos personales"
replace own_findprod_2y="Credit cards" if C1c01=="Tarjeta de crédito"
replace own_findprod_2y="Debit Card" if C1c01=="Tarjeta de débito"
tab own_findprod_2y, m

**Here I am translating Financial Products Data**
**This refers to the most recently chosen financial product**
gen chosen_finprod=C1d
replace chosen_finprod="Credit Card Installment Purchases" if C1d=="Compra en cuotas con tarjeta de crédito"
replace chosen_finprod="Fixed-term deposits" if C1d=="Depósitos a plazo fijo"
replace chosen_finprod="Savings bank deposits" if C1d=="Depósitos en caja de ahorro"
replace chosen_finprod="Deposits in current account" if C1d=="Depósitos en cuenta corriente"
replace chosen_finprod="Deposits in foreign currency accounts" if C1d=="Depósitos en cuentas en moneda extranjera"
replace chosen_finprod="Financing of credit card balances" if C1d=="Financiamiento de saldo de tarjeta de crédito"
replace chosen_finprod="None" if C1d=="Ninguno"
replace chosen_finprod="No answer" if C1d=="No responde"
replace chosen_finprod="Don't know" if C1d=="No sabe"
replace chosen_finprod="Other (ESP):" if C1d=="Otros (ESP):"
replace chosen_finprod="Loans from cooperatives and/or mutuals" if C1d=="Prestamos de cooperativas y/o mutuales"
replace chosen_finprod="Loans from the employer" if C1d=="Prestamos del empleador"
replace chosen_finprod="Loans with mortgage collateral" if C1d=="Préstamos con garantía hipotecaria"
replace chosen_finprod="Loans secured by collateral" if C1d=="Préstamos con garantía prendaria"
replace chosen_finprod="Commercial loans" if C1d=="Préstamos de comercios"
replace chosen_finprod="Personal loans" if C1d=="Préstamos personales"
replace chosen_finprod="Credit cards" if C1d=="Tarjeta de crédito"
replace chosen_finprod="Debit card" if C1d=="Tarjeta de débito"
tab chosen_finprod, m

**Here I am creating dummy variables for Financial Products Data**
gen chosen_finprod_d=1 if C1d=="Compra en cuotas con tarjeta de crédito"
replace chosen_finprod_d=2 if C1d=="Depósitos a plazo fijo"
replace chosen_finprod_d=3 if C1d=="Depósitos en caja de ahorro"
replace chosen_finprod_d=4 if C1d=="Depósitos en cuenta corriente"
replace chosen_finprod_d=5 if C1d=="Depósitos en cuentas en moneda extranjera"
replace chosen_finprod_d=6 if C1d=="Financiamiento de saldo de tarjeta de crédito"
replace chosen_finprod_d=7 if C1d=="Ninguno"
replace chosen_finprod_d=8 if C1d=="No responde"
replace chosen_finprod_d=9 if C1d=="No sabe"
replace chosen_finprod_d=10 if C1d=="Otros (ESP):"
replace chosen_finprod_d=11 if C1d=="Prestamos de cooperativas y/o mutuales"
replace chosen_finprod_d=12 if C1d=="Prestamos del empleador"
replace chosen_finprod_d=13 if C1d=="Préstamos con garantía hipotecaria"
replace chosen_finprod_d=14 if C1d=="Préstamos con garantía prendaria"
replace chosen_finprod_d=15 if C1d=="Préstamos de comercios"
replace chosen_finprod_d=16 if C1d=="Préstamos personales"
replace chosen_finprod_d=17 if C1d=="Tarjeta de crédito"
replace chosen_finprod_d=18 if C1d=="Tarjeta de débito"
tab chosen_finprod_d, m


**Creating a variable for level of indebtedness of the individual**
label variable F10_11_F10 "Level of Indebtedness"
gen level_indebtedness=1 if F10_11_F10=="1 Completamente en desacuerdo"
replace level_indebtedness=2 if F10_11_F10=="2"
replace level_indebtedness=3 if F10_11_F10=="3"
replace level_indebtedness=4 if F10_11_F10=="4"
replace level_indebtedness=5 if F10_11_F10=="5 Completamente de acuerdo"
replace level_indebtedness=. if F10_11_F10=="NR"
tab level_indebtedness, m

**Description of Level of Indebtedness**
gen level_indebtedness_d="1 low" if F10_11_F10=="1 Completamente en desacuerdo"
replace level_indebtedness_d="2 low medium" if F10_11_F10=="2"
replace level_indebtedness_d="3 medium" if F10_11_F10=="3"
replace level_indebtedness_d="4 medium high" if F10_11_F10=="4"
replace level_indebtedness_d="5 high" if F10_11_F10=="5 Completamente de acuerdo"
replace level_indebtedness_d="." if F10_11_F10=="NR"
tab level_indebtedness_d, m

**Grouping individuals into high level of debt**
gen high_debt=1 if level_indebtedness>=4
replace high_debt=0 if level_indebtedness<=3
replace high_debt=. if level_indebtedness==.
tab high_debt, m

**Here I am labelling variables based on the content of the survey questions**
*how did the individual choose the last financial product they acquired*
label variable C2 "decision process"
*what is the most important source of information that led to the individual decision to buy their latest financial product*
label variable C301 "main source of information 1"
label variable C302 "main source of information 2"
label variable C303 "main source of information 3"
label variable C304 "main source of information 4"
label variable C305 "main source of information 5"
label variable C306 "main source of information 6"
label variable C307 "main source of information 7"
label variable C308 "main source of information 8"
label variable C309 "main source of information 9"
label variable C310 "main source of information 10"
label variable C311 "main source of information 11"
label variable C312 "main source of information 12"
label variable C313 "main source of information 13"
label variable C314 "main source of information 14"
label variable C315 "main source of information 15"
label variable C316 "main source of information 16"

**Here I am coding types of income that the family receives**
*type of income 1 salary*
label variable C1e1_1_C1e1 "salary"
*type of income 2 retirement and/or pension*
label variable C1e1_2_C1e1 "pension"
*type of income 3 social assistance*
label variable C1e1_3_C1e1 "social assistance"
*type of income 4 Fees for services*
label variable C1e1_4_C1e1 "fees for services"

**Type of payment method used to receive the mentioned income**
*payment method 1*
label variable C1e21 "By cash"
*payment method 2*
label variable C1e22 "Over the counter in a bank"
*payment method 3*
label variable C1e23 "By deposit in a bank account"
*payment method 4*
label variable C1e24 "By check"
*payment method 5*
label variable C1e25 "By cash in the mail"
*payment method 6*
label variable C1e26 "Don't know"

*How does the individual handle this money*
label variable C1e3 "money handling"

*Reasons to withdraw the money all at once*
label variable C1e41 "They prefer to use cash for expenses"
label variable C1e42 "Where they live they cannot buy with a debit card"
label variable C1e43 "The bank is far away"
label variable C1e44 "At the bank they waste a lot of time"
label variable C1e45 "If the money is left in the bank, it is eaten up by inflation"
label variable C1e46 "They do not trust banks"
label variable C1e47 "Other"
label variable C1e48 "Does not know"
label variable C1e49 "Does not reply"

*Financial action 1 realized in the past 2 years*
label variable C2a_1_C2a "Transfers between bank accounts by homebanking i.e. internet banking, including the use of smartphones"
*Financial action 2 realized in the past 2 years*
label variable C2a_2_C2a "Payment of services by homebanking, i.e. internet banking, including the use of smart cellular phones"
*Financial action 3 realized in the past 2 years*
label variable C2a_3_C2a "Payment of services by automatic debit (direct debit)"
*Financial action 4 realized in the past 2 years*
label variable C2a_4_C2a "Deposits of money in a savings or checking account"
*Financial action 5 realized in the past 2 years*
label variable C2a_5_C2a "Retail purchases with a debit card"
*Financial action 6 realized in the past 2 years*
label variable C2a_6_C2a "Purchases in stores with credit card in one payment"
*Financial action 7 realized in the past 2 years*
label variable C2a_7_C2a "On-line purchases with a credit card"
*Financial action 8 realized in the past 2 years*
label variable C2a_8_C2a "Credit card purchases in installments"
*Financial action 9 realized in the past 2 years*
label variable C2a_9_C2a "Foreign currency purchases"
*Financial action 10 realized in the past 2 years*
label variable C2a_10_C2a "Sending and/or receiving money remittances within the country or to/from other countries"

**Thinking about financial products and services in general, in the past 2 years, have you experienced any of the followingsituations?**
label variable C4_1_C4 "Have you ever taken advice to invest in a financial product that you found to be worthless?"
label variable C4_2_C4 "Have you ever given financial information accidentally in response to a request (email or phone call) that you later realized was not genuine?"
label variable C4_3_C4 "Have you ever been a victim of identity theft in a financial transaction, e.g., someone has used your card to pay for something without your authorization?"
label variable C4_4_C4 "Have you ever tried to do business with any financial institution/entity and given up because you were treated badly or did not comply with the requirements? "
label variable C4_5_C4 "Have you been charged fees and commissions that were not originally explained to you when initiating a financial transaction?"
label variable C4_6_C4 "Has it been complicated for you to cancel a product or service at a financial institution?"

**Behaviour and Attitudes related to Money (Savings, Expenses, Channel)**
*on a scale from 1 to 5*
*before buying sth I carefully consider if I can afford it*
label variable F10_1_F10 "before buying sth I carefully consider if I can afford it"
*I prefer to live in the day and I do not worry about tomorrow*
label variable F10_2_F10 "I prefer to live in the day and I do not worry about tomorrow"
*I prefer to spend money than saving for the future*
label variable F10_3_F10 "I prefer to spend money than saving for the future"
*I pay my bills on time*
label variable F10_4_F10 "I pay my bills on time"
*I am willing to risk some money when I make an investment*
label variable F10_5_F10 "I am willing to risk some money when I make an investment"
*I personally manage my finances*
label variable F10_6_F10 "I personally manage my finances"
*I set long term saving goals and I try to reach them*
label variable F10_7_F10 "I set long term saving goals and I try to reach them"
*Money is there to be spent*
label variable F10_8_F10 "Money is there to be spent"
*my financial situation limits my ability to do the things that are important to me*
label variable F10_9_F10 "my financial situation limits my ability to do the things that are important to me"
*I tend to worry about paying my daily expenses*
label variable F10_10_F10 "I tend to worry about paying my daily expenses"
*I have too many debts at the moment*
label variable F10_11_F10 "I have too many debts at the moment"
*I am happy with my current financial situation*
label variable F10_12_F10 "I am happy with my current financial situation"


**Financial Literacy Assessment**
**Self-assessment**
label variable K1 "self-assessment"
*Financial literacy question 1 K2*
label variable K2 "finq1"
*Financial literacy question 1 K3*
label variable K3 "finq2"
*Financial literacy question 1 K4*
label variable K4 "finq3"
*Financial literacy question 1 K5*
label variable K5 "finq4"
*Financial literacy question 1 K6*
label variable K6 "finq5"
*Financial literacy true of false question 1 K7_1*
label variable K7_1_K7 "TF 1"
*Financial literacy true of false question 2 K7_2*
label variable K7_2_K7 "TF 2"
*Financial literacy true of false question 3 K7_3*
label variable K7_3_K7 "TF 3"

**Generating dummy variables for self-assessed FinLit**
gen self_assessment=1 if K1=="Muy bajo"
replace self_assessment=2 if K1=="Bastante bajo"
replace self_assessment=3 if K1=="En el promedio"
replace self_assessment=4 if K1=="Bastante alto"
replace self_assessment=5 if K1=="Muy alto"
replace self_assessment=0 if K1=="No lo sabe" | K1=="No precisa"
tab K1 self_assessment, m

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

**This question might be too simple to use for the FL index w/ missing values**
gen finq1=1 if K2==200000
replace finq1=0 if K2!=200000
tab K2 finq1, m 

**Question about Inflation**
**Replace "No responde" with missing. If the var is 99 is no responde, and if it is 97 is does not know**
gen finq2=1 if K3=="Menos de lo que podrían comprar hoy"
replace finq2=0 if K3!="Menos de lo que podrían comprar hoy"
tab K3 finq2, m

**Question about Interest (very easy)**
gen finq3=1 if K4==0
replace finq3=0 if K4!=0
tab K4 finq3, m

**Question about Simple Interest**
gen finq4=1 if K5==102000
replace finq4=0 if K5!=102000
tab K5 finq4, m

**Question about Compound Interest**
gen finq5=1 if K6=="Más de $110.000"
replace finq5=0 if K6!="Más de $110.000"
tab K6 finq5, m

*Financial literacy true of false question 1 K7_1*
gen finq6=1 if K7_1_K7=="VERDADERO"
replace finq6=0 if K7_1_K7!="VERDADERO"
tab K7_1_K7 finq6, m

*Financial literacy true of false question 2 K7_2*
gen finq7=1 if K7_2_K7=="VERDADERO"
replace finq7=0 if K7_2_K7!="VERDADERO"
tab K7_2_K7 finq7, m

*Financial literacy true of false question 3 K7_3*
gen finq8=1 if K7_3_K7=="VERDADERO"
replace finq8=0 if K7_3_K7!="VERDADERO"
tab K7_3_K7 finq8, m


**Here I add questions about Inflation, Simple Interest and Compound Interest**
**Dummies for finlit by adding up the number of correct answers**
gen FL_d=finq2+finq4+finq5
tab FL_d, m

**Generating a more comprehensive FinLit index with five questions taken into consideration**
gen FL_c=finq1+finq2+finq3+finq4+finq5
tab FL_c, m

**Generating a more comprehensive FinLit index with five questions taken into consideration**
gen FL_c1=finq1+finq2+finq3+finq4+finq5+finq6+finq7
tab FL_c1, m

**Generating a more comprehensive FinLit index with five questions taken into consideration**
gen FL_c2=finq2+finq3+finq4+finq5
tab FL_c2, m

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

**Education/Job Data**
**Job and Education data**
*Highest educational degree attained by the individual*
label variable D9 "highest degree"
*Which of these situations best describes your job status*
label variable D10 "occupational status"
*is/are your source/s of income regular and stable*
label variable D6 "income regularity"
*monthly income range*
label variable D8 "monthly income"

**Region where the individual lives**
label variable REGION "area"

**Generating dummies for gender**
gen gender=1 if D1=="Hombre"
replace gender=0 if D1!="Hombre"
tab gender, m

**Creating labels for gender**
gen gender_label="Male" if gender==1
replace gender_label="Female" if gender!=1
tab gender_label gender, m

**This is useful if we use the dummies 1 and 2 but in this case we use 0 and 1**
recode gender (1=1) (0=2)
tab gender

**Generating dummies for saving**
gen saving=1 if F3a=="Sí"
replace saving=0 if F3a!="Sí"
tab saving, m

**Here I am importing AR data**
**Finding a midpoint for monthly income**
gen monthly_income_m=5830 if D8=="$5,830 o menos"
replace monthly_income_m=7316 if D8=="De $5,831 a $8,800"
replace monthly_income_m=9701 if D8=="De $8,801 a $10,600"
replace monthly_income_m=11876 if D8=="De $10,601 a $13,150"
replace monthly_income_m=14426 if D8=="De $13,151 a $15,700"
replace monthly_income_m=17401 if D8=="De $15,701 a $19,100"
replace monthly_income_m=21501 if D8=="De $19,101 a $23,900"
replace monthly_income_m=26951 if D8=="De $23,901 a $30,000"
replace monthly_income_m=35601 if D8=="De $30,001 a $41,200"
replace monthly_income_m=41201 if D8=="$41,201 a más"
replace monthly_income_m=. if D8=="No responde"
tab monthly_income_m, m
sum monthly_income_m, d

**Monthly Income in USD. 1 USD = 17.65041 ARP**
gen monthly_income=monthly_income_m/17.65041
tab monthly_income, m

**Asign income quartiles 1, 2, 3, 4. Creating income quartiles**
xtile monthly_income_q= monthly_income_m, nq(4) 
tabstat monthly_income_q, stat(n mean min max sd p50) by(monthly_income_q)

**Asign income quartiles 1, 2, 3, 4. Creating income quartiles in USD**
xtile monthly_income_4 = monthly_income, nq(4) 
tabstat monthly_income, stat(n mean min max sd p50) by(monthly_income_4)

**I have to change Does not reply in the tab**

**Here I am translating Occupational Status Data**
gen occupational_status="Homemaker" if D10=="Ama (o) de casa"
replace occupational_status="Apprentice" if D10=="Aprendiz"
replace occupational_status="Looking for jobs" if D10=="Buscando empleo"
replace occupational_status="Full-time job" if D10=="Empleo a tiempo completo (incluidos los independientes) (30 horas o más por semana)"
replace occupational_status="Part-time job" if D10=="Empleo a tiempo parcial (incluyendo independientes) (menos de 30 horas por semana)"
replace occupational_status="Student" if D10=="Estudiante"
replace occupational_status="Not looking for jobs" if D10=="No está en busca de trabajo"
replace occupational_status="Cannot work due to illness" if D10=="No puedo trabajar debido a enfermedad o mala salud"
replace occupational_status="Does not reply" if D10=="No responde"
replace occupational_status="Other" if D10=="Otro"
replace occupational_status="Retired" if D10=="Retirado/jubilado"
tab occupational_status, m

**Here I am creating dummy variables for Occupational status**
gen occupational_status_d=4 if occupational_status=="Homemaker"
replace occupational_status_d=1 if occupational_status=="Apprentice"
replace occupational_status_d=5 if occupational_status=="Looking for jobs"
replace occupational_status_d=2 if occupational_status=="Full-time job"
replace occupational_status_d=3 if occupational_status=="Part-time job"
replace occupational_status_d=9 if occupational_status=="Student"
replace occupational_status_d=6 if occupational_status=="Not looking for jobs" 
replace occupational_status_d=7 if occupational_status=="Cannot work due to illness"
replace occupational_status_d=. if occupational_status=="Does not reply"
replace occupational_status_d=10 if occupational_status=="Other"
replace occupational_status_d=8 if occupational_status=="Retired"
tab occupational_status_d

**Description of Occupational Status**
gen occupational_status_label="04 Homemaker" if occupational_status_d==4
replace occupational_status_label="01 Apprentice" if occupational_status_d==1
replace occupational_status_label="05 Looking for jobs" if occupational_status_d==5
replace occupational_status_label="02 Full-time job" if occupational_status_d==2
replace occupational_status_label="03 Part-time job" if occupational_status_d==3
replace occupational_status_label="09 Student" if occupational_status_d==9
replace occupational_status_label="06 Not looking for jobs" if occupational_status_d==6
replace occupational_status_label="07 Cannot work due to illness" if occupational_status_d==7
replace occupational_status_label="10 Other" if occupational_status_d==10
replace occupational_status_label="08 Retired" if occupational_status_d==8
tab occupational_status_label

**Generating dummy variables for occupational status categories**
encode occupational_status, gen(occupational_status_codes)

**This line was deleted: "replace occupational_status_label="10 Does not reply" if occupational_status_d==10" because it no longer exists**

**Here I am grouping occupational status into three categories**
gen occupational_status_g="Employed" if occupational_status_d<=3
replace occupational_status_g="Unemployed" if occupational_status_d==5 | occupational_status_d==6  
replace occupational_status_g="Retired" if occupational_status_d==8
replace occupational_status_g="Other" if occupational_status_d==4 | occupational_status_d==7 | occupational_status_d==9 | occupational_status_d==10
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

gen education=D9
label variable education "highest degree"

**Here I am creating dummy variables for Education (Highest Degree) Data**
*this is a draft because the dummy variable 3 cannot be created since the error "invalid name" appears*
gen education_d=1 if education=="No asistí a la escuela"
replace education_d=2 if education=="Primaria incompleta"
replace education_d=3 if education=="Primaria completa"
replace education_d=4 if education=="Secundaria incompleta"
replace education_d=5 if education=="Secundaria completa"
replace education_d=6 if education=="Terciario incompleta"
replace education_d=7 if education=="Terciario completa"
replace education_d=8 if education=="Universitaria incompleta"
replace education_d=9 if education=="Universitaria completa"
replace education_d=10 if education=="Postgrado (Maestría / Doctorado)"
tab education_d, m

**Here I am translating Education (Highest Degree) Data**
gen education_t="None​" if D9=="No asistí a la escuela"
replace education_t="Primary ​incomplete​" if D9=="Primaria incompleta"
replace education_t="Primary complete" if D9=="Primaria completa"
replace education_t="Secondary ​incomplete" if D9=="Secundaria incompleta"
replace education_t="Secondary complete​" if D9=="Secundaria completa"
replace education_t="Tertiary incomplete" if D9=="Terciario incompleta"
replace education_t="Tertiary complete​​" if D9=="Terciario completa"
replace education_t="University incomplete​" if D9=="Universitaria incompleta"
replace education_t="University complete" if D9=="Universitaria completa"
replace education_t="Master's or PhD​" if D9=="Postgrado (Maestría / Doctorado)"
tab education_t, m
sum education_t, detail

**** Transforming Education Data into years of Education ****
gen education_y=education_d
recode education_y (1=0) (2=3) (3=6) (4=9) (5=12) (6=14) (7 8=15) (9=16) (10=18) 
label def education 0 "None" 3 "Primary incomplete​" 6 "Primary complete​" 9 "Secondary incomplete​" 12 "Secondary complete​" 14 "Terciario incompleta" 15 "Tertiary complete​ and University incomplete" 16 "University complete​"  18 "Master's or PhD"
label values education_y education_y
label variable education_y "years of education"
tab education_y

tab gender education_y, r
fre education_y

**Generating dummy variables for occupational status categories**
encode education, gen(education_codes)

**Here I am creating dummy variables for Trust Data**
gen trust=0 if C4_5_C4=="Sí"
replace trust=1 if C4_5_C4=="No"
replace trust=. if C4_5_C4=="No entendió" | C4_5_C4=="No precisa" | C4_5_C4=="No sabe"
tab trust, m

**Here I am creating dummy variables for Trust Data**
gen trust_d1=0 if C4_1_C4=="Sí"
replace trust_d1=1 if C4_1_C4=="No"
replace trust_d1=. if C4_1_C4=="No entendió" | C4_1_C4=="No precisa" | C4_1_C4=="No sabe"
tab trust_d1, m


**Here I am creating dummy variables for Trust Data**
gen trust_d2=0 if C4_4_C4=="Sí"
replace trust_d2=1 if C4_4_C4=="No"
replace trust_d2=. if C4_4_C4=="No entendió" | C4_4_C4=="No precisa" | C4_4_C4=="No sabe"
tab trust_d2, m


**Here I am creating dummy variables for Trust Data**
gen trust_d4=0 if C4_6_C4=="Sí"
replace trust_d4=1 if C4_6_C4=="No"
replace trust_d4=. if C4_6_C4=="No entendió" | C4_6_C4=="No precisa" | C4_6_C4=="No sabe"
tab trust_d4, m


**Here I am creating dummy variables for Trust Data**
gen trust_d5=0 if C2=="Intenté comparar, pero no encontré información sobre otros productos"
replace trust_d5=1 if C2!="Intenté comparar, pero no encontré información sobre otros productos"
replace trust_d5=. if C2=="NO SABE" | C2=="No responde"
tab trust_d5, m

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
gen country="Argentina"


