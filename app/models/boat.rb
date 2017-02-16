class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    boats = self.all
    boats.order("id ASC LIMIT 5")
  end

  def self.dinghy
    boats = self.all
    boats.where("length < 20")
  end

  def self.ship
    boats = self.all
    boats.where("length > 20")
  end

  def self.last_three_alphabetically
    boats = self.all
    boats.order("name DESC LIMIT 3")
  end

  def self.without_a_captain
    boats = self.all
    boats.where(captain_id: nil)
  end

  def self.sailboats
    self.includes(:classifications).where("classifications.name = ?", "Sailboat")
  end



  def self.with_three_classifications
  Boat.joins(:classifications).group("Boats.id").having("Count(*)=3")
end

  def self.longest_boat
    Boat.order("length DESC").limit(1)[0]
end


end
