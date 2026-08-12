-- Housing Market Relational Database
-- PostgreSQL schema

CREATE TABLE location_id (
    state_id INTEGER PRIMARY KEY,
    state VARCHAR(100),
    abbreviation VARCHAR(10),
    region_id VARCHAR(50)
);

CREATE TABLE material_costs_index (
    date_id INTEGER PRIMARY KEY,
    month DATE,
    concrete FLOAT,
    steel FLOAT,
    copper FLOAT,
    lumber FLOAT
);

CREATE TABLE mortgage_rates (
    date_id INTEGER PRIMARY KEY,
    month DATE,
    thirty_year_frm FLOAT,
    thirty_year_fees FLOAT,
    fifteen_year_frm FLOAT,
    fifteen_year_fees FLOAT,
    five_one_arm FLOAT,
    five_one_arm_fees FLOAT,
    five_one_arm_margin FLOAT,
    thirty_yr_to_five_one_arm_spread FLOAT
);

CREATE TABLE bank_failures_by_state (
    id INTEGER PRIMARY KEY,
    state_id INTEGER,
    fail_year INTEGER,
    fails_by_state INTEGER,
    cost_per_year FLOAT,

    FOREIGN KEY (state_id)
        REFERENCES location_id(state_id)
);

CREATE TABLE housing_price_index (
    hpi_key INTEGER PRIMARY KEY,
    date_id INTEGER,
    month DATE,
    place_id VARCHAR(50),
    place_name VARCHAR(225),
    index_nsa FLOAT,
    index_sa FLOAT,
    hpi_type VARCHAR(100),
    hpi_flavor VARCHAR(100),
    level VARCHAR(100),
    year INTEGER
);
