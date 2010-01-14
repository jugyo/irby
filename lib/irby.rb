require 'irb'

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
  def irb
    IRB.start_session(binding)
  end
end
