USE airtraffic;

SELECT AirlineName, CancellationReason, 100 * COUNT(*) / (SELECT COUNT(*)
								  FROM flights
								 WHERE AirlineName = f.AirlineName) AS c
  FROM flights AS f
 WHERE cancelled = 1
 GROUP BY AirlineName, CancellationReason;
 
 
 
 SELECT COUNT(*)
   FROM flights
  WHERE AirlineName = 'American Airlines Inc.';
  
  SELECT COUNT(*)
   FROM flights
  WHERE AirlineName = 'American Airlines Inc.' AND CancellationReason = 'Weather';
  