class ContentModel < ActiveFedora::Base

  has_metadata :name => "descMetadata", :type => ActiveFedora::QualifiedDublinCoreDatastream
  has_metadata :name => "rightsMetadata", :type => Hydra::Datastream::RightsMetadata

  delegate :title, :to => "descMetadata", :unique => true

  belongs_to :admin_policy, :property => :is_governed_by

  include Hydra::ModelMixins::RightsMetadata

  # Pending merge of https://github.com/projecthydra/active_fedora/pull/47
  def audit_trail
    inner_object.audit_trail
  end

end
