require './wrap.rb'
require "rspec"
require "watir-webdriver"

describe "Wrap" do

  before(:all) do
    @wrap = Wrap.navigate("https://www.x1.wrapdev.net/index/")
  end

  after(:all) { @wrap.browser.close }

  it "should create a new personal account" do
    user_name = "rmadhu.nair#{rand(2000...2000000)}"
    @wrap.create_account(user_name)
    @wrap.complete_account_info("Madhu","Ram","Wrap INC","6144327035")
    expect(@wrap.browser.div(:class,"global-nav_user-name").when_present.text == user_name).to be_truthy
  end

  it "should create a new template" do
    @wrap.browser.button(:text,"Create new wrap").when_present.click
    sleep 2
    @wrap.browser.button(:text,"Start from scratch").when_present.click
    @wrap.browser.button(:text,"Start from scratch").wait_while_present
    @wrap.browser.button(:class,"help-tour_nav").when_present.click #closing the tour
    sleep 5
    @wrap.browser.div(:text,"Wrap properties").when_present.click
    @wrap_name = "test_Wrap#{rand(2000...2000000)}"
    @wrap.browser.text_field(:id,"wrap-name").when_present.set @wrap_name
    @wrap.browser.button(:text,"Save").when_present.click
    @wrap.browser.div(:class,/rect-container_rect/).wait_while_present # wait until the save process is complete
    expect(@wrap.browser.div(:class, "action-bar_wrap-name ng-binding").when_present.text == @wrap_name).to be_truthy
  end

  it "should publish a template" do
    @wrap.browser.button(:text,"Publish").when_present.click
    sleep 5
    expect(@wrap.browser.div(:class,"publish-notification").h4(:class,"modal-title").text == "Publish Successful").to be_truthy
    expect(@wrap.browser.span(:class,"publish-notification_primary").text == "#{@wrap_name} is live" ).to be_truthy
    @wrap.browser.button(:text,"Close").click
  end

end

