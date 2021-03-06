require 'spec_helper'

describe Example::App do
  def app
    @app ||= Example::App
  end

  describe "GET '/'" do
    it 'requesting a url that requires authentication redirects to redirect uri' do
      response = get '/'

      uri = Addressable::URI.parse(response.headers['Location'])

      uri.scheme.should eql('http')
      uri.host.should eql('localhost')

      params = uri.query_values
      params['response_type'].should eql('code')
      params['scope'].should eql('public')
      params['client_id'].should match(/\w{20}/)
      params['redirect_uri'].should eql('http://example.org/auth/oauthed/callback')
    end
  end
end
