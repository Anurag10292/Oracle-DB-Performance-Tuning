set linesize 200
set pagesize 150
set pages 150 heading off feed off
set linesize 200
set pagesize 150
column temp_max format 99999999
column sample_time format a25
select *
from (select instance_number, sql_id, max(temp_sum_gb) temp_max_gb
        from (select instance_number, sample_time, sql_id, round(sum(nvl(temp_space_allocated, 0))/1024/1024/1024) temp_sum_gb
                from dba_hist_active_sess_history
               where snap_id between $snap_b and $snap_e
            group by instance_number, sample_time, sql_id)
       group by instance_number, sql_id
       order by temp_max_gb desc)
where rownum <= 10;
