Given 'I am on problem exercise page' do
  visit(TotalBalance)
end

When 'dollar values are present on the screen' do
  on(TotalBalance).check_all_values_present
end

Then 'I should see the right count of values appear on the screen {string}' do |values|
  on(TotalBalance).verify_values(values)
  @browser.screenshot.save("results/screenshots/check_right_value.png")
end

Then 'I should see the values are greater than 0' do
  on(TotalBalance).verify_positive_values
  @browser.screenshot.save("results/screenshots/check_positive_value.png")
end

Then 'I should see the values are correctly formatted as currencies' do
  on(TotalBalance).verify_all_values_currencies
  @browser.screenshot.save("results/screenshots/check_currency_format.png")
end

Then 'I should see the total balance matches the sum of the values' do
  on(TotalBalance).verify_total_balance_amount
  @browser.screenshot.save("results/screenshots/check_total_balance.png")
end
