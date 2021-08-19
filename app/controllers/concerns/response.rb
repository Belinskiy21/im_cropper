module Response

  def choose_response(result)
    if result.is_a?(MiniMagick::Image)
      send_file result.path, disposition: :inline
    else
      json_response(result, :not_found)
    end
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
