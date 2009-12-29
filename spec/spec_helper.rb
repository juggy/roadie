$: << File.dirname(__FILE__) + '/../lib'
 
require 'rubygems'
require 'spec'
require 'actionmailer'
require 'shemail'

# Extract HTML Part
def html_part(email)
  email.parts.select{|part| part.content_type == 'text/html'}.first.body_port.to_s.strip
end

def css_rules(css)
  @css_rules = css
  
  # Stubs
  File.stub(:exist?).and_return(true)
  File.stub(:open).and_return(StringIO.new(@css_rules))
end

# Debugging helper
module Kernel
  if ENV.keys.find {|env_var| env_var.match(/^TM_/)}
    def rputs(*args)
      puts( *["<pre>", args.collect {|a| CGI.escapeHTML(a.to_s)}, "</pre>"])
    end
  else
    alias_method :rputs, :puts
  end
end