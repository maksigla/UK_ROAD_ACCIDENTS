
/* NORMALIZE DATA */

-- Add a flag column to indicate if the update has been done
ALTER TABLE "Accidents_2015" ADD COLUMN IF NOT EXISTS update_completed boolean DEFAULT false,
ADD COLUMN IF NOT EXISTS "Normalised_Date" date,
ADD COLUMN IF NOT EXISTS "Normalised_Time" time;
-- Update the "Normalized_Date" column only if the update_completed flag is false
UPDATE "Accidents_2015"
SET "Normalised_Date" = TO_DATE("Date", 'DD/MM/YYYY'),
    "Normalised_Time" = CAST(SUBSTRING("Time" FROM 1 FOR 2) || ':' || SUBSTRING("Time" FROM 4 FOR 2) AS TIME)
WHERE update_completed = false;

-- Set the flag to true after the update is done
UPDATE "Accidents_2015"
SET update_completed = true;

SELECT "Date", "Normalised_Date", "Time", "Normalised_Time" FROM "Accidents_2015";

-- Normalise sex data
UPDATE "Vehicles_2015"
SET "Sex_of_Driver" = 
    CASE 
        WHEN "Sex_of_Driver" NOT IN (1, 2) THEN 3
        ELSE "Sex_of_Driver"
    END;
