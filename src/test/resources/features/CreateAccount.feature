Feature: Create Account
#1) test api endpoint api/accounts/add-primary-account to add new account( same we do in UI form)
#then status code 201 created. with response generated account 
  Background: generate token for all scenario
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedtoken = response.token

  Scenario: Create new Account happy path
    Given path "api/accounts/add-primary-account"
    And request {"email": "someone@gmail.com","title": "Mrs","firstName": "Sara","lastName": "Johnson","gender": "FEMALE","maritalStatus": "MARRIED", "employmentStatus": "Student","dateOfBirth": "1986/02/09"}
    And header Authorization = "Bearer " + generatedtoken
    When method post
    Then status 201
    And print response
    
