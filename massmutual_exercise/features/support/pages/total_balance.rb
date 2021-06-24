class TotalBalance
  include PageObject, PageObject::PageFactory

  page_url ENV['BASE_URL']

  # page objects:
  text_field(:lbl_val_1,   id: 'txt_val_1')
  text_field(:lbl_val_2,   id: 'txt_val_2')
  text_field(:lbl_val_3,   id: 'txt_val_3')
  text_field(:lbl_val_4,   id: 'txt_val_4')
  text_field(:lbl_val_5,   id: 'txt_val_5')
  text_field(:lbl_ttl_val, id: 'txt_ttl_val')


  # page methods:
  def get_values_text
    [lbl_val_1, lbl_val_2, lbl_val_3, lbl_val_4, lbl_val_5]
  end

  def get_value_elements
    [lbl_val_1_element, lbl_val_2_element, lbl_val_3_element, lbl_val_4_element, lbl_val_5_element]
  end

  def check_all_values_present
    missing_values = []
    get_value_elements.each_with_index do |value_elements, index|
      if value_elements.present?
        puts "Value #{index + 1}: #{value_elements.value} is present on screen."
      else
        missing_values << "Value #{index + 1}"
      end
    end
    raise "Following values are not present on screen: #{missing_values.join(', ')}" unless missing_values.empty?
    if lbl_ttl_val.present?
      puts "Total Balance: #{lbl_ttl_val} is present on screen."
    else
      puts "Total Balance missing"
    end
  end

  def verify_values(values)
    puts "Values Comparison:"
    user_data = YAML.load_file('features/config/data/form_data.yml')
    matching_fail = []
    get_values_text.each_with_index do |value, index|
      value_from_yaml = user_data[values]["value#{index + 1}"]
      if value == value_from_yaml
        puts "Value #{index + 1}: #{value_from_yaml} is matching with value displayed on screen: #{value}."
      else
        matching_fail << "Value #{index + 1}"
      end
    end
    raise "Following values are not matching: #{matching_fail.join(', ')}" unless matching_fail.empty?
  end
  
  def is_positive_value?(value)
    value.match(/(\d.+)/)[1].gsub(',','').to_f
  end

  def verify_positive_values
    puts "Values greater than 0 check:"
    fail = []
    get_values_text.each_with_index do |value, index|
      if is_positive_value?(value) > 0
        puts "I verified that Value #{index + 1}: #{value} is greater than 0."
      else
        fail << value
      end
    end
    raise "Following values are not greater than 0: #{fail.join(', ')}" unless fail.empty?
  end

  def is_currency_format?(value)
    value.strip.match?(/^\-?\$[0-9]{1,3}(?:,[0-9]{3})*\.[0-9]{2}$/)
  end

  def verify_all_values_currencies
    puts "Validation check for Currency format:"
    fail = []
    get_values_text.each_with_index do |value, index|
      if is_currency_format?(value)
        puts "I verified that Value #{index + 1}: #{value} is in US currency format."
      else
        fail << value
      end
    end
    raise "Following values are not in currency format: #{fail.join(', ')}" unless fail.empty?
  end

  def verify_total_balance_amount
    puts "Total Balance amount check:"
    sum = 0.00
    get_values_text.each do |value|
      sum += value.delete('^0-9','^.').to_f
    end
    if sum == lbl_ttl_val.delete('^0-9','^.').to_f
      puts "Total Balance: #{lbl_ttl_val} is correct"
    else
      raise "Total Balance: #{lbl_ttl_val} is incorrect. Correct Total Balance is: #{sum}"
    end
  end

end
