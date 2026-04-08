# PythonAnywhere Deployment Guide for Shiri Water Project

## Overview
This guide provides step-by-step instructions to deploy the Shiri Water Project Django application on PythonAnywhere.

---

## Pre-Deployment Checklist

- [x] Created `requirements.txt` with all dependencies
- [x] Updated `settings.py` for production environment
- [x] Updated security settings and ALLOWED_HOSTS
- [x] Created `.gitignore` for version control

---

## Step 1: Prepare Your Local Repository

1. **Commit all changes to git:**
   ```bash
   cd e:\Web Dev\Shiri
   git add .
   git commit -m "Prepare for PythonAnywhere deployment"
   git push origin main  # or your main branch
   ```

2. **Verify requirements.txt is complete:**
   ```bash
   pip freeze > requirements.txt
   ```
   (Already done, but this ensures you have all packages)

---

## Step 2: Create a PythonAnywhere Account

1. Visit [www.pythonanywhere.com](https://www.pythonanywhere.com)
2. Sign up for a free or paid account
3. Log in to your dashboard
4. Note your username (used for your domain: username.pythonanywhere.com)

---

## Step 3: Set Up Virtual Environment on PythonAnywhere

1. **Open Bash console** from the PythonAnywhere dashboard:
   - Click "Consoles" → "Bash"

2. **Create a virtual environment:**
   ```bash
   mkvirtualenv --python=/usr/bin/python3.11 shiri_venv
   ```
   (Use Python 3.11 or the latest available version)

3. **Clone your repository:**
   ```bash
   cd /home/yourusername
   git clone https://github.com/yourusername/your-repo-name.git shiri_project
   cd shiri_project
   ```
   Replace `yourusername` and `your-repo-name` with your actual GitHub details.

4. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

---

## Step 4: Update Settings for Your Domain

1. **Edit settings.py in bash:**
   ```bash
   nano /home/yourusername/shiri_project/shiri/settings.py
   ```

2. **Update ALLOWED_HOSTS with your domain:**
   Find this line:
   ```python
   ALLOWED_HOSTS = [
       'localhost',
       '127.0.0.1',
       'yourusername.pythonanywhere.com',
   ]
   ```
   Replace `yourusername` with your actual PythonAnywhere username.

3. **Update CSRF_TRUSTED_ORIGINS:**
   ```python
   CSRF_TRUSTED_ORIGINS = [
       'https://yourusername.pythonanywhere.com',
   ]
   ```

4. **Save and exit:** Press Ctrl+X, then Y, then Enter

---

## Step 5: Initialize the Database

1. **In the bash console, run migrations:**
   ```bash
   cd /home/yourusername/shiri_project
   python manage.py migrate
   ```

2. **Create a superuser (admin account):**
   ```bash
   python manage.py createsuperuser
   ```
   Follow the prompts to enter:
   - Username
   - Email
   - Password (twice)

3. **Collect static files:**
   ```bash
   python manage.py collectstatic --noinput
   ```

---

## Step 6: Create and Configure the Web App

1. **Go to "Web" tab** in PythonAnywhere dashboard
2. **Click "Add a new web app"**
3. **Choose "Manual configuration"** → **Select Python 3.11**
4. **Configure WSGI file:**
   - Click on the WSGI configuration file link (typically `/var/www/yourusername_pythonanywhere_com_wsgi.py`)
   - Replace the content with:

```python
import os
import sys

path = '/home/yourusername/shiri_project'
if path not in sys.path:
    sys.path.append(path)

os.environ['DJANGO_SETTINGS_MODULE'] = 'shiri.settings'
os.environ['DEBUG'] = 'False'

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
```

Replace `yourusername` with your actual PythonAnywhere username.

---

## Step 7: Configure Static Files and Media

1. **Back in the "Web" tab**, scroll down to "Static files"
2. **Add static files mapping:**
   - URL: `/static/`
   - Directory: `/home/yourusername/shiri_project/staticfiles`
3. **Add media files mapping (optional, for user uploads):**
   - URL: `/media/`
   - Directory: `/home/yourusername/shiri_project/media`

---

## Step 8: Configure Virtual Environment

1. **In the "Web" tab**, find "Virtualenv"
2. **Click the path and enter:**
   ```
   /home/yourusername/.virtualenvs/shiri_venv
   ```

---

## Step 9: Reload the Web App

1. **In the "Web" tab**, click the green "Reload" button at the top
2. **Wait 30 seconds for the reload to complete**
3. **Visit your app:**
   - Go to `https://yourusername.pythonanywhere.com`
   - You should see your Shiri application!

---

## Step 10: Verify Everything Works

1. **Test the login page:** Go to `/login` and verify it loads
2. **Test the member list:** Check if it asks for login
3. **Create a test user:**
   - Go to `https://yourusername.pythonanywhere.com/admin`
   - Log in with your superuser credentials
   - Create a new user under "Users"

---

## Step 11: Enable HTTPS (Recommended)

1. **In the "Web" tab**, scroll to "Security"
2. **Force HTTPS to ON** - PythonAnywhere provides free SSL certificates

---

## Troubleshooting

### Issue: "No module named 'django'"
**Solution:** Ensure the virtual environment is linked correctly in the "Web" tab.

### Issue: "Module not found" errors
**Solution:** Run in bash console:
```bash
workon shiri_venv
pip install -r /home/yourusername/shiri_project/requirements.txt
```

### Issue: Static files not loading
**Solution:**
```bash
workon shiri_venv
cd /home/yourusername/shiri_project
python manage.py collectstatic --noinput --clear
```
Then reload the web app.

### Issue: Database errors
**Solution:** Check that migrations ran successfully:
```bash
python manage.py migrate --verbosity 2
```

### Issue: Login not working
**Solution:**
1. Check browser console for errors (F12)
2. Check the server error log in PythonAnywhere dashboard
3. Verify CSRF_TRUSTED_ORIGINS includes your domain

### View Error Logs
- Click "Web" → "Log files" (error log and server log tabs)
- These contain detailed error messages

---

## After Deployment: Ongoing Maintenance

### Updating Your App

1. **Make changes locally, commit and push to GitHub:**
   ```bash
   git add .
   git commit -m "Your changes"
   git push origin main
   ```

2. **Pull changes on PythonAnywhere (bash console):**
   ```bash
   cd /home/yourusername/shiri_project
   git pull origin main
   ```

3. **Install any new dependencies:**
   ```bash
   workon shiri_venv
   pip install -r requirements.txt
   ```

4. **Run migrations if needed:**
   ```bash
   python manage.py migrate
   ```

5. **Collect static files:**
   ```bash
   python manage.py collectstatic --noinput
   ```

6. **Reload the web app** in the "Web" tab

### Backing Up Your Database

1. **In bash console:**
   ```bash
   cd /home/yourusername/shiri_project
   cp db.sqlite3 db.sqlite3.backup
   ```

2. **Download the backup:**
   - Use PythonAnywhere's file browser or SFTP to download `db.sqlite3`

---

## Security Best Practices

1. **Change your Django SECRET_KEY:**
   ```bash
   python manage.py shell
   from django.core.management.utils import get_random_secret_key
   print(get_random_secret_key())
   ```
   - Copy the output
   - Update your environment variable on PythonAnywhere (Web → Environment variables)

2. **Set environment variables securely:**
   - In Web tab → "Web app settings" → scroll down to "Web app security & debugging"
   - Set `DJANGO_SECRET_KEY`, `DEBUG=False`, etc.

3. **Keep DEBUG = False in production**

4. **Regularly update dependencies:**
   ```bash
   workon shiri_venv
   pip list --outdated
   pip install --upgrade <package-name>
   ```

---

## Useful Commands Reference

```bash
# Activate virtual environment
workon shiri_venv

# Deactivate
deactivate

# Manage Django
python manage.py runserver
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
python manage.py collectstatic

# View logs
tail /var/log/yourusername.pythonanywhere.com.error.log
tail /var/log/yourusername.pythonanywhere.com.access.log
```

---

## Support & Resources

- **PythonAnywhere Help:** https://www.pythonanywhere.com/help/
- **Django Documentation:** https://docs.djangoproject.com/
- **Django Deployment Checklist:** https://docs.djangoproject.com/en/5.2/howto/deployment/checklist/

---

## Summary

Your Shiri Water Project is now ready for production! The deployment is secure, scalable, and follows Django best practices.

**Key accomplishments:**
✅ Environment variables configured
✅ Static files setup
✅ Database migrations ready
✅ Security headers enabled
✅ HTTPS ready
✅ Error logging available

Good luck with your deployment! 🚀
