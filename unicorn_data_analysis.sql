-- 1. Which unicorn companies have had the biggest return on investment? --
-- top 10 biggest return on investment are 1.Zapier 2.Dunamu 3.Workhuman 4.CFGI 5.Manner 6.DJI Innovations 7.GalaxySpace 8.Canva 9.II Makiage 10.Revolution Precrafted
SELECT 
	company,
    industry,
    country,
    city,
    valuation,
    funding,
    ((valuation - funding)/funding) AS ROI
FROM Unicorn_Companies
ORDER BY ROI DESC
LIMIT 10


-- 2. How long does it usually take for a company to become a unicorn? Has it always been this way? --
-- check min, max, average for a company to become a unicorn company --
select 
    MIN(year - year_founded) as minimun_year,
    ROUND(AVG(year - year_founded),2) as average_year,
    MAX(year - year_founded) as maxumun_year
from Unicorn_Companies

-- check details on how long it takes for the companies to become a unicorn use little time each country --
SELECT 
	company,
    industry,
    country,
    city,
    year - year_founded AS how_long_to_become_unicorn
FROM Unicorn_Companies
WHERE how_long_to_become_unicorn >= 0
GROUP BY how_long_to_become_unicorn
ORDER BY how_long_to_become_unicorn
LIMIT 10

-- 3. Which countries have the most unicorns?  --

SELECT
	country,
    count(company),
	industry
FROM Unicorn_Companies
GROUP BY country
ORDER BY count(company) DESC
LIMIT 10

-- Are there any cities that appear to be industry hubs? --
-- check distinct industry and found in column is same industry but write industry difference --

SELECT DISTINCT industry from Unicorn_Companies

UPDATE Unicorn_Companies
SET industry = REPLACE(industry, 'Artificial Intelligence', 'Artificial intelligence')

SELECT 
    city,
    industry,
    COUNT(*) AS num_company
FROM Unicorn_Companies
GROUP BY industry
ORDER BY num_company DESC
