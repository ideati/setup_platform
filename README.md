# Platform setup instructions

Initialization scripts to replicate data collection nodes.

## Motivation
Data collection servers are the basis of our service. They are a loosely connected set of nodes that acquire and process data and perform different tasks on it.
This repository serves to automate as much as possible the deployment and start-up activities for those servers and replicators.

## Architecture
Given the purpose of the platform, is natural to use a data-driven architecture. So, the system is configured as a set of services/tasks operating through data channels. Services are independient from each other and they are managed by supervisors. Data is stored in a database and then streamed from one service to the next and then to a new storage. It is modeled after the workflow of audio and video processors and its multiple chainable effects and processes.

To make it work properly in realtime conditions and to make it able to recover from shutdowns and errors, careful replication and coordination are needed.
This is inspired in the way Erlang nodes work, but with an encription layer provided by SSH and several other services and mechanisms to defend against network attacks.

To reduce errors, the nodes should be kept as simple as possible. Each node has a minimalist linux server with a nginx server working as a proxy to the different services.
All connections are routed through ports 443 (https) or 22 (ssh).

The deployment is done by a git push. The supervisor service must identify changes and coordinate a hot swap of the changed files without risking loos of data.

