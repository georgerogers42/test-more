#!/usr/bin/env ruby

require 'bundler/setup'
require 'test/more'

t = Test::More.new
u = Test::More::Utils.new t

u.assert! true

t.done_testing
