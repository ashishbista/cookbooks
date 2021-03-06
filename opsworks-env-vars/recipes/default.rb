include_recipe "deploy"

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]
  template "#{deploy[:deploy_to]}/shared/config/application.yml" do
    cookbook 'opsworks-env-vars'
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(:environment_variables => node[:environment_variables])
  end
end