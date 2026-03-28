module 0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::actions_staging {
    struct ActionsIntent has copy, drop {
        dummy_field: bool,
    }

    fun assert_not_config_change(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: 0x1::string::String) {
        assert!(!0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::has_managed_data<0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::ProposedConfigKey>(arg0, 0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::new_proposed_config_key(arg1)), 0);
    }

    public fun cancel_expired_actions(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::drain_and_destroy_expired(0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::cancel_expired_intent(arg0, arg1, arg2, arg3));
    }

    public fun cancel_pending_actions(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        let v0 = 0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::cancel_pending_intent(arg0, arg1, arg2);
        if (0x1::option::is_some<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::Expired>(&v0)) {
            0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::drain_and_destroy_expired(0x1::option::extract<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::Expired>(&mut v0));
        };
        0x1::option::destroy_none<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::Expired>(v0);
    }

    public fun cancel_rejected_actions(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::drain_and_destroy_expired(0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::cancel_rejected_intent(arg0, arg1, arg2));
    }

    public fun cancel_stale_actions(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::drain_and_destroy_expired(0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::cancel_stale_intent(arg0, arg1, arg2));
    }

    public fun request_actions(arg0: 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Auth, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::Params, arg4: vector<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>, arg5: &mut 0x2::tx_context::TxContext) {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::verify(arg1, arg0);
        0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg5));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::assert_single_execution(&arg3);
        let v0 = ActionsIntent{dummy_field: false};
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::create_intent<0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::Approvals, ActionsIntent>(arg1, arg2, arg3, 0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::new_outcome(arg1), 0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::version::current(), v0, arg5);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(&arg4)) {
            assert!(!0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::is_action_type<0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::config::ConfigChange>(0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(&arg4, v2)), 1);
            0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::add_existing_action_spec<0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::Approvals, ActionsIntent>(&mut v1, *0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(&arg4, v2), v0);
            v2 = v2 + 1;
        };
        0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::stage_intent<ActionsIntent>(arg1, arg2, v1, 0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::version::current(), v0, arg5);
        0xaf64760cb9cf5cdb9071dc56079efd8132f4b966b06770e774a93ac793a64643::multisig::emit_intent_created(arg1, 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::params_key(&arg3), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::params_description(&arg3), 0x2::tx_context::sender(arg5));
    }

    public fun witness() : ActionsIntent {
        ActionsIntent{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

