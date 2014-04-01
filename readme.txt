###
# Update gem version:

To use updated version in apps that bundles through git:
- First:  Bump version # here, rebuild gem: gem build deardetector.gemspec and commit + push.
- Second: In app, change version # in gemfile, run "bundle install", commit + push and deploy.