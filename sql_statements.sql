-- all arrivals on a particular run of a line

SELECT b.name, c.arrival_time, d.name
FROM stops a INNER JOIN line b ON a.line_id = b.id
  INNER JOIN arrivals c ON a.id = c.stop_id
  INNER JOIN station d ON a.station_id = d.id
  WHERE b.name = 'Sasquatch' and c.run_id = 1;


-- all arrivals at a station
  SELECT b.name line_name, c.run_id run_number, c.arrival_time, d.name
 station_name FROM stops a INNER JOIN line b ON a.line_id = b.id
  INNER JOIN arrivals c ON a.id = c.stop_id
  INNER JOIN station d ON a.station_id = d.id
  WHERE d.name = 'Pomegranate!';
