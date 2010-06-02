describe "self" do
  it "should always exist" do
    self.should_not be_nil
  end
  
  it "should be reference-immutable" do
    lambda { eval("self = 42") }.should raise_error
  end
end
