-- Create view for income/health ranks

CREATE VIEW vw_StateHealthIncomeRanked AS

-- CTE for rankings
WITH ranks AS (
SELECT
    i.State,
    i.Median_income_dollars,
    d.state_diabetes_rate,
    d.state_inactivity_rate,
    d.state_obesity_rate,

    -- Rankings (lower rank = better outcome)
    RANK() OVER(ORDER BY Median_income_dollars DESC) AS income_rank,
    RANK() OVER(ORDER BY state_diabetes_rate ASC) AS diabetes_rank,
    RANK() OVER(ORDER BY state_inactivity_rate ASC) AS inactivity_rank,
    RANK() OVER(ORDER BY state_obesity_rate ASC) AS obesity_rank

FROM StateDiabetesClean d
JOIN MedianIncomeByState i
    ON d.State = i.State
)

-- Calcuate average health rankings
SELECT 
    *,

    -- Average of three ranks
    (diabetes_rank + inactivity_rank + obesity_rank) / 3.0 AS avg_health_rank,

    -- Difference between income and avg_health. Positive = outperforms vs income, Negative = underperforms
    income_rank - ((diabetes_rank + inactivity_rank + obesity_rank) / 3.0) AS income_vs_health,

    -- Create income ranking tiers
    NTILE(4) OVER(ORDER BY Median_income_dollars DESC) AS income_quartile

FROM ranks;