require 'mongoid'

module Mongoid
  module Rid
    extend ActiveSupport::Concern

    included do 
      field :_id, type: String, default: ->{ Moped::BSON::ObjectId.new }

      set_callback(:create, :before) do |document|
        self._id = Remong::Rmid.make(document.class.name.downcase)
      end
    end
  end
end