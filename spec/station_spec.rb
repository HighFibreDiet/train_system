require 'spec_helper'

describe Station do
  it  'initializes a new line object with a name' do
    new_station = Station.new({'name' => 'Panda'})
    new_station.should be_an_instance_of Station
  end

  it 'can save itself' do
    new_station = Station.new({'name' => 'Panda'})
    new_station.save
    Station.all
  end

  it 'has an empty all array to begin' do
    Station.all.should eq []
  end

   it 'can create a stop at itself' do
    new_line = Line.new({'name' => 'Trans-Siberian'})
    new_line.save
    new_station = Station.new({'name' => 'Panda'})
    new_station.save
    test_result = new_station.create_stop(new_line.id)
    test_result.should be_an_instance_of Fixnum
  end

end
