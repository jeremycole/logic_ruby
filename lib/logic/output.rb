class Logic::Output < Logic::IO
  def output_to(input)
    attach(lambda { |_, _, state|
      input.pull(state)
    })
  end
end