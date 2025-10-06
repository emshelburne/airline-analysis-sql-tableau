USE airtraffic;

/*
Question 1:
The managers of the BrainStation Mutual Fund want to know some basic details about the data. 
Use fully commented SQL queries to address each of the following questions:

a. How many flights were there in 2018 and 2019 separately?
*/
SELECT YEAR(FlightDate) AS year_, COUNT(*) AS total_number_flights
  FROM flights
 GROUP BY year_
 ORDER BY year_;

-- 3218653 flights in 2018
-- 3302708 flights in 2019


/*
b. In total, how many flights were cancelled or departed late over both years?
*/

-- in order to compute the percentage of flights that depart late or are cancelled, we first count the total number of flights
SELECT COUNT(*) AS flight_count
  FROM flights;
-- total number of flights is 6521361

SELECT 
	   CASE -- we determine whether each flight was cancelled or departed late
	      WHEN cancelled = 1 THEN 'cancelled'
          WHEN DepDelay > 0 THEN 'late departure'
	   END AS status_, 
       COUNT(*) AS number_flights, ROUND((COUNT(*)/6521361)*100,2) AS percent_of_all_flights -- we use the total number of flights 6521361 from the last query
  FROM flights
 WHERE cancelled = 1 OR DepDelay > 0
 GROUP BY status_
 
 UNION ALL  -- we union the first table to a second table (having the same column types) so that we can also consider all flights that were either delayed or cancelled
 
 SELECT 'late or cancelled', COUNT(*) AS number_flights, ROUND((COUNT(*)/6521361)*100,2) AS percent_of_all_flights
   FROM flights
  WHERE cancelled = 1 OR DepDelay > 0;
 
 -- 2540874 late, 92363 cancelled, 2633237 delayed or cancelled
 
/*
c. Show the number of flights that were cancelled broken down by the reason for cancellation.
*/
SELECT CancellationReason AS reason_cancelled, COUNT(*) AS number_flights, ROUND((COUNT(*)/6521361)*100,2) AS percent_of_all_flights -- we use the total number of flights 6521361 from the last query
  FROM flights
 WHERE cancelled = 1
 GROUP BY reason_cancelled
 ORDER BY number_flights;

/*
 Reason Cancelled			Number of Flights   Percent of All Flights
	Security					   35				0.00
	National Air System			 7962				0.12
	Carrier						34141				0.52
	Weather						50225				0.77
*/


/*
d. For each month in 2019, report both the total number of flights and percentage of flights cancelled. 
*/

WITH  -- we use a WITH clause to make the subquery more readable
flights_cancelled_by_month AS
(SELECT MONTH(FlightDate) AS month_, COUNT(*) AS number_flights_cancelled
  FROM flights
 WHERE YEAR(FlightDate) = 2019 AND cancelled = 1
 GROUP BY month_
 ORDER BY month_ ASC)

SELECT MONTH(f.FlightDate) AS month_, fc.number_flights_cancelled, COUNT(f.id) AS total_number_flights, 
	   ROUND((fc.number_flights_cancelled / COUNT(f.id))*100,2) AS percentage_cancelled
  FROM flights AS f
  JOIN flights_cancelled_by_month AS fc -- we use an inner join to compare cancellations for each month to the total number of flights
    ON MONTH(f.FlightDate) = fc.month_
 WHERE YEAR(f.FlightDate) = 2019
 GROUP BY MONTH(f.FlightDate), number_flights_cancelled
 ORDER BY month_ ASC;

--   Month | Number Cancelled | Total Number  |  Percent Cancelled
	-- 1	 	5788		    	262165				2.21
	-- 2	 	5502		    	237896				2.31
	-- 3	 	7079		    	283648				2.50
	-- 4	 	7429		    	274115				2.71
	-- 5	 	6912		    	285094				2.42
	-- 6	 	6172		    	282653				2.18
	-- 7	 	4523		    	291955				1.55
	-- 8	 	3624		    	290493				1.25
	-- 9	 	3318		    	268625				1.24
	-- 10	 	2291		    	283815				0.81
	-- 11	 	1580		    	266878				0.59
	-- 12	 	1397		    	275371				0.51

