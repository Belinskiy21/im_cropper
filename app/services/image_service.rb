require 'open-uri'
class ImageService
  def initialize(origin_uri, result_width, result_height)
    @origin_uri = origin_uri
    @result_width = result_width
    @result_height = result_height
  end

  def call
    fetch_image
    return { message: 'Image not found' } unless @response
    process_image
  end

  protected

  def fetch_image
    begin
      @response = open(@origin_uri)
    rescue OpenURI::HTTPError => ex
      puts 'ERROR: Image not found during uri open'
    end
    if @response
      fileIO = @response.to_io.to_io
      @image = MiniMagick::Image.open(fileIO)
      @image.format('jpeg')
    end
  end

  def process_image
    if cropable?
      @image.resize("#{@result_width}x#{@result_height}")
    else
      add_paddings
    end
  end

  def cropable?
    @image.width >= @result_width.to_i || @image.height >= @result_height.to_i
  end

  def add_paddings
    @image.combine_options do |c|
      c.extent("#{@result_width}x#{@result_height}")
      c.gravity('center')
      c.background('black')
    end
  end
end
