module Puppet::Parser::Functions
  newfunction(:get_resource, :type => :rvalue, :doc => "Traverses the catalog for a resource
              and returns the whole resource as a hash, or optionally if you provide the second
              arg, that particular parameter of the resource.

              For example:
              user { 'foo': home => '/bar' }
              $home = get_resource(User['foo'], 'home')

              Caveat: just as the native 'defined' function this suffers from being dependent on parse
              order so keep that in mind.

              Also, if the parameter value data type is anything else than int or str this function will squash it.
             ") do |val|
    rs = compiler.findresource(val[0].type, val[0].title)
    if val[1] != nil
      if rs != nil
        rs.parameters[val[1].to_sym].to_s.sub(/^#{val[1]} => /) {} if rs.parameters.has_key? val[1].to_sym
      else
        nil
      end
    else
      if rs != nil
        rs.parameters.reduce({}) { |hash, (k,v)| hash.merge( k.to_s => v.to_s.sub(/^#{k.to_s} => /) {} ) }
      else
        nil
      end
    end
  end
end
