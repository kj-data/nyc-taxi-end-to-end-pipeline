-- Business rule: A trip with a positive fare and non-zero distance
-- should have a pickup time earlier than its dropoff time.

SELECT *
FROM {{ ref('fct_trips') }} AS fct
WHERE fct.pickup_datetime >= fct.dropoff_datetime
  AND fct.fare_amount > 0
  AND fct.trip_distance != 0