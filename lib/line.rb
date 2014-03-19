class Line
 attr_reader :name, :id

  def self.all
    table_name = self.to_s.downcase
    results = DB.exec("SELECT * FROM #{table_name};")
    all = []
    results.each do |result|
      new_object = self.new(result)
      all << new_object
    end
    all
  end

  def save
    results = DB.exec("INSERT INTO line (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def create_stop(station_id)
    results = DB.exec("INSERT INTO stops (station_id, line_id) VALUES ('#{station_id}', '#{self.id}') RETURNING id;")
    stop_id = results.first['id'].to_i
  end

  def delete
    table_name = self.class.to_s.downcase
    DB.exec("DELETE FROM #{table_name} WHERE id = #{self.id};")
    DB.exec("DELETE FROM stops WHERE #{table_name}_id = #{self.id};")
  end

  def remove_stop(station_id)
    DB.exec("DELETE FROM stops WHERE line_id = #{self.id} and station_id = #{station_id};")
  end

  def self.search(name)
    table_name = self.to_s.downcase
    results = DB.exec("SELECT * FROM #{table_name} WHERE name LIKE '%#{name}'")
    lines = []
    results.each do |result|
      lines << self.new(result)
    end
    lines.first
  end

  def self.exists?(name)
    results = self.search(name)
    !results.nil?
  end

  def ==(other_line)
    self.name == other_line.name
  end

  def all_stations
    field_name = self.class.to_s.downcase
    stations = []
    results = DB.exec("SELECT b.name, b.id FROM stops a INNER JOIN station b ON a.station_id = b.id WHERE a.#{field_name}_id = #{self.id};")
    results.each do |result|
      stations << Station.new(result)
    end
    stations
  end

  def update_name(new_name)
    @name = new_name
    DB.exec("UPDATE line SET name = '#{new_name}' WHERE id = #{self.id};")
  end
end
