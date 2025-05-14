-- Create Project View (run third query only!!)

-- 1. Get the daily net revenue of orders for each customer
SELECT
	s.customerkey,
	s.orderdate,
	SUM(s.netprice * s.quantity * s.exchangerate) AS total_net_revenue
FROM sales s
GROUP BY 
	s.customerkey,
	s.orderdate

-- 2. Join with the customer table to get demographic data
SELECT 
	s.customerkey,
	s.orderdate,
	SUM(s.netprice * s.quantity * s.exchangerate) AS total_net_revenue,
	COUNT(s.orderkey ) AS order_count,
	c.countryfull,
	c.age,
	c.givenname,
	c.surname
FROM sales s
LEFT JOIN customer c ON s.customerkey  = c.customerkey 
GROUP BY 
	s.customerkey,
	s.orderdate,
	c.countryfull,
	c.age,
	c.givenname,
	c.surname

	-- 3. Build a query that calculates first purchase date and cohort year using window functions.
WITH customer_revenue AS (
	SELECT 
		s.customerkey,
		s.orderdate,
		SUM(s.netprice * s.quantity * s.exchangerate) AS total_net_revenue,
		COUNT(s.orderkey ) AS order_count,
		c.countryfull,
		c.age,
		c.givenname,
		c.surname
	FROM sales s
	LEFT JOIN customer c ON s.customerkey  = c.customerkey 
	GROUP BY 
		s.customerkey,
		s.orderdate,
		c.countryfull,
		c.age,
		c.givenname,
		c.surname
)

SELECT 
	cr.*,
	MIN(orderdate) OVER (PARTITION BY cr.customerkey) AS first_purchase_date,
	EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY cr.customerkey)) AS cohorty_year
FROM customer_revenue cr






