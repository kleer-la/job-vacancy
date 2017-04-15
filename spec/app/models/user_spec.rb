require 'spec_helper'

describe User do

	describe 'model' do

		subject { @user = User.new }

		it { should respond_to( :id) }
		it { should respond_to( :name ) }
		it { should respond_to( :crypted_password) }
		it { should respond_to( :email ) }
		it { should respond_to( :job_offers ) }

	end

	describe 'valid?' do

	  let(:user) { 
	  	u=User.new
	  	u.name = 'John Doe'
	  	u.email = 'john.doe@someplace.com'
	  	u.password = 'a_secure_passWord1!'
	  	u
	  }

	  it 'should be false when name is blank' do
	  	user.name = nil
	  	user.valid?.should be_false
	  end


	  it 'should be false when email is not valid' do
	  	user.email = 'john'
	  	user.valid?.should be_false
	  end

	  it 'should be false when password is blank' do
	  	user.password = ''
	  	user.valid?.should be_false
	  end

	  it 'should be true when all field are valid' do
		  	user.valid?.should be_true
	  end

	  it 'should be false when password has no uppercase' do 
	  	user.password = 'a_secure_password!'
	  	user.valid?.should be_false
	  end

	  it 'should be false when password has no lowercase' do 
	  	user.password = 'A_SECURE_PASSWORD!'
	  	user.valid?.should be_false
	  end

	  it 'should be false when password is shorter than 8' do 
	  	user.password = 'Insecu!'
	  	user.valid?.should be_false
	  end

	  it 'should be false when password has no number' do 
	  	user.password = 'a_secure_passWord!'
	  	user.valid?.should be_false
	  end

	end

	describe 'authenticate' do

		before do
			@password = 'password'
		 	@user = User.new
		 	@user.email = 'john.doe@someplace.com'
		 	@user.password = @password
		end

		it 'should return nil when password do not match' do
			email = @user.email
			password = 'wrong_password'
			User.should_receive(:find_by_email).with(email).and_return(@user)
			User.authenticate(email, password).should be_nil
		end

		it 'should return nil when email do not match' do
			email = 'wrong@email.com'
			User.should_receive(:find_by_email).with(email).and_return(nil)
			User.authenticate(email, @password).should be_nil
		end

		it 'should return the user when email and password match' do
			email = @user.email
			User.should_receive(:find_by_email).with(email).and_return(@user)
			User.authenticate(email, @password).should eq @user
		end

	end

end

