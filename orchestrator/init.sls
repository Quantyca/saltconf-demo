#!py

def run():

    config = {}


    config['stop-stock-service'] = {
        'salt.state': [
            {'sls': 'orchestrator.archive.stop-stock-engine'},
            {'tgt': 'roles:client'},
            {'tgt_type': 'pillar'}
        ]
    }

    config['start-aligner'] = {
        'salt.state': [
            {'sls': 'orchestrator.archive.alignment'},
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
            {'sls': 'orchestrator.archive.start-stock-engine'},
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
            {'sls': 'orchestrator.archive.rollback'},
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