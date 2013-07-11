# Add helper configuration methods for multistage extension.
module Capistrano
  class Configuration
    # Require multistage extension first to define
    # variables and callbacks required.
    #
    #   require "capistrano/ext/multistage"
    #   require "morestage"
    #
    #   add_stage "test" do
    #     server "hostname...", :app
    #     ...
    #   end
    def add_stage(name, options = {})
      raise "require multistage first" unless exists?(:stages)
      raise ArgumentError, "expected a block" unless block_given?

      # Define a task for the stage
      desc "Set the target stage to `#{name}'."
      task name do |*args|
        set :stage, name.to_sym
        yield *args
      end

      # Add the stage
      stages << name.to_s

      # Exclude the stage task from the callback
      callbacks[:start].each do |callback|
        if callback.source == "multistage:ensure"
          callback.except << name.to_s
        end
      end

      if options[:default]
        set :default_stage, name.to_sym
      end
    end
  end
end
