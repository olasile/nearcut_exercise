class Upload
  extend ActiveModel::Naming

  attr_accessor :file

  def initialize(file = nil)
    @file = file
  end

  def persisted?
    false
  end

  def to_model
    self
  end

  def process
    UploadService.new(self).perform
  end
end