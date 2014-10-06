#!/root/sentora-docker/ENV/bin/python
import subprocess
import sys
import os

COMMAND = sys.argv[1]
CONTAINER = sys.argv[2]

BACKUP_FOLDERS = [
  '/etc/zpanel/configs',
  '/etc/zpanel/panel/etc/tmp',
  '/etc/zpanel/panel/modules/webalizer_stats',
  '/var/cache/man',
  '/var/lib/mysql',
  '/var/lib/dovecot',
  '/var/lib/php5',
  '/var/lib/postfix',
  '/var/log',
  '/var/named',
  '/var/spool',
  '/var/zpanel',
  '/var/backups',
  '/etc/zpanel/panel',

  # Maybe not this
#'/run',
]

def run_cmd(cmd):
  print "Running cmd: '%s'" % (cmd,)
  p = subprocess.Popen(cmd.split(' '), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  stdout, stderr = p.communicate()
  if p.returncode != 0:
    print 'error running diff'
    sys.exit(1)
  if len(stderr) > 0:
    print 'Error running command - ', stderr 
  return stdout

def check_folders(container_id):
  stdout = run_cmd('docker diff %s' % (CONTAINER,))
  # for each line, lets check if it is covered in our backups list
  for line in stdout.split('\n'):
    dir = line[2:]
    parent_found = False
    for folder in BACKUP_FOLDERS:
      if dir.startswith(folder):
        parent_found = True
        break
    
    if not parent_found:
      print "MISSING",line

# test to see what folders will not be covered in the backup
if COMMAND == '-t':
  print 'Running test...'
  check_folders(CONTAINER)
  print 'DONE'

# run the backup
elif COMMAND == '-b':
  # directory on host to send files to
  BACKUP_DIR = sys.argv[3]
  print 'Backing up in %s' % (BACKUP_DIR,)
  if not os.path.exists(BACKUP_DIR):
    print 'backup dir %s does not exist' % (BACKUP_DIR,)
    sys.exit(2)
  for folder in BACKUP_FOLDERS:
#    host_folder = folder
    host_folder = folder[:folder.rfind('/')]
    if len(host_folder) == 0:
      host_folder = '/'
    if host_folder[0] == '/':
      host_folder = host_folder[1:]
    host_dir = os.path.join(BACKUP_DIR, host_folder)
    print '> backing up %s to %s' % (folder, host_dir)
    run_cmd('docker cp %s:%s %s' % (CONTAINER, folder, host_dir))
  print 'DONE'

# Generate volumes to mount
elif COMMAND == '-g':
  # directory on host to get files from
  BACKUP_DIR = sys.argv[2]
  if not os.path.exists(BACKUP_DIR):
    print 'backup dir %s does not exist' % (BACKUP_DIR,)
    sys.exit(2)
  output = ''
  for folder in BACKUP_FOLDERS:
    host_folder = folder
    if host_folder[0] == '/':
      host_folder = host_folder[1:]
    host_dir = os.path.join(BACKUP_DIR, host_folder)
    container_dir = folder#folder[:folder.rfind('/')]
#    if len(container_dir) == 0:
#      container_dir = '/'
    output += '-v %s:%s ' % (host_dir, container_dir)
  print output

else:
  print "UNKNOWN OPTION '%s'" % (COMMAND,)
  print sys.argv

