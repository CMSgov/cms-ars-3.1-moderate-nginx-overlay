# cms-ars-3.1-moderate-nginx-overlay
**CMS’ ISPG (Information Security and Privacy Group) decided to discontinue funding the customization of MITRE’s Security Automation Framework (SAF) for CMS after September 2023. This repo is now in archive mode, but still accessible. For more information about SAF with current links, see https://security.cms.gov/learn/security-automation-framework-saf**

InSpec profile overlay to validate the secure configuration of NGINX based on [DISA's](https://iase.disa.mil/stigs/Pages/index.aspx) Apache 2.2 Server tailored for [CMS ARS 3.1](https://www.cms.gov/Research-Statistics-Data-and-Systems/CMS-Information-Technology/InformationSecurity/Info-Security-Library-Items/ARS-31-Publication.html) for CMS systems categorized as Moderate.

#### Container-Ready: Profile updated to adapt checks when the running against a containerized instance of nginx, based on reference container: https://ironbank.dso.mil/repomap/opensource/nginx

## Getting Started  
It is intended and recommended that InSpec and this profile overlay be run from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over __ssh__.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__ 

The latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

## Tailoring to Your Environment
The following inputs must be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

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

## Running This Overlay Directly from Github

Against a _**remote**_ target using ssh with escalated privileges (if escalated privileges are needed) (i.e., InSpec installed on a separate runner host)
```bash
inspec exec https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/archive/master.tar.gz -t ssh://TARGET_USERNAME:TARGET_PASSWORD@TARGET_IP:TARGET_PORT --sudo --sudo-password=<SUDO_PASSWORD_IF_REQUIRED> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```

Against a _**remote**_ target using a _**pem**_ key with escalated privileges (if escalated privileges are needed) (i.e., InSpec installed on a separate runner host)
```bash
inspec exec https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/archive/master.tar.gz -t ssh://TARGET_USERNAME@TARGET_IP:TARGET_PORT --sudo -i <your_PEM_KEY> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json>  
```

Against a _**locally-hosted**_ instance with escalated privileges (if escalated privileges are needed) (i.e., InSpec installed on the target)
```bash
sudo inspec exec https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/archive/master.tar.gz --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```

Against a _**docker-containerized**_ instance:
```bash
inspec exec https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/archive/master.tar.gz -t docker://instance_id --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```


### Different Run Options

  [Full exec options](https://docs.chef.io/inspec/cli/#options-3)

## Running This Overlay from a local Archive copy 

If your runner is not always expected to have direct access to GitHub, use the following steps to create an archive bundle of this overlay and all of its dependent tests:

(Git is required to clone the InSpec profile using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site.)

When the __"runner"__ host uses this profile overlay for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay.git
inspec archive cms-ars-3.1-moderate-nginx-overlay
inspec exec <name of generated archive file> -t ssh://TARGET_USERNAME:TARGET_PASSWORD@TARGET_IP:TARGET_PORT --sudo --sudo-password=<SUDO_PASSWORD_IF_REQUIRED> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 

```
_(execute using the same methods discussed above, substituting the name of the generated archive in place of "https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/archive/master.tar.gz")_

For every successive run, follow these steps to always have the latest version of this overlay and dependent profiles:

```
cd cms-ars-3.1-moderate-nginx-overlay
git pull
cd ..
inspec archive cms-ars-3.1-moderate-nginx-overlay --overwrite
inspec exec <name of generated archive file> -t ssh://TARGET_USERNAME:TARGET_PASSWORD@TARGET_IP:TARGET_PORT --sudo --sudo-password=<SUDO_PASSWORD_IF_REQUIRED> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter json:<path_to_your_output_file/name_of_your_output_file.json> 
```
_(execute using the same methods discussed above, substituting the name of the generated archive in place of "https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/archive/master.tar.gz")_

## Using Heimdall for Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://heimdall-lite.cms.gov/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/mitre/heimdall2)__, allowing for additional functionality such as to store and compare multiple profile runs.

## Authors
* Eugene Aronne - [ejaronne](https://github.com/ejaronne)
* Danny Haynes - [djhaynes](https://github.com/djhaynes)

## Special Thanks
* Patrick Muench
* Dominik Richter - [arlimus](https://github.com/arlimus)
* Christoph Hartmann - [chris-rock](https://github.com/chris-rock)
* Rony Xaiver - [rx294](https://github.com/rx294)
* Aaron Lippold - [aaronlippold](https://github.com/aaronlippold)
* Shivani Karikar - [karikarshivani](https://github.com/karikarshivani)


## Contributing and Getting Help
To report a bug or feature request, please open an [issue](https://github.com/CMSgov/cms-ars-3.1-moderate-nginx-overlay/issues).

### NOTICE

© 2018-2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE 

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.

### NOTICE 

DISA STIGs are published by DISA IASE, see: https://iase.disa.mil/Pages/privacy_policy.aspx
