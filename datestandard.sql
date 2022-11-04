select * from date_new;

select day, length(day), months, length(months), year, length(year) from date_new;

#Create new table 'date_standard' with standardize date format
create table date_standard as (select id, concat(y,'-',m,'-',d) dates from(
select id, day,
case
	when length(day) = '1' then concat(0,day)
    else day
end as d,
months,
case
	when length(months) = '1' then concat(0,months)
    else months
end as m,
concat('20',year) y
from date_new) sub);

#Change data type format on dates column
alter table date_standard
modify column dates date;

alter table date_standard
rename column id to id_date;

#Set id as primary key
alter table date_standard
add primary key(id);

describe date_standard;