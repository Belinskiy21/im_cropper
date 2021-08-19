class ThumbnailsController < ApplicationController
  include Response
  resource_description do
    short 'This endpoint will use for cropp image. It is public.'
  end


  api :GET, '/thumbnails', 'for call api cropper'
  param :uri, String, desc: 'uri for fetch and save image', required: true
  param :width, String, desc: 'width of resulting image', required: true
  param :height, String, desc: 'height or resulting image', required: true
  returns code: 200, desc: 'resulting image in base64 format'
  def index
    result = ImageService.new(params[:uri], params[:width], params[:height]).call
    choose_response(result)
  end
end
