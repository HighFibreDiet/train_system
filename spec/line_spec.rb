require 'spec_helper'

describe Line do
  it  'initializes a new line object with a name' do
    new_line = Line.new({'name' => 'Trans-Siberian'})
    new_line.should be_an_instance_of Line
  end

end
