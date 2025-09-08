CREATE DATABASE digital_wallet;
USE digital_wallet;
SELECT * FROM digital_wallet; 

	-- Total Transactions
    CREATE OR REPLACE VIEW total_transaction AS
SELECT
	COUNT(*) AS total_transactions
FROM digital_wallet; 

	-- Total Revenue from Transaction Fees 
    CREATE OR REPLACE VIEW total_revenue AS
SELECT 
	SUM(transaction_fee) AS total_revenue
FROM digital_wallet;

	-- Average Transaction values
    CREATE OR REPLACE VIEW average_transaction AS
SELECT 
	ROUND(AVG(transaction_fee),4) AS avg_transaction
FROM digital_wallet ;

	-- Active Distinct Users: Total number of Active Users
    CREATE OR REPLACE VIEW active_users AS
SELECT
	COUNT(DISTINCT user_id) AS active_users
FROM digital_wallet ;

	-- Monthly Active Users: Number of active users in each month
    CREATE OR REPLACE VIEW monthly_active_users AS
SELECT 
	`transaction month`,
    COUNT(DISTINCT user_id) AS active_users
FROM digital_wallet
GROUP BY `transaction month`
ORDER BY active_users DESC;

	-- New Vs Returning Users
    CREATE OR REPLACE VIEW new_vs_returning_users AS
WITH first_transaction AS (
	SELECT 
		  user_id,
          MIN(transaction_date) AS first_date
	FROM digital_wallet
    GROUP BY user_id
)
    SELECT 
		CASE
			WHEN dw.transaction_date = f.first_date 
            THEN 'New User'
            ELSE 'Returning User'
		END AS user_type,
        COUNT(DISTINCT dw.user_id) AS user_count,
        ROUND(SUM(transaction_fee), 3) AS total_revenue
   FROM digital_wallet dw
   JOIN first_transaction f 
	ON dw.user_id = f.user_id
  GROUP BY user_type ;
  
	-- Retention / Churn Percentage
    CREATE OR REPLACE VIEW retention_and_churn_percentage AS
WITH `transaction month` AS (
	SELECT 
		   user_id,
		   DATE_FORMAT(transaction_date, '%Y-%m') AS month
	FROM digital_wallet
    GROUP BY user_id, DATE_FORMAT(transaction_date, '%Y-%m')
),    
returning_users AS(
	SELECT
		  user_id
	FROM `transaction month`
    GROUP BY user_id
    HAVING COUNT(*) > 1
)
SELECT 
	  (COUNT(DISTINCT ru.user_id) / COUNT(DISTINCT tm.user_id)) * 100 AS retention_rate,
      100 - (COUNT(DISTINCT ru.user_id) / COUNT(DISTINCT tm.user_id)) * 100 AS churn_rate
FROM `transaction month` tm
LEFT JOIN returning_users ru
	ON tm.user_id = ru.user_id ;
								
	-- Total Transactions & Revenue gotten from Transaction Status
    CREATE OR REPLACE VIEW transaction_status_revenue AS 
SELECT 
	transaction_status,
    COUNT(*) AS total,
	ROUND(SUM(product_amount), 3)AS total_amount,
    ROUND(SUM(transaction_fee), 3) AS total_revenue
FROM digital_wallet
GROUP BY transaction_status ;

	-- Monthly Trend: What month have the highest revenue
    CREATE OR REPLACE VIEW monthly_revenue AS
SELECT
	`transaction month`,
    COUNT(`transaction month`) AS total_number,
    SUM(product_amount) AS total_amount,
    SUM(transaction_fee) AS total_revenue
FROM digital_wallet
GROUP BY `transaction month`
ORDER BY total_revenue DESC ;

	-- Payment Method Analysis: Which payment method drives the most revenue
    CREATE OR REPLACE VIEW payment_method_revenue AS
SELECT
	payment_method,
    COUNT(*) AS transaction_count,
    SUM(transaction_fee) AS total_revenue
FROM digital_wallet
GROUP BY payment_method
ORDER BY total_revenue DESC; 

	-- Top Product Category: Top 10 Products with the highest Revenue
    CREATE OR REPLACE VIEW product_revenue AS
SELECT 
	product_category,
    ROUND(SUM(transaction_fee), 4) AS product_revenue
FROM digital_wallet
GROUP BY product_category
ORDER BY product_revenue DESC
LIMIT 10;

	-- Merchant Performance Analysis: Top 10 merchants by Successful transaction value
    CREATE OR REPLACE VIEW top_10_merchants AS
