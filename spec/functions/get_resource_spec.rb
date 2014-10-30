require 'spec_helper'
#require 'puppet/pops'

describe 'get_resource' do

  before :all do
    Puppet::Parser::Functions.autoloader.loadall
  end

  before :each do
    @compiler = Puppet::Parser::Compiler.new(Puppet::Node.new("foo"))
    @scope = Puppet::Parser::Scope.new(@compiler)
  end

  it "retrieve home parameter from user foo resource" do
    resource = Puppet::Resource.new("user", "foo", {:parameters => {:home => '/bar'}})
    @compiler.add_resource(@scope, resource)
    expect(@scope.function_get_resource([resource, 'home'])).to eq('/bar')
  end 

  it "retrieve all parameters from user foo resource" do
    resource = Puppet::Resource.new("user", "foo", {:parameters => {:home => '/bar', :uid => '1001'}})
    @compiler.add_resource(@scope, resource)
    expect(@scope.function_get_resource([resource])).to match('home' => '/bar', 'uid' => '1001')
  end

  it "retrieve home parameter from nonexisting resource" do
    resource = Puppet::Resource.new("user", "foo", {:parameters => {:home => '/bar', :uid => '1001'}})
    expect(@scope.function_get_resource([resource, 'home'])).to be_nil
  end

  it "retrieve all parameters from nonexisting resource" do
    resource = Puppet::Resource.new("user", "foo", {:parameters => {:home => '/bar', :uid => '1001'}})
    expect(@scope.function_get_resource([resource])).to be_nil
  end

end
