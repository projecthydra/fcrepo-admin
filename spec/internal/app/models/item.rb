class Item < ActiveFedora::Base

  has_metadata :name => "descMetadata", :type => ActiveFedora::QualifiedDublinCoreDatastream
  has_metadata :name => "rightsMetadata", :type => Hydra::Datastream::RightsMetadata

  delegate :title, :to => "descMetadata", :unique => true

  belongs_to :admin_policy, :property => :is_governed_by
  belongs_to :collection, :property => :is_member_of_collection, :class_name => 'Collection'
  has_many :parts, :property => :is_part_of, :inbound => true, :class_name => 'Part'

  include Hydra::ModelMixins::RightsMetadata
  include ActiveFedora::Auditable

end
