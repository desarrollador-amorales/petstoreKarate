function fn() {
  var env = karate.env;
  if (!env) env = 'qa';

  var baseUrls = {
    dev:  'https://petstore.swagger.io/v2',
    qa:   'https://petstore.swagger.io/v2',
    prod: 'https://petstore.swagger.io/v2'
  };

  var config = {
    env: env,
    baseUrl: baseUrls[env] || baseUrls.dev,

    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    },

    token: karate.properties['token'] || null
  };

  if (config.token) {
    config.headers.Authorization = 'Bearer ' + config.token;
  }

  // Helpers para convertir una fila del CSV a un body tipo Petstore
  config.toPetRequest = function(row) {
    return {
      id: +row.id,
      category: { id: +row.categoryId, name: row.categoryName },
      name: row.name,
      photoUrls: [ row.photoUrl ],
      tags: [ { id: +row.tagId, name: row.tagName } ],
      status: row.status
    };
  };

  config.toUpdatedPetRequest = function(row) {
    return {
      id: +row.id,
      category: { id: +row.categoryId, name: row.categoryName },
      name: row.updatedName,
      photoUrls: [ row.updatedPhotoUrl || row.photoUrl ],
      tags: [ { id: +row.tagId, name: row.tagName } ],
      status: row.updatedStatus
    };
  };

  karate.log('karate.env =', env);
  karate.log('baseUrl    =', config.baseUrl);

  return config;
}
