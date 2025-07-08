#!/bin/bash

echo "🔐 Testing Auth API Demo"
echo "========================"

BASE_URL="http://localhost:3002/api/v1"

# Function to test auth endpoints
test_auth_endpoint() {
    local name="$1"
    local url="$2"
    local method="${3:-GET}"
    local data="$4"
    local headers="$5"
    
    echo ""
    echo "$name"
    echo "$(printf '=%.0s' {1..50})"
    
    curl_cmd="curl -s -w \"%{http_code}\" -X $method \"$url\""
    
    if [ -n "$headers" ]; then
        curl_cmd="$curl_cmd -H \"$headers\""
    fi
    
    if [ -n "$data" ]; then
        curl_cmd="$curl_cmd -H \"Content-Type: application/json\" -d '$data'"
    fi
    
    response=$(eval $curl_cmd)
    http_code="${response: -3}"
    body="${response%???}"
    
    echo "Status: $http_code"
    
    if command -v jq >/dev/null 2>&1; then
        echo "$body" | jq '.' 2>/dev/null || echo "Response: $body"
    else
        echo "Response: $body"
    fi
    
    if [[ "$http_code" =~ ^[23] ]]; then
        echo "✅ Success"
    else
        echo "⚠️  Expected response"
    fi
}

# Test registration
test_auth_endpoint "1. Register User" \
    "$BASE_URL/auth/register" \
    "POST" \
    '{"name":"John Doe","email":"john@test.com","password":"password123"}'

# Test registration with existing email
test_auth_endpoint "2. Register Existing Email (409)" \
    "$BASE_URL/auth/register" \
    "POST" \
    '{"name":"Admin","email":"admin@test.com","password":"password123"}'

# Test login success
test_auth_endpoint "3. Login Success" \
    "$BASE_URL/auth/login" \
    "POST" \
    '{"email":"user@test.com","password":"password123"}'

# Test login with wrong credentials
test_auth_endpoint "4. Login Wrong Credentials (401)" \
    "$BASE_URL/auth/login" \
    "POST" \
    '{"email":"wrong@test.com","password":"wrongpass"}'

# Test locked account
test_auth_endpoint "5. Login Locked Account (423)" \
    "$BASE_URL/auth/login" \
    "POST" \
    '{"email":"locked@test.com","password":"password123"}'

# Test profile without token
test_auth_endpoint "6. Get Profile Unauthorized (401)" \
    "$BASE_URL/auth/profile"

# Test profile with valid token
test_auth_endpoint "7. Get Profile with Token" \
    "$BASE_URL/auth/profile" \
    "GET" \
    "" \
    "Authorization: Bearer valid-token-123"

# Test profile with invalid token
test_auth_endpoint "8. Get Profile Invalid Token (401)" \
    "$BASE_URL/auth/profile" \
    "GET" \
    "" \
    "Authorization: Bearer invalid-token"

# Test refresh token
test_auth_endpoint "9. Refresh Token" \
    "$BASE_URL/auth/refresh" \
    "POST" \
    '{"refreshToken":"valid-refresh-token"}'

# Test refresh with invalid token
test_auth_endpoint "10. Refresh Invalid Token (401)" \
    "$BASE_URL/auth/refresh" \
    "POST" \
    '{"refreshToken":"invalid-token"}'

# Test forgot password
test_auth_endpoint "11. Forgot Password" \
    "$BASE_URL/auth/forgot-password" \
    "POST" \
    '{"email":"user@test.com"}'

# Test forgot password with non-existent email
test_auth_endpoint "12. Forgot Password Not Found (404)" \
    "$BASE_URL/auth/forgot-password" \
    "POST" \
    '{"email":"notfound@test.com"}'

# Test reset password
test_auth_endpoint "13. Reset Password" \
    "$BASE_URL/auth/reset-password" \
    "POST" \
    '{"token":"valid-reset-token","password":"newpassword123"}'

# Test reset with invalid token
test_auth_endpoint "14. Reset Invalid Token (400)" \
    "$BASE_URL/auth/reset-password" \
    "POST" \
    '{"token":"invalid-token","password":"newpassword123"}'

# Test email verification
test_auth_endpoint "15. Verify Email" \
    "$BASE_URL/auth/verify-email" \
    "POST" \
    '{"token":"valid-verify-token"}'

# Test change password
test_auth_endpoint "16. Change Password" \
    "$BASE_URL/auth/change-password" \
    "POST" \
    '{"currentPassword":"oldpass","newPassword":"newpass123"}' \
    "Authorization: Bearer valid-token-123"

# Test logout
test_auth_endpoint "17. Logout" \
    "$BASE_URL/auth/logout" \
    "POST" \
    "" \
    "Authorization: Bearer valid-token-123"

echo ""
echo "🎉 Auth API testing completed!"
echo ""
echo "📋 Summary:"
echo "- Registration with validation"
echo "- Login with multiple scenarios" 
echo "- Token management (access & refresh)"
echo "- Profile management"
echo "- Password reset flow"
echo "- Email verification"
echo "- Comprehensive error handling"
echo ""
echo "🔧 Test different scenarios:"
echo "- Use different email addresses"
echo "- Test with/without Authorization headers"
echo "- Try invalid tokens and credentials"