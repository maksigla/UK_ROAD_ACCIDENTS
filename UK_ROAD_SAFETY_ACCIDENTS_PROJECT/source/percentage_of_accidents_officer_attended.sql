-- The percentage of accidents where a police officer attended the scene 

WITH v_types AS (
	SELECT 
		"Accident_Index", 
		"label"
	FROM "Vehicles_2015" as v
	LEFT JOIN "vehicle_types" as v_types
		ON v."Vehicle_Type" = v_types."code"
)

SELECT 
	"label",	
	COUNT(*) as total_accidents,
	SUM(CASE WHEN "Did_Police_Officer_Attend_Scene_of_Accident" = 1 THEN 1 ELSE 0 END) AS attended_by_police,
	ROUND((SUM(CASE WHEN "Did_Police_Officer_Attend_Scene_of_Accident" = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS percentage_attended
FROM v_types
LEFT JOIN "Accidents_2015" as accidents
	ON accidents."Accident_Index" = v_types."Accident_Index"
GROUP BY
	"label"
ORDER BY 
	"percentage_attended" DESC;