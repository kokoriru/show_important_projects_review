class ImportantProject < ActiveRecord::Base
  unloadable
  belongs_to :project
end
