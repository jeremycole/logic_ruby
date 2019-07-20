class Logic::Blocks::FullAdder < Logic::Gate
  attr_reader :a
  attr_reader :b
  attr_reader :c_in

  attr_reader :s
  attr_reader :c_out

  attr_reader :a_xor_b
  attr_reader :a_xor_b_xor_c
  attr_reader :a_xor_b_and_c
  attr_reader :a_and_b
  attr_reader :a_xor_b_and_c_or_a_and_b

  def initialize
    super
    @a = add_input("a")
    @b = add_input("b")
    @c_in = add_input("c_in")

    @a_xor_b = Logic::Gates::Xor.new
    @a_xor_b.a.input_from(@a)
    @a_xor_b.b.input_from(@b)

    @a_xor_b_xor_c = Logic::Gates::Xor.new
    @a_xor_b_xor_c.a.input_from(@a_xor_b.q)
    @a_xor_b_xor_c.b.input_from(@c_in)

    @a_xor_b_and_c = Logic::Gates::And.new
    @a_xor_b_and_c.a.input_from(@a_xor_b.q)
    @a_xor_b_and_c.b.input_from(@c_in)

    @a_and_b = Logic::Gates::And.new
    @a_and_b.a.input_from(@a)
    @a_and_b.b.input_from(@b)

    @a_xor_b_and_c_or_a_and_b = Logic::Gates::Or.new
    @a_xor_b_and_c_or_a_and_b.a.input_from(@a_xor_b_and_c.q)
    @a_xor_b_and_c_or_a_and_b.b.input_from(@a_and_b.q)

    @s = add_output("s")
    @c_out = add_output("c_out")

    @s.input_from(@a_xor_b_xor_c.q)
    @c_out.input_from(@a_xor_b_and_c_or_a_and_b.q)
  end

  def inspect
    "#<FullAdder [#{a.value} + #{b.value} + #{c_in.value}] => [#{c_out.value}#{s.value}]>"
  end

  def add(a, b, c_in)
    self.a.pull(a)
    self.b.pull(b)
    self.c_in.pull(c_in)
    self.result
  end

  def sum
    s.value
  end

  def carry
    c_out.value
  end

  def result
    sum + (carry << 1)
  end
end