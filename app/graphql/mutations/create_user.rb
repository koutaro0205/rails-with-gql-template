# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    field :user, Types::UserType, null: true

    argument :name, String, required: true
    argument :email, String, required: false

    def resolve(**args)
      user = User.create!(args)
      {
        user: user
      }
    end
  end
end
