%w{ build-essential pkg-config libcurl4-openssl-dev libfuse-dev fuse-utils libfuse2 libxml2-dev mime-support }.each do |pkg|
  package pkg
end

# install fuse
fuse_dir = ::File.join("/tmp","fuse-#{node['s3fs']['fuse_version']}")
fuse_tar = fuse_dir + ".tar.gz"

remote_file fuse_tar do
  source node['s3fs']['fuse_url']
  mode 0644
end

execute "extract fuse" do
  cwd "/tmp"
  command "tar zxvf #{fuse_tar}"
  not_if { ::File.exists?(fuse_dir) }
end

fuse_touch_file = ::File.join(fuse_dir, "installed")
execute "install fuse" do
  cwd fuse_dir
  command "./configure --prefix=/usr && make && make install && touch #{fuse_touch_file}"
  not_if { ::File.exists?(fuse_touch_file) }
end

# install s3fs
s3fs_dir = ::File.join("/tmp","s3fs-#{node['s3fs']['s3fs_version']}")
s3fs_tar = s3fs_dir + ".tar.gz"
remote_file s3fs_tar do
  source node['s3fs']['s3fs_url']
  mode 0644
end

execute "extract s3fs" do
  cwd "/tmp"
  command "tar zxvf #{s3fs_tar}"
  not_if { ::File.exists?(s3fs_dir) }
end

file "/etc/passwd-s3fs" do
  owner "root"
  mode "0600"
  content node['s3fs']['access_key'] + ":" + node['s3fs']['secret_key']
end

s3fs_touch_file = ::File.join(s3fs_dir, "installed")
execute "install s3fs" do
  cwd s3fs_dir
  command "./configure --prefix=/usr && make && make install && touch #{s3fs_touch_file}"
  not_if { ::File.exists?(s3fs_touch_file) }
end
