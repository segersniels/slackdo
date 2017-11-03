# Slackdo
![example](img/task-example.png)

SlackDO is a simple CLI tool that allows you to send TODO items and Reminders to yourself on Slack through an incoming webhook.

## Installation

```
gem install slackdo
```

In order to use slackdo you still have to add the rubygem's bin location to your $PATH.

```bash
export PATH=$PATH:/usr/local/lib/ruby/gems/2.4.0/gems/slackdo-0.2.0/bin
```

## Usage

First thing you should do is configure your incoming webhook by doing the following:

```
slackdo webhook
```

After that you're all set to go.
Add a new TODO item by using

```ruby
slackdo task
```
or add a reminder with

```ruby
slackdo reminder
```

## Development

Slackdo is still under development and might still be buggy. Feel free to contribute to the project.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/segersniels/slackdo.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
