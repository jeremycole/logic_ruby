class Logic::Gates::Or < Logic::Gates::TwoInputOneOutput
  def perturb(input, previous_state, state)
    super
    @q.pull(@a.state | @b.state)
  end
end