SELECT 
    merchant_name,
    ROUND(SUM(product_amount),2) AS total_sales,
    ROUND(SUM(transaction_fee),2) AS revenue_generated
FROM digital_wallet
WHERE transaction_status = 'Successful'
GROUP BY merchant_name
ORDER BY revenue_generated DESC 
LIMIT 10 ;

	-- Device Type Analysis: Comparison between Web, IOS and Android across Payment Status
    CREATE OR REPLACE VIEW device_type_analysis AS
SELECT 
	device_type,
    SUM(
		CASE
        WHEN transaction_status = 'Successful'
        THEN 1 ELSE 0
        END) AS successful_transaction_status,
	SUM(
		CASE
        WHEN transaction_status = 'Failed'
        THEN 1 ELSE 0
        END) AS failed_transaction_status,
	SUM( 
		CASE
        WHEN transaction_status = 'Pending'
        THEN 1 ELSE 0
        END) AS pending_transaction_status,
	SUM(product_amount) AS total_amount,
    SUM(transaction_fee) AS total_revenue
FROM digital_wallet
GROUP BY device_type;

	-- Location Analysis: Which region contributes most to business
    CREATE OR REPLACE VIEW location_analysis AS
SELECT
	location,
    COUNT(*) AS total_transaction,
    ROUND(SUM(product_amount), 2) AS total_amount,
    ROUND(SUM(transaction_fee), 2) AS total_revenue
FROM digital_wallet
WHERE transaction_status = 'Successful'
GROUP BY location
ORDER BY total_revenue DESC ;

    -- Loyalty Points: Top 20 loyal customers
    CREATE OR REPLACE VIEW top_20_loyal_customers AS
SELECT
	merchant_name,
    SUM(product_amount) AS total_amount,
    SUM(loyalty_points) AS total_points
FROM digital_wallet
WHERE transaction_status = 'Successful'
GROUP BY merchant_name
ORDER BY total_points DESC 
LIMIT 20;

	-- Failure/Declined Transactions: Identifying weak points in the system
    CREATE OR REPLACE VIEW weak_points_payment_method AS
SELECT 
	payment_method,
    COUNT(*) AS total,
    SUM(
		CASE
			WHEN transaction_status = 'Failed'
            THEN 1 ELSE 0
            END) AS failed_transactions,
	ROUND(SUM(
			  CASE
				WHEN transaction_status = 'Failed' 
                THEN 1 ELSE 0
                END) / COUNT(*) * 100,2) AS failure_rate_percentage
FROM digital_wallet
GROUP BY payment_method
ORDER BY failure_rate_percentage DESC ;
 
	-- Churn / Retension Analysis (Cohort Style)
    -- List of users first transaction month
WITH first_transaction AS(
					SELECT
						user_id,
						merchant_name,
						MIN(`transaction month`) AS cohort_month
					FROM digital_wallet
                    WHERE transaction_status = 'Successful'
                    GROUP BY user_id, merchant_name )
SELECT * FROM first_transaction ;

	-- List of all months a user was active
SELECT
	DISTINCT user_id, merchant_name,
    `transaction month`
FROM digital_wallet
WHERE transaction_status = 'Successful';

WITH monthly_users AS (
	SELECT 
		user_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS month
	FROM digital_wallet
    GROUP BY user_id, DATE_FORMAT(transaction_date, '%Y-%m')
),
	month_pairs AS (
		SELECT 
			curr.month AS month,
            COUNT(DISTINCT curr.user_id) AS users_last_month,
            COUNT(DISTINCT next.user_id) AS users_retained
		FROM monthly_users curr
        LEFT JOIN monthly_users next
			ON curr.user_id = next.user_id
            AND DATE_ADD(STR_TO_DATE(CONCAT(curr.month, '-01'), '%Y-%m-%d'), INTERVAL 1 MONTH)
				= STR_TO_DATE(CONCAT(next.month, '-01'), '%Y-%m-%d')
		GROUP BY curr.month
)
	   SELECT 
			month,
            users_last_month,
            users_retained,
            ROUND((users_retained / users_last_month) * 100, 2) AS retention_rate,
            ROUND((1 - (users_retained / users_last_month)) * 100, 2) AS churn_rate
		FROM month_pairs
        ORDER BY month ;
        
	