require 'line'
require 'station'
require 'transit'
require 'rspec'
require 'pg'

DB = PG.connect(:dbname => 'train_system_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM line *;")
    DB.exec("DELETE FROM station *;")
    DB.exec("DELETE FROM stops *;")
  end
end
