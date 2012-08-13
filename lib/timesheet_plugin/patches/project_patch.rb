module TimesheetPlugin
  module Patches
    module ProjectPatch
      extend ActiveSupport::Concern

      included do
        unloadable

        # Prefix our named_scopes to prevent collusion
        scope :timesheet_order_by_name, order('name ASC')
        scope :timesheet_with_membership, lambda { |user|
          # Similar to Project.visible_by but without the STATUS check
          if user && user.memberships.any?

            # Principal#members gets all projects, but #memberships will only
            # get the active ones
            if Setting.plugin_timesheet['project_status'] == 'all'
              project_ids = user.members.collect { |m| m.project_id }
            else
              project_ids = user.memberships.collect { |m| m.project_id }
            end

            {
                :conditions => [
                    "#{Project.table_name}.is_public = :true or #{Project.table_name}.id IN (:project_ids)",
                    {
                        :true        => true,
                        :project_ids => project_ids
                    }
                ]
            }
          else
            {
                :conditions => { :is_public => true }
            }
          end
        }
      end

      module ClassMethods
      end

    end
  end
end
