class Post < ActiveRecord::Base
    # association macro
    belongs_to :user
    # model validations
    validates :content, presence: true
    validates :content, length: { minimum: 3}
end