require 'slackdo/version'
require 'highline'
require 'slack-notifier'
require 'trello'
require 'json'

module Slackdo
  class Config
	def configure_init
      system "mkdir #{ENV['HOME']}/.slackdo &> /dev/null"
	  unless File.exist?("#{ENV['HOME']}/.slackdo/config.json")
		system "touch #{ENV['HOME']}/.slackdo/config.json"
		hash = {
			"slack_webhook" => "",
			"allow_trello_pushing" => "false",
			"trello_public_key" => "",
			"trello_member_token" => ""
		}
		File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
		  f.write(hash.to_json)
		end
	  end
    end
	def configure_trello_api
	  cli = HighLine.new
	  file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
	  public_key = cli.ask 'What is your Trello public key?'.strip
	  member_token = cli.ask 'What is your Trello member token?'.strip
	  hash["trello_public_key"] = public_key
	  hash["trello_member_token"] = member_token
	  hash["allow_trello_pushing"] = "true"
	  File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
	  puts 'Trello API was configured...'
	end
	def configure_slack_webhook
      cli = HighLine.new
	  file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
	  webhook = cli.ask 'What is your Slack webhook?'.strip
      hash["slack_webhook"] = webhook
	  File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
	  puts 'Slack API was configured...'
    end
  end

  class Trello
	def configure_trello
	  file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
	  Trello.configure do |config|
        config.developer_public_key = hash['trello_public_key']
        config.member_token = hash['trello_member_token']
      end
	end
	def add_card(card_name, desc)
	  file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
	  configure_trello
	  Trello::Card.create(
        name: card_name,
        desc: card_description,
        pos: 'top',
        list_id: '----'
      )
	end
  end

  class Task
	note_content = ''
	message = ''
	def set_message(text)
		message = text
	end
	def set_notes(notes)
		note_content = notes
	end
	def get_message
	  return message
	end
	def get_notes
	  return note_content
	end
	def add_task
	  file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
	  webhook = hash['slack_webhook']
      notifier = Slack::Notifier.new webhook
      cli = HighLine.new
	  category = cli.ask 'What is the category of this new task? eg. DEV or GENERAL'
      cli_message = cli.ask 'Type your new task:'
      want_note = cli.ask 'Do you want to add a note to this new task? y/n'
      cli_note = ''
      while want_note == 'y'
        note_text = cli.ask 'Type your note:'
        cli_note << "\n`- #{note_text}`"
        want_note = cli.ask 'Do you want to add another note to the task? y/n'
      end
      note = {
          fallback: "This should've been a new note but looks like something went wrong...",
          text: cli_note,
          color: "gray",
          mrkdwn_in: ["text"]
      }
	  set_message(cli_message)
	  set_notes(cli_note)
      notifier.post text: "• [#{category}] #{cli_message}", attachments: [note]
	  puts 'Item was posted to Slack...'
	end
  end

  class Reminder
	def add_reminder
	  file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      webhook = hash['slack_webhook']
      notifier = Slack::Notifier.new webhook
      cli = HighLine.new
      message = cli.ask 'Type your reminder:'
      notifier.post text: "• _#{message}_"
	  puts 'Reminder was posted to Slack...'
	end
  end
end
