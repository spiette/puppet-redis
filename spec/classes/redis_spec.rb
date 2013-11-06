require 'spec_helper'

describe 'redis' do
  let(:title) { 'redis' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "redis class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('redis') }
      it { should create_class('redis::install') }
      it { should create_package('redis') }
    end
  end
end
