module ProcessSpecification
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def process(args, &block)
      name = args[:of]
      self.class_eval do
        self.send(:define_method, name) do  # def uninstall
          context = Context.new
          context.instance_eval(&block)
          context.transitions.each do |t|
            self.send(t)
          end
        end                                 # end
      end
    end
    
    class Context
      attr_reader :transitions
      def initialize
        @transitions = []
      end
      def transition(name, statuses)
        @transitions << name
      end
    end
  end
end