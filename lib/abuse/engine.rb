module Abuse
  # Abuse engine
  class Engine < ::Rails::Engine
    isolate_namespace Abuse
    config.generators do |g|
      g.test_framework :rspec
      g.factory_girl dir: 'spec/factories'
    end
    # run migrations in wrapper Rails app
    # No need for rake mercury:install:migrations anymore ;-)
    # see: https://content.pivotal.io/blog/leave-your-migrations-in-your-rails-engines
    initializer :append_migrations do |app|
      # Don't expaned the path when using test app (duplicate migration errors)
      if !app.root.to_s.match(root.to_s) && (app.root.to_s =~ /\/spec\/test_app/).nil?
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
    initializer 'model_core.factories', after: 'factory_girl.set_factory_paths' do
      if defined?(FactoryGirl)
        FactoryGirl.definition_file_paths <<
          File.expand_path('../../../spec/factories', __FILE__)
      end
    end
  end
end
