require_relative 'nomore/version'

module Nomore
  HOSTS = '/etc/hosts'
  START = '### begin nomore managed ###'
  ENDE  = '### end nomore managed ###'
  REGEX = /^#{START}$(.*)\n^#{ENDE}$/m

  def self.enable(domain)
    hosts = File.read(HOSTS)
    if hosts =~ REGEX 
      hosts[REGEX, 1] = hosts[REGEX, 1] + "\n127.0.0.1 #{domain}"
    else
      hosts += "\n" + START + "\n127.0.0.1 #{domain}\n" + ENDE
    end

    File.write('/etc/hosts', hosts)
  rescue Errno::EACCES
    warn 'nomore should be called as sudo'
  end

  def self.disable(domain = :all)
    hosts = File.read(HOSTS)
    if domain == :all
      hosts[REGEX] = ''
    else
      if blocked_domains = hosts[REGEX, 1]
        blocked_domains[/^.*#{domain}$/] = ''
        if blocked_domains =~ /\A(\s)*\z/
          hosts[REGEX] = ''
        else
          hosts[REGEX, 1] = blocked_domains
        end
      end
    end

    File.write('/etc/hosts', hosts)
  rescue IndexError
    warn 'Nothing done'
  rescue Errno::EACCES
    warn 'nomore should be called as sudo'
  end
end
