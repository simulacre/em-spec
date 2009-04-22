require File.dirname(__FILE__) + '/../lib/em/spec'

EM.rspec EventMachine, "when running failing examples" do
  it "should not bubble failures beyond rspec" do
    #em do
      EM.add_timer(0.1) do
        :should_not_bubble.should == :failures
        done
      end
    #end
  end

  it "should not block on failure" do
     1.should == 2
  end

  
end