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
    @id = attributes['id']
  end

  def create_stop(line_id)
    results = DB.exec("INSERT INTO stops (station_id, line_id) VALUES ('#{self.id}', '#{line_id}') RETURNING id;")
    stop_id = results.first['id'].to_i
  end

end
