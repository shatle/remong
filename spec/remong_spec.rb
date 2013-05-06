# coding: utf-8
#

require 'spec_helper'

describe Remong do 
	
	it "should show version: 0.0.1 " do 
		Remong::VERSION.should == "0.0.1"
	end 

	it "should default to link to redis successfully" do
		Remong.redis.should_not == nil
	end 

	it "should link to redis successfully from creating one" do
		require 'redis'
		require 'redis-namespace'

		redis = Redis.new(:host=>"127.0.0.1", :port => "6379")
		Remong.redis = Redis::Namespace.new('remong_new', :redis => redis)
		Remong.redis.should_not == nil
	end 

	it "rmid should not be same value" do 
		arr = []
		# if max is 1000 which is accepted, but not 10000.
		
		(0..100).each do |index|
			Thread.new do 
				# p "Thread 1 start: #{arr.sort}"
				id = Remong::Rmid.make('test')
				arr.include?(id).should be_false
				arr << id 
				# p "Thread 1 end: #{arr.sort}"
			end
		end

		(0..100).each do |index|
			Thread.new do 
				# p "Thread 2 start: #{arr.sort}"
				id = Remong::Rmid.make('test')
				arr.include?(id).should be_false
				arr << id 
				# p "Thread 2 end: #{arr.sort}"
			end
		end

		# exit until all threads finished
		all = Thread.list
		all.each {|t| t.join unless t == Thread.current or t == Thread.main }
	end

end
