# README

this is introduction to test the speed of elastic search

## search by pg search

* pull the repository

* run <code> bundle install</code>

* config the database on file database.yml

* run <code> rake db:create</code> to create the database

* <code>rake db:migrate</code>

* <code>rake db:seed</code> 1 or twice times to create big fake data 

* install the elastic search server and start the server 

* in post controller you can choose search list of posts by pg_search or elastic_serach
to see different.




<pre><code>

 def index
  resources = elastic_search # or pg_search
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
  resources = order.apply(resources)
  resources = resources.pg_search(search_term) if search_term.present?
  resources = resources.page(params[:page]).per(records_per_page)
  resources
 end

def elastic_search
  return Post.search(search_term).page(params[:page]).records if search_term.present?
  Post.paginate(:page => params[:page], :per_page => records_per_page)
end
</code></pre>


