-- Number of accidents grouped by sex and speed limit

WITH speed_limit AS (
    SELECT 
        "Accident_Index",
        "Speed_limit"
    FROM "Accidents_2015"
),
sex AS (
    SELECT 
        "Accident_Index",
        "Sex_of_Driver"
    FROM "Vehicles_2015"
)

SELECT 
    COUNT("Accident_Index"),
    CASE WHEN "Sex_of_Driver" = 1 THEN 'Male'
		 WHEN "Sex_of_Driver" = 2 THEN 'Female'
		 ELSE 'Non-binary' END AS sex,
    "Speed_limit" AS limit
FROM speed_limit
LEFT JOIN sex USING ("Accident_Index")
GROUP BY "Sex_of_Driver", "Speed_limit"
ORDER BY "Sex_of_Driver", "Speed_limit";
