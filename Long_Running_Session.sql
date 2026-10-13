set lines 300
col sid form 99999
col start_time head "Start|Time" form a12 trunc
col opname head "Operation" form a12 trunc
col target head "Object" form a30 trunc
col totalwork head "Total|Work" form 9999999999 trunc
col Sofar head "Sofar" form 9999999999 trunc
col elamin head "Elapsed|Time|(Mins)" form 99999999 trunc
col tre head "Time|Remain|(Mins)" form 999999999 trunc
select sid,serial#,to_char(start_time,'dd-mon:hh24:mi') start_time,
          opname,target,totalwork,sofar,(elapsed_Seconds/60) elamin,
          time_remaining tre,sql_id,inst_id
 from gv$session_longops
 where totalwork <> SOFAR
 order by 9 desc
/
