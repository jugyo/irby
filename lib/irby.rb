module Kernel
  def irb
    require 'irb'
    IRB.setup(nil)
    irb = IRB::Irb.new(IRB::WorkSpace.new(binding))
    IRB.conf[:MAIN_CONTEXT] = irb.context
    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end
