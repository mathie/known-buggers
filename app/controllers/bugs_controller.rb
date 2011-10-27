class BugsController < ApplicationController
  http_basic_authenticate_with :name => "freeagent", :password => "secret"

  def index
    projects = PivotalTracker::Project.all.select { |project| project.account == 'Olly Headey' }
    product_project  = projects.find { |project| project.name == 'FreeAgent Product' }
    platform_project = projects.find { |project| project.name == 'FreeAgent Platform' }
    @product_bugs = product_project.stories.all :story_type => 'bug'
    @platform_bugs = platform_project.stories.all :story_type => 'bug'
  end
end