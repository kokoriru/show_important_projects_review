require_dependency 'project'

module ShowImportantProjectsReview
  module ProjectPatch
    extend ActiveSupport::Concern

    included do
      unloadable
      has_one :important_project, dependent: :destroy
      safe_attributes :important_project_attributes
      accepts_nested_attributes_for :important_project

      scope :importants, -> { joins(:important_project).where(important_projects: { is_important: true }) }
    end

    def important?
      important_project.try(:is_important?)
    end
  end
end

ActionDispatch::Reloader.to_prepare do
  unless Project.included_modules.include?(ShowImportantProjectsReview::ProjectPatch)
    Project.send(:include, ShowImportantProjectsReview::ProjectPatch)
  end
end
