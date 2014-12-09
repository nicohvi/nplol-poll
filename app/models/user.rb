class User < ActiveRecord::Base
  has_many :votes, dependent: :delete_all
  has_many :created_polls, class_name: 'Poll', foreign_key: 'owner_id', dependent: :delete_all
  has_many :polls, through: :votes  

  validates :email, presence: true
  validates_uniqueness_of :email
  
  def voted_for?(object)
    attribute = "#{object.to_s}_id".to_sym
    votes.pluck(attribute).include? object.id
  end

  def vote(option)
    return false if voted_for?(option) || option.poll.closed
    remove_old_vote(option.poll) if voted_for?(option.poll)
    votes << Vote.new(option: option, poll: option.poll)
  end

  private

  def remove_old_vote(poll)
    votes.find_by(poll_id: poll.id).delete
  end

end
