class Logic::Gates::TwoInputOneOutput < Logic::Gate
  attr_accessor :name
  attr_reader :a
  attr_reader :b
  attr_reader :q

  def initialize(name: nil, inputs: [], outputs: [])
    super
    @a = add_input("a")
    @b = add_input("b")
    @q = add_output("q")
  end

  def operator_name
    @class_name ||= self.class.name.split("::").last.upcase
  end

  def inspect
    "#<#{operator_name} [#{a.value}, #{b.value}] => #{q.value}>"
  end

  def perturb(input, previous_state, state)
  end
end