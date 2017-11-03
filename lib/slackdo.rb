require "slackdo/version"
require 'highline'
require 'slack-notifier'

module Slackdo
  class Webhook
	def create_directory
	  system 'mkdir ~/.slackdo &> /dev/null'
	end
	def configure_webhook
	  cli = HighLine.new
	  webhook = cli.ask 'Configure your webhook:'
	  system "echo #{webhook} > ~/.slackdo/webhook"
    end
  end
  class Task
	def add_task
      notifier = Slack::Notifier.new `cat ~/.slackdo/webhook`.strip
      cli = HighLine.new
	  category = cli.ask 'What is the category of this new task? eg. DEV or GENERAL'
      message = cli.ask 'Type your new task:'
      want_note = cli.ask 'Do you want to add a note to this new task? y/n'
      note_content = ''
      while want_note == 'y'
        note_text = cli.ask 'Type your note:'
        note_content << "\n`- #{note_text}`"
        want_note = cli.ask 'Do you want to add another note to the task? y/n'
      end
      note = {
          fallback: "This should've been a new note but looks like something went wrong...",
          text: note_content,
          color: "gray",
          mrkdwn_in: ["text"]
      }
      notifier.post text: "• [#{category}] #{message}", attachments: [note]
	end
  end

  class Reminder
	def add_reminder
      notifier = Slack::Notifier.new `cat ~/.slackdo/webhook`.strip
      cli = HighLine.new
      message = cli.ask 'Type your reminder:'
      notifier.post text: "◊ [REMINDER] #{message}"
	end
  end
end
