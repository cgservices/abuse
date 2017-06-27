require 'rails_helper'

module Abuse
  describe Score, type: :model do
    let(:score) { create :score }
    let(:scores) { create_list :score, 10 }
    let(:scores_2_days_ago) { create_list :score, 10, created_at: 2.days.ago }
    let(:scores_ip2) { create_list :score, 5, ip: '2.2.2.2' }
    it { should validate_presence_of :ip }
    it { should validate_presence_of :points }
    it { should validate_presence_of :reason }

    it 'changes the default timespan' do
      Score.default_timespan = 123
      expect(Score.class_eval('@default_timespan')).to eq 123
    end

    it 'adds a score' do
      expect do
        Score.add_score '1.1.1.1', 20, 'some reason'
      end.to(change { Score.count }.by(1))
    end

    it 'fails when a invalid score is added' do
      expect do
        Score.add_score nil, nil, nil
      end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'returns an array with scores for an IP' do
      scores
      scores_ip2
      expect(
        Score.get_points('1.1.1.1')
      ).to eq [20] * 10
      expect(
        Score.get_points('2.2.2.2')
      ).to eq [20] * 5
    end

    it 'returns an array with scores for an IP within a timespan' do
      Score.default_timespan = 5.days
      scores
      scores_2_days_ago
      scores_ip2
      expect(
        Score.get_points('1.1.1.1')
      ).to eq [20] * 20
      expect(
        Score.get_points('1.1.1.1', 1.day)
      ).to eq [20] * 10
    end

    it 'returns cumulative points for an IP' do
      scores
      scores_ip2
      expect(
        Score.get_cumulative_points('1.1.1.1')
      ).to eq 200
      expect(
        Score.get_cumulative_points('2.2.2.2')
      ).to eq 100
    end

    it 'returns cumulative points for an IP within a timespan' do
      Score.default_timespan = 5.days
      scores
      scores_2_days_ago
      expect(
        Score.get_cumulative_points('1.1.1.1')
      ).to eq 400
      expect(
        Score.get_cumulative_points('1.1.1.1', 1.day)
      ).to eq 200
    end

    it 'removes all scores' do
      scores
      scores_ip2
      expect do
        Score.clean_scores
      end.to(change { Score.count }.from(15).to(0))
    end

    it 'removes all scores within a timespan' do
      scores
      scores_2_days_ago
      expect do
        Score.clean_scores 1.day
      end.to(change { Score.count }.from(15).to(5))
    end

    it 'clears points for an IP' do
      scores
      scores_ip2
      Scores.reset '1.1.1.1'
      expect(
        Score.get_points('1.1.1.1')
      ).to eq []
      expect(
        Score.get_cumulative_points('1.1.1.1')
      ).to be 0
    end

    it 'does not fail when an unknown IP is provided' do
      scores
      expect(
        Score.get_points('3.3.3.3')
      ).to eq []
      expect(
        Score.get_cumulative_points('3.3.3.3')
      ).to be 0
    end
  end
end
