set linesize 200
set pagesize 150
set pages 150 heading off feed off
set linesize 200
set pagesize 150
column temp_max format 99999999
column sample_time format a25
select * from (SELECT a.sql_id,a.event Event ,count(a.sample_time) AS EST_SECS_IN_WAIT,   WAIT_CLASS
FROM dba_hist_active_sess_history a
WHERE SESSION_STATE = 'WAITING' and a.sql_id is not null
and a.snap_id between $snap_b and $snap_e
group by event,sql_id,WAIT_CLASS order by 3)
where rownum <11;
