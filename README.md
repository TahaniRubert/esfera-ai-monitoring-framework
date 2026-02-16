# Esfera AI Monitoring Framework

End-to-end analytical framework designed to measure, interpret, and monitor the performance of an enterprise AI assistant integrated within construction management software.

---

## 📊 Project Overview

This project transforms raw system logs into a structured analytical model capable of measuring:

- AI usage patterns
- Query complexity
- Response quality proxies
- Technical performance (TTFT & total duration)
- Operational cost per query
- Reformulation behavior
- Explicit technical error rates

The objective was to build a reproducible KPI structure that enables long-term monitoring and dashboard integration.

---

## 🧠 Business Context

Esfera is a construction management software that integrates a conversational AI assistant.  
Users interact with the AI to:

- Analyze financial data
- Track project progress
- Generate reports
- Interpret operational information

The system required a structured analytical framework to evaluate adoption, performance, and scalability readiness.

---

## 🌎 Language Context

The original system logs and production queries were written in Spanish, as the software operates in a Spanish-speaking business environment.

For portfolio and documentation purposes, the analytical framework, KPI definitions, and strategic interpretation were fully translated and standardized in English.

This ensures professional clarity while preserving real implementation conditions.

---

## 🛠 Methodology

The framework includes:

- Sessionization logic based on a 10-minute inactivity threshold
- Real query filtering (≥20 characters or containing "?")
- Heuristic query classification logic (keyword-based approach)
- Behavioral KPI definitions
- Cost estimation based on token consumption
- Performance baseline metrics (TTFT & duration)

All KPIs are fully reproducible using SQL (BigQuery).

---

## 📈 Core KPIs Defined

1. Satisfactory Response Rate  
2. Reformulation Rate  
3. Average Queries per Session  
4. Explicit Error Rate  
5. AI Response Time (TTFT & Duration)  
6. Cost per Query (USD)

These KPIs establish a technical and operational baseline for monitoring future AI evolution.

---

## 📊 Dashboard Implementation

The defined KPIs were integrated into Tableau dashboards for:

- Executive monitoring
- Technical performance tracking
- Usage evolution analysis
- Cost scalability evaluation

This structure enables threshold definition, longitudinal tracking, and performance governance.

---

## 📂 Repository Structure

- `/notebooks` → Full analytical notebook (Kaggle version)
- `/sql` → Production-ready SQL queries
- `/dashboard` → Dashboard structure documentation
- `/presentation` → Executive presentation version

---

## Outcome

The project delivers a scalable monitoring architecture that enables:

- Evidence-based product decisions
- Performance baseline tracking
- Cost visibility
- Strategic AI positioning within enterprise software

This framework can evolve into a live monitoring layer as AI usage scales.

---

## Author

Tahani Rubert  
Data Analyst | AI Monitoring & Performance Analytics