/*
Based on your results, what might you say about the cyclic nature of airline revenue?

The data from 2019 reveals a cyclic pattern in airline operations, with seasonal variations impacting both the total number of flights and cancellation rates. 
Airline activity peaks in the summer months (June–August), when the total number of flights is highest, reflecting increased demand during peak vacation season. 
However, cancellation rates are not at their lowest during this time. Instead, the fall and winter months (September–December) see slightly fewer total flights 
and the lowest cancellation rates, suggesting more stable operations. The least popular month for air travel turns out to be February, perhaps due to people having
busy schedules following their winter holiday breaks. In contrast, spring (March–May) experiences moderate flight volume but higher cancellation rates, 
likely due to erratic weather disrupting schedules. These trends indicate that airline revenue, when considered in terms of flight volume and reliability, 
follows an annual cycle, rising in the summer with increased travel demand and dipping in the spring when cancellations are more frequent, 
potentially impacting profitability.

*/



/*
Question 2

a. Create two new tables, one for each year (2018 and 2019) showing the total miles traveled and number of flights broken down by airline.


*/

DROP TABLE IF EXISTS flights_2018; -- we run this line if we would like to delete and recreate a table
CREATE TABLE flights_2018 AS
(SELECT AirlineName AS airline, SUM(Distance) AS miles_traveled, COUNT(*) AS number_flights
  FROM flights
 WHERE YEAR(flightDate) = 2018 AND Cancelled = 0 -- we exclude all flights which were cancelled
 GROUP BY AirlineName );

DROP TABLE IF EXISTS flights_2019;
 CREATE TABLE flights_2019 AS (SELECT AirlineName AS airline, SUM(Distance) AS miles_traveled, COUNT(*) AS number_flights
  FROM flights 
 WHERE YEAR(flightDate) = 2019 AND Cancelled = 0 -- we exclude all flights which were cancelled
 GROUP BY AirlineName );
 
 /*
b. Using your new tables, find the year-over-year percent change in total flights and miles traveled for each airline.
 */
 
 
 SELECT f1.airline, ROUND(((f2.miles_traveled-f1.miles_traveled)/f1.miles_traveled)*100,2) AS percent_change_miles_traveled,
		ROUND(((f2.number_flights-f1.number_flights)/f1.number_flights)*100,2) AS percent_change_number_flights
   FROM flights_2018 AS f1
   JOIN flights_2019 as f2
     ON f1.airline = f2.airline -- we join the two tables by equating the airline fields
  ORDER BY percent_change_miles_traveled DESC, percent_change_number_flights DESC;
  
/*
	Airline 		  Percent Change in Miles Traveled		Percent Change in Number of Flights
  Delta Air Lines Inc.			5.78									4.69
American Airlines Inc.			0.04									2.74
Southwest Airlines Co.			-1.32									-0.30

Use fully commented SQL queries to address the questions above. What investment guidance would you give to the fund managers based on your results?

Based on our analysis of year-over-year changes in total flights and miles traveled, we recommend investing in Delta Air Lines, 
as it has shown the strongest growth, with a 5.78% increase in miles traveled and a 4.69% rise in the number of flights. This suggests 
that Delta is expanding its operations and capturing more market share. American Airlines has seen only a slight increase in miles 
traveled (0.04%) but a notable 2.74% rise in the number of flights, indicating a possible focus on increasing the number of shorter routes. 
While this strategy may impact revenue differently, the overall increase suggests continued profitability, making it a reasonable company 
to hold investments in. In contrast, Southwest Airlines has shown declines in both miles traveled (-1.32%) and total flights (-0.30%), 
signaling a reduction in operations. Given these downward trends, we recommend divesting from Southwest, as the company appears to be losing 
value. We note that our analysis only considered flights that were not cancelled, ensuring an accurate estimate of the actual distance 
traveled and the number of flights that departed as planned.

*/
  
  
  
  
/*  
Question 3
Another critical piece of information is what airports the three airlines utilize most commonly.

a. What are the names of the 10 most popular destination airports overall? For this question, generate a SQL query that first joins flights and airports then does the necessary aggregation.
*/

