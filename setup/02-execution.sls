#!py

def run():

  slspath = __sls__.rsplit(".", 1)[0].replace(".", "/")
  archive_path = 'salt://' + slspath + '/archive/'
  is_aligner = __salt__['pillar.get']('align', 'false')
  config = {}

  config['rinascente-client-user'] = {
    'user.present' : [
      {'name': 'rinascente-client'},
      {'home': '/home/rinascente-client'},
      {
        'require': [
          {'pkg': 'git-client-package'}
        ]
      }
    ]
  }

  config['copy-stock-engine-script'] = {
    'file.managed' : [
      {'name': '/home/rinascente-client/stock-engine.sh'},
      {'source':  archive_path +  'stock-engine.sh'},
      {
        'require': [
          {'user': 'rinascente-client-user'}
        ]
      }
    ]
  }

  config['copy-service-file'] = {
    'file.managed' : [
      {'name': '/etc/systemd/system/stock-engine.service'},
      {'source': archive_path + 'stock-engine.service'},
      {
        'require': [
          {'user': 'rinascente-client-user'}
        ]
      }
    ]
  }

  config['copy-rollback-script'] = {
    'file.managed' : [
      {'name': '/home/rinascente-client/rollback.sh'},
      {'source':  archive_path +  'rollback.sh'},
      {'mode': '0755'},
      {
        'require': [
          {'user': 'rinascente-client-user'}
        ]
      }
    ]
  }

  
  if is_aligner == 'true':
    config['copy-aligner-script'] = {
      'file.managed' : [
        {'name': '/home/rinascente-client/aligner.sh'},
        {'source':  archive_path +  'aligner.sh'},
        {'mode': '0755'},
        {
          'require': [
            {'user': 'rinascente-client-user'}
          ]
        }
      ]
    }

  return config