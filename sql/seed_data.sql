INSERT INTO user_roles (user_role_id, role_name, is_admin) VALUES
(1, 'Traveler', 0),
(2, 'Employee', 0),
(3, 'Admin', 1);

INSERT INTO users (user_id, first_name, last_name, user_role_id) VALUES
(1, 'Bob', 'Sanderson', 1),
(2, 'Darren', 'Erikson', 1),
(3, 'Helene', 'Yung', 2),
(4, 'Chirri', 'Parsons', 3);

INSERT INTO card_types (card_type_id, type_name, fare_multiplier) VALUES
(1, 'Adult', 1.0),
(2, 'Child/Youth', 0.5),
(3, 'Concession', 0.5),
(4, 'Employee', 0.0);

INSERT INTO opal_cards (card_id, card_type_id, user_id, balance) VALUES
(1, 1, 1, 100.00),
(2, 2, 1, 20.00),
(3, 3, 2, 30.00),
(4, 1, 2, 500.00),
(5, 4, 3, 15.00);

INSERT INTO station_types (station_type_id, station_type_name) VALUES
(1, 'Train'),
(2, 'Metro'),
(3, 'Bus');

INSERT INTO stations (station_id, station_name, station_type_id) VALUES
(1, 'Strathfield', 1),
(2, 'Redfern', 1),
(3, 'Central', 1),
(4, 'Circular Quay', 2),
(5, 'Town Hall', 1);

INSERT INTO trips (
    trip_id, card_id, travel_date, entry_station_id, exit_station_id, trip_start_time, fare_paid
) VALUES
(1, 1, '2023-02-19', 1, 2, '10:00:00', 4.10),
(2, 1, '2023-02-26', 1, 2, '10:05:00', 4.10),
(3, 1, '2023-03-10', 2, 1, '19:00:00', 4.10),
(4, 3, '2023-03-19', 1, 3, '07:00:00', 2.05),
(5, 3, '2023-04-19', 1, 3, '07:00:00', 2.05),
(6, 4, '2023-05-02', 3, 5, '09:10:00', 3.80),
(7, 5, '2023-05-03', 5, 4, '08:30:00', 0.00),
(8, 1, '2023-05-10', 1, 4, '11:00:00', 5.30);
