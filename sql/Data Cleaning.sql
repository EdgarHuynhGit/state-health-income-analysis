-- Aggregate to State level

WITH StateAggregated AS (
    SELECT
        State,

        -- Diabetes counts
        SUM(num_men_diabetes) AS total_men_diabetes,
        SUM(num_women_diabetes) AS total_women_diabetes,

        -- Obesity counts
        SUM(num_men_obese) AS total_men_obese,
        SUM(num_women_obese) AS total_women_obese,

        -- Inactivity counts
        SUM(num_men_inactive_leisure) AS total_men_inactive,
        SUM(num_women_inactive_leisure) AS total_women_inactive,

        -- Back-calculate populations
        SUM(ROUND(num_men_diabetes / (percent_men_diabetes / 100.0), 0)) AS male_population,
        SUM(ROUND(num_women_diabetes / (percent_women_diabetes / 100.0), 0)) AS female_population

    FROM StateDiabetesRaw
    GROUP BY State
)
SELECT
    State,

    total_men_diabetes,
    total_women_diabetes,
    total_men_diabetes + total_women_diabetes AS total_diabetes_cases,

    total_men_obese,
    total_women_obese,
    total_men_obese + total_women_obese AS total_obese_cases,

    total_men_inactive,
    total_women_inactive,
    total_men_inactive + total_women_inactive AS total_inactive_cases,

    male_population,
    female_population,
    male_population + female_population AS total_population,

    -- Diabetes rates
    ROUND(total_men_diabetes * 100.0 / male_population, 2) AS male_diabetes_rate,
    ROUND(total_women_diabetes * 100.0 / female_population, 2) AS female_diabetes_rate,
    ROUND((total_men_diabetes + total_women_diabetes) * 100.0 / 
        (male_population + female_population), 2) AS state_diabetes_rate,

    -- Obesity rates
    ROUND(total_men_obese * 100.0 / male_population, 2) AS male_obesity_rate,
    ROUND(total_women_obese * 100.0 / female_population, 2) AS female_obesity_rate,
    ROUND((total_men_obese + total_women_obese) * 100.0 / 
        (male_population + female_population), 2) AS state_obesity_rate,

    -- Inactivity rates
    ROUND(total_men_inactive * 100.0 / male_population, 2) AS male_inactivity_rate,
    ROUND(total_women_inactive * 100.0 / female_population, 2) AS female_inactivity_rate,
    ROUND((total_men_inactive + total_women_inactive) * 100.0 /
        (male_population + female_population), 2) AS state_inactivity_rate

INTO StateDiabetesClean
FROM StateAggregated
ORDER BY State ASC

SELECT *
FROM StateDiabetesRaw
