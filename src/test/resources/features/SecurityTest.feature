@Smoke
Feature: Security test. Token Generation test
@Smoke  
  Scenario: generate token with valid username and password.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  #2) test api end point "/api/token" invalid user name and valid password.
  # status code shoiuld be 404 not found and print the response
  #response errormessage is "USER_NOT_FOUND"
  @Smoke @Psitive
  Scenario: generate token with invalid username and valid password
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisors", "password": "tek_supervisor"}
    When method post
    Then status 404
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "USER_NOT_FOUND"

  #3) test api end point "/api/token" valid user name and invalid password.
  #status code should be 400
  #response with errormessage "password not found" take screenshot and share.
  #note: there is defect for this scenario already open.
  @Smoke  @Negative
  Scenario: generate token with valid username and invalid password
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisor", "password": "tek_supervisors"}
    When method post
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Password Not Matched"
