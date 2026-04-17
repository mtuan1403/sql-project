-- 1) Trip volume by user
SELECT
    u.user_id,
    u.first_name || ' ' || u.last_name AS full_name,
    COUNT(t.trip_id) AS trip_count,
    ROUND(SUM(t.fare_paid), 2) AS total_fare_paid
FROM users u
JOIN opal_cards c ON c.user_id = u.user_id
JOIN trips t ON t.card_id = c.card_id
GROUP BY u.user_id, full_name
ORDER BY trip_count DESC, total_fare_paid DESC;

-- 2) Monthly fare trend
SELECT
    SUBSTR(travel_date, 1, 7) AS year_month,
    COUNT(*) AS trips,
    ROUND(SUM(fare_paid), 2) AS revenue
FROM trips
GROUP BY SUBSTR(travel_date, 1, 7)
ORDER BY year_month;

-- 3) Most used entry stations
SELECT
    s.station_name,
    COUNT(*) AS entries
FROM trips t
JOIN stations s ON s.station_id = t.entry_station_id
GROUP BY s.station_name
ORDER BY entries DESC, s.station_name;

-- 4) Window function example: user spend ranking
WITH user_spend AS (
    SELECT
        u.user_id,
        u.first_name || ' ' || u.last_name AS full_name,
        SUM(t.fare_paid) AS total_spend
    FROM users u
    JOIN opal_cards c ON c.user_id = u.user_id
    JOIN trips t ON t.card_id = c.card_id
    GROUP BY u.user_id, full_name
)
SELECT
    user_id,
    full_name,
    ROUND(total_spend, 2) AS total_spend,
    RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
FROM user_spend
ORDER BY spend_rank, user_id;
