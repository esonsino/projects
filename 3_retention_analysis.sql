
WITH customer_last_purchase AS (
	SELECT 
		customerkey,
		TRIM(CONCAT(givenname, ' ', surname)) AS cleaned_name,
		orderdate,
		ROW_NUMBER() OVER(PARTITION BY customerkey ORDER BY orderdate DESC) AS rownumber,
		first_purchase_date 
	FROM cohort_analysis ca 
),
churned_customers AS (
	SELECT
		customerkey,
		cleaned_name,
		orderdate AS last_purchase_date,
		CASE 
			WHEN orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN  'Churned'
			ELSE 'Active'
	 	END AS customer_status
	FROM customer_last_purchase
	WHERE rownumber = 1
	AND first_purchase_date  < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
)

SELECT 
	customer_status,
	COUNT(customerkey) AS customer_count,
	SUM(COUNT(customerkey)) OVER() AS total_customers,
	ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER(), 2) AS status_percentage
FROM churned_customers
GROUP BY customer_status 

