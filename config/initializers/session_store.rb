# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bingo_session',
  :secret      => 'af85f73bbbdfb7c6727d3b2b79819f9e5946303032d6b7286bc9ed723ea0a6f828da0dee29adfd6fa2de77cc746da440a102e29595e2e0b19164e198d6ac800f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
