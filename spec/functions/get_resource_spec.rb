require 'spec_helper'
require 'puppet/pops'

#describe 'get_details' do
#  it "test this crap" do
#    Puppet::Parser::Functions.autoloader.loadall
#    @compiler = Puppet::Parser::Compiler.new(Puppet::Node.new("foo"))
#    @scope = Puppet::Parser::Scope.new(@compiler)
#    resource = Puppet::Resource.new("user", "foo")
#    @compiler.add_resource(@scope, resource)
#    expect(@scope.function_get_details([resource])).to be_true
#  end
#end

describe 'get_resource' do

  before :all do
    Puppet::Parser::Functions.autoloader.loadall
  end

  before :each do
    @compiler = Puppet::Parser::Compiler.new(Puppet::Node.new("foo"))
    @scope = Puppet::Parser::Scope.new(@compiler)
  end

  it {
    resource = Puppet::Resource.new("user", "foo")
    @compiler.add_resource(@scope, resource)
    expect(@scope.function_get_resource([resource, 'home'])).to be_true
  }
end
