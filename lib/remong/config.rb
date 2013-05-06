# coding: utf-8
require 'redis'
require 'redis-namespace'
    
module Remong 
	class << self
    attr_accessor :redis

    alias old_redis redis

    def redis
      return old_redis if old_redis
      select_redis = Redis.new(:host=> "127.0.0.1", :port => "6379")
      return Redis::Namespace.new("remong", :redis => select_redis)
    end
  end
end
