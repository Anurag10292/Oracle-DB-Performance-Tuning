set linesize 200
set pagesize 150
set pages 150 heading off feed off
select * from (SELECT st.sql_text, sub.sql_id, sub.ELAPSED_TIME PER_EXEC_ELAPSED_TIME_MINUTES
FROM DBA_HIST_SQLTEXT st,
( SELECT t.sql_id,
ROUND (SUM (t.elapsed_time_delta / 60000000)/ SUM (t.executions_delta)) ELAPSED_TIME
FROM dba_hist_sqlstat t, dba_hist_snapshot s, DBA_HIST_SQLTEXT st
WHERE t.snap_id = s.snap_id
AND t.dbid = s.dbid
AND t.instance_number = s.instance_number
AND t.executions_delta > 0
AND s.snap_id between $snap_b and $snap_e
GROUP BY t.sql_id
ORDER BY 2 DESC) sub
WHERE sub.sql_id = st.sql_id
ORDER BY 3 DESC) where rownum < 16;
