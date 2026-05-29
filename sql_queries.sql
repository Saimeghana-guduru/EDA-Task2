create database hotel_db;
use hotel_db;
select * from hotel_bookings;

-- Query 1: Top Revenue Performing Months

SELECT 
    hotel,
    date_format(arrival_date_new,"%M") as mon,
    SUM(adr * (stay_length)) AS total_revenue
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY hotel, mon
ORDER BY hotel, 
    CASE mon
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3 
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6 
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9 
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END;
    
-- Query 2: The Cancellation Problem by Distribution Channel

SELECT 
    distribution_channel,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS canceled_bookings,
    ROUND(CAST(SUM(is_canceled) AS FLOAT) / COUNT(*) * 100, 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY distribution_channel
ORDER BY cancellation_rate_percentage DESC;

-- Query 3: Lead Time Impact on Cancellations

SELECT 
    is_canceled,
    AVG(lead_time) AS avg_lead_time_days,
    MIN(lead_time) AS min_lead_time,
    MAX(lead_time) AS max_lead_time
FROM hotel_bookings
GROUP BY is_canceled;

-- Query 4: Top 5 Guest Origin Countries

SELECT 
    country,
    COUNT(*) AS total_guests
FROM hotel_bookings
WHERE is_canceled = 0 AND country IS NOT NULL
GROUP BY country
ORDER BY total_guests DESC
LIMIT 5;

-- Query 5: Market Segment Behavior Analysis

SELECT 
    market_segment,
    ROUND(AVG(adr), 2) AS average_daily_rate,
    ROUND(AVG(stay_length), 2) AS avg_length_of_stay
FROM hotel_bookings
GROUP BY market_segment
ORDER BY average_daily_rate DESC;

-- Query 6: Repeated Guests vs. Cancellations

SELECT 
    is_repeated_guest,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS canceled_bookings,
    ROUND(CAST(SUM(is_canceled) AS FLOAT) / COUNT(*) * 100, 2) AS cancellation_rate_percentage
FROM hotel_bookings
GROUP BY is_repeated_guest;