SELECT TOP 5 State, Median_income_dollars, income_rank, avg_health_rank, income_vs_health
FROM vw_StateHealthIncomeRanked
ORDER BY income_vs_health ASC

SELECT TOP 5 State, Median_income_dollars, income_rank, avg_health_rank, income_vs_health
FROM vw_StateHealthIncomeRanked
ORDER BY income_vs_health DESC
