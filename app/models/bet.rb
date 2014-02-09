class Bet < ActiveRecord::Base
  belongs_to :tipster
  belongs_to :match

end
