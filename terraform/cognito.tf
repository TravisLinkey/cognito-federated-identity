resource "aws_cognito_user_pool" "user_pool" {
    name="testUserPool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name = "test_pool_client"

  user_pool_id = aws_cognito_user_pool.user_pool.id

  allowed_oauth_flows = [ "code", "implicit" ]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [ "phone", "email", "openid", "profile", "aws.cognito.signin.user.admin" ]

  callback_urls = [ var.SITE_URL ]
  logout_urls = [ var.SITE_URL ]
}

resource "aws_cognito_identity_provider" "google" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  provider_name = "Google"
  provider_type = "Google"

  attribute_mapping = {
    email = "email"
  }

  provider_details = {
    client_id = var.GOOGLE_CLIENT_ID
    client_secret = var.GOOGLE_CLIENT_SECRET
  }

  idp_identifiers = [ "accounts.google.com" ]
}

resource "aws_cognito_identity_pool" "user_identity_pool" {
    identity_pool_name = "testIdentityPool"
    allow_unauthenticated_identities = false

    cognito_identity_providers {
      client_id = aws_cognito_user_pool.user_pool.id
      provider_name = aws_cognito_user_pool.user_pool.endpoint
      server_side_token_check = true
    }
}

output "user_pool_id" {
    description = "ID of the Cognito User Pool"
    value = aws_cognito_user_pool.user_pool.id
}

output "user_pool_client_id" {
  description = "ID of the Cognito User Pool Client"
  value = aws_cognito_user_pool_client.user_pool_client.id
}

output "identity_pool_id" {
  description = "ID of the Cognito Identity Pool"
  value = aws_cognito_identity_pool.user_identity_pool.id
}