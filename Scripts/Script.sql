-- netprice * quantity * exchangerate

WITH ltv AS (
	SELECT
		customerkey,
		SUM(netprice * quantity * exchangerate)::integer AS lifetime_value
	FROM sales s 
	GROUP BY customerkey 
	ORDER BY customerkey 
),
percentiles AS (
SELECT
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY lifetime_value) AS percentile_25th,
	PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY lifetime_value) AS percentile_50th,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY lifetime_value) AS percentile_75th
FROM ltv
)
SELECT
	customerkey,
	lifetime_value,
	CASE
		WHEN lifetime_value < percentile_25th THEN '1 - Low Value'
		WHEN lifetime_value BETWEEN percentile_25th AND percentile_50th THEN '2 - Mid Value'
		ELSE '3 - High Value'
	END
FROM ltv, percentiles