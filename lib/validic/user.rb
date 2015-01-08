# encoding: utf-8

module Validic
  module User

    ##
    # Get Users base on `access_token` and organization_id
    #
    # @params :status - optional (active or inactive) default :all
    # @params :access_token - optional
    # @params :start_date - optional
    # @params :end_date - optional
    # @params :offset - optional
    # @params :limit - optional
    #
    # @return [Hashie::Mash] with list of Organization
    def get_users(params={})
      get_endpoint(:users, params)
    end

    ##
    # Get User id base on `access_token`
    #
    # @return id
    def me(authentication_token)
      response = get("/#{Validic.api_version}/me.json", authentication_token: authentication_token)
      response if response
    end

    ##
    # POST User info for provisioning base on `access_token`
    #
    # @params[:organization_id] -- organization_id -- String
    # @params[:access_token] -- organization's access_token -- String
    # @params[:uid] -- uid for the new user -- String
    # @params[:height] -- info for user -- Integer
    # @params[:weight] -- info for user -- String
    # @params[:location] -- info for user -- String
    # @params[:gender] -- info for user -- String
    # @params[:birth_year] -- info for user -- String
    #
    # @return user object
    def provision_user(uid, options={})
      organization_id = options[:organization_id] || Validic.organization_id
      options = {
        access_token: options[:access_token] || Validic.access_token,
        user: {
          uid: uid,
          profile: {
            height: options[:height],
            gender: options[:gender],
            location: options[:location],
            weight: options[:weight]
          }
        }
      }
      response = post("/#{Validic.api_version}/organizations/#{organization_id}/users.json", options)
      response if response
    end

    ##
    # PUT User info for updating based on `access_token`
    #
    # @params[:organization_id] -- organization_id -- String
    # @params[:access_token] -- organization's access_token -- String
    # @params[:uid] -- uid for the new user -- String
    # @params[:height] -- info for user -- Integer
    # @params[:weight] -- info for user -- String
    # @params[:location] -- info for user -- String
    # @params[:gender] -- info for user -- String
    # @params[:birth_year] -- info for user -- String
    #
    # @return user object
    def update_user(user_id, options={})
      organization_id = options[:organization_id] || Validic.organization_id
      options = {
        access_token: options[:access_token] || Validic.access_token,
        user: {
          uid: options[:uid],
          profile: {
            gender: options[:gender],
            location: options[:location],
            country: options[:country],
            birth_year: options[:birth_year],
            height: options[:height],
            weight: options[:weight]
          }
        }
      }

      response = put("/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}.json", options)
      response if response
    end

    ##
    #
    # PUT request for suspending a user
    #
    # @params[:organization_id] -- String
    # @params[:access_token] -- String -- organization's access_token
    # @params[:user_id] -- String -- user's ID to suspend
    #
    # @return user object
    def suspend_user(user_id, options={})
      organization_id = options[:organization_id] || Validic.organization_id
      options = {
        suspend: 1,
        access_token: options[:access_token] || Validic.access_token
      }

      response = put("/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}.json", options)
      response
    end

    ##
    #
    # PUT request for unsuspending a user
    #
    # @params[:organization_id] -- String
    # @params[:access_token] -- String -- organization's access_token
    # @params[:user_id] -- String -- user's ID to suspend
    #
    # @return user object
    def unsuspend_user(user_id, options={})
      organization_id = options[:organization_id] || Validic.organization_id
      options = {
        suspend: 0,
        access_token: options[:access_token] || Validic.access_token
      }

      response = put("/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}.json", options)
      response
    end

    ##
    #
    # GET request to refresh a user authentication token
    #
    # @params[:organization_id] -- String
    # @params[:access_token] -- String -- organization's access_token
    # @params[:user_id] -- String -- user's ID to suspend
    #
    # @return user object
    def refresh_token(user_id, options={})
      organization_id = options[:organization_id] || Validic.organization_id
      options = {
        access_token: options[:access_token] || Validic.access_token
      }

      response = get("/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}/refresh_token.json", options)
      response
    end

    ##
    #
    # DELETE request for deleting a user
    #
    # @params[:organization_id] -- String
    # @params[:access_token] -- String -- organization's access_token
    # @params[:uid] -- String -- user's ID to suspend
    #
    # @return [Hashie::Mash] with response
    def delete_user(user_id, options={})
      organization_id = options[:organization_id] || Validic.organization_id
      options = {
        access_token: options[:access_token] || Validic.access_token
      }

      response = delete("/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}.json", options)
      response
    end
  end
end