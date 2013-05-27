server "localhost", :app, {
  :user => "vagrant",
  :ssh_options => {
    :port => 2222,
    :keys => "#{ENV["HOME"]}/.vagrant.d/insecure_private_key"
  }
}
