require 'irb'

module IRBy
  def self.binding_stack
    @binding_stack ||= []
  end
end

set_trace_func lambda { |event, file, line, id, binding, klass|
  case event
  when /call$/
    IRBy.binding_stack << binding
  when /return$/
    IRBy.binding_stack.pop
  end
}

module IRB
  def self.start_session(binding)
    unless @__irb_initialized
      args = ARGV.dup
      ARGV.clear
      IRB.setup(nil)
      ARGV.replace(args)
      @__irb_initialized = true
    end

    workspace = WorkSpace.new(binding)

    irb = Irb.new(workspace)

    @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
    @CONF[:MAIN_CONTEXT] = irb.context

    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end

class Object
  def irb(specific_binding = nil)
    if specific_binding
      target_binding = specific_binding
    else
      caller_binding = IRBy.binding_stack[-2]
      if self == caller_binding.eval('self')
        target_binding = caller_binding
      else
        target_binding = binding
      end
    end

    IRB.start_session(target_binding)
  end
  alias_method :irby, :irb
end
