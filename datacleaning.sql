use epl;
select * from s1314;

#Add id column with auto increment fill, set as primary key
alter table s1314
modify id int not null auto_increment primary key;

#change table structure
alter table s1314
modify id int first;

describe s1314;

#CREATE NEW TABLE date_new, trying to separate day, month and year
create table date_new as (select id, dates, day, left(month, position("/" in month)-1) months, year
from(
select id, dates, length(dates),
left(dates, position("/" in dates)-1) day,
right(dates, (length(dates)-position("/" in dates))) month,
right(dates, 2) year
from s1314) sub);






