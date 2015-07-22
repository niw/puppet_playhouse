Puppet playhouse
================

Simple scripts and configurations to use [Puppet](https://puppetlabs.com/) for provisioning small amount of remote hosts.

Puppet playhouse __does__

 * Provide pre configured scripts to run Puppet on each remote host.
 * Run provisioning by using local `puppet master` and `puppet agent --onetime`.
 * Automatically setup local and remote hosts to run `puppet`.

Puppet playhouse __doesn't__

 * Provide manifests or modules.
 * Run provisioning periodically.

Requirements
------------

Puppet playhouse script will setup isolated environment on local also remote hosts to run `puppet` command, however, it has small requirements on top of normal environments like bash, ssh.

 * Ruby 2.1.0 (or 1.8.7 and higher)

    Current Puppet playhouse `puppet-3.8` branch is using [Puppet 3.8.x](http://docs.puppetlabs.com/puppet/3.8/reference/system_requirements.html#ruby) which recommends using Ruby 2.1.0 (or by design, it works with 1.8.7 or higher version.)

    If you need to use latest Puppet, try [`master`](https://github.com/niw/puppet_playhouse/tree/master), which is using Puppet 4.10.x.

 * Rsync

    Puppet playhouse syncs a small scripts to remote host by using [Rsync](https://rsync.samba.org/).

Usage
-----

Put puppet manifest into `environments/production/manifests` and modules into `modules`, then run `script/puppet apply HOSTNAME`.

### Getting started

For example, let's run provisioning on the [Vagrant](https://www.vagrantup.com/) host.
Assuming that we've already setup Vagrant, and do this in Puppet playhouse directory.

First, create a really simple manifest for the host.

    $ cat <<END_OF_MANIFEST > environments/production/manifests/vagrant.pp
    node "vagrant" {
      notify {
        "Hello, world!":
      }
    }
    END_OF_MANIFEST

Then, launch Vagrant host.
To allow us to ssh to Vagrant host, put `vagrant ssh-config` to your `~/.ssh/config`.

    $ vagrant up
    $ vagrant ssh-config >> ~/.ssh/config

Then run `scripts/puppet`. Note that `centos7` is the hostname added by `vagrant ssh-config`.

    $ scripts/puppet apply centos7

If it failed in some reasons, then you may need to wipe `ssl` directories from both local and remote hosts to sync certificates before retrying.

In the long outputs, you'll see next lines.

    Notice: Hello, world!
    Notice: /Stage[main]/Main/Node[vagrant]/Notify[Hello, world!]/message: defined 'message' as 'Hello, world!'