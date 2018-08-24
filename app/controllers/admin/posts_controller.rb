module Admin
  class PostsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def index
      # resources = pg_search
      resources = elastic_search
      resources = order.apply(resources)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
          resources: resources,
          search_term: search_term,
          page: page,
          show_search_bar: show_search_bar?,
      }
    end

    def pg_search
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           "").run
      resources = apply_resource_includes(resources)
      resources = resources.pg_search(search_term) if search_term.present?
      resources = resources.page(params[:page]).per(records_per_page)
      resources
    end

    def elastic_search
      WillPaginate.per_page = records_per_page
      return Post.search(search_term).page(params[:page]) if search_term.present?
      Post.page(params[:page])

    end


    def search_term
      params[:search].to_s.strip
    end

  end
end
