# coding: utf-8

require 'spec_helper'

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
