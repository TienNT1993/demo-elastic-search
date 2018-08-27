class CreateIndexForPosts < ActiveRecord::Migration[5.2]
  def change
    execute <<-sql
      CREATE INDEX pg_serach_index ON posts USING gin(to_tsvector('english', content || ' ' || title));
    sql
  end
end
