Feature: PetStore API tests

  Background:
    * url baseUrl
    * configure headers = headers

  Scenario Outline: Flujo CRUD de mascota usando datasets externos (CSV)
    * def petData = toPetRequest(__row)
    * def updatedPetData = toUpdatedPetRequest(__row)

    # 1) Crear mascota
    Given path 'pet'
    And request petData
    When method post
    Then status 200
    And match response.id == petData.id
    And match response.name == petData.name
    And match response.status == petData.status

    # 2) Consultar por ID
    Given path 'pet', petData.id
    When method get
    Then status 200
    And match response.id == petData.id
    And match response.name == petData.name
    And match response.status == petData.status

    # 3) Actualizar
    Given path 'pet'
    And request updatedPetData
    When method put
    Then status 200
    And match response.id == updatedPetData.id
    And match response.name == updatedPetData.name
    And match response.status == updatedPetData.status

    # 4) Consultar por status (evita fragilidad de response[0])
    Given path 'pet/findByStatus'
    And param status = __row.queryStatus
    When method get
    Then status 200
    And match response[*].status contains __row.queryStatus

    Examples:
      | karate.read('classpath:pets.csv') |
