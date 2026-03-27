module 0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::actions_staging {
    struct ActionsIntent has copy, drop {
        dummy_field: bool,
    }

    fun assert_not_config_change(arg0: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: 0x1::string::String) {
        assert!(!0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::has_managed_data<0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::ProposedConfigKey>(arg0, 0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::new_proposed_config_key(arg1)), 0);
    }

    public fun cancel_expired_actions(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::drain_and_destroy_expired(0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::cancel_expired_intent(arg0, arg1, arg2, arg3));
    }

    public fun cancel_pending_actions(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        let v0 = 0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::cancel_pending_intent(arg0, arg1, arg2);
        if (0x1::option::is_some<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::Expired>(&v0)) {
            0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::drain_and_destroy_expired(0x1::option::extract<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::Expired>(&mut v0));
        };
        0x1::option::destroy_none<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::Expired>(v0);
    }

    public fun cancel_rejected_actions(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::drain_and_destroy_expired(0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::cancel_rejected_intent(arg0, arg1, arg2));
    }

    public fun cancel_stale_actions(arg0: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::drain_and_destroy_expired(0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::cancel_stale_intent(arg0, arg1, arg2));
    }

    public fun request_actions(arg0: 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Auth, arg1: &mut 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::Account, arg2: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::package_registry::PackageRegistry, arg3: 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::Params, arg4: vector<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>, arg5: &mut 0x2::tx_context::TxContext) {
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::verify(arg1, arg0);
        0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg5));
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::assert_single_execution(&arg3);
        let v0 = ActionsIntent{dummy_field: false};
        let v1 = 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::account::create_intent<0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::Approvals, ActionsIntent>(arg1, arg2, arg3, 0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::new_outcome(arg1), 0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::version::current(), v0, arg5);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&arg4)) {
            assert!(!0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_validation::is_action_type<0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::config::ConfigChange>(0x1::vector::borrow<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&arg4, v2)), 1);
            0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::add_existing_action_spec<0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::Approvals, ActionsIntent>(&mut v1, *0x1::vector::borrow<0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec>(&arg4, v2), v0);
            v2 = v2 + 1;
        };
        0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::stage_intent<ActionsIntent>(arg1, arg2, v1, 0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::version::current(), v0, arg5);
        0xe7a98d678bd2d57b0049980aa2dc4f0600a7b290f1a7666965f914d135e84705::multisig::emit_intent_created(arg1, 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::params_key(&arg3), 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::params_description(&arg3), 0x2::tx_context::sender(arg5));
    }

    public fun witness() : ActionsIntent {
        ActionsIntent{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

