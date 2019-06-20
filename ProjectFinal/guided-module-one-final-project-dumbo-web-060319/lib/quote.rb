class Quote < ActiveRecord::Base
    attr_accessor :is_favorite
    has_many :answers
    has_many :candidates, through: :answers


end