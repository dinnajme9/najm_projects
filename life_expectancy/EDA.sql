CREATE DATABASE `life_expectancy`;
USE `life_expectancy`;

CREATE TABLE IF NOT EXISTS life_expectancy (
    Country VARCHAR(255),
    Sum_of_Females_Life_Expectancy double,
    Sum_of_Life_Expectancy_both_sexes double,
    Sum_of_Males_Life_Expectancy double
);

SELECT @@secure_file_priv;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\life_expectancy.csv' INTO TABLE life_expectancy
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 LINES;

SELECT * FROM life_expectancy.life_expectancy;

SELECT MAX(Sum_of_Life_Expectancy_both_sexes) FROM life_expectancy.life_expectancy;

SELECT *
FROM life_expectancy.life_expectancy
WHERE Sum_of_Females_Life_Expectancy = (
    SELECT MAX(Sum_of_Females_Life_Expectancy)
    FROM life_expectancy.life_expectancy
);

SELECT *
FROM life_expectancy.life_expectancy
WHERE Sum_of_Males_Life_Expectancy = (
    SELECT MAX(Sum_of_Males_Life_Expectancy)
    FROM life_expectancy.life_expectancy
);

SELECT MIN(Sum_of_Life_Expectancy_both_sexes) FROM life_expectancy.life_expectancy;

SELECT *
FROM life_expectancy.life_expectancy
WHERE Sum_of_Females_Life_Expectancy = (
    SELECT MIN(Sum_of_Females_Life_Expectancy)
    FROM life_expectancy.life_expectancy
);


SELECT *
FROM life_expectancy.life_expectancy
WHERE Sum_of_Males_Life_Expectancy = (
    SELECT MIN(Sum_of_Males_Life_Expectancy)
    FROM life_expectancy.life_expectancy
);







