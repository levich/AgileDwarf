class AllSprintsController < ApplicationController
  unloadable

  def index
    @backlog = SprintsTasks.get_backlog.group_by(&:project_id).each {|project_id, sprint_tasks| sprint_tasks.sort!{|a,b| a.parent_id || 0 <=> b.parent_id || 0 } }
    @sprints = Sprints.all_sprints.group_by(&:project_id)
    # @sprints.each{|s| s['tasks'] = SprintsTasks.get_tasks_by_sprint(@project, [s.id])}
    # @assignables = {}
    # @project.assignable_users.each{|u| @assignables[u.id] = u.firstname + ' ' + u.lastname}
    # @project_id = @project.id
    @plugin_path = File.join(Redmine::Utils.relative_url_root, 'plugin_assets', 'agile_dwarf')
    @closed_status = Setting.plugin_agile_dwarf["stclosed"].to_i
  end
end
