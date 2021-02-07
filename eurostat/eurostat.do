sysdir set PLUS "C:\Users\Christophe Godlewski\OneDrive - unistra.fr\ado\plus"
cd "C:\Users\Christophe Godlewski\Documents\wirus\eurostat"

*** données EUROSTAT

/* 
Total health care expenditure (tps00207)	
Hospital beds (tps00046)	 
Curative care beds in hospitals (tps00168)	
Available beds in hospitals by NUTS 2 regions (tgs00064)	
Death due to pneumonia, by sex (tps00128)	 

Body mass index (BMI) by sex, age and educational attainment level (hlth_ehis_bm1e)	 
Body mass index (BMI) by sex, age and income quintile (hlth_ehis_bm1i)	 
Daily smokers of cigarettes by sex, age and educational attainment level (hlth_ehis_sk3e)
Daily smokers of cigarettes by sex, age and income quintile (hlth_ehis_sk3i)	 
Performing (non-work-related) physical activities by sex, age and educational attainment level (hlth_ehis_pe3e)	 
Time spent on health-enhancing (non-work-related) aerobic physical activity by sex, age and educational attainment level (hlth_ehis_pe2e)	 
Daily consumption of fruit and vegetables by sex, age and educational attainment level (hlth_ehis_fv3e)		
			
Hospital beds by type of care (hlth_rs_bds)	 
Hospital beds by NUTS 2 regions (hlth_rs_bdsrg)	 
Long-term care beds in nursing and residential care facilities by NUTS 2 regions (hlth_rs_bdsns)	 
Technical resources in hospital (hlth_rs_tech)	 
Medical technology (hlth_rs_equip)	 

Health personnel employed in hospital (hlth_rs_prshp1)	 
Nursing and caring professionals (hlth_rs_prsns)	 
Physicians by medical speciality (hlth_rs_spec)	 
Physicians by sex and age (hlth_rs_phys)	 
Health personnel by NUTS 2 regions (hlth_rs_prsrg)	 
Health personnel (excluding nursing and caring professionals) (hlth_rs_prs1)	 
												
Hospital discharges and length of stay for inpatient and curative care (hlth_co_dischls)	 
Curative care bed occupancy rate (hlth_co_bedoc)	 
Non-residents among all hospital discharges, % (hlth_co_dischnr)	 

In-patient average length of stay (days) (hlth_co_inpst)	 
Hospital days of in-patients (hlth_co_hosday)	 

Self-reported vaccination against influenza by sex, age and educational attainment level (hlth_ehis_pa1e) 
Self-reported vaccination against influenza by sex, age and degree of urbanisation (hlth_ehis_pa1u)	 
Self-reported screening of cardiovascular diseases and diabetes risks by sex, age and educational attainment level (hlth_ehis_pa2e)	 
Self-reported screening of cardiovascular diseases and diabetes risks by sex, age and degree of urbanisation (hlth_ehis_pa2u)
Vaccination against influenza of population aged 65 and over (hlth_ps_immu)	 
Self-reported vaccination against influenza by sex, age and educational attainment level (%) (hlth_ehis_hc1)
								
Self-reported use of home care services by sex, age and educational attainment level (hlth_ehis_am7e)	 
Self-reported use of home care services by sex, age and degree of urbanisation (hlth_ehis_am7u)	 
Self-reported use of home care services by sex, age and level of activity limitation (hlth_ehis_am7d)
							
Causes of death - deaths by country of residence and occurrence (hlth_cd_aro)	 
Causes of death - standardised death rate by NUTS 2 region of residence (hlth_cd_asdr2)	 
Causes of death - crude death rate by NUTS 2 region of residence (hlth_cd_acdr2)	 
Causes of death - potential years of life lost by residence (hlth_cd_apyll)	 
Causes of death - deaths by NUTS 2 region of residence and occurrence, 3 year average (hlth_cd_yro)	 
Causes of death - standardised death rate by NUTS 2 region of residence, 3 year average (hlth_cd_ysdr2)	 
Causes of death - crude death rate by NUTS 2 regions of residence, 3 year average (hlth_cd_ycdr2)	 
Causes of death - years and potential years of life lost by NUTS 2 regions of residence, 3 year average (hlth_cd_ypyll)
						
Deaths of residents related to dementias including Alzheimer (hlth_cd_dar)	 
Deaths related to infectious diseases (hlth_cd_ido)	 

Life expectancy by age and sex (demo_mlexpec)	 
Healthy life years by sex (from 2004 onwards) (hlth_hlye)	 
Self-perceived health by sex, age and educational attainment level (hlth_silc_02)	 
Self-perceived health by sex, age and income quintile (hlth_silc_10)	 
Current depressive symptoms by sex, age and educational attainment level (hlth_ehis_mh1e)	 
Current depressive symptoms by sex, age and income quintile (hlth_ehis_mh1i)	 

Population on 1 January by age group, sex and NUTS 2 region
online data code: DEMO_R_PJANGROUP
Population density by NUTS 3 region
online data code: DEMO_R_D3DENS

Hospital discharges by diagnosis, in-patients, total number
online data code: HLTH_CO_DISCH1
Hospital discharges by diagnosis, in-patients, per 100 000 inhabitants
online data code: HLTH_CO_DISCH2
Hospital discharges by diagnosis, day cases, total number
online data code: HLTH_CO_DISCH3
Hospital discharges by diagnosis, day cases, per 100 000 inhabitants
online data code: HLTH_CO_DISCH4 

Death and crude death rate tps00029
Death by week demo_r_mwk_ts

*/



