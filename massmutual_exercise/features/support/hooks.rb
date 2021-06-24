Before do
  @browser = Watir::Browser.new ENV['BROWSER_NAME'].to_sym
  @browser.window.maximize
end


After do |scenario|
  @browser.screenshot.save("results/screenshots/failure_#{SecureRandom.hex(6)}.png") if scenario.status == :failed
  @browser.close
  log "Scenario #{scenario.status}!"
end
