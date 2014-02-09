class Bet < ActiveRecord::Base
  belongs_to :tipster

  VALID_OUTCOMES = %w(pending win loss)

  validates_inclusion_of :outcome, :in => VALID_OUTCOMES

  def outcome_enum
    # Do not select any value, or add any blank field. RailsAdmin will do it for you.
    VALID_OUTCOMES
  end
end
