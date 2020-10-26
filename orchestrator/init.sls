#!py

def run():

    config = {}


    config['stop-stock-service'] = {
        'salt.state': [
            {'sls': 'orchestrator.states.stop-stock-engine'},
            {'tgt': 'roles:client'},
            {'tgt_type': 'pillar'}
        ]
    }

    config['start-aligner'] = {
        'salt.state': [
            {'sls': 'orchestrator.states.alignment'},
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
            {'sls': 'orchestrator.states.start-stock-engine'},
            {'tgt': 'roles:client'},
            {'tgt_type': 'pillar'},
            {
                'require': [
                    {'salt': 'start-aligner'}
                ]
            }
        ]
    }


    """
    config['rollback'] = {
        'salt.state': [
            {'sls': 'orchestrator.states.rollback'},
            {'tgt': 'roles:client'},
            {'tgt_type': 'pillar'},
            {
                'onfail': [
                    {'salt': 'start-aligner'}
                ]
            }
        ]
    }
    """

    return config