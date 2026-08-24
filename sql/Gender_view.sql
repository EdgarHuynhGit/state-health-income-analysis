--rank states based on male vs female outcomes
CREATE VIEW vw_GenderDisparirtyByState AS

SELECT 
	d.State,
	i.Median_income_dollars,

	male_diabetes_rate,
	female_diabetes_rate,
	male_inactivity_rate,
	female_inactivity_rate,
	male_obesity_rate,
	female_obesity_rate,
	
	--gender disparity analysis, if positive, men are more affected by the given ailment, if negative, women are
	male_diabetes_rate - female_diabetes_rate AS diabetes_gender_gap,
	male_inactivity_rate - female_inactivity_rate AS inactivity_gender_gap,
	male_obesity_rate - female_obesity_rate AS obesity_gender_gap,

	--income quartile
	NTILE(4) OVER(ORDER BY i.Median_income_dollars DESC) AS income_quartile

FROM StateDiabetesClean d
JOIN MedianIncomeByState i
ON d.State = i.State
