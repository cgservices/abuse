module Abuse
  # Abuse::Score
  class Score < ActiveRecord::Base
    @default_timespan = 24.hours

    validates :ip, :points, :reason, presence: true

    class << self
      attr_accessor :default_timespan

      def add_score(ip, points, reason)
        Score.create! ip: ip, points: points, reason: reason
      end

      def get_points(ip, timespan = nil)
        timespan ||= @default_timespan
        Score
          .where(ip: ip)
          .where('created_at > ?', Time.zone.now - timespan.to_i)
          .pluck(:points)
      end

      def get_cumulative_points(ip, timespan=nil)
        timespan ||= @default_timespan
        Score
          .where(ip: ip)
          .where('created_at > ?', Time.zone.now - timespan.to_i)
          .sum(:points)
      end

      def clean_scores(timespan=nil)
        timespan ||= @default_timespan
        Score
          .where(ip: ip)
          .where('created_at > ?', Time.zone.now - timespan.to_i)
          .destroy_all
      end

      def reset(ip)
        timespan ||= @default_timespan
        Score
          .where(ip: ip)
          .where('created_at > ?', Time.zone.now - timespan.to_i)
          .destroy_all
      end
    end
  end
end
