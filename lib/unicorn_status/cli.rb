require 'thor'
require 'unicorn_status'

module UnicornStatus
  class CLI < Thor
    class_option :help, :type => :boolean, :aliases => '-h', :desc => 'Help message.'
    option :socket,    aliases: '-s', desc: 'path to unix socket'
    option :interval,  aliases: '-i', default: 1, desc: 'poll interval in seconds'

    desc "execute", "hoge"
    def execute
      unless File.exist? options[:socket]
        abort "#{options[:socket]} no exsits"
      end

      loop do
        response = UnicornStatus::Activity.stat options[:socket]
        p response
        sleep options[:interval]
      end
    end

    no_tasks do
      # defined in /lib/thor/invocation.rb
      def invoke_task(task, *args)
        if options[:help]
          CLI.task_help(shell, task.name)
        else
          super
        end
      end
    end
  end
end

