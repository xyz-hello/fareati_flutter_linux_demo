# daily_commit.ps1

# File to track daily commits
$file = "daily_commit.txt"

# Append today's date to the file
Add-Content -Path $file -Value (Get-Date -Format "yyyy-MM-dd HH:mm:ss")

# Stage the file
git add $file

# Commit with today's date
$today = Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
git commit --date="$today" -m "Daily commit: $today"

# Push to GitHub
git push origin main
