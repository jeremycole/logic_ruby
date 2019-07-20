class Logic::IO
  attr_reader :name
  attr_reader :state

  def initialize(name, state: Logic::LOW)
    @name = name
    @state = Logic::Z
    @sinks = []

    pull(state)
  end

  def attach(sink)
    @sinks << sink
    self
  end

  def notify(previous_state, state)
    @sinks.each do |sink|
      sink.call(self, previous_state, state)
    end
    self
  end

  def pull(level)
    return if level == @state
    return pull(Logic::INTEGER_LEVELS[level]) if level.is_a?(Integer)
    @previous_state = @state
    @state = level
    notify(@previous_state, @state)
    self
  end

  def input_from(io)
    io.attach(lambda { |_, _, state|
      pull(state)
    })
    self
  end

  def value
    state ? 1 : 0
  end
end