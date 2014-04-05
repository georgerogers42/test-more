require "test/more/version"

module Test
	class More
		def initialize(n:nil, s:STDOUT)
			@s = s
			@n = n
			@x = 0
			plan n: @n
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
		def plan n: nil
			puts "1..#{n}" if n
		end

		# Output test plan based on tests executed.
		def done_testing
			plan n: @x unless @n
		end

		class Utils
			def initialize t
				@t = t
			end
			def assert(msg="")
				if x = yield
					@t.ok "#{x} #{msg}"
				else
					@t.not_ok "#{x} #{msg}"
				end
			rescue
				@t.not_ok "#$! #{msg}"
			end
			def assert_success(msg="")
				x = yield
				@t.ok "#{x} #{msg}"
			rescue
				@t.not_ok "#$! #{msg}"
			end
			def assert_fail(msg="")
				v = yield
				@t.not_ok "!#{v} #{msg}"
			rescue
				@t.ok "!#$! #{msg}"
			end
			def assert!(v, msg="")
				if v
					@t.ok "#{v} #{msg}"
				else
					@t.not_ok "#{v} #{msg}"
				end
			end
		end
	end
end
