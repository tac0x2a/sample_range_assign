use sample_db


truncate table rel
insert into rel (event_id, range_id)
select
  e.id as event_id,
  ( select top 1 r.id
    from range as r
    order by ( ABS(DATEDIFF(s, r.begin_at, e.event_at)) +  ABS(DATEDIFF(s, r.end_at, e.event_at)) )
  ) as range_id
from event as e


-- 04:16:17 かかった。。。


-- select *
-- from rel as r inner join event as e on e.id = r.event_id
--              inner join range as rr on rr.id = r.range_id
