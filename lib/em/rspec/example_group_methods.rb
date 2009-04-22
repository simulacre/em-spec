module Spec
  module Example
    module ExampleMethods

      def instance_eval(&block)
        
        EM.run do
          @_em_spec_fiber = :goo
          em_spec_exception = nil
          @_em_spec_fiber = Fiber.new do
            begin
              super(&block)
            rescue Exception => em_spec_exception
              resume_on_error
            end
            Fiber.yield
          end  
          
          @_em_spec_fiber.resume
          
          raise em_spec_exception if em_spec_exception
        end
      end

      def done
        EM.next_tick{
          :done.should == :done
          finish_em_spec_fiber
        }
      end

      private

      def resume_on_error
        EM.next_tick{
          finish_em_spec_fiber
        }
      end
      
      def finish_em_spec_fiber
        EM.stop_event_loop if EM.reactor_running?
        @_em_spec_fiber.resume if @_em_spec_fiber.alive?
      end

    end

  end
end