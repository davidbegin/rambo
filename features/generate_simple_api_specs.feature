Feature: Generate simple API specs

  Scenario: Single resource route
    Given a file named "foo.raml" with:
      """
      #%RAML 0.8
      ---
      title: e-BookMobile API
      baseUri: http://api.e-bookmobile.com/{version}
      version: v1

      /authors:
        get:
          description: Retrieve a list of authors
          responses:
            200:
              body:
                application/json:
                  example: |
                    {
                      "data": [
                        {
                          "id": 1,
                          "first_name": "Hermann",
                          "last_name": "Hesse"
                        },
                        {
                          "id": 2,
                          "first_name": "Charles",
                          "last_name": "Dickens"
                        }
                      ],
                      "success": true,
                      "status": 200
                    }
      """
    When I run `rambo foo.raml`
    Then the file "spec/contract/foo_spec.rb" should contain:
      """
      require 'spec_helper'

      describe 'e-BookMobile API' do
        include Rack::Test::Methods

        describe '/authors' do
          let(:route) { '/authors' }

          describe 'GET' do
            let(:response_body) do
              {
                "data" => [
                  {
                    "id" => 1,
                    "first_name" => "Hermann",
                    "last_name" => "Hesse"
                  },
                  {
                    "id" => 2,
                    "first_name" => "Charles",
                    "last_name" => "Dickens"
                  }
                ],
                "success" => true,
                "status" => 200
              }.to_json
            end

            it 'retrieve a list of authors' do
              get route
              expect(last_response.body).to eql response_body
            end

            it 'returns status 200' do
              get route
              expect(last_response.status).to eql 200
            end
          end
        end
      end
      """
