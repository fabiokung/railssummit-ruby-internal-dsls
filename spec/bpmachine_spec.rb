require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "an DSL for business process executions" do
  
  class Machine
    include ProcessSpecification
    
    process :of => :uninstall do
      transition :destroy_disks,
        :from => :installed,
        :to => :diskless
      
      transition :destroy_vm,
        :from => :diskless,
        :to => :vm_destroyed
    end
  end
  
  it "should execute all steps while running a process" do
    machine = Machine.new
    machine.should_receive :destroy_disks
    machine.should_receive :destroy_vm
    machine.uninstall
  end
  
  it "should create a method for each process" do
    machine = Machine.new
    machine.should respond_to(:uninstall)
  end
  
  
end