require "slackdo/version"

module Slackdo
  class Task
	def add_task
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
      message = cli.ask 'Type your reminder:'
      notifier.post text: "• [REMINDER] #{message}"
	end
end
