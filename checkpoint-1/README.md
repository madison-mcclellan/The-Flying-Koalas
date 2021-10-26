# Checkpoint 1: Relational Analytics

## Running the Code
To run the code for this checkpoint, open the file src/checkpoint1.sql in a SQL interpreter or IDE such as DataGrip. Ensure that a connection is established to the database either locally or remotely. The file is divided into five parts, one for each of the five relational analytics questions. The queries can be highlighted and run one at a time. You can also copy and paste the queries below into a new SQL file. The checkpoint1.sql file provided contains additional queries than what is described below to provide more context for each question. 

## Questions and SQL Queries

### Are certain types of use of force more common in certain districts?
Count the number of TRR incidents and group by district:
`SELECT count(*) as num_instances, name as district
FROM trr_trr JOIN data_area ON ST_Intersects(trr_trr.point, data_area.polygon) JOIN trr_actionresponse ta on trr_trr.id = ta.trr_id
WHERE area_type = 'police-districts' AND person = 'Member Action'
GROUP BY name
ORDER BY num_instances DESC;`

Count the number of TRR incidents and group by district and action type:
`SELECT count(*) as num_instances, name as district, action
FROM trr_trr JOIN data_area ON ST_Intersects(trr_trr.point, data_area.polygon) JOIN trr_actionresponse ta on trr_trr.id = ta.trr_id
WHERE area_type = 'police-districts' AND person = 'Member Action'
GROUP BY name, action
ORDER BY num_instances DESC;`

### Does age play a role in what action the officer takes against the subject?
Count number of TRR incidents and group by age:
`SELECT count(*) as num_instances, subject_age
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action'
GROUP BY subject_age
ORDER BY num_instances DESC;`

Calculate the average age of subjects in TRR incidents:
`SELECT avg(subject_age)
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action';`

Count the number of TRR incidents against subjects under the age of 30 and group by officer action:
`SELECT count(*) as num_instances, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action' AND subject_age < 30
GROUP BY action
ORDER BY num_instances DESC;`

Between the ages of 30 and 60:
`SELECT count(*) as num_instances, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action' AND subject_age >= 30 AND subject_age < 60
GROUP BY action
ORDER BY num_instances DESC;`

Over the age of 60:
`SELECT count(*) as num_instances, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action' AND subject_age >= 60
GROUP BY action
ORDER BY num_instances DESC;`

Combine these three tables into a single table showing distinct ages rather than age ranges:
`SELECT count(*) as num_instances, action, subject_age
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action'
GROUP BY action, subject_age
ORDER BY num_instances DESC;`

### Are there trends in officers' actions based on the lighting conditions of the incident?
Count the number of TRR incidents and group by lighting condition:
`SELECT count(*) as num_instances, lighting_condition
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
GROUP BY lighting_condition
ORDER BY num_instances DESC;`

Count the number of TRR incidents and group by lighting condition and action type:
`SELECT count(*) as num_instances, lighting_condition, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
GROUP BY lighting_condition, action
ORDER BY num_instances DESC;`

### Are officers more likely to use a firearm on an unarmed subject if they are off duty?
Count the number of instances of use of firearm on unarmed subject for officers on vs. off duty:
`SELECT count(*) as num_instances, officer_on_duty
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action' AND action = 'FIREARM' AND subject_armed = false
GROUP BY officer_on_duty;`

### Are there trends in officers’ actions based on the race of the subject?
Count the number of TRR incidents and group by race:
`SELECT count(*) as num_instances, subject_race
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action'
GROUP BY subject_race
ORDER BY num_instances DESC;`

Count the number of TRR incidents and group by race and action type:
`SELECT count(*) as num_instances, action, subject_race
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.trr_id
WHERE person = 'Member Action'
GROUP BY action, subject_race
ORDER BY num_instances DESC;`