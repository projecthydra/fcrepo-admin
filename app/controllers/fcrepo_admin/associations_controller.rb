module FcrepoAdmin
  class AssociationsController < ApplicationController

    layout 'fcrepo_admin/objects'

    include FcrepoAdmin::Controller::ControllerBehavior

    before_filter :load_and_authorize_object
    before_filter :load_association, :only => :show

    def index
    end

    def show
      if @association.nil?
        render :text => "Association not found", :status => 404
      elsif @association.collection?
        @response, @documents = get_collection_from_solr
      else 
        # This shouldn't normally happen b/c UI links directly to target object view in this case
        # but we'll handle it gracefully anyway.
        target = @object.send("#{@association.name}_id")
        if target
          redirect_to :controller => 'objects', :action => 'show', :id => target, :use_route => 'fcrepo_admin'
        else
          render :text => "Target not found", :status => 404
        end
      end
    end

    protected

    def get_collection_from_solr
      solr_response = solr_response_for_raw_result(get_collection_query_result)
      [solr_response, solr_documents_for_response(solr_response)]
    end

    def get_collection_query_result
      ActiveFedora::SolrService.query(collection_query, collection_query_args)
    end

    def collection_query_args
      page = params[:page].blank? ? 1 : params[:page].to_i
      rows = FcrepoAdmin.association_show_docs_per_page
      start = (page - 1) * rows
      args = {raw: true, start: start, rows: rows}
      if FcrepoAdmin.association_collection_query_sort_param
        args[:sort] = FcrepoAdmin.association_collection_query_sort_param
      end
      apply_gated_discovery(args, nil) # add args to enforce Hydra access controls
      args
    end

    def collection_query
      @object.send(params[:id].to_sym).send(:construct_query)
    end

    def load_association
      @association = @object.reflections[params[:id].to_sym]
    end

  end
end
