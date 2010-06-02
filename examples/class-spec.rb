describe "classes" do
  before :each do
    class X; end
  end

  it "should have a superclass" do
    obj = X.new
    obj.class.superclass
  end
  
  it "should have a superclass whose type is broader" do
    obj = X.new
    obj.class.should < obj.class.superclass
  end
  
  it "should have a superclass whose type is at least not narrower" do
    obj = X.new
    obj.class.should_not >= obj.class.superclass
  end
  
  it "should have Object in inheritance hierarchy" do
    X.ancestors.include?(Object).should be_true
  end
end
