ALTER EXTENSION postgis UPDATE;

-- 1) ARE CERTAIN TYPES OF USE OF FORCE MORE COMMON IN CERTAIN DISTRICTS?
-- generate list of distinct types of use of force used by officers
SELECT DISTINCT action
FROM trr_actionresponse
WHERE person = 'Member Action';

-- generate list of districts
SELECT distinct name
FROM data_area
WHERE area_type = 'police-districts';

-- count the number of TRR incidents and group by beat
SELECT count(*) as num_instances, beat
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action'
GROUP BY beat
ORDER BY num_instances DESC;

-- count the number of TRR incidents and group by district
SELECT count(*) as num_instances, name as district
FROM trr_trr JOIN data_area ON ST_Intersects(trr_trr.point, data_area.polygon) JOIN trr_actionresponse ta on trr_trr.id = ta.id
WHERE area_type = 'police-districts' AND person = 'Member Action'
GROUP BY name
ORDER BY num_instances DESC;

-- count the number of TRR incidents and group by district and action type
SELECT count(*) as num_instances, name as district, action
FROM trr_trr JOIN data_area ON ST_Intersects(trr_trr.point, data_area.polygon) JOIN trr_actionresponse ta on trr_trr.id = ta.id
WHERE area_type = 'police-districts' AND person = 'Member Action'
GROUP BY name, action
ORDER BY num_instances DESC;

-- count the number of instances of use of firearm and group by district
SELECT count(*) as num_instances, name as district
FROM trr_trr JOIN data_area ON ST_Intersects(trr_trr.point, data_area.polygon) JOIN trr_actionresponse ta on trr_trr.id = ta.id
WHERE area_type = 'police-districts' AND person = 'Member Action' AND action = 'FIREARM'
GROUP BY name
ORDER BY num_instances DESC;

-- 2) DOES AGE PLAY A ROLE IN WHAT ACTION THE OFFICER TAKES AGAINST THE SUBJECT?
-- generate list of subject ages in TRR incidents
SELECT DISTINCT subject_age
FROM trr_trr
ORDER BY subject_age;

-- count number of TRR incidents and group by age
SELECT count(*) as num_instances, subject_age
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action'
GROUP BY subject_age
ORDER BY num_instances DESC;

-- calculate the average age of subjects in TRR incidents
SELECT avg(subject_age)
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action';

-- count the number of TRR incidents against subjects under the age of 30 and group by officer action
SELECT count(*) as num_instances, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action' AND subject_age < 30
GROUP BY action
ORDER BY num_instances DESC;

-- between the ages of 30 and 60
SELECT count(*) as num_instances, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action' AND subject_age >= 30 AND subject_age < 60
GROUP BY action
ORDER BY num_instances DESC;

-- over the age of 60
SELECT count(*) as num_instances, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action' AND subject_age >= 60
GROUP BY action
ORDER BY num_instances DESC;

-- combine these three tables into a single table showing distinct ages rather than age ranges
SELECT count(*) as num_instances, action, subject_age
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action'
GROUP BY action, subject_age
ORDER BY num_instances DESC;

-- 3) ARE THERE TRENDS IN OFFICERS' ACTIONS BASED ON THE LIGHTING CONDITION OF THE INCIDENT?
-- count the number of TRR incidents and group by lighting condition
SELECT count(*) as num_instances, lighting_condition
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
GROUP BY lighting_condition
ORDER BY num_instances DESC;

-- count the number of TRR incidents and group by lighting condition and action type
SELECT count(*) as num_instances, lighting_condition, action
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
GROUP BY lighting_condition, action
ORDER BY num_instances DESC;

-- 4) ARE OFFICERS MORE LIKELY TO USE A FIREARM ON AN UNARMED SUBJECT IF THEY ARE OFF DUTY?
-- count the number of instances of use of firearm on armed vs. unarmed subject
SELECT count(*) as num_instances, subject_armed
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action' AND action = 'FIREARM'
GROUP BY subject_armed;

-- count the number of instances of use of firearm on unarmed subject for officers on vs. off duty
SELECT count(*) as num_instances, officer_on_duty
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action' AND action = 'FIREARM' AND subject_armed = false
GROUP BY officer_on_duty;

-- 5) ARE THERE TRENDS IN OFFICERS' ACTIONS BASED ON THE RACE OF THE SUBJECT?
-- count the number of TRR incidents and group by race
SELECT count(*) as num_instances, subject_race
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action'
GROUP BY subject_race
ORDER BY num_instances DESC;

-- count the number of TRR incidents and group by race and action type
SELECT count(*) as num_instances, action, subject_race
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action'
GROUP BY action, subject_race
ORDER BY num_instances DESC;

-- count the number of instances of use of firearm and group by race
SELECT count(*) as num_instances, action, subject_race
FROM trr_trr JOIN trr_actionresponse ON trr_trr.id = trr_actionresponse.id
WHERE person = 'Member Action' AND action = 'FIREARM'
GROUP BY action, subject_race
ORDER BY num_instances DESC;
