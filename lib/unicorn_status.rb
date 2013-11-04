require 'raindrops'

module UnicornStatus
  class Activity
    def self.stat(socket)
      Raindrops::Linux.unix_listener_stats([socket]).each do |addr, stats|
        stats.active.to_s + stats.queued.to_s.rjust(header.length - stats.active.to_s.length)
      end
    end
  end
end

