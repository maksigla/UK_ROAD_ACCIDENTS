--  QUERY TO REPRESENT VEHICLES NUMBER OF ACCIDENTS FOR EACH MONTH IN 2015

WITH help AS (
  SELECT *
  FROM "Vehicles_2015" AS ve
  LEFT JOIN "vehicle_types"
  ON ve."Vehicle_Type" = vehicle_types."code"
),
	full_help AS (
	SELECT help.*, accidents."Normalised_Date"
	FROM help
	LEFT JOIN "Accidents_2015" as accidents
	ON help."Accident_Index" = accidents."Accident_Index"
)


SELECT label,
       EXTRACT(MONTH FROM "Normalised_Date") AS month,
       COUNT("Accident_Index") AS "cnt"
FROM full_help
GROUP BY label, month
ORDER BY label, month;
	
	