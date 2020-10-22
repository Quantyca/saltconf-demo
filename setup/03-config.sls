#!py

def run():

  config = {}

  config['start-stock-engine'] = {
    'service.running' : [
      {'name': 'stock-engine'},
      {
        'require': [
          {'file': 'copy-service-file'}
        ]
      }
    ]
  }

  return config
