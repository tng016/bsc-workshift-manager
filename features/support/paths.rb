# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/ then root_path

    when /^the sign in page$/ then new_user_session_path

    when /^the personal page for "(.*)"$/
        id = User.find_by(username: $1).id
        user_path(id)

    when /^the preferences page for "(.*)"$/
        id = User.find_by(username: $1).id
        user_preferences_path(id)

    when /^the my preferences page for "(.*)"$/
        id = User.find_by(username: $1).id
        preference_id = User.find(id).preference.id
        user_preference_path(id, preference_id)

    when /^the user creation page$/
        new_user_registration_path

    when /^the multiple user creation page$/
        mass_add_path

    when /^the user revoking page$/
        delete_path

    when /^the new password page for "(.*)"$/
        edit_user_registration_path

    when /^the make preferences page/
        new_user_preference_path(User.find_by_username(@username).id)

    when /^the no preferences page for "(.*)"/
        no_user_preferences_path(User.find_by_username($1).id)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
