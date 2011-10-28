class BugsController < ApplicationController
  http_basic_authenticate_with :name => "freeagent", :password => "secret"

  def index
    @product_bugs = product_bugs
    @platform_bugs = platform_bugs
  end

  def tagged
    @tags = params[:tags].split(',')
    @product_bugs = product_bugs :label => @tags
    @platform_bugs = platform_bugs :label => @tags
  end

  def in_state
    @state = params[:state]
    pt_current_state = case @state
    when 'fixed'
      'accepted'
    when 'in_progress'
      ['started', 'finished', 'rejected']
    when 'scheduled'
      'unstarted'
    when 'unscheduled'
      'unscheduled'
    else
      raise "Unsupported state"
    end

    @product_bugs  = product_bugs  :current_state => pt_current_state
    @platform_bugs = platform_bugs :current_state => pt_current_state
  end

  private
  def projects
    @projects ||= PivotalTracker::Project.all.select { |project| project.account == 'Olly Headey' }
  end

  def product_project
    @product_project ||= projects.find { |project| project.name == 'FreeAgent Product' }
  end

  def platform_project
    @platform_project ||= projects.find { |project| project.name == 'FreeAgent Platform' }
  end

  def product_stories(options)
    product_project.stories.all(options)
  end

  def platform_stories(options)
    platform_project.stories.all(options)
  end

  def product_bugs(options = {})
    product_stories({ :story_type => 'bug' }.merge(options))
  end

  def platform_bugs(options = {})
    platform_stories({ :story_type => 'bug' }.merge(options))
  end
end