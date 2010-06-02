describe "object model" do
  before :each do
    class X
      def metaclass
        class << self; self; end
      end
    end
    
    def metaclass(obj)
      class << obj; self; end
    end
  end

  it "should provide metaclasses for objects" do
    obj = X.new
    obj.metaclass.should_not be_nil
  end
  
  it "should provide metaclasses for objects which themselves have metaclasses" do
    obj = X.new
    metaclass(metaclass(obj)).should_not be_nil
  end
  
  it "should provide metaclasses which recursively have metaclasses" do
    obj = X.new
    100.times do
      obj = metaclass(obj)
      obj.should_not be_nil
    end
  end
  
  it "should provide metaclasses even if the object is a Module and not a Class" do
    obj = X.new
    metaclass(Module.new).should_not be_nil
  end
  
  it "should provide metaclasses of superclasses that are the same as superclasses of metaclasses" do
    class A; end
    class B < A; end
    
    left = metaclass(B.superclass)
    right = metaclass(B).superclass
    left.should == right
  end
end
