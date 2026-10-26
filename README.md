# 🌐 Multi-Region Active-Active High-Availability Architecture

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Azure Front Door](https://img.shields.io/badge/Global_Traffic-Front_Door_Premium-0078D4.svg?logo=microsoftazure)](https://azure.microsoft.com)
[![Cosmos DB](https://img.shields.io/badge/Database-Cosmos_DB_Multi--Master-blue.svg)](https://azure.microsoft.com)
[![SLA](https://img.shields.io/badge/High_Availability-99.999%25_Five_Nines-success.svg)](https://learn.microsoft.com)
[![RTO / RPO](https://img.shields.io/badge/RTO%2FRPO-Near_Zero-brightgreen.svg)](https://www.linkedin.com/in/gunjan-gaurav)

**Global Active-Active Resilience • Anycast Edge Load Balancing • Cosmos DB Multi-Region Multi-Write • Automated Region Evacuation Drills**

[Architecture](#-architecture) • [Failover Automation](#-failover-mechanisms) • [Repository Structure](#-repository-structure)

</div>

---

## 🎯 Executive Overview

For mission-critical enterprise systems, regional cloud outages must not cause downtime. **Multi-Region Active-Active Resilience** was designed and implemented by **Gunjan Kumar Gaurav** to deliver **99.999% SLA (Five Nines)** with near-zero RTO and RPO.

```
                  [ Global Users & API Clients ]
                                |
                                v
          [ Azure Front Door Premium (Anycast Routing) ]
                                |
         +----------------------+----------------------+
         |                                             |
         v (Low-Latency Origin Routing)                v
[ Primary Region: East US ]                 [ Secondary Region: West Europe ]
• AKS Cluster / App Service                 • AKS Cluster / App Service
• In-Region Private Endpoints               • In-Region Private Endpoints
         \                                             /
          \                                           /
           v                                         v
         [ Azure Cosmos DB: Multi-Region Multi-Master Write ]
         • Bi-directional real-time replication with Session Consistency
```

---

## ⚡ Core Architectural Capabilities

* **Active-Active Bi-Directional Processing:** Both regions process live write and read transactions simultaneously.
* **Instant Region Evacuation:** If telemetry indicates latency degradation in one geography, Front Door immediately shifts 100% of ingress to the secondary region.
* **Data Conflict Resolution:** Cosmos DB Last-Write-Wins (LWW) and custom stored procedure conflict resolution.

---

## 📁 Repository Structure

```
multi-region-active-active-resilience/
├── chaos-dr-drills/
│   └── automated_region_evacuation.ps1   # Regional evacuation simulation script
├── terraform/
│   ├── front_door.tf                     # Front Door Premium and Cosmos DB multi-write
│   ├── variables.tf
│   └── outputs.tf
└── README.md
```

---

## 👤 Architect & Author

**Gunjan Kumar Gaurav**  
*Senior Cloud Architect & DevSecOps Consultant*  
[LinkedIn](https://www.linkedin.com/in/gunjan-gaurav) • [GitHub](https://github.com/gunjankumargaurav7350) • Email: `gunjankumargaurav7@gmail.com`
