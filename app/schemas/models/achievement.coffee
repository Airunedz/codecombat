c = require './../schemas'

# TODO add these: http://docs.mongodb.org/manual/reference/operator/query/
MongoQueryOperatorSchema =
  title: 'MongoDB Query operator'
  id: 'mongoQueryOperator'
  type: 'object'
  properties:
    '$gt': type: 'number'
    '$gte': type: 'number'
    '$in': type: 'array'
    '$lt': type: 'number'
    '$lte': type: 'number'
    '$ne': type: [ 'number', 'string' ]
    '$nin': type: 'array'
  additionalProperties: true # TODO set to false when the schema's done

MongoFindQuerySchema =
  title: 'MongoDB Query'
  id: 'mongoFindQuery'
  type: 'object'
  patternProperties:
    #'^[-a-zA-Z0-9_]*$':
    '^[-a-zA-Z0-9]*$':
      oneOf: [
        #{ $ref: '#/definitions/' + MongoQueryOperatorSchema.id},
        { type: 'string' }
      ]
  additionalProperties: false
  definitions: {}

MongoFindQuerySchema.definitions[MongoQueryOperatorSchema.id] = MongoQueryOperatorSchema

AchievementSchema = c.object()
c.extendNamedProperties AchievementSchema
c.extendBasicProperties AchievementSchema, 'article'
c.extendSearchableProperties AchievementSchema

_.extend(AchievementSchema.properties,
  query:
    type:'object'
    #$ref: '#/definitions/' + MongoFindQuerySchema.id
  worth: { type: 'number' }
  collection: { type: 'string' }
  description: { type: 'string' }
  userField: { type: 'string' }
  related: c.objectId
  proportionalTo:
    type: 'string'
    description: 'For repeatables only. Denotes the field a repeatable achievement needs for its calculations'
)

AchievementSchema.definitions = {}
AchievementSchema.definitions[MongoFindQuerySchema.id] = MongoFindQuerySchema

module.exports = AchievementSchema
