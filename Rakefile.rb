#Basic configuration to run rake tasks
Dir.glob('lib/tasks/*.rake').each {|r| import r}
