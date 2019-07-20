class Logic::Gate
  attr_reader :name

  def initialize(name: nil, inputs: [], outputs: [])
    @name = name
    @inputs = inputs
    @outputs = outputs
  end

  def perturb(input, previous_state, state)
    nil
  end

  def add_input(name)
    input = Logic::Input.new(name)
    input.attach(lambda { |input, previous_state, state|
      perturb(input, previous_state, state)
    })
    @inputs << input

    input
  end

  def add_output(name)
    output = Logic::Output.new(name)
    @outputs << output

    output
  end
end