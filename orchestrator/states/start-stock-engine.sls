#!py

def run():

  config = {}

  config['start-stock-engine'] = {
    'service.running' : [
      {'name': 'stock-engine'},
    ]
  }

  return config