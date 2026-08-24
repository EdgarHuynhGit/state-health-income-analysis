CREATE VIEW vw_HealthByIncomeQuartile AS

SELECT
    income_quartile,

    COUNT(*) AS state_count,

    AVG(Median_income_dollars) AS avg_income,
    AVG(state_diabetes_rate) AS avg_diabetes_rate,
    AVG(state_obesity_rate) AS avg_obesity_rate,
    AVG(state_inactivity_rate) AS avg_inactivity_rate

FROM vw_StateHealthIncomeRanked
GROUP BY income_quartile;
