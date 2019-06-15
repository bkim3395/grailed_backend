class DisallowedUsername < ApplicationRecord
    validates :invalid_username, presence: true
    
end