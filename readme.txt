###
# Ruby gem for Detector

Identifies the current browser segment and makes a browser_segment variable available.

# Update gem version

To use updated version in apps that bundles through git:
- First:  Bump version # here, rebuild gem: gem build deardetector.gemspec and commit + push.
- Second: In app, change version # in gemfile, run "bundle install", commit + push and deploy.