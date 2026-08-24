SELECT
    income_quartile,
    AVG(diabetes_gender_gap) AS avg_diabetes_gap,
    AVG(obesity_gender_gap) AS avg_obesity_gap,
    AVG(inactivity_gender_gap) AS avg_inactivity_gap
FROM vw_GenderDisparityByState
GROUP BY income_quartile
ORDER BY income_quartile
