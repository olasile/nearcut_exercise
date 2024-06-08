class Upload
  attr_accessor :file

  def initialize(file = nil)
    @file = file
  end

  def process
    UploadService.new(self).perform
  end
end