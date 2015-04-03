class Item < ActiveRecord::Base

  def image_filename
    return File.exists?(Rails.root.join("app/assets/images/#{image_name}")) ? "#{image_name}" : 'no-photo.png'
  end

  def quantity_remaining
    return quantity_initial - super
  end

  private
    def image_name
      "items/#{name.gsub ':', '_'}-M#{metadata}.png"
    end
end
