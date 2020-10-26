#!py

def run():

  config = {}

  config['execute-rollback'] = {
    'cmd.run' : [
        {'name': './rollback.sh'},
        {'cwd': '/home/rinascente-client'},
        {'runas': 'rinascente-client'}
    ]
  }

  return config