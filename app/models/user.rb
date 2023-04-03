class User < ApplicationRecord 
  has_many :viewing_party_users 
  has_many :viewing_parties, through: :viewing_party_users

  validates_uniqueness_of :email
  validates :password, confirmation: true
  validates_presence_of :name, :email, :password, :password_confirmation

  has_secure_password


  def movie_ids 
    viewing_parties.pluck('movie_id')
  end

  def viewing_parties_invited_to 
    viewing_parties.joins(:viewing_party_users).where('viewing_party_users.is_host = false').distinct
  end

  def viewing_parties_as_host
    viewing_parties.joins(:viewing_party_users).where('viewing_party_users.is_host = true').distinct
  end
end