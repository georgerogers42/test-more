require "test/more/version"

module Test
	class More
		def initialize(plan:nil, s:STDOUT)
			@s = s
			@n = plan
			@x = 0
      output_plan @n
		end
		def puts *args
			@s.puts args
		end

		# Record test success.
		def ok(msg="")
			@x += 1
			puts "ok #@x - #{msg}"
		end

		# Record test failure.
		def not_ok(msg="")
			@x += 1
			puts "not ok #@x - #{msg}"
		end

		# Output test plan.
		def plan
      @n
		end
    def plan= n
      @n = n
    end

    def output_plan p
      puts "#{@n}"
    end
		# Output test plan based on tests executed.
		def done_testing
			@n = 1..@x
      output_plan @n
		end

    module Utility
      attr_reader :tester
			def initialize t
				@tester = t
			end
      def method_missing m, *args, &blk
        @tester.send(m, *args, &blk)
      end
    end

		class Utils
      include Utility
			def assert(msg="")
				if x = yield
					ok "#{x} #{msg}"
				else
					not_ok "#{x} #{msg}"
				end
			rescue
				not_ok "#$! #{msg}"
			end
			def assert_success(msg="")
				x = yield
				ok "#{x} #{msg}"
			rescue
				not_ok "#$! #{msg}"
			end
			def assert_fail(msg="")
				v = yield
				not_ok "!#{v} #{msg}"
			rescue
				ok "!#$! #{msg}"
			end
			def assert!(v, msg="")
				if v
					ok "#{v} #{msg}"
				else
					not_ok "#{v} #{msg}"
				end
			end
		end
	end
end
