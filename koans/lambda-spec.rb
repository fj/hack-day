describe "lambdas" do
  context "when they return" do
    it "should return from lambda rather than caller" do
      def m
        l = Proc.new { return :inner }
        l.call
        return :outer
      end
      m.should == :inner
    end
  end
end