SELECT a.AirportName AS airport, COUNT(f.id) AS number_flights
  FROM flights AS f
  JOIN airports AS a
	ON f.DestAirportID = a.AirportID -- we inner join the airports and flights table by equating airport ids
 GROUP BY a.AirportID, a.AirportName
 ORDER BY number_flights DESC
 LIMIT 10;

/*
b. Answer the same question but using a subquery to aggregate & limit the flight data before your join with the airport information, hence optimizing your query runtime.
*/

WITH flights_by_dest AS -- we use a CTE to improve readability
(SELECT DestAirportID, COUNT(id) AS number_flights
   FROM flights
  GROUP BY DestAirportID -- we aggregate and limit the data before applying a join
  ORDER BY number_flights DESC
  LIMIT 10)

SELECT a.AirportName AS airport, fbd.number_flights
  FROM flights_by_dest AS fbd
  JOIN airports AS a
	ON fbd.DestAirportID = a.AirportID
 ORDER BY number_flights DESC;

/*
			Airport									Number of Flights
Hartsfield-Jackson Atlanta International				595527
Dallas/Fort Worth International							314423
Phoenix Sky Harbor International						253697
Los Angeles International								238092
Charlotte Douglas International							216389
Harry Reid International								200121
Denver International									184935
Baltimore/Washington International Thurgood Marshall	168334
Minneapolis-St Paul International						165367
Chicago Midway International							165007


If done correctly, the results of these two queries are the same, but their runtime is not. 
In your SQL script, comment on the runtime: which is faster and why?

The second query significantly improves performance by reducing the dataset size before performing the join. 
Instead of joining the full flights table with airports first, it aggregates and filters the top 10 most popular 
destination airports in a subquery (or CTE) first, reducing the number of rows that need to be processed in the join. 
This leads to a much smaller intermediate result, making the join operation much more efficient. On my computer,
the first query had a runtime of 6.016 seconds, while the second was about twice as fast with a runtime of 2.985 seconds.
This demonstrates why filtering in a subquery or CTE before joining is a best practice when dealing with large datasets.


*/



/*
Question 4
The fund managers are interested in operating costs for each airline. We don't have actual cost or revenue information available, 
but we may be able to infer a general overview of how each airline's costs compare by looking at data that reflects equipment and fuel costs.
*/

/*

a. A flight's tail number is the actual number affixed to the fuselage of an aircraft, much like a car license plate. 
As such, each plane has a unique tail number and the number of unique tail numbers for each airline should approximate how many planes the airline operates in total. 
Using this information, determine the number of unique aircrafts each airline operated in total over 2018-2019.
*/

SELECT AirlineName AS airline, COUNT(DISTINCT Tail_Number)  AS number_planes -- we use DISTINCT to ensure we count tail numbers uniquely
  FROM flights
 GROUP BY AirlineName
 ORDER BY number_planes DESC;

/*			Airline					Number of Aircrafts
		American Airlines Inc.				993
		Delta Air Lines Inc.				988
		Southwest Airlines Co.				754
*/

/*
b. Similarly, the total miles traveled by each airline gives an idea of total fuel costs and the distance traveled per plane gives an approximation of total equipment costs. 
What is the average distance traveled per aircraft for each of the three airlines?
*/
WITH miles_by_plane AS -- we use a CTE to improve readability 
( SELECT Tail_Number AS tail_number, AirlineName AS airline, SUM(Distance) AS miles_traveled 
   FROM flights
  WHERE cancelled = 0 -- we exclude cancelled flights to ensure we obtain an accurate estimate of the distance traveled per aircraft
  GROUP BY Tail_Number, AirlineName
  ORDER BY miles_traveled DESC )

SELECT airline, COUNT(DISTINCT tail_number) AS num_aircrafts, ROUND(AVG(miles_traveled),3) AS avg_miles_per_aircraft
  FROM miles_by_plane
 GROUP BY airline
 ORDER BY avg_miles_per_aircraft DESC;

