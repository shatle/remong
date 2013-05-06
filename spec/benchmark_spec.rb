# coding: utf-8

require "spec_helper"
require "benchmark"

# On My computer:
#
# $ rspec spec/benchmark_spec.rb 
#
#               user     system      total        real
# Rid                   :  1.930000   0.140000   2.070000 (  2.206524)
# Moped::BSON::ObjectId :  0.420000   0.040000   0.460000 (  0.458976)
#
# .              user     system      total        real
# Moped::BSON::ObjectId :  0.460000   0.010000   0.470000 (  0.481906)
# Rid                   :  1.970000   0.150000   2.120000 (  2.256055)

describe "#benchmark" do 

  after(:each) do 
    Article.all.delete
    Post.all.delete
  end

  it "should report result 1: " do 
    Benchmark.bm(7) do |x|
      x.report("Rid                   :") { 
        (1..1000).each { Article.create({:title => 'title1'}) } 
      }
      x.report("Moped::BSON::ObjectId :") { 
        (1..1000).each { Post.create({:title => 'title1'}) }
      }
    end
  end

  it "should report result 2: " do 
    Benchmark.bm(7) do |x|
      x.report("Moped::BSON::ObjectId :") { 
        (1..1000).each { Post.create({:title => 'title1'}) }
      }
      x.report("Rid                   :") { 
        (1..1000).each { Article.create({:title => 'title1'}) } 
      }
    end
  end

end 