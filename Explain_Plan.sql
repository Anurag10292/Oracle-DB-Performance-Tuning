--Explain_Plan 
select * from table(dbms_xplan.display_cursor('&sqlid',&child_number))
/
--Explain_Plan Advance
select * from table(dbms_xplan.display_cursor('&sqlid',&child,format=>'ADVANCED'))
/
--Explain_Plan from AWR
 select * from table(dbms_xplan.display_awr('&sqlid'))
/
