# Cloud Infrastructure Security Scanner

A web-based security scanner for Infrastructure-as-Code (IaC) files that detects critical cloud security misconfigurations before deployment.

## Overview

This MVP demonstrates real cloud security skills by analyzing Terraform and CloudFormation files for common security vulnerabilities and providing actionable remediation guidance.

## Features

- **File Upload**: Drag-and-drop or click to upload IaC files (Terraform .tf, CloudFormation .yaml/.json)
- **Rule-Based Security Scanning**: Implements 7 high-impact security rules
- **Results Dashboard**: Clean, color-coded display of security issues with severity levels
- **Scan History**: View and access previous scan results
- **Persistent Storage**: All scans are saved to Supabase database

## Security Rules Implemented

The scanner checks for these critical security issues:

1. **Public S3 Buckets**: Detects buckets with public-read or public-read-write ACLs
2. **Unrestricted SSH/RDP Access**: Identifies security groups allowing 0.0.0.0/0 on ports 22 or 3389
3. **Overly Permissive IAM Policies**: Flags IAM policies with `*:*` permissions
4. **Hardcoded Credentials**: Detects hardcoded AWS keys, passwords, and API keys
5. **Unencrypted EBS Volumes**: Identifies storage volumes without encryption
6. **Publicly Accessible Databases**: Detects RDS instances with public access enabled
7. **S3 Buckets Without Encryption**: Flags S3 buckets missing server-side encryption

## Tech Stack

- **Frontend**: React, TypeScript, TailwindCSS
- **Backend**: Supabase Edge Functions
- **Database**: Supabase (PostgreSQL)
- **Icons**: Lucide React
- **Build Tool**: Vite

## Architecture

```
React Frontend (Upload + Dashboard)
        ↓
Supabase Edge Function
        ↓
Parser + Security Rule Engine
        ↓
Supabase Database (Scan Storage)
```

## Getting Started

### Prerequisites

- Node.js 18+ installed
- Supabase account (already configured)

### Installation

```bash
npm install
```

### Development

```bash
npm run dev
```

Visit `http://localhost:5173` to use the application.

### Build

```bash
npm run build
```

## Testing the Scanner

A sample Terraform file with intentional security issues is included: `sample-terraform.tf`

Upload this file to see how the scanner detects and reports:
- Public S3 bucket
- Unrestricted SSH access
- Overly permissive IAM policy
- Hardcoded AWS credentials
- Unencrypted EBS volume
- Publicly accessible RDS database
- S3 bucket without encryption

## Project Structure

```
src/
├── components/
│   ├── UploadForm.tsx       # File upload interface
│   ├── ScanResults.tsx      # Scan results display
│   └── PreviousScans.tsx    # Scan history list
├── lib/
│   └── supabase.ts          # Supabase client and types
├── App.tsx                  # Main application component
└── main.tsx                 # Application entry point

supabase/
└── functions/
    └── scan-infrastructure/ # Edge function for scanning
```

## Resume Description

This project can be accurately described on a resume as:

> Developed a web-based security scanner for Infrastructure-as-Code (Terraform/CloudFormation) files. Implemented a rule-based validation engine to detect critical cloud security misconfigurations including public access permissions, overly permissive IAM policies, and unencrypted storage. Built a results dashboard with severity levels and remediation guidance. Designed full-stack solution using React, TypeScript, Supabase Edge Functions, and PostgreSQL.

## Key Accomplishments

- Implements 7 production-ready security rules based on industry best practices
- Provides line-number references for easy issue location
- Color-coded severity system (High/Medium/Low) for prioritization
- Persistent scan history with detailed issue tracking
- Clean, professional UI appropriate for security tooling
- Scalable architecture supporting additional rules and file formats

## Future Enhancements (Not in MVP)

- Live cloud account scanning
- CI/CD GitHub integration
- Multi-cloud support (Azure, GCP)
- Auto-remediation suggestions
- User authentication and team collaboration
- Custom rule creation

## License

MIT License
