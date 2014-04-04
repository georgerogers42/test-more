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
		def ok(msg="")
			@x += 1
			puts "ok #@x - #{msg}"
		end
		def not_ok(msg="")
			@x += 1
			puts "not ok #@x - #{msg}"
		end
		def plan n:nil
			puts 1..n if n
		end
		def done_testing
			plan @x if not @n
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
