 select b.tablespace_name, tbs_size SizeMb, a.free_space FreeMb
from 
(select tablespace_name, round(sum(bytes)/1024/1024 ,2) as free_space 
	from dba_free_space group by tablespace_name) a, 
(select tablespace_name, sum(bytes)/1024/1024 as tbs_size 
	from dba_data_files group by tablespace_name
	UNION
	select tablespace_name, sum(bytes)/1024/1024 tbs_size
	from dba_temp_files
	group by tablespace_name ) b
where a.tablespace_name(+)=b.tablespace_name; 

