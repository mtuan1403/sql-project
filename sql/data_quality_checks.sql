-- 1) Trips where entry and exit station are the same
SELECT
    trip_id,
    card_id,
    travel_date,
    entry_station_id,
    exit_station_id
FROM trips
WHERE entry_station_id = exit_station_id;

-- 2) Trips with impossible fare values
SELECT
    trip_id,
    fare_paid
FROM trips
WHERE fare_paid < 0 OR fare_paid > 20;

-- 3) Cards that appear unused (potential inactivity)
SELECT
    c.card_id,
    c.user_id,
    c.balance
FROM opal_cards c
LEFT JOIN trips t ON t.card_id = c.card_id
WHERE t.trip_id IS NULL;

-- 4) Potentially suspicious high-frequency same-day usage
SELECT
    card_id,
    travel_date,
    COUNT(*) AS trips_per_day
FROM trips
GROUP BY card_id, travel_date
HAVING COUNT(*) >= 4
ORDER BY trips_per_day DESC, card_id, travel_date;
