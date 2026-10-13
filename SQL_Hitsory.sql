col DT format a20
select ss.snap_id, ss.instance_number node, to_char(begin_interval_time,'DD-MON-YY HH24MI') "DT",sql_id,  plan_hash_value,
nvl(executions_delta,0) execs,
(elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
(buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta)) avg_lio,
(disk_reads_delta/decode(nvl(disk_reads_delta,0),0,1,executions_delta)) avg_pio,
(iowait_delta/decode(nvl(iowait_delta,0),0,1,executions_delta)) avg_iowait
from DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS
where sql_id = '&sql_id'
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
and begin_interval_time >sysdate-90
order by 1, 2, 3
/