-- Southwest Airlines Co.:	2637233.403 miles per aircraft
-- American Airlines Inc.:	1853158.809 miles per aircraft
-- Delta Air Lines Inc.: 1748244.743 miles per aircraft

/*
As before, use fully commented SQL queries to address the questions. 
Compare the three airlines with respect to your findings: how do these results impact your estimates of each airline's finances?



Our analysis shows that Southwest Airlines operates fewer planes (754) than American Airlines (993) and Delta (988) 
but has the highest miles traveled per aircraft (2,637,233 miles per plane). This aligns with our earlier finding that Southwest’s 
total flights decreased, possibly due to a limited fleet, forcing each aircraft to cover greater distances. American Airlines, with 
1,853,158 miles per aircraft, appears to prioritize shorter, more frequent flights, reflecting its modest increase in miles traveled 
but higher growth in flight numbers. Delta, with 1,748,244 miles per aircraft, follows a more balanced approach, maintaining moderate 
fleet usage while experiencing steady growth. These patterns highlight different cost structures: Southwest’s intense aircraft 
utilization may lead to higher maintenance costs, American’s large fleet suggests higher operational expenses, and Delta’s strategy 
may prioritize long-term efficiency over rapid expansion. Based on this analysis, we still recommend investing in Delta as the company 
was able to grow both in terms of total flights and total miles traveled while still using their aircrafts conservatively, thus reducing
cost of maintenance and repair.


*/




/*
Question 5:
Finally, the fund managers would like you to investigate the three airlines and major airports in terms of on-time performance as well. 
For each of the following questions, consider early departures and arrivals (negative values) as on-time (0 delay) in your calculations.

Next, we will look into on-time performance more granularly in relation to the time of departure. 
We can break up the departure times into three categories as follows:
CASE
    WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
    WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
    ELSE "4-night"
END AS "time_of_day"

a. Find the average departure delay for each time-of-day across the whole data set. Can you explain the pattern you see?
*/
WITH departure_times AS -- we use a CTE to improve readability
(SELECT id, CASE 
				 WHEN DepDelay > 0 THEN DepDelay 
                 ELSE 0 -- when planes depart early or exactly on time, we consider the delay to be 0 minutes
		    END AS delay, 
			CASE
				  WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
				  WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
				  WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
				  ELSE "4-night"
			END AS time_of_day
  FROM flights
)

SELECT time_of_day, ROUND(AVG(delay),2) AS avg_delay
  FROM departure_times
 GROUP BY time_of_day
 ORDER BY time_of_day;

/*
Time of Day	  Average Delay (minutes)
1-morning		7.80
2-afternoon		13.48
3-evening		18.04
4-night			7.67

The pattern in departure delays suggests a strong correlation with airport congestion at different times of the day. 
Morning and night flights experience the shortest average delays (7.80 and 7.67 minutes, respectively), likely due 
to lower air traffic. Afternoon and evening flights, however, show significantly higher delays (13.48 and 18.04 minutes), 
which aligns with peak travel times when airports are busiest. As more passengers prefer flying in the afternoon and 
evening for convenience, congestion builds up, causing delays. This pattern reflects the transitive effect of delays throughout 
the day, where earlier disruptions may impact later departures, making evening flights the most delayed overall.


*/



/*
b. Now, find the average departure delay for each airport and time-of-day combination.
*/

WITH delay_times_by_airport AS -- we use a CTE to improve readability
(SELECT id, OriginAirportID AS airport_id, 
		CASE 
			 WHEN DepDelay > 0 THEN DepDelay 
			 ELSE 0 -- when planes depart early or exactly on time, we consider the delay to be 0 minutes
		END AS delay,
        CASE
			 WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
			 WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
			 WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
			 ELSE "4-night"
		END AS time_of_day
  FROM flights
)

