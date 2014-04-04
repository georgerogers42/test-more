require "test/more/version"

module Test
  class More
		def initialize(n=nil)
			@n = n
			@x = 0
			puts "1..#@n" if @n
		end
		def ok(msg="")
			@x += 1
			puts "ok #@x - #{msg}"
		end
		def not_ok(msg="")
			@x += 1
			puts "not ok #@x - #{msg}"
		end
		def assert(msg="") 
			if x = yield
				ok "#{x} #{msg}"
			else
				not_ok "#{x} #{msg}"
			end
		rescue
			not_ok "#$! #{msg}"
		end
		def assert_fail(msg="")
			v = yield
			not_ok "#{v} #{msg}"
		rescue
			ok "#$! #{msg}"
		end
		def assert!(v, msg="")
			if v
				ok "#{v} #{msg}"
			else
				not_ok "#{v} #{msg}"
			end
		end
		def done_testing
			puts "1..#@x" unless @n
		end
  end
end
