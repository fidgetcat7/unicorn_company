-- View table --

SELECT * from Unicorn_Companies
PRAGMA table_info(Unicorn_Companies)

-- Check duplicate value --
-- Bolt and Fabric appear twice in both data sets. Anyway, they are in different cities / countries. --
-- Therefore, we will keep those data. --
SELECT *
FROM Unicorn_Companies
WHERE company IN (
    SELECT company
    FROM Unicorn_Companies
    GROUP BY company
    HAVING COUNT(*) > 1
);

-- > 

-- Check missing value --

SELECT COUNT(company) AS null_count
FROM Unicorn_Companies
WHERE company IS NULL;

SELECT COUNT(valuation) AS null_count
FROM Unicorn_Companies
WHERE valuation IS NULL;

SELECT COUNT(industry) AS null_count
FROM Unicorn_Companies
WHERE industry IS NULL;

SELECT COUNT(*) AS null_count
FROM Unicorn_Companies
WHERE city IS NULL;

SELECT COUNT(*) AS null_count
FROM Unicorn_Companies
WHERE country IS NULL;

SELECT COUNT(*) AS null_count
FROM Unicorn_Companies
WHERE continent IS NULL;

SELECT COUNT(*) AS null_count
FROM Unicorn_Companies
WHERE year_founded IS NULL;

SELECT COUNT(*) AS null_count
FROM Unicorn_Companies
WHERE funding IS NULL;

SELECT COUNT(*) AS null_count
FROM Unicorn_Companies
WHERE select_investors IS NULL;

-- Strftime with date_joined column to year, month, day column -- 

ALTER TABLE Unicorn_Companies
ADD COLUMN year INTEGER
UPDATE Unicorn_Companies
SET year = CAST(strftime('%Y',date_joined) AS INTEGER)

ALTER TABLE Unicorn_Companies
ADD COLUMN month INTEGER
UPDATE Unicorn_Companies
SET month = CAST(strftime('%m',date_joined) AS INTEGER)

ALTER TABLE Unicorn_Companies
ADD COLUMN day INTEGER
UPDATE Unicorn_Companies
SET day = CAST(strftime('%d',date_joined) AS INTEGER)

-- Drop rows where Funding column contain 0 or Unknown (not unicorn company) --

SELECT DISTINCT Funding
FROM Unicorn_Companies
ORDER BY Funding DESC

DELETE FROM Unicorn_Companies
WHERE Funding IN ('$0M', 'Unknown')

-- Change format & data type both valuation and funding column --

UPDATE Unicorn_Companies
SET valuation = REPLACE(REPLACE(valuation, 'B','000000000'), 'M', '000000')

UPDATE Unicorn_Companies
SET valuation = REPLACE(valuation, '$', '')

UPDATE Unicorn_Companies
SET Funding = REPLACE(REPLACE(Funding, 'B','000000000'), 'M', '000000')

UPDATE Unicorn_Companies
SET funding = REPLACE(funding, '$', '')

UPDATE Unicorn_Companies
SET select_investors = REPLACE(select_investors, ', ', ',')

-- View table --
SELECT * FROM Unicorn_Companies