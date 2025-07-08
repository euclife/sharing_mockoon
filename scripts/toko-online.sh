#!/bin/bash

echo "🚀 Testing Toko Online API"
echo "=========================="

BASE_URL="http://localhost:3001"

echo ""
echo "1. GET /products"
curl -s "$BASE_URL/products" | jq '.'

echo ""
echo "2. GET /products/123" 
curl -s "$BASE_URL/products/123" | jq '.'

echo ""
echo "3. GET /products/999 (404 test)"
curl -s "$BASE_URL/products/999" | jq '.'

echo ""
echo "4. GET /products/123?error=server (500 test)"
curl -s "$BASE_URL/products/123?error=server" | jq '.'

echo ""
echo "5. POST /products"
curl -s -X POST "$BASE_URL/products" \
  -H "Content-Type: application/json" \
  -d '{"name":"Demo Product","price":50000,"category":"Electronics","description":"Test product"}' | jq '.'

echo ""
echo "6. GET /categories"
curl -s "$BASE_URL/categories" | jq '.'

echo ""
echo "7. Payment sequencing (call 3 times)"
echo "Call 1:"
curl -s "$BASE_URL/payment/status" | jq '.'
echo "Call 2:" 
curl -s "$BASE_URL/payment/status" | jq '.'
echo "Call 3:"
curl -s "$BASE_URL/payment/status" | jq '.'

echo ""
echo "✅ Testing completed!"