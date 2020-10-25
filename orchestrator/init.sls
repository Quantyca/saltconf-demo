#!py

def run():

    config = {}


    config['stop-stock-service'] = {
        'salt.state': [
            {
                'service.dead': [
                    {'name': 'stock-engine'},
                    {'init_delay': 10}
                ]
            },
            {'tgt': 'roles:client'},
            {'tgt_type': 'pillar'}
        ]
    }

    config['start-aligner'] = {
        'salt.state': [
            {
                'cmd.run': [
                    {'name': 'aligner.sh'},
                    {'cwd': '/home/rinascente-client'},
                    {'runas': 'rinascente-client'}
                ]
            },
            {'tgt': 'align:true'},
            {'tgt_type': 'pillar'},
            {
                'require': [
                    {'salt': 'stop-stock-service'}
                ]
            }
        ]
    }


    config['start-stock-service'] = {
        'salt.state': [
            {
                'service.running': [
                    {'name': 'stock-engine'},
                    {'init_delay': 10}
                ]
            },
            {'tgt': 'roles:client'},
            {'tgt_type': 'pillar'},
            {
                'require': [
                    {'salt': 'start-aligner'}
                ]
            }
        ]
    }


    config['start-stock-service'] = {
        'salt.state': [
            {
                'cmd.run': [
                    {'name': 'rollback.sh'},
                    {'cwd': '/home/rinascente-client'},
                    {'runas': 'rinascente-client'}
                ]
            },
            {'tgt': 'roles:client'},
            {'tgt_type': 'pillar'},
            {
                'onfail': [
                    {'salt': 'start-aligner'}
                ]
            }
        ]
    }

    return config