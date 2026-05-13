-- Categorize customers based on their total lifetime value (LTV).
-- Assign customers to High, Mid, and Low-value groups using CASE WHEN.

-- 1. Get each customers lifetime value (total revenue: quantity * netprice * exchangerate)
WITH customer_ltv AS (
	SELECT 
		customerkey,
		SUM(total_net_revenue) AS total_ltv
	FROM cohort_analysis ca 	
	GROUP BY 
		customerkey, givenname, surname
),
-- 2. Get the 3 percentiles of the lifetime value (25-50-75). This will help me to segment the customers
customer_segments AS (
	SELECT 
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS ltv_25th_percentile,
		PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_ltv) AS ltv_50th_percentile,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS ltv_75th_percentile
	FROM customer_ltv
),
-- 3. Using the percentiles and CASE WHEN, we can segment the customers into Low, Med, High value groups.
segment_values AS (
	SELECT
		customerkey,
		total_ltv,
	CASE 
		WHEN total_ltv < ltv_25th_percentile THEN '1 - Low Value'
		WHEN total_ltv BETWEEN ltv_25th_percentile AND ltv_75th_percentile THEN '2 - Mid Value'
		ELSE '3 - High Value'
	END AS customer_segment
	FROM customer_ltv, customer_segments 
)
-- 4. Get the total revenue for each customer segment
SELECT 
	customer_segment,
	SUM(total_ltv)::int AS total_ltv,
	COUNT(customerkey) AS customer_count,
	SUM(total_ltv)::int / COUNT(customerkey)::int AS avg_ltv
FROM segment_values
GROUP BY customer_segment
ORDER BY customer_segment

/*
customer_segment	total_ltv	customer_count	avg_ltv
1 - Low Value	    4,341,810	        12,372	    350
2 - Mid Value	   66,636,452	        24,743	  2,693
3 - High Value	  135,429,277	        12,372	 10,946
/*
