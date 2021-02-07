# covid19
covid19 things

Stringency index vs new deaths

Dataset: https://github.com/owid/covid-19-data

Software: Stata 16.1

European countries

Graphical results of country-level analysis

y = log of daily variations in new deaths per million and X = stringency index (lagged by 14 days)

OLS regressions with robust s.e.

=> all country beta coefficients (betacoefwe.png)

=> scatter plots + linear fits (with R²) for each country (country 3 letters iso code.png)

OLS rolling window (30 days) regressions with robust s.e.

=> beta coefficient + t-stat curves (rw_country 3 letters iso code.png) for each country
