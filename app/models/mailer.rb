require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.view_paths= File.dirname(__FILE__)

  class Mailer < ActionMailer::Base

    def send_password_link(user)
      @user = user

      ActionMailer::Base.smtp_settings = {
        :address   => ENV['JMA_ADDRESS'],
        :port      => ENV['JMA_PORT'],
        :domain    => ENV['JMA_DOMAIN'],
        :authentication => :"login",
        :tls =>         true,
        :user_name      => ENV['JMA_USER'],
        :password       => ENV['JMA_PASS'],
        :enable_starttls_auto => true,
      }

      puts "sending password reminder to: #{@user.email} from: #{ENV['JMA_FROM_ADDRESS']}"
      mail(
        :to      =>  @user.email,
        :from    => ENV['JMA_FROM_ADDRESS'],
        :subject => "JMA Mood Matters Information ",
      ) do |format|
        format.html
        format.text
      end
    end

     def send_welcome_email(user)
      begin
        @user = user

        ActionMailer::Base.smtp_settings = {
          :address   => ENV['JMA_ADDRESS'],
          :port      => ENV['JMA_PORT'],
          :domain    => ENV['JMA_DOMAIN'],
          :authentication => :"login",
          :tls =>         true,
          :user_name      => ENV['JMA_USER'],
          :password       => ENV['JMA_PASS'],
          :enable_starttls_auto => true,
        }

        puts "sending welcome email to: #{@user.email} from: #{ENV['JMA_FROM_ADDRESS']}"
        mail( 
          :to      =>  @user.email,
          :from    => ENV['JMA_FROM_ADDRESS'],
          :subject => "Welcome to Mood Matters",
        ) do |format|
          format.html
          format.text
        end

      rescue Exception => e
        puts "rescue caught in send_welcome_email #{e.message}"
      end
    end
    

     def alert_admin_new_user(user)
      begin
        @user = user

        ActionMailer::Base.smtp_settings = {
          :address   => ENV['JMA_ADDRESS'],
          :port      => ENV['JMA_PORT'],
          :domain    => ENV['JMA_DOMAIN'],
          :authentication => :"login",
          :tls =>         true,
          :user_name      => ENV['JMA_USER'],
          :password       => ENV['JMA_PASS'],
          :enable_starttls_auto => true,
        }

        puts "sending new user alert email for #{@user.name}  #{@user.email} to: JMA admin: #{ENV['JMA_FROM_ADDRESS']}"
        mail( 
          :to      =>   ENV['JMA_SUPPORT_EMAIL'],
          :from    => ENV['JMA_SUPPORT_EMAIL'],
          :subject => "Mood Matters New User Added",
        ) do |format|
          format.html
          format.text
        end

      rescue Exception => e
        puts "rescue caught in alert_admin_new_user #{e.message}"
      end
    end

    def send_weekly_mood_report(user, coach, results, chart_results)
      @user = user
      @coach = coach
      @results = results
      @chart_results = chart_results
      puts "send_weekly_mood_report chart_results #{@chart_results}"

      puts "mailer.rb send_weekly_mood_report called.  from ENV['JMA_FROM_ADDRESS']: #{ENV['JMA_FROM_ADDRESS']}"

      ActionMailer::Base.smtp_settings = {
        :address   => ENV['JMA_ADDRESS'],
        :port      => ENV['JMA_PORT'],
        :domain    => ENV['JMA_DOMAIN'],
        :authentication => :"login",
        :tls =>         true,
        :user_name      => ENV['JMA_USER'],
        :password       => ENV['JMA_PASS'],
        :enable_starttls_auto => true,
      }

      puts "sending weekly mood report to: #{@user.email} and coach: #{coach.name}from: #{ENV['JMA_FROM_ADDRESS']}"
      @results.each do |entry|
        puts "date/time: #{entry.created_at} mood:  #{entry.mood} source: #{entry.internal_external}"
      end

      recipients = [@user.email, @coach.email]
      mail(
        :to      =>  recipients.join(";"),
        :from    => ENV['JMA_FROM_ADDRESS'],
        :subject => "Weekly Mood Matters Report For #{@user.name}",
      ) do |format|
        format.html
        format.text
      end
    end


    def send_monthly_mood_report(user, coach, results, chart_results)
      @user = user
      @coach = coach
      @results = results
      @chart_results = chart_results

      puts "send_monthly_mood_report chart_results #{@chart_results}"

      ActionMailer::Base.smtp_settings = {
        :address   => ENV['JMA_ADDRESS'],
        :port      => ENV['JMA_PORT'],
        :domain    => ENV['JMA_DOMAIN'],
        :authentication => :"login",
        :tls =>         true,
        :user_name      => ENV['JMA_USER'],
        :password       => ENV['JMA_PASS'],
        :enable_starttls_auto => true,
      }

      puts "sending monthly mood report to: #{@user.email} and coach: #{coach.name}from: #{ENV['JMA_FROM_ADDRESS']}"
      @results.each do |entry|
        puts "date/time: #{entry.created_at} mood:  #{entry.mood} source: #{entry.internal_external}"
      end

      recipients = [@user.email, @coach.email]
      mail(
        :to      =>  recipients.join(";"),
        :from    => ENV['JMA_FROM_ADDRESS'],
        :subject => "Monthly Mood Matters Report For #{@user.name}",
      ) do |format|
        format.html
        format.text
      end
    end

    def to_jma_support(name, email)
      @name = name
      @email = email

      ActionMailer::Base.smtp_settings = {
        :address   => ENV['JMA_ADDRESS'],
        :port      => ENV['JMA_PORT'],
        :domain    => ENV['JMA_DOMAIN'],
        :authentication => :"login",
        :tls =>         true,
        :user_name      => ENV['JMA_USER'],
        :password       => ENV['JMA_PASS'],
        :enable_starttls_auto => true,
      }
      puts "sending confirm to jma support team at this address:  #{ENV['JMA_SUPPORT_EMAIL']} from: #{ENV['JMA_FROM_ADDRESS']}"
      mail(
        :to      => ENV['JMA_SUPPORT_EMAIL'],
        :from    => ENV['JMA_FROM_ADDRESS'],
        :subject => "JMA Mood Matters",
      ) do |format|
        format.html
        format.text
      end
    end

     def submit_test_email(name, email)
      @name = name
      @email = email

      begin
       ActionMailer::Base.smtp_settings = {
        :address   => ENV['JMA_ADDRESS'],
        :port      => ENV['JMA_PORT'],
        :domain    => ENV['JMA_DOMAIN'],
        :authentication => :"login",
        :tls =>         true,
        :user_name      => ENV['JMA_USER'],
        :password       => ENV['JMA_PASS'],
        :enable_starttls_auto => true,
      }
      puts "settings #{ActionMailer::Base.smtp_settings}"
      mail( 
        :to      => ENV['DEVELOPER_EMAIL'],
        :from    => ENV['JMA_FROM_ADDRESS'],
        :subject => "Mood Matters Thank You For Your Registering",
      ) do |format|
        format.html
        format.text
      end

    rescue Exception => e
      puts "rescue caught submit_test_email #{e.message}"
      puts e.backtrace
    end
  end

  def get_email(email)
    retval = email
    if ENV['RACK_ENV'] == 'development' then
      retval = ENV['DEVELOPER_EMAIL']
    end
    puts "get_email retval #{retval}"
    retval
  end
end
