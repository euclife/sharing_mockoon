---
theme: default
background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'
class: text-center
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: 'Mockoon: Stop Waiting, Start Mocking!'
mdc: true
fonts:
  sans: 'Inter'
  mono: 'Fira Code'
---

# Mockoon: Stop Waiting, Start Mocking! 🚀

## Demo Session - From Zero to Hero in 15 minutes

<div class="pt-12">
  <span> s.id/mockcoon</span>
  <img src="images/qr-mockoon.png" class="w-32 mx-auto mb-4" alt="Mockoon Logo">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Spasi Gan <carbon:arrow-right class="inline"/>
  </span>
</div>

<!--
Today we'll learn Mockoon through hands-on demo
-->

---
layout: center
---

# The Problem 🤔

<img src="https://media.giphy.com/media/tXL4FHPSnVJ0A/giphy.gif" class="w-64 mx-auto mb-4" alt="Waiting GIF">

### Frontend waiting for Backend API...
### Backend waiting for External Services...
### Everyone waiting for someone else...

<!--
We've all been here - let's fix this!
-->

---
layout: center
---

# The Solution: Mockoon 🎯

<img src="https://mockoon.com/images/logo-eyes-sticker.png" class="w-32 mx-auto mb-4" alt="Mockoon Logo">

## Free, Open Source, Easy to Use
### ✅ Desktop App + CLI
### ✅ Dynamic Data Generation  
### ✅ Advanced Features

<!--
Simple solution for complex problems
-->

--
layout: center
---

# 📊 **Feature Comparison**

| Feature | Mockoon | Postman Mock | Wiremock | JSON Server |
|---------|---------|--------------|----------|-------------|
| **Free Version** | ✅ Full features | ❌ Limited | ✅ Basic | ✅ Basic |
| **GUI + CLI** | ✅ Both | ❌ GUI only | ❌ CLI only | ❌ CLI only |
| **Dynamic Data** | ✅ Faker.js built-in | ❌ Manual only | ❌ Complex setup | ❌ Static only |
| **Response Rules** | ✅ Visual editor | ❌ Limited | ✅ Complex code | ❌ None |
| **Team Collaboration** | ✅ Git-based | 💰 Paid plans | ❌ Manual | ❌ Manual |
| **CI/CD Integration** | ✅ Native | 💰 Paid plans | ⚠️ Complex | ⚠️ Basic |
| **Import/Export** | ✅ Multiple formats | ✅ Postman only | ❌ Limited | ❌ None |


<!--
Feature Comparison
-->

---
layout: default
---

# Installation 📦

<div class="grid grid-cols-2 gap-8">

<div>

## Desktop App
```bash
# macOS
brew install --cask mockoon

# Windows
winget install mockoon

# Linux
sudo snap install mockoon

# Manual download
https://mockoon.com/download/
```

</div>

<div>

## CLI Tool
```bash
# Install globally
npm install -g @mockoon/cli

# Quick start
mockoon-cli start --data my-api.json --port 3001
```

</div>

</div>

<div class="mt-4 text-center text-sm">
💡 <strong>Demo today:</strong> We'll use Desktop App first, then CLI
</div>

<!--
Let's start with Desktop App for visual learning
-->

---
layout: center
---

# Live Demo Time! 🎬

<img src="https://media.giphy.com/media/LmNwrBhejkK9EFP504/giphy.gif" class="w-48 mx-auto" alt="Fast typing GIF">

## We'll build a complete Toko Online API

<!--
Time for hands-on action!
-->

---
layout: default
---

# Demo Step 1: Create Environment 🏗️

## What we'll create:
- **Environment Name:** `toko-online-api`
- **Port:** `3001`
- **Base URL:** `http://localhost:3001`

## Live Demo Actions:
1. Open Mockoon Desktop
2. Create New Environment
3. Set name and port
4. Ready for endpoints!

<!--
Follow along as we create our first environment
-->

---
layout: default
---

# Demo Step 2: Products Endpoint 🛍️

## GET /products

```json
[
  {
    "id": "{{faker 'string.uuid'}}",
    "name": "{{faker 'commerce.productName'}}",
    "price": {{faker 'commerce.price' 10000 500000 0}},
    "category": "{{faker 'helpers.arrayElement' 
      (array 'Electronics' 'Fashion' 'Books' 'Home')}}",
    "description": "{{faker 'commerce.productDescription'}}",
    "inStock": {{faker 'number.int' 0 100}},
    "rating": {{faker 'number.float' 1 5 2}},
    "imageUrl": "{{faker 'image.url' 300 300 'products'}}",
    "createdAt": "{{faker 'date.recent'}}",
    "vendor": {
      "name": "{{faker 'company.name'}}",
      "location": "{{faker 'location.city'}}"
    }
  }
]
```

