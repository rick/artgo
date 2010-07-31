require 'fileutils'

namespace :deploy do
  task :make_db_yml do
    FileUtils.copy(
      File.expand_path(File.join(File.dirname(__FILE__), '/../../config/database.yml.example')),
      File.expand_path(File.join(File.dirname(__FILE__), '/../../config/database.yml'))
    )
  end

  task :make_dirs do
    %w(tmp db log).each do |path|
      dir = File.expand_path(File.join(File.dirname(__FILE__), "/../../#{path}"))
      FileUtils.mkdir(dir) unless File.exists?(dir)
    end
  end

  task :post_deploy => [ :make_db_yml, :make_dirs ]
end

