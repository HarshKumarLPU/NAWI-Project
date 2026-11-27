#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -o errexit

echo "============================================================"
echo "  NAWI Test Report Management System — Render Build Process"
echo "============================================================"

# 1. Upgrade pip and install production dependencies
echo "==> Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# 2. Collect static files
echo "==> Collecting static assets via WhiteNoise..."
python manage.py collectstatic --no-input --settings=config.settings.production

# 3. Apply database migrations
echo "==> Applying database migrations..."
python manage.py migrate --no-input --settings=config.settings.production

# 4. Seed demo organization, all 4 role accounts, instruments, and test sessions
echo "==> Seeding demo data and role accounts..."
DJANGO_SETTINGS_MODULE=config.settings.production python scripts/seed_demo_data.py

echo "============================================================"
echo "  Build completed successfully! Ready for launch."
echo "============================================================"

