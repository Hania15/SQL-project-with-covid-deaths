Select *
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 3,4


-- select the starting data 
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 1,2

-- showing the death percentage and changing type of data so it allows us a divide function 
-- checking death percentaga rate of particular location

Select Location, date, CONVERT(DECIMAL(15, 3), total_deaths) as 'total_deaths'
    ,CONVERT(DECIMAL(15, 3), total_cases) as 'total_cases'
    ,CONVERT(DECIMAL(15, 3), (CONVERT(DECIMAL(15, 3), total_deaths) / CONVERT(DECIMAL(15, 3), total_cases))) AS 'DeathPercentage'
From PortfolioProject..CovidDeaths
--Where Location = 'Armenia'
WHERE continent = 'Europe' 
order by 1,2

-- checking type of data types to know what data type have been used on particular columns
use PortfolioProject
go
select TABLE_SCHEMA,TABLE_NAME,COLUMN_NAME,DATA_TYPE, CHARACTER_MAXIMUM_LENGTH from INFORMATION_SCHEMA.COLUMNS 
where table_name='CovidDeaths'

-- percent of population infected with covid - for example in europe
Select Location, date, population, CONVERT(DECIMAL(15, 3), total_cases) as 'total_cases'
    ,CONVERT(DECIMAL(15, 3), population) as 'population'
    ,CONVERT(DECIMAL(15, 3), (CONVERT(DECIMAL(15, 3), total_cases) / CONVERT(DECIMAL(15, 3), population)))*100 AS 'PercentPopultionInfected'
From PortfolioProject..CovidDeaths
--Where Location = 'Armenia'
WHERE continent = 'Europe' 
order by 1,2


-- countries highest infection rate (compared to population) 
Select Location, population, MAX(total_cases) as HighestInfectionCount 
    ,CONVERT(DECIMAL(15, 3), population) as 'population'
    ,CONVERT(DECIMAL(15, 3), MAX(CONVERT(DECIMAL(15, 3), total_cases) / CONVERT(DECIMAL(15, 3), population)))*100 AS 'PercentPopultionInfected'
From PortfolioProject..CovidDeaths
--Where Location = 'Armenia'
--WHERE continent = 'Europe' 
GROUP BY location, population
ORDER BY PercentPopultionInfected DESC


-- classical cast is not working as it shows error "Conversion failed when converting the varchar value '1.0' to data type int." so I will use convert option with float (A floating point number)so it will allow me to calculate the max value of "Total_deaths" per each location, even if some values contain decimal points



Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like 'Austria'
Where continent is not null 
Group by Location
order by TotalDeathCount desc

-- once it finally working - let show countries with Highest Death Count per Population

Select location,  MAX(CONVERT(FLOAT, Total_deaths)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like 'Austria'
Where continent is not null 
Group by Location
order by TotalDeathCount desc

-- and the contintents with the highest death count per population

Select continent,  MAX(CONVERT(FLOAT, Total_deaths)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like 'Austria'
Where continent is not null 
Group by continent
order by TotalDeathCount desc


Select SUM(CONVERT(FLOAT, new_cases)) as total_cases, SUM(CONVERT(float,new_deaths)) as total_deaths, SUM(CONVERT(float, new_deaths))/SUM(CONVERT(float,New_Cases))*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent = Europe"
--Group By date
order by 1,2