<!--
Rich, dynamic product data with nested objects
-->

---
layout: default
---

# Demo Step 3: Single Product Endpoint 📱

## GET /products/:id

```json
{
  "id": "{{request.params.id}}",
  "name": "{{faker 'commerce.productName'}}",
  "price": {{faker 'commerce.price' 10000 500000 0}},
  "category": "{{faker 'helpers.arrayElement' 
    (array 'Electronics' 'Fashion' 'Books' 'Home')}}",
  "description": "{{faker 'commerce.productDescription'}}",
  "images": [
    "{{faker 'image.url' 400 400 'products'}}",
    "{{faker 'image.url' 400 400 'products'}}",
    "{{faker 'image.url' 400 400 'products'}}"
  ],
  "specifications": {
    "brand": "{{faker 'company.name'}}",
    "model": "{{faker 'commerce.productAdjective'}} {{faker 'commerce.productMaterial'}}",
    "warranty": "{{faker 'number.int' 6 36}} months"
  }
}
```

<!--
Using request parameters in responses
-->

---
layout: default
---

# Demo Step 4: Error Handling 🚨

## Rules for GET /products/:id

### Rule 1: 404 Not Found
```javascript
{{#if (eq request.params.id '999')}}
  {{setStatusCode 404}}
{{/if}}
```

### Rule 2: Server Error
```javascript
{{#if (eq request.query.error 'server')}}
  {{setStatusCode 500}}
{{/if}}
```

### Rule 3: Validation Error
```javascript
{{#if (eq request.query.error 'validation')}}
  {{setStatusCode 422}}
{{/if}}
```

<!--
Testing different error scenarios easily
-->

---
layout: default
---

# Demo Step 5: POST Create Product ➕

## POST /products

### Request Body Validation
```json
{
  "name": "{{request.body.name}}",
  "price": {{request.body.price}},
  "category": "{{request.body.category}}",
  "description": "{{request.body.description}}"
}
```

### Success Response (201)
```json
{
  "id": "{{faker 'string.uuid'}}",
  "name": "{{request.body.name}}",
  "price": {{request.body.price}},
  "category": "{{request.body.category}}",
  "description": "{{request.body.description}}",
  "createdAt": "{{now}}",
  "status": "created"
}
```

<!--
Handling POST requests with body data
-->

---
layout: default
---

# Demo Step 6: Advanced Features ⚡

## Response Sequencing Example

### GET /payment/status
```json
[
  {
    "statusCode": 200,
    "body": {
      "status": "pending",
      "message": "Payment being processed"
    }
  },
  {
    "statusCode": 200,
    "body": {
      "status": "failed", 
      "message": "Payment failed"
    }
  },
  {
    "statusCode": 200,
    "body": {
      "status": "success",
      "message": "Payment completed"
    }
  }
]
```

<!--
Simulate real-world payment flow scenarios
-->

---
layout: default
---

# Demo Step 7: Custom Headers & CORS 🌐

## Headers Configuration

```json
{
  "Content-Type": "application/json",
  "X-API-Version": "v1.0.0",
  "X-Rate-Limit-Remaining": "{{faker 'number.int' 50 100}}",
  "X-Response-Time": "{{faker 'number.int' 10 150}}ms",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE",
  "Access-Control-Allow-Headers": "Content-Type,Authorization"
}
```

## Enable CORS
✅ Auto-handle preflight requests
✅ Custom CORS headers
✅ Development-friendly settings

<!--
Production-ready header configuration
-->

---
layout: default
---

# Demo Step 8: Testing Our API 🧪

## Using curl
```bash
# Get all products
curl http://localhost:3001/products

# Get single product
curl http://localhost:3001/products/123

# Test error scenario
curl http://localhost:3001/products/999
curl "http://localhost:3001/products/123?error=server"

# Create new product
curl -X POST http://localhost:3001/products \
  -H "Content-Type: application/json" \
  -d '{"name":"New Product","price":50000}'
```

## Using Postman/Insomnia
- Import collection
- Test all endpoints
- Verify dynamic data

<!--
Multiple ways to test our mock API
-->

