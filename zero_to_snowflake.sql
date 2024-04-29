-- -- use database weather;

-- -- create table json_weather_data (v variant);


-- -- create stage nyc_weather
-- -- url = 's3://snowflake-workshop-lab/zero-weather-nyc';

-- -- list @nyc_weather;


-- -- copy into json_weather_data
-- -- from @nyc_weather
-- --     file_format = (type = json strip_outer_array = true);


-- -- select * from json_weather_data limit 10;


-- -- create or replace view json_weather_data_view as
-- -- select
-- -- v:obsTime::timestamp as observation_time,
-- -- v:station::string as station_id,
-- -- v:name::string as city_name,
-- -- v:country::string as country,
-- -- v:latitude::float as city_lat,
-- -- v:longitude::float as city_lon,
-- -- v:weatherCondition::string as weather_conditions,
-- -- v:coco::int as weather_conditions_code,
-- -- v:temp::float as temp,
-- -- v:tsun::float as tsun,
-- -- v:wdir::float as wind_dir,
-- -- v:wspd::float as wind_speed,
-- -- v:dwpt::float as dew_point,
-- -- v:rhum::float as relative_humidity,
-- -- v:pres::float as pressure

-- -- from 
-- --     json_weather_data
-- -- where
-- --     station_id = '72502';



-- -- select * from json_weather_data_view
-- -- where date_trunc('month', observation_time) = '2018-01-01'
-- -- limit 20;



-- -- select weather_conditions as conditions,
-- -- count(*) as num_trips
-- -- from citibike.public.trips
-- -- left outer join json_weather_data_view
-- -- on date_trunc('hour', observation_time) = date_trunc('hour', starttime)
-- -- group by 1 order by 2 desc;


-- -- drop table json_weather_data;



-- -- select * from json_weather_data limit 10;

-- -- undrop table json_weather_data;


-- -- select * from json_weather_data limit 10;




-- -- use role accountadmin;
-- -- use warehouse compute_wh;
-- -- use database citibike;
-- -- use schema public;


-- -- update trips set start_station_name = 'oops';


-- -- select * from trips limit 10;



-- -- select
-- -- start_station_name as "station",
-- -- count(*) as "rides",
-- -- from trips
-- -- group by 1
-- -- order by 2 desc
-- -- limit 20;



-- set query_id =
-- (select query_id from table(information_schema.query_history_by_session (result_limit=>500))
-- where query_text like 'update%' order by start_time desc limit 1);

-- create or replace table trips as
-- (select * from trips before (statement => $query_id));

-- select
-- start_station_name as "station",
-- count(*) as "rides"
-- from trips
-- group by 1
-- order by 2 desc
-- limit 20;



-- use role accountadmin;

-- create role junior_dba;

-- grant role junior_dba to user SOFTWAREINTROSPECTRE;


-- use role accountadmin;
-- grant usage on warehouse compute_wh to junior_dba;


-- use role junior_dba;
-- use warehouse compute_wh;


-- use role accountadmin;
-- grant usage on database citibike to role junior_dba;
-- grant usage on database weather to role junior_dba;

-- use role junior_dba;



-- use role accountadmin;


-- drop share if exists zero_to_snowflake_shared_data;

-- drop share if exists CITIBIKE_SNOWFLAKE_SECURE_SHARE_1714424353742;
-- drop database if exists citibike;
-- drop database if exists weather;
-- drop warehouse if exists analytics_wh;
-- drop role if exists junior_dba;
