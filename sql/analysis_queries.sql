-- Housing Market Relational Database
-- Example analytical queries


-- ============================================================
-- Single-table queries
-- ============================================================


-- Average non-seasonally adjusted HPI by year
SELECT
    year,
    AVG(index_nsa) AS avg_hpi
FROM housing_price_index
GROUP BY year
ORDER BY year;


-- Highest and lowest observed mortgage rates
SELECT
    MAX(thirty_year_frm) AS max_30yr,
    MIN(thirty_year_frm) AS min_30yr,
    MAX(fifteen_year_frm) AS max_15yr,
    MIN(fifteen_year_frm) AS min_15yr
FROM mortgage_rates;


-- State with the most bank failures in 2009
SELECT
    state_id,
    fails_by_state
FROM bank_failures_by_state
WHERE fail_year = 2009
ORDER BY fails_by_state DESC
LIMIT 1;


-- Maximum observed construction material indexes
SELECT
    MAX(concrete) AS max_concrete,
    MAX(steel) AS max_steel,
    MAX(copper) AS max_copper,
    MAX(lumber) AS max_lumber
FROM material_costs_index;



-- ============================================================
-- Cross-table queries
-- ============================================================


-- Mortgage rates during the month when
-- the concrete cost index was lowest
SELECT
    m.month,
    m.thirty_year_frm,
    m.fifteen_year_frm,
    c.concrete
FROM mortgage_rates AS m
JOIN material_costs_index AS c
    ON m.date_id = c.date_id
ORDER BY c.concrete ASC
LIMIT 1;


-- Bank failures in states belonging to the Census division
-- with the lowest non-seasonally adjusted HPI in 2009
SELECT
    b.state_id,
    l.state,
    b.fails_by_state,
    h.place_name,
    h.index_nsa
FROM bank_failures_by_state AS b
JOIN location_id AS l
    ON b.state_id = l.state_id
JOIN housing_price_index AS h
    ON l.region_id = h.place_id
WHERE b.fail_year = 2009
  AND h.year = 2009
  AND h.index_nsa = (
      SELECT MIN(index_nsa)
      FROM housing_price_index
      WHERE year = 2009
  );


-- Mortgage rates during the month with the
-- highest seasonally adjusted HPI
SELECT
    m.month,
    m.thirty_year_frm,
    m.fifteen_year_frm,
    h.index_sa
FROM mortgage_rates AS m
JOIN housing_price_index AS h
    ON m.date_id = h.date_id
ORDER BY h.index_sa DESC
LIMIT 1;


-- Average construction-material index during the month
-- with the highest seasonally adjusted HPI
SELECT
    c.month,
    (
        c.concrete +
        c.steel +
        c.copper +
        c.lumber
    ) / 4.0 AS avg_material_index,
    h.index_sa
FROM material_costs_index AS c
JOIN housing_price_index AS h
    ON c.date_id = h.date_id
ORDER BY h.index_sa DESC
LIMIT 1;
