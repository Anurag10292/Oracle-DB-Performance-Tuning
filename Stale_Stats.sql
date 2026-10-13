set pages 50 line 300 heading on feed off
col owner for a20
col TABLE_NAME for a35
col PARTITION_NAME for a30
col stale_stats for a15
col stattype_locked for a20
SELECT s.con_id,s.owner, s.table_name, s.stale_stats, s.last_analyzed, s.stattype_locked
  FROM cdb_tab_statistics s,
       cdb_tables t
WHERE t.CON_ID = s.CON_ID
   AND s.object_type = 'TABLE'
   AND s.owner NOT IN ('DBSNMP','ORDSYS','OUTLN','OWBSYS')
   AND s.owner NOT IN ('MGDSYS','OJVMSYS')
   AND s.last_analyzed IS NULL
   AND s.table_name NOT LIKE 'BIN%'
   AND NOT (s.table_name LIKE '%TEMP' OR s.table_name LIKE '%\_TEMP\_%' ESCAPE '\')
   AND t.owner = s.owner
   AND t.table_name = s.table_name
   AND t.temporary = 'N'
   AND NOT EXISTS (
SELECT NULL
  FROM dba_external_tables e
WHERE e.owner = s.owner
   AND e.table_name = s.table_name
)
ORDER BY
       s.owner, s.table_name;

SELECT distinct s.owner, s.table_name,s.PARTITION_NAME,  s.stattype_locked
  FROM cdb_tab_statistics s,
       cdb_tables t
WHERE
       s.owner NOT IN ('DBSNMP','ORDSYS','OUTLN','OWBSYS')
   AND s.owner NOT IN ('MGDSYS','OJVMSYS')
   AND s.stale_stats = 'YES'
   AND s.table_name NOT LIKE 'BIN%'
   AND NOT (s.table_name LIKE '%TEMP' OR s.table_name LIKE '%\_TEMP\_%' ESCAPE '\')
   AND t.con_id = s.con_id
   AND t.owner = s.owner
   AND t.table_name = s.table_name
   AND t.temporary = 'N'
   AND NOT EXISTS (
SELECT NULL
  FROM dba_external_tables e
WHERE e.owner = s.owner
   AND e.table_name = s.table_name
)
ORDER BY
       s.owner, s.table_name;
