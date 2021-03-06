require_relative('../db/sql_runner')

class Event

attr_reader :id, :type, :point_gain
  
  def initialize(options)
    @id = options['id'].to_i
    @type = options['type']
    @point_gain = options['point_gain'].to_i  
  end

  def save()
    sql = "INSERT INTO events (type, point_gain) VALUES ('#{type}', #{point_gain}) RETURNING *"
    event = SqlRunner.run(sql).first
    @id = event['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM events"
    return Event.map_items(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM events WHERE id = #{id}"
    return Event.map_item(sql)
  end

  def self.map_items(sql)
    events = SqlRunner.run(sql)
    result = events.map{|event| Event.new(event)}
    return result
  end

  def self.map_item(sql)
    result = Event.map_items(sql)
    return result.first
  end

end
