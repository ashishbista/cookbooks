include_recipe "deploy"

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  template "#{deploy[:deploy_to]}/config/application.yml" do
    source "aplication.yml.erb"
    cookbook 'opsworks-env-vars'
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(:environment_variables => deploy[:environment_variables])

    notifies :run, "execute[restart Rails app #{application}]"

    only_if do
      File.exists?("#{deploy[:deploy_to]}") && File.exists?("#{deploy[:deploy_to]}/shared/config/")
    end
  end
end