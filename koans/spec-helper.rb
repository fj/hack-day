class Oracle
  def metaclass
    class << self; self; end
  end
end
