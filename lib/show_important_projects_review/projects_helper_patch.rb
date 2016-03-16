require_dependency 'projects_helper'

module ShowImportantProjectsReview
  module ProjectsHelperPatch
    extend ActiveSupport::Concern

    included do
      alias_method_chain :render_project_hierarchy, :show_important_projects_review
    end

    def render_project_hierarchy_with_show_important_projects_review(projects)
      s = render_important_projects
      s << render_project_hierarchy_without_show_important_projects_review(projects)
      s.html_safe
    end

    private

    def render_important_projects
      s = "<h2>重要プロジェクト</h3><ul id='important_projects' class='projects root'>"
      Project.importants.each do |project|
        s << "<li id='favorite_#{project.id}' class='root'><div class='root'>"
        s << link_to_project(project, {}, class: "#{project.css_classes} #{User.current.member_of?(project) ? 'my-project' : nil}")
        s << '</div></li>'
      end
      s << '</ul>'
      s << "<hr style='margin: 24px 0;' />"
    end
  end
end

ActionDispatch::Reloader.to_prepare do
  unless ProjectsHelper.included_modules.include?(ShowImportantProjectsReview::ProjectsHelperPatch)
    ProjectsHelper.send(:include, ShowImportantProjectsReview::ProjectsHelperPatch)
  end
end