SELECT a.AirportName AS airport_name, dt.airport_id, dt.time_of_day, ROUND(AVG(delay),2) AS avg_delay
  FROM delay_times_by_airport AS dt
  JOIN airports AS a -- we inner join to the airports table in order to obtain the names of the airports (rather than just the IDs)
    ON dt.airport_id = a.AirportID
 GROUP BY a.AirportName, dt.time_of_day, dt.airport_id
 ORDER BY airport_name, time_of_day;

/*
Sample rows of output table:

   Airport						Airport ID    Time of Day		Average Delay (minutes)
Akron-Canton Regional				10874		1-morning			2.11
Akron-Canton Regional				10874		2-afternoon			11.96
Akron-Canton Regional				10874		3-evening			10.11
Akron-Canton Regional				10874		4-night				6.78
Albany International				10257		1-morning			5.54
Albany International				10257		2-afternoon			9.55
Albany International				10257		3-evening			15.12
Albany International				10257		4-night				4.52
Albuquerque International Sunport	10140		1-morning			8.05
Albuquerque International Sunport	10140		2-afternoon			13.49
Albuquerque International Sunport	10140		3-evening			17.97
Albuquerque International Sunport	10140		4-night				4.60

*/





/*
c. Next, limit your average departure delay analysis to morning delays and airports with at least 10,000 flights.
*/

WITH -- we use CTEs to improve readability
popular_airports AS  -- we create a list of all airports with more than 10,000 departing flights
(SELECT OriginAirportID AS airport_id, COUNT(id)
   FROM flights
  GROUP BY OriginAirportID
 HAVING COUNT(id) > 10000),  

delay_by_airport AS 
(SELECT id, OriginAirportID AS airport_id,	
		CASE 
			 WHEN DepDelay > 0 THEN DepDelay 
			 ELSE 0 -- when planes depart early or exactly on time, we consider the delay to be 0 minutes
		END AS delay
   FROM flights
  WHERE (HOUR(CRSDepTime) BETWEEN 7 AND 11) AND OriginAirportID IN (SELECT airport_id
																	  FROM popular_airports) -- we use a subquery to restrict to airports with more than 10,000 departing flights
)

/*
d. By extending the query from the previous question, name the top-10 airports (with >10,000 flights) with the highest average morning delay. 
In what cities are these airports located?
*/

SELECT a.AirportName AS airport_name, a.city, ROUND(AVG(d.delay),2) AS avg_delay
  FROM delay_by_airport AS d
  JOIN airports AS a -- we inner join to the airports table in order to obtain the names of the airports and cities (rather than just the IDs)
    ON d.airport_id = a.AirportID
 GROUP BY a.AirportName, a.city
 ORDER BY avg_delay DESC
 LIMIT 10;
 
 /*
		Airport								City			Average Delay (minutes)
 San Francisco International			San Francisco, CA			13.22
George Bush Intercontinental/Houston	Houston, TX					12.42
Chicago O'Hare International			Chicago, IL					11.33
Dallas/Fort Worth International			Dallas/Fort Worth, TX		11.28
Los Angeles International				Los Angeles, CA				10.80
Seattle/Tacoma International			Seattle, WA					10.12
Chicago Midway International			Chicago, IL					9.81
Tulsa International						Tulsa, OK					9.57
Logan International						Boston, MA					8.72
Raleigh-Durham International			Raleigh/Durham, NC			8.65
 */
 
 
/*
Make sure you comment on the results in your script.



The analysis of average morning departure delays reveals that San Francisco International (13.22 minutes), 
George Bush Intercontinental in Houston (12.42 minutes), and Chicago O’Hare (11.33 minutes) have the highest delays. 
Given that delays often translate into operational inefficiencies, airlines heavily reliant on these airports may 
face increased costs and passenger dissatisfaction. Thus, it may be beneficial to deprioritize investments in airlines 
with a large number of flights through these airports.

Notably, the high-delay airports are distributed across many different regions of the U.S., indicating that delays are not 
specific to a particular geographic area but may instead be influenced by airport-specific factors such as congestion or 
operational challenges. Additionally, the top three airports with the highest delays do not appear in our previous analysis 
of the most popular airports, suggesting that their inefficiency is not purely due to high traffic volume but could stem from 
other logistical or infrastructure related issues.

*/