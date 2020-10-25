#!py

def run():

  config = {}

  config['perform-stock-alignment'] = {
    'cmd.run' : [
        {'name': './aligner.sh'},
        {'cwd': '/home/rinascente-client'},
        {'runas': 'rinascente-client'}
    ]
  }

  return config