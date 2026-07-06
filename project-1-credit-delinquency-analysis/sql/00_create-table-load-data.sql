-- =========================================================================
-- CREATE TABLE AND LOAD DATA
-- =========================================================================
-- create a table to import the raw data into

-- monthly_income and num_dependents created as TEXT... 
-- ...field due to string literal 'NA' as placeholder for NULL
-- =========================================================================

CREATE TABLE IF NOT EXISTS credit_data 
(
	row_id INTEGER,
	serious_dlq_in_2_yrs INTEGER,
	revolving_utilization NUMERIC,
	age INTEGER,
	num_times_30to59_days_late INTEGER,
	debt_ratio NUMERIC,
	monthly_income TEXT,
	num_open_credit_lines_and_loans INTEGER,
	num_times_90ormore_days_late INTEGER,
	num_real_estate_lines_or_loans INTEGER,
	num_times_60to89_days_late INTEGER,
	num_dependents TEXT
);