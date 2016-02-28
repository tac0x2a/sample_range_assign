
# generate sample db
require 'date'

BeginAt = "2016/01/01 00:00:00"
EndAt   = "2016/03/01 00:00:00"

begin_at = DateTime.parse(BeginAt)
end_at   = DateTime.parse(EndAt)

# Generate Range
def gen_range(at, unit, end_at, table = "range")
  until at >= end_at
    b = at.strftime("%Y/%m/%d %H:%M:%S")
    at += unit
    e = at.strftime("%Y/%m/%d %H:%M:%S")
    puts "INSERT INTO #{table} VALUES('#{b}', '#{e}')"
    at += unit
  end
end
# gen_range(DateTime.parse(BeginAt), Rational(5, 24*60*60), DateTime.parse(EndAt))



# Generate Event
# count: count of samples.
def gen_event(count, begin_at, end_at, table = "event")
  term_sec = (end_at - begin_at) * 24 * 60 * 60

  count.times do |t|
    event_at = begin_at + Rational(rand(term_sec), 24 * 60 * 60)
    e = event_at.strftime("%Y/%m/%d %H:%M:%S")
    puts "INSERT INTO #{table} VALUES('#{e}')"
  end
end
gen_event(100000, DateTime.parse(BeginAt), DateTime.parse(EndAt))
