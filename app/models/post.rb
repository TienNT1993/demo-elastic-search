
require 'elasticsearch/model'

class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :pg_search, :against => [:title, :content]

  #   elastic search
  include Elasticsearch::Model

end
