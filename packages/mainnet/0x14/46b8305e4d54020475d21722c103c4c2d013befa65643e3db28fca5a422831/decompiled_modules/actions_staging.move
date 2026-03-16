module 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::actions_staging {
    struct ActionsIntent has copy, drop {
        dummy_field: bool,
    }

    fun assert_no_config_change_actions(arg0: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired) {
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::expired_action_specs(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(v0)) {
            assert!(!0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_validation::is_action_type<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::config::ConfigChange>(0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(v0, v1)), 0);
            v1 = v1 + 1;
        };
    }

    public fun cancel_expired_actions(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::cancel_expired_intent(arg0, arg1, arg2, arg3);
        assert_no_config_change_actions(&v0);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::destroy_expired(v0);
    }

    public fun cancel_pending_actions(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::cancel_pending_intent(arg0, arg1, arg2);
        if (0x1::option::is_some<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired>(&v0)) {
            let v1 = 0x1::option::extract<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired>(&mut v0);
            assert_no_config_change_actions(&v1);
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::destroy_expired(v1);
        };
        0x1::option::destroy_none<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired>(v0);
    }

    public fun cancel_stale_actions(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::cancel_stale_intent(arg0, arg1, arg2);
        assert_no_config_change_actions(&v0);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::destroy_expired(v0);
    }

    public fun request_actions(arg0: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Auth, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Params, arg4: vector<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>, arg5: &mut 0x2::tx_context::TxContext) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::verify(arg1, arg0);
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg5));
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::assert_single_execution(&arg3);
        let v0 = ActionsIntent{dummy_field: false};
        let v1 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::create_intent<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals, ActionsIntent>(arg1, arg2, arg3, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::new_outcome(arg1), 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::version::current(), v0, arg5);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(&arg4)) {
            assert!(!0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_validation::is_action_type<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::config::ConfigChange>(0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(&arg4, v2)), 1);
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::add_existing_action_spec<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals, ActionsIntent>(&mut v1, *0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(&arg4, v2), v0);
            v2 = v2 + 1;
        };
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::stage_intent<ActionsIntent>(arg1, arg2, v1, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::version::current(), v0, arg5);
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::emit_intent_created(arg1, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::params_key(&arg3), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::params_description(&arg3), 0x2::tx_context::sender(arg5));
    }

    public fun witness() : ActionsIntent {
        ActionsIntent{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

