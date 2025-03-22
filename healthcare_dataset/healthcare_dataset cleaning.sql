CREATE DATABASE `healthcare`;
USE `healthcare`;
CREATE TABLE IF NOT EXISTS healthcare_data (
    `name` VARCHAR(255),
    Age INT,
    Gender VARCHAR(255),
    Blood_Type VARCHAR(255),
    Medical_Condition VARCHAR(255),
    Date_of_Admission VARCHAR(255),
    Doctor VARCHAR(255),
    Hospital VARCHAR(255),
    Insurance_Provider VARCHAR(255),
    Billing_Amount DOUBLE,
    Room_Number INT,
    Admission_Type VARCHAR(255),
    Discharge_Date VARCHAR(255),
    Medication VARCHAR(255),
    Test_Results VARCHAR(255)
);

SELECT @@secure_file_priv;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\healthcare_dataset.csv' INTO TABLE healthcare_data
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 LINES;

SELECT * FROM healthcare.healthcare_data;

SELECT 
        *, 
        ROW_NUMBER() OVER (
            PARTITION BY `name`, Age, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) AS row_num
    FROM healthcare.healthcare_data;

WITH Dup AS (
    SELECT 
        *, 
        ROW_NUMBER() OVER (
            PARTITION BY `name`, Age, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) AS row_num
    FROM healthcare.healthcare_data
)
SELECT *
FROM Dup
WHERE row_num > 1;


CREATE TABLE IF NOT EXISTS healthcare_data2 (
    `name` VARCHAR(255),
    Age INT,
    Gender VARCHAR(255),
    Blood_Type VARCHAR(255),
    Medical_Condition VARCHAR(255),
    Date_of_Admission VARCHAR(255),
    Doctor VARCHAR(255),
    Hospital VARCHAR(255),
    Insurance_Provider VARCHAR(255),
    Billing_Amount DOUBLE,
    Room_Number INT,
    Admission_Type VARCHAR(255),
    Discharge_Date VARCHAR(255),
    Medication VARCHAR(255),
    Test_Results VARCHAR(255),
    rn INT
);

INSERT INTO healthcare_data2
SELECT *, ROW_NUMBER() OVER (
			PARTITION BY `name`,Age, Gender, Blood_Type,Medical_Condition,Date_of_Admission,Doctor,Hospital,Insurance_Provider,Billing_Amount,Room_Number,Admission_Type,Discharge_Date,Medication,Test_Results) AS row_num
	FROM healthcare.healthcare_data;
    
SELECT * FROM healthcare.healthcare_data2;

SELECT *
FROM healthcare_data2
WHERE rn > 1;

DELETE
FROM healthcare_data2
WHERE rn > 1;

SELECT * 
FROM healthcare_data2
WHERE `name` IS NULL
   OR Age IS NULL
   OR Gender IS NULL
   OR Blood_Type IS NULL
   OR Medical_Condition IS NULL
   OR Date_of_Admission IS NULL
   OR Doctor IS NULL
   OR Hospital IS NULL
   OR Insurance_Provider IS NULL
   OR Billing_Amount IS NULL
   OR Room_Number IS NULL
   OR Admission_Type IS NULL
   OR Discharge_Date IS NULL
   OR Medication IS NULL
   OR Test_Results IS NULL;

UPDATE healthcare_data2
SET name = TRIM(name),Age = TRIM(Age),
    Gender = TRIM(Gender),
    Blood_Type = TRIM(Blood_Type),
    Medical_Condition = TRIM(Medical_Condition),
    Date_of_Admission = TRIM(Date_of_Admission),
    Doctor = TRIM(Doctor),
    Hospital = TRIM(Hospital),
    Insurance_Provider = TRIM(Insurance_Provider),
    Billing_Amount = TRIM(Billing_Amount),
    Room_Number = TRIM(Room_Number),
    Admission_Type = TRIM(Admission_Type),
    Discharge_Date = TRIM(Discharge_Date),
    Medication = TRIM(Medication),
    Test_Results = TRIM(Test_Results);
    

SELECT DISTINCT Medical_Condition
FROM healthcare_data2
ORDER BY 1;

UPDATE healthcare_data2
SET Medical_Condition = 'Asthma'
WHERE Medical_Condition LIKE 'As%';

UPDATE healthcare_data2
SET Medical_Condition = 'Cancer'
WHERE Medical_Condition LIKE 'Can%';

UPDATE healthcare_data2
SET Medical_Condition = 'Hypertension'
WHERE Medical_Condition LIKE 'Hyper%';

SELECT DISTINCT Insurance_Provider
FROM healthcare_data2
ORDER BY 1;

UPDATE healthcare_data2
SET Insurance_Provider = 'Cigna'
WHERE Insurance_Provider LIKE 'Cig%';

SELECT DISTINCT Admission_Type
FROM healthcare_data2
ORDER BY 1;

UPDATE healthcare_data2
SET Admission_Type = 'Elective'
WHERE Admission_Type LIKE 'Elec%';

SELECT 
    STR_TO_DATE(Date_of_Admission, '%m/%d/%Y') AS Date_of_Admission, 
    STR_TO_DATE(Discharge_Date, '%m/%d/%Y') AS Discharge_Date
FROM healthcare_data2;

UPDATE healthcare_data2
SET 
    Date_of_Admission = STR_TO_DATE(Date_of_Admission, '%m/%d/%Y'),
    Discharge_Date = STR_TO_DATE(Discharge_Date, '%m/%d/%Y');
    
    
    ALTER TABLE healthcare_data2
    MODIFY COLUMN Date_of_Admission DATE,
    MODIFY COLUMN Discharge_Date DATE;

    
ALTER TABLE healthcare_data2
DROP COLUMN rn;










