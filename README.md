# Slackdo
![example](img/task-example.png)

SlackDO is a simple CLI tool that allows you to send TODO items and Reminders to yourself on Slack through an incoming webhook.

## Installation

```
gem install slackdo
```

In order to use slackdo you still have to add the rubygem's bin location to your $PATH.

eg. for OSX:

```bash
export PATH=$PATH:/usr/local/lib/ruby/gems/<ruby-version>/gems/slackdo-<gem-version>/bin
```

To get to know your general gem installation path use the following for your general rubygems information and look for the GEM PATHS variable:

```bash
$ gem env
```

Or just check the specific gem information to see the location where it's installed:

```bash
$ gem which slackdo
/usr/local/lib/ruby/gems/<ruby-version>/gems/slackdo-<gem-version>/lib/slackdo.rb
```

This indicates that your gem binary is located at `/usr/local/lib/ruby/gems/<ruby-version>/gems/slackdo-<gem-version>/bin`.

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
