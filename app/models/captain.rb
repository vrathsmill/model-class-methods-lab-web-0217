class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats


  def self.catamaran_operators
    self.includes(:classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
      self.includes(:classifications).where("classifications.name = ?", "Sailboat").group("Captains.name")
  end

  def self.talented_seamen
    sailboat_captains = self.includes(:classifications).where("classifications.name = ?", "Sailboat")
    motorboat_captains = self.includes(:classifications).where("classifications.name = ?", "Motorboat")
    motorboat_captains.where({name: sailboat_captains.pluck(:name)})
end

  def self.non_sailors
    sailor_names = self.includes(:classifications).where("classifications.name = ?", "Sailboat").pluck(:name)
    Captain.where.not(name: sailor_names)
  end


end
