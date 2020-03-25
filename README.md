# Platform setup instructions

Initialization scripts to replicate data collection nodes.
```console
user1@node1:~$ sudo ./boot.sh
```

## Motivation
Data collection servers are the basis of our service. They are a loosely connected set of nodes that acquire and process data and perform different tasks on it.
This repository serves to automate as much as possible the deployment and start-up activities for those servers and replicators.

## Architecture
Given the purpose of the platform, is natural to use a data-driven architecture. So, the system is configured as a set of services/tasks operating through data channels. Services are independient from each other and they are managed by supervisors. Data is stored in a database and then streamed from one service to the next and then to a new storage. It is modeled after the workflow of audio and video processors and its multiple chainable effects and processes.

To make it work properly in realtime conditions and to make it able to recover from shutdowns and errors, careful replication and coordination are needed.
This is inspired in the way Erlang nodes work, but with an encription layer provided by SSH and several other services and mechanisms to defend against network attacks.

### Nodes
To reduce errors, the nodes should be kept as simple as possible. Each node has a minimalist linux server with Nginx working as a reverse proxy and load balancer to the different services. All connections between nodes are routed through port 443 (https).

### Databases
PostgreSQL stores all information needed to coordinate and ensure command and control between the nodes. PgBouncer manages the connection pool between nodes and the database server through the reverse proxy.
Redis is used for acquiring and storing high speed data such as process variables from industrial PLCs or IoT data collectors.
SQLite:memory is used for single node data processing, ephemeral calculations and other data transition activities such as saving bandwidth.

### Maintenance
Code deployment to each node is done by a git push. Every component and every message must be version aware. The supervisor service shall identify changes and shall coordinate a hot swap of the changed files without risking loss of data. That means transparent coexistence of different versions of the same program in execution.

### Control
The basis for controlling the system is the scheduler. The scheduler decides which services run on each node, when to stop a service, when to start a new one and when to update each component.

### Testing
Each component of the system must comply with a test bench. Every exposed functionality must be tested to pass the whole technical specification before committing it to the master branch. At all times, the master branch shall compile properly and shall pass all the tests.
