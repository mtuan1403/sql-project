PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS opal_cards;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS stations;
DROP TABLE IF EXISTS station_types;
DROP TABLE IF EXISTS card_types;

CREATE TABLE user_roles (
    user_role_id INTEGER PRIMARY KEY,
    role_name TEXT NOT NULL,
    is_admin INTEGER NOT NULL CHECK (is_admin IN (0, 1))
);

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    user_role_id INTEGER NOT NULL,
    FOREIGN KEY (user_role_id) REFERENCES user_roles(user_role_id)
);

CREATE TABLE card_types (
    card_type_id INTEGER PRIMARY KEY,
    type_name TEXT NOT NULL,
    fare_multiplier REAL NOT NULL
);

CREATE TABLE opal_cards (
    card_id INTEGER PRIMARY KEY,
    card_type_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    balance REAL NOT NULL CHECK (balance >= 0),
    FOREIGN KEY (card_type_id) REFERENCES card_types(card_type_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE station_types (
    station_type_id INTEGER PRIMARY KEY,
    station_type_name TEXT NOT NULL
);

CREATE TABLE stations (
    station_id INTEGER PRIMARY KEY,
    station_name TEXT NOT NULL,
    station_type_id INTEGER NOT NULL,
    FOREIGN KEY (station_type_id) REFERENCES station_types(station_type_id)
);

CREATE TABLE trips (
    trip_id INTEGER PRIMARY KEY,
    card_id INTEGER NOT NULL,
    travel_date TEXT NOT NULL,
    entry_station_id INTEGER NOT NULL,
    exit_station_id INTEGER NOT NULL,
    trip_start_time TEXT NOT NULL,
    fare_paid REAL NOT NULL CHECK (fare_paid >= 0),
    FOREIGN KEY (card_id) REFERENCES opal_cards(card_id),
    FOREIGN KEY (entry_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (exit_station_id) REFERENCES stations(station_id)
);
