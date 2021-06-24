Feature: MassMutual exercise - Problem 1

  Background: Navigate to mock page
    Given I am on problem exercise page
    When dollar values are present on the screen

  Scenario Outline: Verify values on screen with <values> scenario
    Then I should see the right count of values appear on the screen "<values>"

    Examples:
      | values        |
      | exercise_data |

  Scenario: Verify that values are positive
    Then I should see the values are greater than 0

  Scenario: Verify that values are formatted as currencies
    Then I should see the values are correctly formatted as currencies

  Scenario: Verify that total balance matches the sum of the values
    Then I should see the total balance matches the sum of the values
