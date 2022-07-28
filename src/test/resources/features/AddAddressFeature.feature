Feature: Create an account and add address to the account.

  Background: Create new Account.
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccountFeature.feature')
    And print createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def newToken = createAccountResult.result.response.token

  Scenario: Add address to an account
    Given path '/api/accounts/add-account-address'
    Given param primaryPersonId = primaryPersonId
    Given header Authorization = "Bearer " + newToken
    Given request
      """
      {
      "addressType": "Home",
      "addressLine1": "2244 Wheyfield dr",
      "city": "Springfield",
      "state": "Virginia",
      "postalCode": "22153",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
