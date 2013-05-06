# coding: utf-8

require 'rubygems'
require 'bundler'
require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'mongoid'
Mongoid.load!(File.dirname(__FILE__)+'/mongoid.yml', :test)
require 'remong'

class Article
  include Mongoid::Document
  include Mongoid::Rid

  field :title, :type => String

end

class Post
  include Mongoid::Document

  field :title, :type => String

end