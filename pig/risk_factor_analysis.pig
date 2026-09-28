-- ============================================================
-- Fleet Risk Analytics
-- Apache Pig Driver Risk Factor Analysis
-- ============================================================
-- Purpose:
-- Identify unsafe driving events, aggregate them by driver,
-- combine event counts with total mileage, and calculate a
-- normalized risk factor per 1,000,000 miles driven.
-- ============================================================


-- Load fleet geolocation/event data from Hive
geolocation_data =
    LOAD 'geolocation'
    USING org.apache.hive.hcatalog.pig.HCatLoader();


-- Retain only unsafe/non-normal driving events
unsafe_events =
    FILTER geolocation_data BY event != 'normal';


-- Create one occurrence for each unsafe event
event_occurrences =
    FOREACH unsafe_events
    GENERATE driverid,
             event,
             (int) 1 AS occurrence;


-- Group unsafe events by driver
events_by_driver =
    GROUP event_occurrences BY driverid;


-- Calculate total unsafe events for each driver
driver_event_totals =
    FOREACH events_by_driver
    GENERATE group AS driverid,
             SUM(event_occurrences.occurrence) AS total_events;


-- Load total driver mileage generated in Hive
driver_mileage =
    LOAD 'drivermileage'
    USING org.apache.hive.hcatalog.pig.HCatLoader();


-- Join unsafe-event totals with total mileage
driver_risk_data =
    JOIN driver_event_totals BY driverid,
         driver_mileage BY driverid;


-- Calculate normalized risk factor per 1,000,000 miles
final_data =
    FOREACH driver_risk_data
    GENERATE
        $0 AS driverid,
        $1 AS events,
        $3 AS total_miles,
        (float)$1 / $3 * 1000000 AS risk_factor;


-- Store results in the Hive riskfactor table
STORE final_data
    INTO 'riskfactor'
    USING org.apache.hive.hcatalog.pig.HCatStorer();
