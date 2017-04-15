class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :crypted_password, String
  property :email, String
  has n, :job_offers

  attr_accessor :secure_password

  validates_presence_of :name
  validates_presence_of :crypted_password
  validates_presence_of :email
  validates_format_of   :email,    :with => :email_address
  validates_with_method :crypted_password, 
                        :method => :valid_secure_password?

  def valid_secure_password?
    if secure_password
      return true
    else
      return [false, "bad password"]
    end
  end

  def secure_password?(password)
    !(password == password.downcase) and 
    !(password == password.upcase) and
    password.length >= 8 and
    !(password =~ /.*\d.*/).nil?
  end

  def password= (password)
    self.secure_password = secure_password?(password)
    self.crypted_password = ::BCrypt::Password.create(password) unless password.nil?	
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.has_password?(password)? user : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

end
