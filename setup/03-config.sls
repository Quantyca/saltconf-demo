#!py

def run():

  config = {}

  config['start-stock-engine'] = {
    'service.running' : [
      {'name': 'stock-egine'},
      {
        'require': [
          {'file': 'copy-service-file'}
        ]
      }
    ]
  }

  return config
