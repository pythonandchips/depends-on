require "spec_helper"

class DependancyA
end

class DependancyB
end

class TestClass
  depends_on :dependancy_a, :dependancy_b, :dependancy_c => lambda { |owner| "a nother dependancy" }
end

describe "add depends on method to class" do
  it "should include DependsOn::MacroMethods into class" do
    Class.include?(DependsOn::MacroMethods).should eql true
  end

  it "should add class leave method #pends_on" do
    Class.respond_to?(:depends_on).should eql true
  end
end

describe "when adding dependancies to instance" do

  subject { TestClass.new }

  it "should respond to dependancy a" do
    subject.respond_to?(:dependancy_a).should eql true
  end

  it "should respond to dependancy a" do
    subject.respond_to?(:dependancy_b).should eql true
  end

  it { subject.dependancy_a.should be_an_instance_of DependancyA}
  it { subject.dependancy_b.should be_an_instance_of DependancyB}
end

describe "when accessing the dependancy" do

  before do
    @test_class = TestClass.new
    @first_access = @test_class.dependancy_a
  end

  it "should return same instance as first access" do
    @test_class.dependancy_a.should be @first_access
  end
end

describe "when factory is defined" do
  before do
    @test_class = TestClass.new
    @dependancy = @test_class.dependancy_c
  end

  it "should resolve factory method" do
    @dependancy.should eql "a nother dependancy"
  end
end
