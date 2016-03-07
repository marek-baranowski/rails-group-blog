namespace :users do
  desc "Set user status to admin"
  task :set_admin, [:user_login] => :environment do |task, args|
    begin
      user = User.find_by_email!(args.user_login)
      user.admin!
      user.activate!
      puts "Success: User #{user.email} has been activated and set to admin."
    rescue
      warn "Warnig: #{$!}. Task not completed."
    end
  end
end
