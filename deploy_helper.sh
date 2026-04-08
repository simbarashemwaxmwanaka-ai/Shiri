#!/bin/bash
# PythonAnywhere Deployment Helper Script
# Run this script in PythonAnywhere bash console after cloning your repository
#
# Usage: bash deploy_helper.sh yourusername
#
# This script automates many deployment steps

set -e  # Exit on error

USERNAME=$1

if [ -z "$USERNAME" ]; then
    echo "Usage: bash deploy_helper.sh yourusername"
    echo "Example: bash deploy_helper.sh john_doe"
    exit 1
fi

echo "====================================="
echo "Shiri Water Project - PythonAnywhere Deployment Helper"
echo "====================================="
echo ""

# Step 1: Create virtual environment
echo "[1/6] Creating virtual environment..."
mkvirtualenv --python=/usr/bin/python3.11 shiri_venv
echo "✓ Virtual environment created"
echo ""

# Step 2: Check if we're in the right directory
if [ ! -f "manage.py" ]; then
    echo "Error: manage.py not found. Please run this script from the project root directory."
    exit 1
fi

echo "[2/6] Installing dependencies..."
workon shiri_venv
pip install -r requirements.txt
echo "✓ Dependencies installed"
echo ""

# Step 3: Update settings
echo "[3/6] Updating settings.py with your domain..."
DOMAIN="${USERNAME}.pythonanywhere.com"
echo "Domain: ${DOMAIN}"

# Note: We can't easily sed the settings file due to special characters,
# so we just inform the user
echo "⚠ Manual step required:"
echo "  1. Edit shiri/settings.py"
echo "  2. Find ALLOWED_HOSTS and update to: '${DOMAIN}'"
echo "  3. Find CSRF_TRUSTED_ORIGINS and update to: 'https://${DOMAIN}'"
echo ""

# Step 4: Run migrations
echo "[4/6] Running migrations..."
python manage.py migrate
echo "✓ Migrations complete"
echo ""

# Step 5: Collect static files
echo "[5/6] Collecting static files..."
python manage.py collectstatic --noinput --clear
echo "✓ Static files collected"
echo ""

# Step 6: Create superuser (optional)
echo "[6/6] Creating superuser..."
echo "You will now be asked to create a superuser account for admin access."
echo "Press Enter to create superuser, or Ctrl+C to skip"
read -r
python manage.py createsuperuser

echo ""
echo "====================================="
echo "✓ Deployment preparation complete!"
echo "====================================="
echo ""
echo "Next steps:"
echo "1. Update ALLOWED_HOSTS in shiri/settings.py with: '${DOMAIN}'"
echo "2. Update CSRF_TRUSTED_ORIGINS in shiri/settings.py"
echo "3. Go to PythonAnywhere Web tab and:"
echo "   - Add new web app (Manual configuration, Python 3.11)"
echo "   - Link virtual environment: /home/${USERNAME}/.virtualenvs/shiri_venv"
echo "   - Update WSGI file with Django configuration"
echo "   - Add static files mapping:"
echo "     URL: /static/ → Dir: /home/${USERNAME}/shiri_project/staticfiles"
echo "4. Click 'Reload' button"
echo "5. Visit https://${DOMAIN} to see your app!"
echo ""
echo "For detailed instructions, see PYTHONANYWHERE_DEPLOYMENT.md"
echo ""
