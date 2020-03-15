# cms-ars-3.1-moderate-nginx-overlay
InSpec profile overlay to validate the secure configuration of NGINX based on [DISA's](https://iase.disa.mil/stigs/Pages/index.aspx) Apache 2.2 Server tailored for [CMS ARS 3.1](https://www.cms.gov/Research-Statistics-Data-and-Systems/CMS-Information-Technology/InformationSecurity/Info-Security-Library-Items/ARS-31-Publication.html) for CMS systems categorized as Moderate.

## Getting Started  
It is intended and recommended that InSpec and this profile overlay be run from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over __ssh__.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__ 

Latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

Git is required to download the latest InSpec profiles using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site. 

The following attributes must be configured in an attributes file for the profile to run correctly. More information about InSpec attributes can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```
# description: Path for the nginx configuration file (e.g., '/etc/nginx/nginx.conf') 
nginx_conf_file: ''

# description: Path to nginx backup repository (e.g., '/usr/share/nginx/html')
nginx_backup_repository: ''

# description: Subnet of the DMZ (e.g., '62.0.0.0/24')
dmz_subnet: ''

# description: Minimum Web vendor-supported version (e.g., '1.12.0').
nginx_min_ver: ''

# description: Nginx owner (e.g., 'nginx')
nginx_owner: ''

# description: The Nginx group (e.g., 'nginx')
nginx_group: ''

# description: The system adminstrator (e.g., ['root','centos'])
sys_admin: []

# description: The system adminstrator group (e.g., 'root')
sys_admin_group: ''

# description: List of non admin user accounts (e.g., ['user'])
authorized_user_list: []

# description: Monitoring software for CGI or equivalent programs (e.g., ['audit', 'auditd'])
monitoring_software: []

# description: List of disallowed packages (e.g., ['postfix'])
disallowed_packages_list: []

# description: List of disallowed compilers (e.g., ['gcc'])
disallowed_compiler_list: []

# description: DoD-approved PKIs such as DoD PKI, DoD ECA, and DoD-approved external partners (e.g. ['DoD', 'ECA'])
dod_approved_pkis: []

# description: File list of documentation, sample code, example applications, and tutorials (e.g.,['/usr/share/man/man8/nginx.8.gz'])
nginx_disallowed_file_list: []

# description: File list of allowed documentation, sample code, example applications, and tutorials.
nginx_allowed_file_list: []

# description: List of authorized nginx modules (e.g., ['http_addition', 'http_auth_request', 'http_dav', 'http_flv', 'http_gunzip', 'http_gzip_static', 'http_mp4', 'http_random_index', 'http_realip', 'http_secure_link', 'http_slice', 'http_ssl', 'http_stub_status', 'http_sub', 'http_v2', 'mail_ssl', 'stream_realip', 'stream_ssl', 'stream_ssl_preread']).

nginx_authorized_modules: []

# description: List of unauthorized nginx modules.
nginx_unauthorized_modules: []

# description: Path for the nginx binary (e.g., '/usr/sbin/nginx')
nginx_path: ''

# description: domain and port to the OCSP Server (e.g., 'login.live.com:443')
ocsp_server: ''

# description: Frequency at which CRL is updated in days (e.g., 7)
crl_update_frequency: 
```

## Running This Overlay
When the __"runner"__ host uses this profile overlay for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay.git
git clone https://github.com/mitre/nginx-baseline.git
cd cms-ars-3.1-moderate-nginx-stig-overlay
bundle install
cd ..
inspec exec cms-ars-3.1-moderate-nginx-overlay --target=ssh://<your_target_host_name_or_ip_address> --user=<target_account_with_administrative_privileges> --password=<password_for_target_account> --attrs=<path_to_your_attributes_file/name_of_your_attributes_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json> 

```

For every successive run, follow these steps to always have the latest version of this overlay and dependent profiles:

```
cd profiles/nginx-baseline
git pull
cd ../cms-ars-3.1-moderate-nginx-overlay
git pull
bundle install
cd ..
inspec exec cms-ars-3.1-moderate-nginx-overlay --target=ssh://<your_target_host_name_or_ip_address> --user=<target_account_with_administrative_privileges> --password=<password_for_target_account> --attrs=<path_to_your_attributes_file/name_of_your_attributes_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>  
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
To report a bug or feature request, please open an [issue](https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/issues).

## License
This is licensed under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license. 

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.

### NOTICE
DISA STIGs are published by DISA IASE, see: https://iase.disa.mil/Pages/privacy_policy.aspx
