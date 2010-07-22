require 'eventmachine'
require File.dirname(__FILE__) + '/../ext/fiber18'

module EventMachine
  TestTimeoutExceededError = Class.new(RuntimeError)

  module TestHelper
    
    def self.included(cls)
      cls.class_eval(<<-HERE_DOC, __FILE__, __LINE__)
        DefaultTimeout = nil unless const_defined?(:DefaultTimeout)
        
        def self.default_timeout(timeout)
          self.send(:remove_const, :DefaultTimeout)
          self.send(:const_set, :DefaultTimeout, timeout)
        end
        
        def current_default_timeout
          DefaultTimeout
        end
      HERE_DOC
      
    end
    
    
    def timeout(time_to_run)
      EM.cancel_timer(@_em_timer) if @_em_timer
      @_em_timer = EM.add_timer(time_to_run) { done('timeout exceeded') }
    end
    
    def em(time_to_run = current_default_timeout, &block)
      @flunk_test = nil
      EM.run do
        timeout(time_to_run) if time_to_run
        em_spec_exception = nil
        @_em_spec_fiber = Fiber.new do
          begin
            block.call
          rescue Exception => em_spec_exception
            done
          end
          Fiber.yield
        end
        
        @_em_spec_fiber.resume
        
        raise em_spec_exception if em_spec_exception
      end
      raise(@flunk_test) if @flunk_test
    end

    def done(flunk_reason = nil)
      EM.next_tick{
        @flunk_test = flunk_reason
        finish_em_spec_fiber
      }
    end

    private

    def finish_em_spec_fiber
      EM.stop_event_loop if EM.reactor_running?
      @_em_spec_fiber.resume if @_em_spec_fiber.alive?
    end
    
  end
  
  module Test
  
    def self.included(cls)
      cls.class_eval(<<-HERE_DOC, __FILE__, __LINE__)
        def self.default_timeout(timeout)
          self.send(:remove_const, :DefaultTimeout)
          self.send(:const_set, :DefaultTimeout, timeout)
        end
        
        include TestHelper

        alias_method :run_without_em, :run
        def run(result, &block)
          em(DefaultTimeout) { run_without_em(result, &block) }
        rescue Exception => e
          if RUBY_VERSION >= "1.9.1"
            result.puke(self.class, @name, e)
          else
            add_error($!)
          end
        end
        
      HERE_DOC
      
    end
    
  end
  
end