---
layout: default
---

# Demo Step 9: Export & Share 📤

## Export Environment
1. **File → Export Environment**
2. **Save as:** `toko-online-api.json`
3. **Share with team** via Git/Slack
4. **Version control** your mocks

## Import to CLI
```bash
# Start with CLI
mockoon-cli start --data toko-online-api.json --port 3001

# Run in background
mockoon-cli start --data toko-online-api.json --port 3001 &

# Docker
docker run -p 3001:3001 -v $(pwd):/data \
  mockoon/cli --data /data/toko-online-api.json --port 3001
```


---
layout: default
---

# CI/CD Integration 🔄

## GitHub Actions Example

```yaml
name: Frontend Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Start Mockoon
        run: |
          npm install -g @mockoon/cli
          mockoon-cli start --data ./mocks/toko-online-api.json --port 3001 &
          sleep 5
          
      - name: Run Tests
        run: npm test
        env:
          REACT_APP_API_URL: http://localhost:3001
```

<!--
Automated testing with consistent mock data
-->

---
layout: default
---

# CI/CD Integration: GitLab CI 🦊

## GitLab CI Example

```yaml
# .gitlab-ci.yml
stages:
  - test
  - build
  - deploy

variables:
  NODE_VERSION: "18"
  MOCK_API_PORT: "3001"

before_script:
  - npm install -g @mockoon/cli

test_frontend:
  stage: test
  image: node:18
  services:
    - name: mockoon/cli:latest
      alias: mockoon
      command: ["--data", "/builds/$CI_PROJECT_PATH/mocks/toko-online-api.json", "--port", "3001"]
  script:
    - npm install
    - npm run test
  environment:
    name: testing
  variables:
    REACT_APP_API_URL: "http://mockoon:3001"
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml
```

<!--
GitLab CI with service containers for Mockoon
-->


---
layout: default
---

# Pro Tips & Best Practices 💡

## Data Management
- ✅ **Use realistic data** with Faker.js
- ✅ **Create multiple scenarios** (success, error, edge cases)
- ✅ **Keep responses lightweight** for mobile testing
- ✅ **Version control** your mock files

## Team Collaboration  
- ✅ **Consistent naming** conventions
- ✅ **Document** your endpoints
- ✅ **Share environments** via Git
- ✅ **Regular updates** as API evolves

## Development Workflow
- ✅ **Start with GUI** for design
- ✅ **Switch to CLI** for automation  
- ✅ **Integrate with CI/CD**
- ✅ **Remove mocks** before production

<!--
Proven practices for team adoption
-->

---
layout: center
---

# What We Built Today 🎯

<img src="https://media.giphy.com/media/3o7aCSPqXE5C6T8tBC/giphy.gif" class="w-40 mx-auto mb-4" alt="Success GIF">

### ✅ Complete Toko Online API
### ✅ Dynamic data with Faker.js
### ✅ Error handling & validation
### ✅ CORS & custom headers
### ✅ CLI integration ready
### ✅ Frontend integration example

<!--
Comprehensive demo completed!
-->

---
layout: center
---

# Next Steps 🚀

## Your Action Items:
### 📱 **Download Mockoon** (5 minutes)
### 🎮 **Recreate today's demo** (15 minutes)
### 🤝 **Share with your team** (today!)
### 🔗 **Integrate with current project** (this week)

## Resources:
- 🌐 **mockoon.com** - Download & docs
- 📁 **github.com/euclife/sharing_mockoon** - This presentation
- 💬 **Discord community** for questions

<!--
Clear action plan for immediate adoption
-->

---
layout: center
---

# Questions & Demo Requests? 🤔

<img src="https://media.giphy.com/media/Wn74RUT0vjnoU98Hnt/giphy.gif" class="w-48 mx-auto mb-4" alt="Questions GIF">

## Want to see specific scenarios?
## Integration with your current stack?
## Advanced features demo?

<!--
Let's address your specific needs
-->

---
layout: end
class: text-center
---

# Thanks! Happy Mocking! 🙏

<img src="https://media.giphy.com/media/ICOgUNjpvO0PC/giphy.gif" class="w-40 mx-auto mb-4" alt="Bye GIF">

### 🌐 **mockoon.com**
### 📁 **github.com/euclife/sharing_mockoon**
### 💬 **euclife - for questions**

<div class="text-sm mt-4 opacity-75">
Created for the dev community 🚀
</div>

<!--
Go build amazing things with Mockoon!
-->