
require 'elasticsearch/model'

class Post < ApplicationRecord
  self.per_page = 20
  include PgSearch
  pg_search_scope :pg_search, :against => [:title, :content]

  #   elastic search
  include Elasticsearch::Model

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english', index_options: 'offsets'
      indexes :content, analyzer: 'english', index_options: 'offsets'
    end
  end

end
