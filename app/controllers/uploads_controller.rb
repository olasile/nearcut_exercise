class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params[:file])
    @results = @upload.process
  rescue UploadError => e
    flash.now[:alert] = e.message
  end

  private

  def upload_params
    params.require(:upload).permit(:file)
  end
end