foreach v in tps00046  tps00168 tps00207 hlth_rs_prshp1 hlth_rs_prsns hlth_rs_prs1  hlth_co_dischls hlth_co_bedoc hlth_co_inpst hlth_co_hosday  hlth_ps_immu  hlth_cd_aro   hlth_silc_02   {
    eurostatuse `v' , clear long noflags   keepdim()  save
*save d_`v', replace
}

foreach v in tps00128 hlth_cd_ido tps00029 demo_r_mwk_ts {
	eurostatuse `v' , clear long noflags   keepdim()  save
	}
	
	foreach v in hlth_rs_spec hlth_rs_phys hlth_rs_prs1  {
	eurostatuse `v' , clear long noflags   keepdim()  save
	}
	
**************************************************************

******************************
****** décès par semaine (par sexe)

use  demo_r_mwk_ts, clear
gen date=weekly(time,"YW")
format date %tw
drop if demo_r_mwk_ts==.
labvars demo_r_mwk_ts "total deaths"
keep if sex=="T"
drop sex
drop unit
gen W_EU=1 if geo=="AT" | geo=="BE" | geo=="CH" | geo=="DE" | geo=="DK" | geo=="ES" | geo=="FI" | geo=="FR" | geo=="IE" | geo=="IT" | geo=="LU" | geo=="NL" | geo=="NO" | geo=="PT" | geo=="UK" | geo=="SE"
replace W_EU=0 if W_EU==.
gen E_EU=1 if geo=="BG" | geo=="CZ" | geo=="EE" | geo=="HR" | geo=="HU" | geo=="LT" | geo=="LV" | geo=="PL" | geo=="RO" | geo=="SK"
replace E_EU=0 if E_EU==.
encode geo, gen(ngeo)
gen year=substr(time,1,4)
destring year, replace
egen tag  = tag(geo year)
egen ntags = total(tag), by(geo)
bysort geo (tag year) : gen consec = tag & tag[_n-1] & (year ==  year[_n-1] + 1)
by geo : egen nconsec = total(consec)
tab nconsec 
tabstat demo_r_mwk_ts, by(geo )
xtset ngeo date
xtline demo_r_mwk_ts if nconsec>19 & W_EU==1, overlay ylabel(, labsize(small)) xlabel( #8, labsize(small)) legend(size(small) cols(5)) subtitle("Total weekly deaths (Western Europe)") note("Source: EUROSTAT") 
xtline demo_r_mwk_ts if nconsec>19 & E_EU==1, overlay ylabel(, labsize(small)) xlabel( #8, labsize(small)) legend(size(small) cols(5)) subtitle("Total weekly deaths (Eastern Europe)") note("Source: EUROSTAT") 

keep if geo=="FR"
tsset date
tsline demo_r_mwk_ts
sort year
rename year annee
merge m:m annee using "C:\Users\Christophe Godlewski\Documents\wirus\pop.dta"
keep if _merge==3
drop _merge
gen p60=pop60/pop
gen p75=pop75/pop 
labvars p60 p75 demo_r_mwk_ts "% pop. > 60ans" "% pop. > 75ans" "total décès"

tsline demo_r_mwk_ts, ytitle(,size(small)) ylabel(,labsize(small))  || tsline p60  , yaxis(2) ytitle(,size(small) axis(2)) ylabel(,labsize(small) axis(2)) || tsline p75, yaxis(3) ytitle(,size(small) axis(3)) ylabel(,labsize(small) axis(3)) legend(size(small) cols(3)) subtitle("Décès hebdo. et % pop. agée +60 et +75 ans en France") note("Source: EUROSTAT & INSEE") xlabel(#10, labsize(small)) yline(11529.67, lp(dash) lc(gs10)) yline(11766.2,lp(dash) lc(gs8))  yline(11755.38,lp(dash) lc(gs6)) yline(12759.79,lp(dash) lc(gs4))

sum demo_r_mwk_ts
sum demo_r_mwk_ts if inrange(annee,2015,2020)
sum demo_r_mwk_ts if annee==2020
sum demo_r_mwk_ts if annee==2019


******************************
****** décès par cause dans un pays  

use hlth_cd_aro, clear
sort icd10
keep if sex=="T"
keep if age=="TOTAL"
keep if resid=="TOT_RESID"
drop if hlth_cd_aro==.
rename hlth_cd_aro deaths

tab geo

keep if geo=="FR"

keep if geo=="PL"

keep if geo=="EU28"

drop unit sex age resid  


* codes groupes

keep if icd10=="A-R_V-Y" | icd10=="ACC" | icd10=="A_B" | icd10=="C" | icd10=="E" | icd10=="F" | icd10=="G_H" | icd10=="I" | icd10=="J" | icd10=="K" | icd10=="L" | icd10=="M" | icd10=="N" | icd10=="O" | icd10=="P" | icd10=="Q" | icd10=="R" | icd10=="V01-Y89"

gen code="allcauses" if icd10=="A-R_V-Y"
replace code="accidents" if icd10=="ACC"  
replace code="infectparasit" if icd10=="A_B"  
replace code="neoplasm" if icd10=="C"  
replace code="endocrinnutrimetabolic" if icd10=="E"  
replace code="mentalbehavior" if icd10=="F"
replace code="nervoussens" if icd10=="G_H"
replace code="circulation" if icd10=="I"
replace code="respiratory" if icd10=="J"
replace code="digestive" if icd10=="K"
replace code="skinsubcutaneous" if icd10=="L"
replace code="musculoskeletal" if icd10=="M"
replace code="genitourinary" if icd10=="N"
replace code="pregnantchild" if icd10=="O"
replace code="perinatal" if icd10=="P"
replace code="congenitalchromosomal" if icd10=="Q"
replace code="notelseclass" if icd10=="R"
replace code="externalcauses" if icd10=="V01-Y89"

keep deaths code time  geo

reshape wide deaths   , i(time) j(code) string

tsset time

sum deathsaccidents deathscirculation deathscongenitalchromosomal deathsdigestive deathsendocrinnutrimetabolic deathsexternalcauses deathsgenitourinary deathsinfectparasit deathsmentalbehavior deathsmusculoskeletal deathsneoplasm deathsnervoussens deathsnotelseclass deathsperinatal deathspregnantchild deathsrespiratory deathsskinsubcutaneous

gen deathspregnantperinatal=deathsperinatal+deathspregnantchild 

graph bar (asis) deathsallcauses, over(time) title(Evolution décès en `=geo') subtitle(Toutes causes) note("Source: EUROSTAT")

graph export dc`=geo'.png, replace

labvars deathsaccidents deathscirculation deathscongenitalchromosomal deathsdigestive deathsendocrinnutrimetabolic deathsexternalcauses deathsgenitourinary deathsinfectparasit deathsmentalbehavior deathsmusculoskeletal deathsneoplasm deathsnervoussens deathsnotelseclass deathspregnantperinatal deathsrespiratory deathsskinsubcutaneous ///
 "accidents" "circulatory system" "congenital & chromosomal abnormalities" "digestive system" "endocrine, nutritional, metabolic" "external" "genitourinary system" "infectious & parasitic" "mental, behavioral, neurodevelopmental" "musculoskeletal system" "neoplasms" "nervous system" "not classified elsewhere" "pregnancy, childbirth, puerperium, perinatal" "respiratory system" "skin & subcutaneous tissue"

graph bar (asis) deathsneoplasm deathscirculation deathsnotelseclass deathsrespiratory deathsexternalcauses deathsnervoussens  deathsaccidents deathsdigestive deathsendocrinnutrimetabolic deathsinfectparasit deathscongenitalchromosomal  deathsgenitourinary  deathsmentalbehavior deathsmusculoskeletal  deathspregnantperinatal  deathsskinsubcutaneous, over(time ) stack legend(size(vsmall) )   bar(1, fcolor(black)) bar(2,fcolor(red)) bar(3,fcolor(gs14)) bar(4,fcolor(blue)) bar(5,fcolor(gs4)) bar(6,fcolor(yellow)) title(Evolution décès par causes en `=geo') note("Source: EUROSTAT") ylabel(,labsize(vsmall) angle(horizontal))

graph export dcf`=geo'd.png, replace

graph bar deathsneoplasm deathscirculation deathsnotelseclass deathsrespiratory deathsexternalcauses deathsnervoussens  deathsaccidents deathsdigestive deathsendocrinnutrimetabolic deathsinfectparasit deathscongenitalchromosomal  deathsgenitourinary  deathsmentalbehavior deathsmusculoskeletal  deathspregnantperinatal  deathsskinsubcutaneous,  legend(size(vsmall) )   bar(1, fcolor(black)) bar(2,fcolor(red)) bar(3,fcolor(gs14)) bar(4,fcolor(blue)) bar(5,fcolor(gs4)) bar(6,fcolor(yellow)) title(Moyenne décès par causes en `=geo' (2011-2016)) note("Source: EUROSTAT") ylabel(,labsize(vsmall) angle(horizontal))

graph export dcm`=geo'.png, replace

graph bar deathsneoplasm deathscirculation deathsnotelseclass deathsrespiratory deathsexternalcauses deathsnervoussens  deathsaccidents deathsdigestive deathsendocrinnutrimetabolic deathsinfectparasit deathscongenitalchromosomal  deathsgenitourinary  deathsmentalbehavior deathsmusculoskeletal  deathspregnantperinatal  deathsskinsubcutaneous if time>2013,  legend(size(vsmall) )   bar(1, fcolor(black)) bar(2,fcolor(red)) bar(3,fcolor(gs14)) bar(4,fcolor(blue)) bar(5,fcolor(gs4)) bar(6,fcolor(yellow)) title(Moyenne décès par causes en `=geo' (2014-2016)) note("Source: EUROSTAT") ylabel(,labsize(vsmall) angle(horizontal))

graph export dcm2`=geo'.png, replace

foreach v in   deathsaccidents deathscirculation deathscongenitalchromosomal deathsdigestive deathsendocrinnutrimetabolic deathsexternalcauses deathsgenitourinary deathsinfectparasit deathsmentalbehavior deathsmusculoskeletal deathsneoplasm deathsnervoussens deathsnotelseclass deathspregnantperinatal deathsrespiratory deathsskinsubcutaneous   {
    gen p`v'=`v'/deathsallcauses
}

sum p*

colorpalette HSV heat, n(16) nograph
tsline pdeathsneoplasm pdeathscirculation pdeathsnotelseclass pdeathsrespiratory pdeathsexternalcauses pdeathsnervoussens  pdeathsaccidents pdeathsdigestive pdeathsendocrinnutrimetabolic pdeathsinfectparasit pdeathscongenitalchromosomal  pdeathsgenitourinary  pdeathsmentalbehavior pdeathsmusculoskeletal  pdeathspregnantperinatal  pdeathsskinsubcutaneous,lcolor(`r(p)') legend(size(vsmall) label(1 "neoplasms") label(2 "circulatory system") label(3 "not classified elsewhere") label(4 "respiratory system") label(5 "external") label(6 "nervous system") label(7  "accidents") label(8 "digestive system") label(9 "endocrine, nutritional, metabolic") label(10 "infectious & parasitic") label(11 "congenital & chromosomal abnormalities") label(12 "genitourinary system") label(13 "mental, behavioral, neurodevelopmental") label(14 "musculoskeletal system") label(15 "pregnancy, childbirth, puerperium, perinatal") label(16 "skin & subcutaneous tissue")) ///
 title("Evolution décès par causes (en % total décès) en `=geo'") note("Source: EUROSTAT") xtitle("")
 
 graph export dc`=geo'ep.png, replace
 

/*
Chapter	Code Range	Description
1	A00-B99	Certain infectious and parasitic diseases
2	C00-D49	Neoplasms
3	D50-D89	Diseases of the blood and blood-forming organs and certain disorders involving the immune mechanism
4	E00-E89	Endocrine, nutritional and metabolic diseases
5	F01-F99	Mental, Behavioral and Neurodevelopmental disorders
6	G00-G99	Diseases of the nervous system
7	H00-H59	Diseases of the eye and adnexa
8	H60-H95	Diseases of the ear and mastoid process
9	I00-I99	Diseases of the circulatory system
10	J00-J99	Diseases of the respiratory system
11	K00-K95	Diseases of the digestive system
12	L00-L99	Diseases of the skin and subcutaneous tissue
13	M00-M99	Diseases of the musculoskeletal system and connective tissue
14	N00-N99	Diseases of the genitourinary system
15	O00-O9A	Pregnancy, childbirth and the puerperium
16	P00-P96	Certain conditions originating in the perinatal period
17	Q00-Q99	Congenital malformations, deformations and chromosomal abnormalities
18	R00-R99	Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified
19	S00-T88	Injury, poisoning and certain other consequences of external causes
20	V00-Y99	External causes of morbidity
21	Z00-Z99	Factors influencing health status and contact with health services
*/

******* hospital data

*Hospital beds 100.000 hab. 
use tps00046,clear
rename tps00046 hospbeds
drop if hospbeds==.
gen yvar=hospbeds 

* Curative care beds in hospitals 
use tps00168,clear
rename tps00168 curcarebeds
drop if curcarebeds==.
gen yvar=curcarebeds

*Curative care bed occupancy rate (hlth_co_bedoc)	 
use hlth_co_bedoc,clear
rename hlth_co_bedoc curcarebedocupr
drop if curcarebedocupr==.
gen yvar=curcarebedocupr

*Total health care expenditure (tps00207)	
/* unit
EUR_HAB = euro / hab
PC_GDP = % gdp
*/
use tps00207,clear
rename tps00207 tothcexp
drop if tothcexp==.
gen yvar=tothcexp

keep if unit=="EUR_HAB"

keep if unit=="PC_GDP"

* Health personnel employed in hospital (hlth_rs_prshp1)	
use hlth_rs_prshp1,clear
/*
isco08 = HOSP
isco08 = OC221 (medical doctors)
isco08 = OC222_3222 (nurses)
unit = FTE_HTHAB (full time equiv / 100k hab)
unit = HC_HTHAB (head count / 100k hab)
*/
drop if hlth_rs_prshp1==.
gen yvar=hlth_rs_prshp1
keep if unit=="HC_HTHAB"

keep if isco08 == "OC221"

keep if isco08 == "OC222_3222" 

*Physicians by medical speciality (hlth_rs_spec )
use hlth_rs_spec , clear
keep if unit=="P_HTHAB"
drop if hlth_rs_spec==.
gen yvar=hlth_rs_spec
*respiratory medecine
keep if med_spec=="MED_RES" 
*microbiology-bacteriology
keep if med_spec=="MED_MIC"
* pathology
keep if med_spec=="MED_PAT"

* Physicians by sex and age
use hlth_rs_phys ,clear
keep if sex=="T"
*keep if time==2018
drop if hlth_rs_phys==.
gen yvar=hlth_rs_phys

keep if age=="TOTAL"

keep if age=="Y65-74"

* keep if age=="Y_GE75"



*Vaccination against influenza of population aged 65 and over (%)
use hlth_ps_immu , clear
drop if  hlth_ps_immu==.
gen yvar=hlth_ps_immu

keep if time==2018
sort geo
rename geo A2
merge 1:1 A2 using "C:\Users\Christophe Godlewski\OneDrive - unistra.fr\DATA\stata data\countryisocodes.dta"
keep if _merge==3
drop _merge
rename Number ccode 
sort ccode
merge 1:m ccode using "C:\Users\Christophe Godlewski\OneDrive - unistra.fr\DATA\Macro Data\maps stata\idfile.dta"
keep if _merge==3
drop _merge
keep hlth_ps_immu na_id_world
duplicates drop * , force
sum hlth_ps_immu, d
colorpalette HSV heat, n(10) reverse nograph
spmap hlth_ps_immu using "C:\Users\Christophe Godlewski\OneDrive - unistra.fr\DATA\Macro Data\maps stata\coord_mercator_europe.dta", id(na_id_world) fcolor(`r(p)') osize(vvthin vvthin vvthin vvthin) ndsize(vvthin) clmethod(custom) clbreaks(10 20 45 55 60 65 70 75 80) title("Vaccination against influenza" "of population aged 65 and over (%)")


************************

encode geo, gen(geo1)

gen W_EU=1 if geo=="AT" | geo=="BE" | geo=="CH" | geo=="DE" | geo=="DK" | geo=="ES" | geo=="FI" | geo=="FR" | geo=="IE" | geo=="IT" | geo=="LU" | geo=="NL" | geo=="NO" | geo=="PT" | geo=="UK" | geo=="SE"
replace W_EU=0 if W_EU==.
gen E_EU=1 if geo=="BG" | geo=="CZ" | geo=="EE" | geo=="HR" | geo=="HU" | geo=="LT" | geo=="LV" | geo=="PL" | geo=="RO" | geo=="SK"
replace E_EU=0 if E_EU==.

egen tag  = tag(geo time)
egen ntags = total(tag), by(geo)
bysort geo (tag time) : gen consec = tag & tag[_n-1] & (time ==  time[_n-1] + 1)
by geo : egen nconsec = total(consec)
tab nconsec 

xtset geo1 time

xtline yvar if W_EU==1 & nconsec>10, addplot(line yvar time if geo=="EU27_2020", lcolor(black) lpattern(dot)) overlay legend(size(vsmall) label(15 "EU") cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
 title("# hospital beds / 100k hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export litsw.png,replace
 
 xtline yvar if E_EU==1 & nconsec>10, addplot(line yvar time if geo=="EU27_2020", lcolor(black) lpattern(dot)) overlay legend(size(vsmall) label(11 "EU") cols(4)) xtitle("") ytitle("") xlabel(#12 ) ///
 subtitle("Evolution nombre de lits hospitaliers / 100k hab. (Europe Est)") note("Source: EUROSTAT") 
graph export litse.png,replace

xtline yvar if W_EU==1 & nconsec>10, addplot(line yvar time if geo=="EU27_2020", lcolor(black) lpattern(dot)) overlay legend(size(vsmall) label(14 "EU") cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
 title("# curative care beds / 100k hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export litscw.png,replace
 
 xtline yvar if E_EU==1 & nconsec>10, addplot(line yvar time if geo=="EU27_2020", lcolor(black) lpattern(dot)) overlay legend(size(vsmall) label(10 "EU") cols(4)) xtitle("") ytitle("") xlabel(#12 ) ///
 subtitle("Evolution nombre de lits soins curatifs / 100k hab. (Europe Est)") note("Source: EUROSTAT") 
graph export litsce.png,replace

xtline yvar if W_EU==1  & nconsec>10 & time>1999,  overlay legend(size(vsmall) cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
title("Curative beds occupancy rate (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export litscorw.png,replace
 
 xtline yvar if E_EU==1 & nconsec>10 & time>1999,  overlay legend(size(vsmall) cols(4)) xtitle("") ytitle("") xlabel(#12 ) ///
 subtitle("Evolution tx occupation lits soins curatifs (Europe Est)") note("Source: EUROSTAT") 
graph export litscore.png,replace

xtline yvar if W_EU==1 & nconsec>10, addplot(line yvar time if geo=="EU27_2020", lcolor(black) lpattern(dot)) overlay legend(size(vsmall) label(10 "EU") cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
 title("Tot. healthcare expenditure: € / hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export tohcexpeurhabw.png,replace
 
 xtline yvar if W_EU==1 & nconsec>10, addplot(line yvar time if geo=="EU27_2020", lcolor(black) lpattern(dot)) overlay legend(size(vsmall) label(10 "EU") cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
 title("Tot. healthcare expenditure:% / GDP (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export tohcexppgdpw.png,replace
 
 xtline yvar if W_EU==1  & nconsec>10 & time>1999,  overlay legend(size(vsmall) cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
title("Medical doctors - head count / 100k hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export mdhcw.png,replace
 
  xtline yvar if W_EU==1  & nconsec>10 & time>1999,  overlay legend(size(vsmall) cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
title("Nurses - head count / 100k hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export nurhcw.png,replace
 
   xtline yvar if W_EU==1  & nconsec>5 & time>2004,  overlay legend(size(vsmall) cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
title("Specialists: respiratory medecine / 100k hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export specrespiw.png,replace
 
    xtline yvar if W_EU==1  & nconsec>5 & time>2004,  overlay legend(size(vsmall) cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
title("Specialists: microbiology-bacteriology / 100k hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export specmicrobactw.png,replace
 
     xtline yvar if W_EU==1  & nconsec>5 & time>2004,  overlay legend(size(vsmall) cols(5)) xtitle("") ytitle("") xlabel(#12 ) ///
title("Specialists:  pathology / 100k hab. (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export specpathow.png,replace
 
  xtline yvar if W_EU==1  & nconsec>15 & time>1999,  overlay legend(size(vsmall) cols(5) all) xtitle("") ytitle("") xlabel(#12 ) ylabel(,labsize(small)) ///
title("Physicians (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export physage0w.png,replace
 
     xtline yvar if W_EU==1  & nconsec>10 & time>1999,  overlay legend(size(vsmall) cols(5)) xtitle("") ytitle("") xlabel(#12 ) ylabel(,labsize(small)) ///
title("Physicians aged 65 to 74 (Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak")
 graph export physage1w.png,replace


xtline yvar if W_EU==1  & nconsec>10 & time>1999,  overlay legend(size(vsmall) cols(4)) xtitle("") ytitle("") xlabel(#12 ) ///
 subtitle("Evolution % pop. 65+ vaccinée contre grippe (Europe Ouest)") note("Source: EUROSTAT") 
 graph export grippew.png,replace
 
 xtline yvar if E_EU==1 & nconsec>10 & time>1999,  overlay legend(size(vsmall) cols(4)) xtitle("") ytitle("") xlabel(#12 ) ///
 subtitle("Evolution % pop. 65+ vaccinée contre grippe (Europe Est)") note("Source: EUROSTAT") 
graph export grippee.png,replace
 
**** In-patient average length of stay (days)

use hlth_co_inpst, clear
drop if hlth_co_inpst==.
keep if age=="TOTAL"
keep if sex=="T"
sort icd10
merge m:m icd10 using icd10def
keep if _merge==3
drop _merge

* respiratory only
keep if icd10=="J"
rename hlth_co_inpst lengthstay
encode geo, gen(geo1)

xtset geo1 time

gen W_EU=1 if geo=="AT" | geo=="BE" | geo=="CH" | geo=="DE" | geo=="DK" | geo=="ES" | geo=="FI" | geo=="FR" | geo=="IE" | geo=="IT" | geo=="LU" | geo=="NL" | geo=="NO" | geo=="PT" | geo=="UK" | geo=="SE"
replace W_EU=0 if W_EU==.
gen E_EU=1 if geo=="BG" | geo=="CZ" | geo=="EE" | geo=="HR" | geo=="HU" | geo=="LT" | geo=="LV" | geo=="PL" | geo=="RO" | geo=="SK"
replace E_EU=0 if E_EU==.

egen tag  = tag(geo time)
egen ntags = total(tag), by(geo)
bysort geo (tag time) : gen consec = tag & tag[_n-1] & (time ==  time[_n-1] + 1)
by geo : egen nconsec = total(consec)
tab nconsec 


xtline  lengthstay if W_EU==1 & nconsec>15 & time>1999, overlay legend(size(small) cols(5) all ) xtitle("") ytitle("") xlabel(#12 ) ///
 title("In-patient average length of stay (days) - respiratory illness""(Western Europe)") caption("Source: EUROSTAT") note("stata monkey: @chrisgodlak") 
graph export lengthstayrespiw.png,replace

xtline  lengthstay if E_EU==1 & nconsec>10 & time>1999, overlay legend(size(small) cols(4)  ) xtitle("") ytitle("") xlabel(#12 ) ///
 subtitle("Evolution durée moy. séjour patient (maladies respiratoires) (Europe Est)") note("Source: EUROSTAT") 
graph export dureee.png,replace
