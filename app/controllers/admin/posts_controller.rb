module Admin
  class PostsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def index

      resources = pg_search
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
      resources = order.apply(resources)
      # pg fulltext search
      resources = resources.pg_search(search_term) if search_term.present?

      # elastic search
      # resources = resources.search(search_term) if search_term.present?

      resources = resources.page(params[:page]).per(records_per_page)
      resources
    end

    def elastic_search
    #   todo: some code in here
    end


    def search_term
      params[:search].to_s.strip
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Post.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
