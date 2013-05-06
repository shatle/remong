# coding: utf-8

require 'mongoid'
Mongoid.load!(File.dirname(__FILE__)+'/mongoid.yml', :test)
require 'remong'

class Article
	include Mongoid::Document
  include Mongoid::Rid

	field :title, :type => String
	field :content, :type => String 
	field :tags, :type => String 

end

describe Article do 
  after(:each) do 
    Article.all.delete
  end

  context "#new" do 
    it "should Moped::BSON::ObjectId" do 
      article = Article.new({:title => 'title1'})
      article.id.length.should == 24 #Moped::BSON::ObjectId 's length
    end
  end

  context "#create" do 
    it "should redis create id" do 
      article = Article.create({:title => 'title1'})
      article.id.length.should < 10
    end
  end
end
