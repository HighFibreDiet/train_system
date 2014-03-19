require 'spec_helper'

describe Line do
  it  'initializes a new line object with a name' do
    new_line = Line.new({'name' => 'Trans-Siberian'})
    new_line.should be_an_instance_of Line
  end

  it 'can save itself' do
    new_line = Line.new({'name' => 'Trans-Siberian'})
    new_line.save
    Line.all
  end

  it 'has an empty all array to begin' do
    Line.all.should eq []
  end

  it 'can create a stop on itself' do
    new_line = Line.new({'name' => 'Trans-Siberian'})
    new_line.save
    new_station = Station.new({'name' => 'Panda'})
    new_station.save
    test_result = new_line.create_stop(new_station.id)
    test_result.should be_an_instance_of Fixnum
  end

end
