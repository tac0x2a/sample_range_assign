use sample_db 

select *
from rel as r inner join rel_improved as i on
r.event_id = i.event_id and r.range_id <> i.range_id

select *
from event as e left join rel_improved as i on
e.id = i.event_id
where i.event_id is not null
