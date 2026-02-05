Feature: PetStore API tests

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def data = read('./petstore-data.json')
    * def petData = data.petData
    * def updatedPetData = data.updatedPetData

  Scenario: Añadir una mascota a la tienda
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    And match response.name == "Balto el mejor!"
    And match response.status == "available"

  Scenario: Consultar la mascota ingresada previamente por ID
    Given path 'pet', petData.id
    When method get
    Then status 200
    And match response.id == petData.id
    And match response.name == "Balto el mejor!"
    And match response.status == "available"

  Scenario: Actualizar la mascota
    Given path 'pet'
    And request updatedPetData
    When method put
    Then status 200
    And match response.name == "Togo 2"
    And match response.status == "sold"

  Scenario: Consultar la mascota modificada por status
    Given path 'pet/findByStatus'
    And param status = "sold"
    When method get
    Then status 200
    And match response[0].status == "sold"

