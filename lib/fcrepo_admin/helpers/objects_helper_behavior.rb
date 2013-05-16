module FcrepoAdmin::Helpers
  module ObjectsHelperBehavior

    def object_title
      "#{object_type} #{@object.pid}"
    end

    def object_type
      @object.class.to_s
    end

    def object_properties
      FcrepoAdmin.object_properties.inject(Hash.new) { |h, p| h[p] = @object.send(p); h }
    end

    def object_show_datastream_columns
      FcrepoAdmin.object_show_datastream_columns
    end

    def object_context_nav_header
	  t("fcrepo_admin.object.nav.header")
    end

    def object_context_nav_items
      FcrepoAdmin.object_context_nav_items.collect do |item|
        content = object_context_nav_item(item)
        content unless content.nil?
      end
    end

    def object_context_nav_item(item)
      condition = case
                  when item == :summary      then true
                  when item == :datastreams  then true
                  when item == :permissions  then @object.has_permissions? && can?(:permissions, @object)
                  when item == :associations then true
                  when item == :audit_trail  then @object.auditable? && can?(:audit_trail, @object)
                  end
      custom_object_context_nav_item(item) if condition.nil?
      link_to_object(item) if condition
    end

    def link_to_object(view)
      label = t("fcrepo_admin.object.nav.items.#{view}")
      path = case
             when view == :summary      then fcrepo_admin.object_path(@object)
             when view == :datastreams  then fcrepo_admin.object_datastreams_path(@object)
             when view == :permissions  then fcrepo_admin.permissions_object_path(@object)
             when view == :associations then fcrepo_admin.object_associations_path(@object)
             when view == :audit_trail  then fcrepo_admin.audit_trail_object_path(@object)
             end
      link_to_unless_current label, path
    end

    def custom_object_context_nav_item(item)
      # Override this method with your custom items
    end
    
  end
end
