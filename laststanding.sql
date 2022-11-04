select * from s1314_new;

#PL Standing Home Game

#First union the scores table together swapping the hometeam with the awayteam and swapping the goal counts.
#This gives you some source data that is easily aggregated and the query to generate the score card is something like this:

select hometeam team, fthg, ftag from s1314_new
union all
select awayteam, ftag, fthg from s1314_new;

select
	team,
    count(*) P,
    count(case when fthg > ftag then 1 end) W,
    count(case when fthg < ftag then 1 end) L,
    count(case when fthg = ftag then 1 end) D,
    sum(fthg) GF,
    sum(ftag) GA,
    sum(fthg-ftag) GD,
    sum(
		case when fthg > ftag then 3 else 0 end +
        case when fthg = ftag then 1 else 0 end) Pts
from (
select hometeam team, fthg, ftag from s1314_new
union all
select awayteam, ftag, fthg from s1314_new) sub
group by team
order by Pts desc, GD desc;