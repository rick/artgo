require 'fileutils'

namespace :deploy do
  task :make_db_yml do
    FileUtils.copy(
      File.expand_path(File.join(File.dirname(__FILE__), '/../../config/database.yml.example')),
      File.expand_path(File.join(File.dirname(__FILE__), '/../../config/database.yml'))
    )
  end

  task :post_deploy => [ :make_db_yml ]
end

