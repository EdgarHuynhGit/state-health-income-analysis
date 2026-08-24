SELECT
    MAX(CASE WHEN income_quartile = 4 THEN avg_diabetes_rate END)
    / MAX(CASE WHEN income_quartile = 1 THEN avg_diabetes_rate END) * 100 - 100
    AS diabetes_pct_increase,

    MAX(CASE WHEN income_quartile = 4 THEN avg_obesity_rate END)
    / MAX(CASE WHEN income_quartile = 1 THEN avg_obesity_rate END) * 100 - 100
    AS obesity_pct_increase,

    MAX(CASE WHEN income_quartile = 4 THEN avg_inactivity_rate END)
    / MAX(CASE WHEN income_quartile = 1 THEN avg_inactivity_rate END) * 100 - 100
    AS inactivity_pct_increase
FROM vw_HealthByIncomeQuartile
