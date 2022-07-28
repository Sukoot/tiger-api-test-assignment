# 1)Test API endpoint "/api/accounts/add-primary-account" to add new Account with Existing email address.
# Then status code should be 400 – Bad Request ,  validate response
Feature: Add new Account with Existing email address

  Background: generate token for all scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generateToken = response.token

  Scenario: Add new Account with Existing email address
    Given path "/api/accounts/add-primary-account"
    And request {"id": 0,"email": "someone@gmail.com","title": "Mr","firstName": "Sukoot","lastName": "Kohistani", "gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Student","dateOfBirth": "1988/05/09"new": true}
    And header Authorization = "Bearer " + generateToken
    When method post
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Account with Email someone@gmail.com is exist"
    And print response
    Then status 400

  # 2)Test API endpoint "/api/accounts/add-account-car" to add car to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Add car to an existing Account
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = 8144
    And request {"id": 0,"primaryPerson": {"id": 8144,"email": "someone@gmail.com", "title": "Mr","firstName": "Sukoot","lastName": "Kohistani","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Student","dateOfBirth": "1988/05/09"},"make": "RangRover","model": "X","year": "2022","licensePlate": "009X"}
    * def generatedToken = response.token
    And header Authorization =  "Bearer " + generatedToken
    When method post
    Then print response
    Then status 201

  # 3)Test API endpoint "/api/accounts/add-account-phone" to add Phone number to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Add phone number to an existing Account.
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = 8144
    And request {"id": 8144,"phoneNumber": "703-090-1008","phoneExtension": "010","phoneTime": "Any Time","phoneType": "Home"}
    * def generatedToken = response.token
    And header Authorization =  "Bearer " + generatedToken
    When method post
    Then print response
    #And assert response.primaryPerson.id == 8144
    #And assert response.primaryPerson.email == "someone@gmail.com"
    Then status 201

  # 4)Test API endpoint "/api/accounts/add-account-address" to add address to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Add address to an existing Account
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = 8144
    And request {"id": 0,"addressType": "Home","addressLine1": "1278 Silver rd","city": "Springfield","state": "Virgina", "postalCode": "22153","countryCode": "null"}
    * def generatedToken = response.token
    And header Authorization =  "Bearer " + generatedToken
    When method post
    Then print response
    Then status 201
    
    
    
    
    
