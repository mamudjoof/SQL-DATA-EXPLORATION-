--HOW MANY CONTINENTS DO WE HAVE COVID DATA FOR?
SELECT DISTINCT(continent) NumberOfCont
FROM CovidDeaths 
WHERE continent IS NOT NULL

SELECT COUNT(DISTINCT(continent)) NumberOfCont
FROM CovidDeaths 
WHERE continent IS NOT NULL


--WHAT IS THE POSSIBILITY OF DYING IF YOU CONTRACT COVID IN POLAND
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100  Prob_of_dying
FROM CovidDeaths
WHERE location='Poland'

--WHAT IS THE PERCENTAGE OF THE POPULATION IS INFECTED WITH COVID-19 IN POLAND
SELECT location, population, date, total_cases, total_deaths, (total_cases/population)*100  Perc_of_Pop_Infec
FROM CovidDeaths
WHERE location='Poland'
ORDER BY 1,2

--WHAT COUNTRIES HAS THE THE HIGHEST COVID-19 INFECTION RATE COMAPRED TO THE POPULATION?
SELECT location, population, MAX(total_cases) Higst_Total_Cov, MAX((total_cases/population)*100)  Higst_Cov_Infec_Rate
FROM CovidDeaths
--WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Higst_Cov_Infec_Rate DESC


--WHAT COUNTRIES HAS THE HIGHEST DEATH PER POPULATION FROM COVID-19?
EXEC sp_help CovidDeaths
SELECT location, population, MAX(CAST(total_deaths as int)) Hgst_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Hgst_Deaths DESC

--WHICH CONTINENTS HAS THE HIGHEST DEATH PER POPULATION FROM COVID-19?
SELECT continent, MAX(CAST(total_deaths as int)) Hgst_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Hgst_Deaths DESC

--WHAT CONTINENTS HAS THE HIGHEST PERCENTAGE OF DEATH FROM COVID-19 COMPARED TO IT'S POPULATION?
SELECT continent, MAX((CAST(total_deaths as int)/population)*100) Hgst_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Hgst_Deaths DESC


--WHAT ARE THE TOTAL COVID-19 CASES, TOTAL COVID-19 DEATH AND DEATHS PERCENTAGE FROM COVID-19 IN THE WORLD?
SELECT SUM(new_cases)  Total_Cases, SUM(CAST(total_deaths AS INT))  Total_Deaths,  (SUM(new_cases)/SUM(CAST(total_deaths AS INT)))*100  Deaths_Perc
FROM CovidDeaths


--HOW DO THE MATRICS RELATED TO COVID-19(CASES,DEATHS RATES) COMAPRE BETWEENT COUNTRIES AND CONTINENTS?
SELECT continent, location, SUM(total_cases) Total_Cases, SUM(CAST(total_deaths AS INT)) Total_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent, location
ORDER BY Total_Cases DESC,  Total_Deaths DESC
 
 --HOW MANY PEOPLE IN THE WORLD HAS RECIEVED ATLEAST ONE COVID-19 VACCINE?
SELECT CD.continent, CD.location, CD.population, CD.date, CV.new_vaccinations,
SUM(CAST(new_vaccinations AS INT)) OVER (PARTITION BY CD.location ORDER BY CD.continent, CV.date)  RollingPeopleVaccinated
FROM CovidDeaths CD
JOIN CovidVaccinations  CV
ON CD.continent=CV.continent and CD.date=CV.date
WHERE CD.continent IS NOT NULL
ORDER BY 2,3




EXEC sp_help CovidVaccinations



SELECT *
FROM CovidDeaths
--


SELECT *
FROM CovidVaccinations











