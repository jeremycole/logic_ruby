class Logic::Blocks::ChainedAdder < Logic::Gate
  attr_reader :size
  attr_reader :adders

  def initialize(size)
    @size = size
    @adders = []
    size.times do |n|
      @adders[n] = Logic::Blocks::FullAdder.new
      @adders[n].c_in.input_from(@adders[n-1].c_out) unless n.zero?
    end
  end

  def inspect
    a = ""
    b = ""
    s = ""
    size.times.to_a.reverse.each do |n|
      a << adders[n].a.value.to_s
      b << adders[n].b.value.to_s
      s << adders[n].s.value.to_s
    end
    "#<ChainedAdder [#{a} + #{b}] => [#{carry}#{s}]>"
  end

  def add(a, b, c_in=false)
    size.times do |n|
      bit = 1 << n
      @adders[n].a.pull(a & bit == bit)
      @adders[n].b.pull(b & bit == bit)
    end
    @adders[0].c_in.pull(c_in)
    result
  end

  def sum
    size.times.inject(0) { |sum, n| sum + (@adders[n].sum << n) }
  end

  def carry
    @adders.last.c_out.value
  end

  def result
    sum + (carry << size)
  end
end