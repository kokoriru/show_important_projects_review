class ImportantProject < ActiveRecord::Base
  unloadable
  belongs_to :project
  attr_accessible :is_important
end
