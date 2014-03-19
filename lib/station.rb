class Station
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
    table_name = self.class.to_s.downcase
    results = DB.exec("INSERT INTO #{table_name} (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def create_stop(line_id)
    results = DB.exec("INSERT INTO stops (station_id, line_id) VALUES ('#{self.id}', '#{line_id}') RETURNING id;")
    stop_id = results.first['id'].to_i
  end

  def delete
    table_name = self.class.to_s.downcase
    DB.exec("DELETE FROM #{table_name} WHERE id = #{self.id};")
    DB.exec("DELETE FROM stops WHERE #{table_name}_id = #{self.id};")
  end

  def remove_stop(line_id)
    DB.exec("DELETE FROM stops WHERE line_id = #{line_id} and station_id = #{self.id};")
  end

  def self.search(name)
    table_name = self.to_s.downcase
    results = DB.exec("SELECT * FROM #{table_name} WHERE name LIKE '%#{name}'")
    stations = []
    results.each do |result|
      stations << self.new(result)
    end
    stations.first
  end

  def self.exists?(name)
    results = self.search(name)
    !results.nil?
  end

  def ==(other_station)
    self.name == other_station.name
  end

   def all_lines
    field_name = self.class.to_s.downcase
    lines = []
    results = DB.exec("SELECT b.name, b.id FROM stops a INNER JOIN line b ON a.line_id = b.id WHERE a.#{field_name}_id = #{self.id};")
    results.each do |result|
      lines << Line.new(result)
    end
    lines
  end

  def update_name(new_name)
    @name = new_name
    DB.exec("UPDATE station SET name = '#{new_name}' WHERE id = #{self.id};")
  end
end
