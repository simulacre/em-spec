require 'eventmachine'
require File.dirname(__FILE__) + '/../ext/fiber18'

module EventMachine
  module SpecHelper

    class EMSpecTimeoutError < Timeout::Error
    end

    def em(timeout=nil, &block)

      EM.run do
        em_spec_exception = nil
        @_em_spec_fiber = Fiber.new do
          begin
            block.call
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
  
  module Spec

    include SpecHelper

    def instance_eval(&block)
      em do
        super(&block)
      end
    end

  end
  
end


