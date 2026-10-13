set linesize 200
set pagesize 150
set pages 150 heading off feed off
select *
from (select instance_number, sql_id, max(pga_sum_gb) pga_max_gb
        from (select instance_number, sample_time, sql_id, round(sum(nvl(pga_allocated, 0))/1024/1024/1024) pga_sum_gb
                from dba_hist_active_sess_history
               where snap_id between $snap_b and $snap_e
            group by instance_number, sample_time, sql_id)
       group by instance_number, sql_id
       order by pga_max_gb desc)
where rownum <= 16;
