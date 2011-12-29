# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_solr-frontend_session',
  :secret      => '22edfe3e2fe4a60bdd7eaf182bf373d8852270625c1ca2f4369015c6220acd76a5b56d0fcb4b6fb000cd02f6bc125e3bee93c47afd0cd4ba9027d86e6732e7cc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
