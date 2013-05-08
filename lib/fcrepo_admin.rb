require 'fcrepo_admin/engine'
require 'blacklight'
require 'hydra/head'

module FcrepoAdmin
  autoload :SolrDocumentExtension, 'fcrepo_admin/solr_document_extension'
  autoload :Ability, 'fcrepo_admin/ability'
  module Helpers
    autoload :BlacklightHelperBehavior, 'fcrepo_admin/helpers/blacklight_helper_behavior'
    autoload :ObjectsHelperBehavior, 'fcrepo_admin/helpers/objects_helper_behavior'
    autoload :DatastreamsHelperBehavior, 'fcrepo_admin/helpers/datastreams_helper_behavior'
    autoload :AssociationsHelperBehavior, 'fcrepo_admin/helpers/associations_helper_behavior'
    autoload :FcrepoAdminHelperBehavior, 'fcrepo_admin/helpers/fcrepo_admin_helper_behavior'
  end
  module Controller
    autoload :ControllerBehavior, 'fcrepo_admin/controller/controller_behavior'
  end
end
