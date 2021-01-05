# encoding: utf-8

include_controls 'nginx-baseline' do

  control 'V-2234' do
    desc 'It is important to segregate public web server resources from private resources located behind the DMZ in order to protect private assets. When folders, drives or other resources are directly shared between the public web server and private 
    servers the intent of data and resource segregation can be compromised.'
    end

  control 'V-2242' do
    title 'A public web server, if hosted on the NIPRNet, must be isolated in an accredited DMZ.'
    desc 'To minimize exposure of private assets to unnecessary risk by attackers, public web servers must be isolated from internal systems. Public web servers are by nature more 
    vulnerable to attack from publically based sources, such as the public Internet. Once compromised, a public web server might be used as a base for further attack on private resources, unless additional layers of protection are implemented. Public web servers must be located in a DMZ, if hosted on the Internet, with carefully controlled access. Failure to isolate resources in this way increase risk that private assets are exposed 
    to attacks from public sources.'
    desc 'check', ' Interview the SA or web administrator to see where the public web server is logically located in the data center. Review the site’s network diagram to see how the 
    web server is connected to the LAN. Visually check the web server hardware connections to see if it conforms to the site’s network diagram. An improperly located public web server is a potential threat to the entire network. If the web server is not isolated in an accredited DMZ, this is a finding.'
    describe "For this CMS ARS 3.1 overlay, this control must be reviewed manually" do 
      skip "For this CMS ARS 3.1 overlay, this control must be reviewed manually"
    end
  end	     

  control 'V-2246' do
    desc 'check', 'To determine the version of the nginx software that is running on the system. Use the command:

    nginx -v

    If the version of nginx is not at the following version or higher, this is a finding.

    nginx version: nginx/1.15.0

    Note: In some situations, the nginx software that is being used is supported by another vendor, such as nginx.com. 

    The versions of the software in these cases may not match the above mentioned version numbers. If the site can provide vendor documentation showing the version of the web server is supported, this would not be a finding.'
  end
    
  control 'V-6485' do
    describe "For this CMS ARS 3.1 overlay, this control must be reviewed manually" do 
      skip "For this CMS ARS 3.1 overlay, this control must be reviewed manually"
    end
  end
  
  control 'V-13613' do
    describe.one
      describe "All packages are up to date" do
        subject { linux_update.updates.length }
        it { should eq 0 }
      end
      linux_update.updates.each do |update|
        describe package(update['name']) do
          its('version') { should eq update['version'] }
        end
      end
  end

  control 'V-13620' do
    title "A private web server’s list of CAs in a trust hierarchy must lead to an authorized CMS PKI Root CA."

    desc "A PKI certificate is a digital identifier that establishes the identity of an individual or a platform. A server that has a certificate provides users with third-party confirmation of authenticity. Most web browsers perform server authentication automatically and the user is notified only if the authentication fails. The authentication process between the server and the client is performed using the SSL/TLS protocol. Digital certificates are authenticated, issued, and managed by a trusted Certificate Authority (CA). The use of a trusted certificate validation hierarchy is crucial to the ability to control access to a site’s server and to prevent unauthorized access. Only CMS-approved PKIs will be utilized."
    
    tag "check": "Enter the following command:
    find / -name ssl.conf
    note the path of the file.

    grep ""ssl_client_certificate"" in conf files in context http,server
    Review the results to determine the path of the ssl_client_certificate.
    more /path/of/ca-bundle.crt
    
    Examine the contents of this file to determine if the trusted CAs are CMS approved. If the trusted CA that is used to authenticate users to the web site does not lead to an approved CMS CA, this is a finding.

    NOTE: There are non CMS roots that must be on the server in order for it to function. Some applications, such as anti-virus programs, require root CAs to function. CMS approved certificate can include external CAs if approved by CMS."
    tag "fix": "Configure the web server’s trust store to trust only CMS-approved PKIs (e.g., DoD PKI, DoD ECA, and DoD-approved external partners)."
    
    describe "For this CMS ARS 3.1 overlay, this control must be reviewed manually" do
      skip "For this CMS ARS 3.1 overlay, this control must be reviewed manually"
    end
  end

  control 'V-13672' do
    title "The private web server must use an approved CMS certificate validation process."
    tag "check": "The reviewer should query the ISSO, the SA, the web administrator, or developers as necessary to determine if the web server is configured to utilize an approved CMS certificate validation process.
    The web administrator should be questioned to determine if a validation process is being utilized on the web server.
    To validate this, the reviewer can ask the web administrator to describe the validation process being used. They should be able to identify either the use of certificate revocation lists (CRLs) or Online Certificate Status Protocol (OCSP).
    
    If the production web server is accessible, the SA or the web administrator should be able to demonstrate the validation of good certificates and the rejection of bad certificates.
    
    If CRLs are being used, the SA should be able to identify how often the CRL is updated and the location from which the CRL is downloaded.
    
    If the web administrator cannot identify the type of validation process being used, this is a finding."
    tag "fix": "Configure CMS Private Web Servers to conduct certificate revocation checking utilizing certificate revocation lists (CRLs) or Online Certificate Status Protocol (OCSP)."
  end

end