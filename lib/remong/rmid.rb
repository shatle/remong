# coding: utf-8
module Remong
  module Rmid
    class << self
      def make(model_name)
        Maker.new(model_name).incr
      end
    end    

    class Maker
      def initialize(m_name)
        @model_name = m_name
        Remong.redis.set("#{@model_name}:id", 0) unless Remong.redis.get("#{@model_name}:id")
      end

      def incr
        Remong.redis.incr("#{@model_name}:id")
      end
    end
  end
end