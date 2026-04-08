# Deployment Checklist - Shiri Water Project

## Pre-Deployment (Already Done ✓)

- [x] Created `requirements.txt` with all dependencies
- [x] Updated `settings.py` with production configurations
- [x] Added STATIC_ROOT for static files collection
- [x] Configured environment variable support for SECRET_KEY and DEBUG
- [x] Updated ALLOWED_HOSTS for PythonAnywhere domain
- [x] Added CSRF_TRUSTED_ORIGINS security setting
- [x] Enabled security headers
- [x] Created `.gitignore` for version control
- [x] Created comprehensive deployment guide

## Local Preparation (Do This First)

- [ ] Commit all changes: `git add . && git commit -m "Prepare for deployment"`
- [ ] Push to GitHub: `git push origin main`
- [ ] Verify `requirements.txt`: `pip freeze > requirements.txt`

## PythonAnywhere Setup (Do These Steps)

### 1. Account & Initial Setup
- [ ] Create PythonAnywhere account at pythonanywhere.com
- [ ] Note your username (yourusername.pythonanywhere.com)
- [ ] Open PythonAnywhere bash console

### 2. Environment & Repository
- [ ] Create virtual environment: `mkvirtualenv --python=/usr/bin/python3.11 shiri_venv`
- [ ] Clone repository: `git clone https://github.com/yourusername/repo.git shiri_project`
- [ ] Install dependencies: `pip install -r requirements.txt`

### 3. Settings Update
- [ ] Update ALLOWED_HOSTS in settings.py with your domain
- [ ] Update CSRF_TRUSTED_ORIGINS with your domain

### 4. Database Setup
- [ ] Run migrations: `python manage.py migrate`
- [ ] Create superuser: `python manage.py createsuperuser`
- [ ] Collect static files: `python manage.py collectstatic --noinput`

### 5. Web App Configuration
- [ ] Go to "Web" tab in PythonAnywhere
- [ ] Add new web app → Manual configuration → Python 3.11
- [ ] Configure WSGI file (replace content with Django setup)
- [ ] Link virtual environment: `/home/yourusername/.virtualenvs/shiri_venv`
- [ ] Add static files mapping:
  - URL: `/static/` → Directory: `/home/yourusername/shiri_project/staticfiles`
- [ ] Add media files mapping (optional):
  - URL: `/media/` → Directory: `/home/yourusername/shiri_project/media`
- [ ] Click "Reload" button

### 6. Verification
- [ ] Visit https://yourusername.pythonanywhere.com
- [ ] Check if login page loads
- [ ] Test member list functionality
- [ ] Access admin panel: https://yourusername.pythonanywhere.com/admin
- [ ] Check error logs in dashboard if issues arise

### 7. Security (After Deployment)
- [ ] Force HTTPS in "Web" tab → "Security"
- [ ] Generate new SECRET_KEY and set as environment variable
- [ ] Verify DEBUG = False
- [ ] Test login functionality thoroughly

## Testing & Maintenance

### First Week
- [ ] Test all CRUD operations (Create, Read, Update, Delete members)
- [ ] Test member search functionality
- [ ] Test export features (CSV, Excel, Word, PDF)
- [ ] Test import from Excel
- [ ] Monitor error logs daily

### Ongoing
- [ ] Back up database regularly
- [ ] Monitor server logs for errors
- [ ] Keep dependencies updated
- [ ] Test new features before deploying to production

## Files Prepared for Deployment

1. **requirements.txt** - Python dependencies
2. **settings.py** - Updated for production
3. **.gitignore** - Version control exclusions
4. **PYTHONANYWHERE_DEPLOYMENT.md** - Detailed guide (this checklist references it)

## Important Notes

- Replace `yourusername` with your actual PythonAnywhere username
- Replace `your-repo-name` with your actual GitHub repository name
- The free tier on PythonAnywhere has limitations - consider upgrading if needed
- Database backups should be done manually on the free tier
- Always test changes locally before pushing to production

## Quick Links

- PythonAnywhere Dashboard: https://www.pythonanywhere.com/
- Your App URL: https://yourusername.pythonanywhere.com
- Django Admin: https://yourusername.pythonanywhere.com/admin
- Detailed Guide: See PYTHONANYWHERE_DEPLOYMENT.md

---

**Status:** Ready for deployment ✅
**Last Updated:** April 8, 2026
