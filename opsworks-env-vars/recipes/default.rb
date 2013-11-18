include_recipe "deploy"

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  template "/srv/www/#{application}/current/config/application.yml" do
    cookbook 'opsworks-env-vars'
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(:environment_variables => node[:deploy][:environment_variables])
  end
end