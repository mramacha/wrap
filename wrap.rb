
  class Wrap
    def initialize(url)
      @browser ||= Watir::Browser.new :firefox
      @browser.goto url
      @browser.window.maximize()
    end

    def self.navigate(url)
      new(url)
    end

    def browser
      @browser
    end

    def create_account(user_name)
      @browser.span(:text,"PLANS & PRICING").when_present.click
      @browser.execute_script('arguments[0].scrollIntoView();', @browser.a(:text,/Try Small Business for Free/i))
      @browser.a(:text,/Sign Up/i).when_present.click
      @browser.text_field(:placeholder ,"Email").when_present.set "#{user_name}@gmail.com"
      @browser.button(:text,"Sign Up").click
      #expect(@browser.div(:class, "signup_suggested-username").when_present.text.include? user_name).to be_truthy
      @browser.text_field(:placeholder ,"Create a username").when_present.set user_name
      @browser.text_field(:placeholder ,"Password").when_present.set "test123"
      sleep(3)
      @browser.button(:text, /Create Account/i).when_present.click
    end

    def complete_account_info(first_name,last_name,company_name,phone_number)
      @browser.text_field(:placeholder, "First Name *").when_present.set first_name
      @browser.text_field(:placeholder, "Last Name *").when_present.set last_name
      @browser.text_field(:placeholder, "Company *").when_present.set company_name
      @browser.text_field(:placeholder, "Phone Number").when_present.set phone_number
      @browser.button(:text, "Create account").when_present.click
    end
  end
