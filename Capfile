#
# Use multistage extension.
#

set :stage_dir, "stages"
set :default_stage, "use_hosts_env"

task :use_hosts_env do
  unless ENV["HOSTS"]
    raise Capistrano::NoMatchingServersError,
          "Use HOSTS to give servers to apply, also use SSH_USER, SSH_PORT and SSH_KEYS."
  end
end

# NOTE need to require multistage after setting stage_dir.
require "capistrano/ext/multistage"

#
# Common Capistrano Configurations
#

# Use default login user.
set :user, ENV["DEPLOY_USER"] || ENV["SSH_USER"] || "root"

# By default, Capistrano will try to use sudo to do certain operations.
set :use_sudo, false
# Allocate pseudo-tty for each command.
default_run_options[:pty] = true

# Give a way to override default SSH parameters.
#ssh_options[:user] = ENV["SSH_USER"] if ENV["SSH_USER"]
ssh_options[:port] = ENV["SSH_PORT"] if ENV["SSH_PORT"]
ssh_options[:keys] = ENV["SSH_KEYS"] if ENV["SSH_KEYS"]

#
# Deploy Recipe Configurations
#

# Use Capistrano default deploy recipe which, I know, includes many
# Rails specific things though.
load "deploy"

set :application, "puppet"

# Copy the current working directory or local HEAD to the remote hosts.
set :repository, File.expand_path("../", __FILE__)
set :deploy_via, :copy
# To use the current working directory, use `set :scm, :none`.
# Default :scm is :git which checkouts local HEAD instead.
set :scm, :none

set :deploy_to, "/tmp/#{application}"

# Avoid Rails specific directories creation and normalization.
set :shared_children, []
set :normalize_asset_timestamps, false

# Chain deploy tasks
before "deploy:update", "deploy:setup"
after "deploy", "deploy:cleanup"

#
# Puppet Recipe
#

namespace :puppet do
  desc "Update puppet manifests then apply"
  task :default do
    update
    apply
  end

  desc "Update puppet manifests by running deploy"
  task :update do
    # deploy.default runs deploy:update and deploy:restart which doesn't anything.
    # See /lib/capistrano/recipes/deploy.rb.
    deploy.default
  end

  desc "Run puppet apply"
  task :apply do
    module_path = File.join(current_path, "modules")

    manifest = ENV["PUPPET_MANIFEST"] || "site.pp"
    manifest_path = File.join(current_path, "manifests", manifest)

    # NOTE Can we invoke puppet apply from puppet.gem instead of using the wrapper?
    sudo "/usr/bin/puppet apply --modulepath=#{module_path} #{manifest_path}"
  end
end
