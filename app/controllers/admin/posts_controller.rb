module Admin
  class PostsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           "").run
      resources = apply_resource_includes(resources)
      resources = order.apply(resources)
      resources = resources.pg_search(search_term) if search_term.present?
      resources = resources.page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
          resources: resources,
          search_term: search_term,
          page: page,
          show_search_bar: show_search_bar?,
      }
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Post.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
