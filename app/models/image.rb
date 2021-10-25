class Image < ApplicationRecord
  mount_uploader :img, ImageUploader
end
