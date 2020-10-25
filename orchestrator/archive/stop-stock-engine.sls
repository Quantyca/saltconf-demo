#!py

def run():

  config = {}

  config['stop-stock-engine'] = {
    'service.dead' : [
      {'name': 'stock-engine'},
    ]
  }

  return config