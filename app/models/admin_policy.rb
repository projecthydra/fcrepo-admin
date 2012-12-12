class AdminPolicy < Hydra::AdminPolicy
  # AdminPolicy does not subclass DulHydra::Models::Base
  # b/c Hydra::AdminPolicy provides all the datastreams it needs.

  APO_NAMESPACE = "duke-apo"
  # Fedora PID of the default APO object
  DEFAULT_APO_PID = "#{APO_NAMESPACE}:default"
                                   
  # Standard APO permission (by convention)
  APO_PERMISSIONS = [DulHydra::Permissions::ADMIN_GROUP_ACCESS]

  # Create the default APO and return it
  def self.create_default_apo!
    apo = AdminPolicy.new(:pid => DEFAULT_APO_PID, :label => "Default Admin Policy")
    apo.default_permissions = DulHydra::Permissions::DEFAULT_PERMISSIONS
    apo.permissions = APO_PERMISSIONS
    apo.save!
    return apo
  end

  # Return the default APO, raises ActiveFedora::ObjectNotFoundError if not exists
  def self.get_default_apo
    AdminPolicy.find(DEFAULT_APO_PID)
  end

end
