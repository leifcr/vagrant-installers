# Make the path Windows-style if we're on Windows
package_name = node[:vagrant][:gem_path].gsub("/", "\\")

gem_package package_name do
  version "> 0"
  gem_binary "#{embedded_dir}/bin/gem"
end

# We need a little batch wrapper so that we execute the
# bin in the context of our isolated Ruby.
template "#{staging_dir}/bin/vagrant.bat" do
  source "bin_wrapper.bat.erb"
  mode   0755
  variables :bin => "vagrant"
end

# Create a bash script as well for users on Windows who
# are using msys or some shell that has bash.
template "#{staging_dir}/bin/vagrant" do
  source "vagrant.erb"
  mode   0755
end
