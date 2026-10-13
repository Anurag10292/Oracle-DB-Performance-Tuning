set lines 300 pages 1200
col username for a10
col osuser for a20
select inst_id,sid, serial#,username,sql_hash_value,sql_id,program,last_call_et/60 as ET,logon_time,status, osuser  from gv$session where event='&ev'
order by ET,inst_id
/
