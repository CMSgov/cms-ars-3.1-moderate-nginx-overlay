# cms-ars-3.1-nginx-overlay
InSpec profile overlay to validate the secure configuration of NGINX based on [DISA's](https://iase.disa.mil/stigs/Pages/index.aspx) Apache 2.2 Server tailored for [CMS ARS 3.1](https://www.cms.gov/Research-Statistics-Data-and-Systems/CMS-Information-Technology/InformationSecurity/Info-Security-Library-Items/ARS-31-Publication.html) for CMS systems categorized as Moderate.

## Getting Started  
It is intended and recommended that InSpec and this profile overlay be run from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over __ssh__.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__ 

Latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

The following attributes must be configured in an attributes file for the profile to run correctly. More information about InSpec attributes can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```
# description: Path for the nginx configuration file
nginx_conf_file: '/etc/nginx/nginx.conf'

# description: Path to nginx backup repository
nginx_backup_repository: '/usr/share/nginx/html'

# description: Subnet of the DMZ
dmz_subnet: '62.0.0.0/24'

# description: Minimum Web vendor-supported version.
nginx_min_ver: '1.12.0'

# description: Nginx owner
nginx_owner: 'nginx'

# description: The Nginx group,
nginx_group: 'nginx'

# description: The system adminstrator,
sys_admin: ['root','centos']

# description: The system adminstrator group,
sys_admin_group: 'root'

# description: List of non admin user accounts
authorized_user_list:
    ['user'
    ]

# description: Monitoring software for CGI or equivalent programs,
monitoring_software: ['audit', 'auditd']

# description: 'List of disallowed packages',
disallowed_packages_list: ['postfix']

# description: List of disallowed compilers
disallowed_compiler_list:
    ['gcc'
    ]

# description: DoD-approved PKIs (e.g., DoD PKI, DoD ECA, and DoD-approved external partners.
dod_approved_pkis:
    ['DoD',
     'ECA'
    ]

# description: File list of  documentation, sample code, example applications, and tutorials.
nginx_disallowed_file_list:
    [ '/usr/share/man/man8/nginx.8.gz'
    ]

# description: File list of allowed documentation, sample code, example applications, and tutorials.
nginx_allowed_file_list:
    [
    ]

# description: List of  authorized nginx modules.
nginx_authorized_modules:
    ['http_addition',
     'http_auth_request',
     'http_dav',
     'http_flv',
     'http_gunzip',
     'http_gzip_static',
     'http_mp4',
     'http_random_index',
     'http_realip',
     'http_secure_link',
     'http_slice',
     'http_ssl',
     'http_stub_status',
     'http_sub',
     'http_v2',
     'mail_ssl',
     'stream_realip',
     'stream_ssl',
     'stream_ssl_preread'
     ]

# description: List of  unauthorized nginx modules.
nginx_unauthorized_modules:
    [
    ]

# description: Path for the nginx binary
nginx_path: '/usr/sbin/nginx'

# description: domain and port to the OCSP Server
ocsp_server: 'login.live.com:443'

# description: Frequency at which CRL is updated in days
crl_udpate_frequency: 7
```

## Running This Overlay
When the __"runner"__ host uses this profile overlay for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.cms.gov/ispg-dev/cms-ars-3.1-nginx-overlay.git
git clone https://github.com/mitre/nginx-baseline.git
cd cms-ars-3.1-moderate-nginx-stig-overlay
bundle install
cd ..
inspec exec cms-ars-3.1-nginx-overlay --target=ssh://<your_target_host_name_or_ip_address> --user=<target_account_with_administrative_privileges> --password=<password_for_target_account> --attrs=cms-ars-3.1-nginx-overlay/static-attributes.yml <path_to_your_attributes_file/name_of_your_attributes_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json> 

```

For every successive run, follow these steps to always have the latest version of this overlay and dependent profiles:

```
cd profiles/nginx-baseline
git pull
cd ../cms-ars-3.1-nginx-overlay
git pull
bundle install
cd ..
inspec exec cms-ars-3.1-nginx-overlay --target=ssh://<your_target_host_name_or_ip_address> --user=<target_account_with_administrative_privileges> --password=<password_for_target_account> --attrs=cms-ars-3.1-nginx-overlay/static-attributes.yml <path_to_your_attributes_file/name_of_your_attributes_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>  
```

## Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://mitre.github.io/heimdall-lite/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/mitre/heimdall)__, allowing for additional functionality such as to store and compare multiple profile runs.

## Authors
* Eugene Aronne
* Danny Haynes

## Special Thanks
* Patrick Muench 
* Dominik Richter
* Christoph Hartmann
* Rony Xaiver
* Aaron Lippold


## Contributing and Getting Help
To report a bug or feature request, please open an [issue](https://github.cms.gov/ispg-dev/cms-ars-3.1-moderate-nginx-stig-overlay/issues).

## License
This is licensed under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license. 

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.

### NOTICE
DISA STIGs are published by DISA IASE, see: https://iase.disa.mil/Pages/privacy_policy.aspx
