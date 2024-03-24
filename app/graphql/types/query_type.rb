# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me (Example)
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    # /resolvers以下に引っ越し
    # # GraphQLクエリでのfield名、GraphQL Type、必須かどうか
    # field :user, Types::UserType, null: false do
    #   # GraphQLクエリでの引数、GraphQLでの型、必須かどうか
    #   argument :id, ID, required: true
    # end
    # # fieldが指定されたとき、どのようにデータ取得するかをfieldと同名メソッドで実装する
    # def user(id:)
    #   User.find(id)
    # end
    field :user, resolver: Resolvers::UserResolver

    # ユーザ一覧
    field :users, resolver: Resolvers::UsersResolver
  end
end
