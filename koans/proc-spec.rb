describe "procs" do
  context "when they return" do
    it "should return from caller rather than proc" do
      def m
        l = lambda { return :inner }
        l.call
        return :outer
      end
      m.should == :outer
    end
  end
end
