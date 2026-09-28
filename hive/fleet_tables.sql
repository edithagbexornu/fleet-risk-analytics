-- ============================================================
-- Fleet Risk Analytics
-- Hive Data Definition & Transformation Script
-- ============================================================
-- Purpose:
-- Create and transform fleet telematics, mileage, and fuel data
-- for downstream driver risk analysis.
-- ============================================================


-- ------------------------------------------------------------
-- 1. GEOLOCATION TABLE
-- Stores driver events and geographic information
-- ------------------------------------------------------------

CREATE TABLE geolocation (
    truckid STRING,
    driverid STRING,
    event STRING,
    latitude DOUBLE,
    longitude DOUBLE,
    city STRING,
    state STRING,
    velocity BIGINT,
    event_ind BIGINT,
    idling_ind BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");


-- ------------------------------------------------------------
-- 2. TRUCKS TABLE
-- Historical mileage and fuel consumption by truck/driver
-- ------------------------------------------------------------

CREATE TABLE trucks (
    driverid STRING,
    truckid STRING,
    model STRING,

    jun13_miles BIGINT, jun13_gas BIGINT,
    may13_miles BIGINT, may13_gas BIGINT,
    apr13_miles BIGINT, apr13_gas BIGINT,
    mar13_miles BIGINT, mar13_gas BIGINT,
    feb13_miles BIGINT, feb13_gas BIGINT,
    jan13_miles BIGINT, jan13_gas BIGINT,

    dec12_miles BIGINT, dec12_gas BIGINT,
    nov12_miles BIGINT, nov12_gas BIGINT,
    oct12_miles BIGINT, oct12_gas BIGINT,
    sep12_miles BIGINT, sep12_gas BIGINT,
    aug12_miles BIGINT, aug12_gas BIGINT,
    jul12_miles BIGINT, jul12_gas BIGINT,
    jun12_miles BIGINT, jun12_gas BIGINT,
    may12_miles BIGINT, may12_gas BIGINT,
    apr12_miles BIGINT, apr12_gas BIGINT,
    mar12_miles BIGINT, mar12_gas BIGINT,
    feb12_miles BIGINT, feb12_gas BIGINT,
    jan12_miles BIGINT, jan12_gas BIGINT,

    dec11_miles BIGINT, dec11_gas BIGINT,
    nov11_miles BIGINT, nov11_gas BIGINT,
    oct11_miles BIGINT, oct11_gas BIGINT,
    sep11_miles BIGINT, sep11_gas BIGINT,
    aug11_miles BIGINT, aug11_gas BIGINT,
    jul11_miles BIGINT, jul11_gas BIGINT,
    jun11_miles BIGINT, jun11_gas BIGINT,
    may11_miles BIGINT, may11_gas BIGINT,
    apr11_miles BIGINT, apr11_gas BIGINT,
    mar11_miles BIGINT, mar11_gas BIGINT,
    feb11_miles BIGINT, feb11_gas BIGINT,
    jan11_miles BIGINT, jan11_gas BIGINT,

    dec10_miles BIGINT, dec10_gas BIGINT,
    nov10_miles BIGINT, nov10_gas BIGINT,
    oct10_miles BIGINT, oct10_gas BIGINT,
    sep10_miles BIGINT, sep10_gas BIGINT,
    aug10_miles BIGINT, aug10_gas BIGINT,
    jul10_miles BIGINT, jul10_gas BIGINT,
    jun10_miles BIGINT, jun10_gas BIGINT,
    may10_miles BIGINT, may10_gas BIGINT,
    apr10_miles BIGINT, apr10_gas BIGINT,
    mar10_miles BIGINT, mar10_gas BIGINT,
    feb10_miles BIGINT, feb10_gas BIGINT,
    jan10_miles BIGINT, jan10_gas BIGINT,

    dec09_miles BIGINT, dec09_gas BIGINT,
    nov09_miles BIGINT, nov09_gas BIGINT,
    oct09_miles BIGINT, oct09_gas BIGINT,
    sep09_miles BIGINT, sep09_gas BIGINT,
    aug09_miles BIGINT, aug09_gas BIGINT,
    jul09_miles BIGINT, jul09_gas BIGINT,
    jun09_miles BIGINT, jun09_gas BIGINT,
    may09_miles BIGINT, may09_gas BIGINT,
    apr09_miles BIGINT, apr09_gas BIGINT,
    mar09_miles BIGINT, mar09_gas BIGINT,
    feb09_miles BIGINT, feb09_gas BIGINT,
    jan09_miles BIGINT, jan09_gas BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");


-- ------------------------------------------------------------
-- 3. TRANSFORM MONTHLY TRUCK DATA
-- Convert wide monthly mileage/gas columns into a longitudinal
-- structure and calculate MPG.
-- ------------------------------------------------------------

CREATE TABLE truck_mileage AS
SELECT
    truckid,
    driverid,
    rdate,
    miles,
    gas,
    miles / gas AS mpg
FROM trucks
LATERAL VIEW stack(
    54,

    'jun13', jun13_miles, jun13_gas,
    'may13', may13_miles, may13_gas,
    'apr13', apr13_miles, apr13_gas,
    'mar13', mar13_miles, mar13_gas,
    'feb13', feb13_miles, feb13_gas,
    'jan13', jan13_miles, jan13_gas,

    'dec12', dec12_miles, dec12_gas,
    'nov12', nov12_miles, nov12_gas,
    'oct12', oct12_miles, oct12_gas,
    'sep12', sep12_miles, sep12_gas,
    'aug12', aug12_miles, aug12_gas,
    'jul12', jul12_miles, jul12_gas,
    'jun12', jun12_miles, jun12_gas,
    'may12', may12_miles, may12_gas,
    'apr12', apr12_miles, apr12_gas,
    'mar12', mar12_miles, mar12_gas,
    'feb12', feb12_miles, feb12_gas,
    'jan12', jan12_miles, jan12_gas,

    'dec11', dec11_miles, dec11_gas,
    'nov11', nov11_miles, nov11_gas,
    'oct11', oct11_miles, oct11_gas,
    'sep11', sep11_miles, sep11_gas,
    'aug11', aug11_miles, aug11_gas,
    'jul11', jul11_miles, jul11_gas,
    'jun11', jun11_miles, jun11_gas,
    'may11', may11_miles, may11_gas,
    'apr11', apr11_miles, apr11_gas,
    'mar11', mar11_miles, mar11_gas,
    'feb11', feb11_miles, feb11_gas,
    'jan11', jan11_miles, jan11_gas,

    'dec10', dec10_miles, dec10_gas,
    'nov10', nov10_miles, nov10_gas,
    'oct10', oct10_miles, oct10_gas,
    'sep10', sep10_miles, sep10_gas,
    'aug10', aug10_miles, aug10_gas,
    'jul10', jul10_miles, jul10_gas,
    'jun10', jun10_miles, jun10_gas,
    'may10', may10_miles, may10_gas,
    'apr10', apr10_miles, apr10_gas,
    'mar10', mar10_miles, mar10_gas,
    'feb10', feb10_miles, feb10_gas,
    'jan10', jan10_miles, jan10_gas,

    'dec09', dec09_miles, dec09_gas,
    'nov09', nov09_miles, nov09_gas,
    'oct09', oct09_miles, oct09_gas,
    'sep09', sep09_miles, sep09_gas,
    'aug09', aug09_miles, aug09_gas,
    'jul09', jul09_miles, jul09_gas,
    'jun09', jun09_miles, jun09_gas,
    'may09', may09_miles, may09_gas,
    'apr09', apr09_miles, apr09_gas,
    'mar09', mar09_miles, mar09_gas,
    'feb09', feb09_miles, feb09_gas,
    'jan09', jan09_miles, jan09_gas

) truck_data AS rdate, miles, gas;


-- ------------------------------------------------------------
-- 4. AVERAGE MPG BY TRUCK
-- ------------------------------------------------------------

CREATE TABLE avg_mileage AS
SELECT
    truckid,
    AVG(mpg) AS avgmpg
FROM truck_mileage
GROUP BY truckid;


-- ------------------------------------------------------------
-- 5. TOTAL MILEAGE BY DRIVER
-- Used to normalize unsafe driving events by exposure
-- ------------------------------------------------------------

CREATE TABLE drivermileage AS
SELECT
    driverid,
    SUM(miles) AS totmiles
FROM truck_mileage
GROUP BY driverid;


-- ------------------------------------------------------------
-- 6. TRUCK MILEAGE/GAS TABLE
-- ------------------------------------------------------------

CREATE TABLE trucks_mg (
    driverid STRING,
    truckid STRING,
    model STRING,
    tdate STRING,
    miles BIGINT,
    gas BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");


-- ------------------------------------------------------------
-- 7. RISK FACTOR OUTPUT TABLE
-- Populated by the Apache Pig risk analysis pipeline.
-- ------------------------------------------------------------

CREATE TABLE riskfactor (
    driverid STRING,
    events BIGINT,
    totmiles BIGINT,
    riskfactor FLOAT
);
