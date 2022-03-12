## Automated ELK Stack Deployment

The files in this repository were used to configure the network shown below.

![Azure Cloud Infrastructure Diagram](Diagrams/Wagner,_Michael_-_Azure_Cloud_Infrastructure_Diagram.png)

These files were tested and used to build a live ELK stack (Elasticsearch, Logstash, and Kibana) deployment on
the Azure cloud platform. They can be used to recreate the entire deployment pictured above, or select portions of
the [Ansible playbook files](./Ansible/) can be run to install specific features, such as Metricbeat.

This document contains the following details:

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the
D\*mn Vulnerable Web Application.

Load balancing ensures that the application will be both highly available and responsive,
in addition to restricting access to the frontend IP addresses of the virtual network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file system and system metrics.

The configuration details of each machine may be found below.

| Name                           | Function   | IP Address | Operating System    |
|--------------------------------|------------|------------|---------------------|
| Red-Team--Jump-Box-Provisioner | Gateway    | 10.0.0.4   | Linux: Ubuntu 18.04 |
| Red-Team--Web-Server-1         | Web Server | 10.0.0.5   | Linux: Ubuntu 18.04 |
| Red-Team--Web-Server-2         | Web Server | 10.0.0.6   | Linux: Ubuntu 18.04 |
| Red-Team--Web-Server-3         | Web Server | 10.0.0.7   | Linux: Ubuntu 18.04 |
| Project-ELK--Server            | ELK Server | 10.1.0.4   | Linux: Ubuntu 18.04 |

### Access Policies

The machines on the internal network are not exposed to the public Internet;
they can only be accessed by the Red-Team--Jump-Box-Provisioner machine.

Only the Jump Box can accept connections from the Internet.
Access to this machine is only allowed from the developer's workstation.

The table below summarizes the access policies in place:

| Name                           | Publicly Accessible | Allowed IP Addresses               |
| ------------------------------ | ------------------- | ---------------------------------- |
| Red-Team--Jump-Box-Provisioner | Yes                 | Developer's workstation            |
| Red-Team--Web-Server-1         | No                  | 10.0.0.4                           |
| Red-Team--Web-Server-2         | No                  | 10.0.0.4                           |
| Red-Team--Web-Server-3         | No                  | 10.0.0.4                           |
| Project-ELK--Server            | No                  | 10.0.0.4 & Developer's workstation |


