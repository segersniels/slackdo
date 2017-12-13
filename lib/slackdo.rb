require 'slackdo/version'
require 'slack-notifier'
require 'trello'
require 'json'
require 'tty-prompt'

$prompt = TTY::Prompt.new

module Slackdo
  class Config
    def configure_init
      `mkdir #{ENV['HOME']}/.slackdo` unless File.exist?("#{ENV['HOME']}/.slackdo")
      unless File.exist?("#{ENV['HOME']}/.slackdo/config.json")
        system "touch #{ENV['HOME']}/.slackdo/config.json"
        hash = {
          "slack_webhook" => "",
          "allow_trello_pushing" => "false",
          "trello_public_key" => "",
          "trello_member_token" => "",
          "trello_list_id" => "",
          "trello_label_ids" => [],
          "categories" => ["GENERAL"]
        }
        File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
          f.write(hash.to_json)
        end
      end
    end
    def add_category
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      cat = $prompt.ask('What is the category you wish to add?')
      unless hash['categories'].include?(cat.upcase)
        hash['categories'].push(cat.upcase)
        File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
          f.write(hash.to_json)
        end
        puts "Category '#{cat.upcase}' was added..."
      else
        puts "Category '#{cat.upcase}' already exists..."
      end
    end
    def remove_category
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      cat = $prompt.select('What is the category you wish to remove?', hash['categories'])
      hash['categories'].delete(cat)
      File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
      puts "Category '#{cat}' was removed..."
    end
    def add_label
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      id = $prompt.ask('What is the ID of the label you wish to add?')
      hash['trello_label_ids'].push(id)
      File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
      puts "Label with ID '#{id}' was added..."
    end
    def remove_label
      Board.configure_trello
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      label_names = []
      hash['trello_label_ids'].each do |i|
        label_name = Trello::Label.find(i).name
        label_names.push(label_name)
      end
      label = $prompt.select('What is the label you wish to remove?', label_names)
      id = ""
      hash['trello_label_ids'].each do |i|
        label_name = Trello::Label.find(i).name
        id = i if label_name == label
      end
      hash['trello_label_ids'].delete(id)
      File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
      puts "Label '#{label}' was removed..."
    end
    def enable_trello
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      hash["allow_trello_pushing"] = "true"
      File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
      puts 'Trello has been enabled...'
    end
    def disable_trello
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      hash["allow_trello_pushing"] = "false"
      File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
      puts 'Trello has been disabled...'
    end
    def configure_trello_api
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      public_key = $prompt.ask('What is your Trello public key?', default: hash['trello_public_key'])
      member_token = $prompt.ask('What is your Trello member token?', default: hash['trello_member_token'])
      list_id = $prompt.ask('What is your Trello list ID where the cards should be created?', default: hash['trello_list_id'])
      hash["trello_public_key"] = public_key
      hash["trello_member_token"] = member_token
      hash["allow_trello_pushing"] = "true"
      hash["trello_list_id"] = list_id
      File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
      puts 'Trello API was configured...'
    end
    def configure_slack_webhook
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      webhook = $prompt.ask('What is your Slack webhook?', default: hash['slack_webhook'])
      hash["slack_webhook"] = webhook
      File.open("#{ENV['HOME']}/.slackdo/config.json",'w') do |f|
        f.write(hash.to_json)
      end
      puts 'Slack API was configured...'
    end
  end

  class Board
    def self.configure_trello
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      Trello.configure do |config|
        config.developer_public_key = hash['trello_public_key']
        config.member_token = hash['trello_member_token']
      end
    end
    def add_card(card_category, card_name, card_desc)
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      Board.configure_trello
      card_name_full = ''
      card_name_full << "[#{card_category}]"
      card_name_full << " #{card_name}"
      label_id = ''
      hash['trello_label_ids'].each do |id|
        label = Trello::Label.find(id)
        label_id = id if label.name == card_category
      end
      card = Trello::Card.create(
        name: card_name_full,
        desc: card_desc,
        list_id: hash['trello_list_id'],
        pos: 'top',
        card_labels: label_id
      )
      card.save
      puts 'Card was created on Trello...'
    end
  end

  class Task
    $note_content = ''
    $message = ''
    $category = ''
    def set_category(cat)
      $category = cat
    end
    def get_category
      return $category
    end
    def set_message(text)
      $message = text
    end
    def get_message
      return $message
    end
    def set_notes(notes)
      $note_content = notes
    end
    def get_notes
      return $note_content
    end
    def add_task
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      webhook = hash['slack_webhook']
      notifier = Slack::Notifier.new webhook
      cli_category = $prompt.select('What is the category of this new task?', hash['categories'])
      cli_message = $prompt.ask('Type your new task:')
      want_note = $prompt.select('Do you want to add a note to this new task?', %w(Yes No))
      cli_note = ''
      while want_note == 'Yes'
        note_text = $prompt.ask('Type your note:')
        cli_note << "\n`- #{note_text}`"
        want_note = $prompt.select('Do you want to add another note to the task?', %w(Yes No))
      end
      note = {
        fallback: "This should've been a new note but looks like something went wrong...",
        text: cli_note,
        color: "gray",
        mrkdwn_in: ["text"]
      }
      set_message(cli_message)
      set_category(cli_category)
      set_notes(cli_note)
      notifier.post text: "• [#{cli_category}] #{cli_message}", attachments: [note]
      puts 'Item was posted to Slack...'
    end
  end

  class Reminder
    def add_reminder
      file = File.read("#{ENV['HOME']}/.slackdo/config.json")
      hash = JSON.parse(file)
      webhook = hash['slack_webhook']
      notifier = Slack::Notifier.new webhook
      message = $prompt.ask('Type your reminder:')
      notifier.post text: "• _#{message}_"
      puts 'Reminder was posted to Slack...'
    end
  end
end
