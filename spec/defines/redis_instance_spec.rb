require 'spec_helper'

describe 'redis::instance', :type => 'define'  do
  name = '1'
  let(:title) { name }

  ['Debian', 'RedHat'].each do |osfamily|
    context "redis::instance without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      # included redis class
      it { should create_class('redis') }
      it { should create_class('redis::install') }
      it { should create_package('redis') }
      it { should create_redis__instance(name) }

      it { should create_file("/etc/redis#{name}.conf")
           .with_content(/^logfile .var.log.redis.redis#{name}.log$/ )\
           .with_content(/^pidfile .var.run.redis.redis#{name}.pid$/ )\
           .with_content(/^dir .var.lib.redis#{name}$/ )\
           .with_content(/^dbfilename dump#{name}.rdb$/ )\
           .with_content(/^vm-swap-file .tmp.redis#{name}.swap$/ )\
           .with_content(/^timeout 0$/ )\
           .with_content(/^loglevel notice$/ )\
      }
      it { should create_file("/etc/init.d/redis#{name}") }
      it { should create_service("redis#{name}")
           .with_ensure('running')\
           .with_enable('true')\
           .with_hasstatus('true')
      }

    end
  end
end
