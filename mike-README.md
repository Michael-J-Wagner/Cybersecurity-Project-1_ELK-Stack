## Automated ELK Stack Deployment

The files in this repository were used to configure the network shown below.

![Azure Cloud Infrastructure Diagram](Diagrams/Wagner,_Michael_-_Azure_Cloud_Infrastructure_Diagram.png)

These files were tested and used to build a live ELK deployment on the Azure cloud platform.
They can be used to recreate the entire deployment pictured above, or select portions of the
[Ansible playbook files](./Ansible/)
can be run to install specific features, such as Metricbeat.

This document contains the following details:

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA,
the D\*mn Vulnerable Web Application.

Load balancing ensures that the application will be both highly available and responsive,
in addition to restricting access to the frontend IP addresses of the virtual network.
