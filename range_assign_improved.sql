use sample_db

declare event cursor  for
select e.id, e.event_at from event as e order by e.event_at

open event


declare range cursor  for
select r.id, r.begin_at, r.end_at from range as r order by r.begin_at

open range


-- �����ɏ���������
declare @e_id int
declare @e_at datetime
declare @r_id int
declare @r_begin datetime
declare @r_end   datetime
declare @r_id_p int
declare @r_begin_p datetime
declare @r_end_p datetime


--fetch first.
fetch next from event into @e_id, @e_at

fetch next from range into @r_id_p, @r_begin_p, @r_end_p
fetch next from range into @r_id,   @r_begin,   @r_end

declare @prev_diff int    =    abs(datediff(ss, @r_begin_p, @e_at))
                             + abs(datediff(ss, @e_at, @r_end_p))
declare @current_diff int =    abs(datediff(ss, @r_begin, @e_at))
                             + abs(datediff(ss, @e_at, @r_end))


WHILE (@@fetch_status = 0)
BEGIN

--	print cast(@prev_diff as nvarchar(30)) + '  <  ' + cast(@current_diff as nvarchar(30))

	if @prev_diff < @current_diff -- 離れた。最も近いのは prev
	begin

	  -- for debug
--	  print 'Event:' + cast(@e_id   as nvarchar(30)) + '-' + cast(@e_at as nvarchar(30))
--	  print 'Range:' + cast(@r_id_p as nvarchar(30)) + '-' + cast(@r_begin_p as nvarchar(30)) + '-' + cast(@r_end_p as nvarchar(30))
--    BREAK

	  INSERT INTO rel_improved values (@e_id, @r_id_p)
	  fetch next from event into @e_id, @e_at

	  set @prev_diff     =    abs(datediff(ss, @r_begin_p, @e_at))
                            + abs(datediff(ss, @e_at, @r_end_p))
      set @current_diff  =    abs(datediff(ss, @r_begin, @e_at))
                            + abs(datediff(ss, @e_at, @r_end))
	end
	else -- 近づいているので、より近いrangeが存在する
	begin
	  set @prev_diff = @current_diff
	  set @r_id_p    = @r_id
	  set @r_begin_p = @r_begin
	  set @r_end_p   = @r_end

      fetch next from range into @r_id,   @r_begin,   @r_end
      set @current_diff  =  abs(datediff(ss, @r_begin, @e_at))
                          + abs(datediff(ss, @e_at, @r_end))
	end
end

close range
deallocate range


close event
deallocate event


-- 00:00:27 で処理できた。
