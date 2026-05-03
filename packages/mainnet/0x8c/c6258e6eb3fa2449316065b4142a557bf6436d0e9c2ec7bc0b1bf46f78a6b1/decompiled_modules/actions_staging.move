module 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::actions_staging {
    struct ActionsIntent has copy, drop {
        dummy_field: bool,
    }

    fun assert_not_config_change(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String) {
        assert!(!0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::intent_has_config_change_action(arg0, arg1), 0);
    }

    public fun cancel_expired_actions(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_expired_intent(arg0, arg1, arg2, arg3));
    }

    public fun cancel_pending_actions(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_pending_intent(arg0, arg1, arg2, arg3));
    }

    public fun cancel_rejected_actions(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_rejected_intent(arg0, arg1, arg2));
    }

    public fun cancel_stale_actions(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_stale_intent(arg0, arg1, arg2));
    }

    public fun request_actions(arg0: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Auth, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Params, arg4: vector<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>, arg5: &mut 0x2::tx_context::TxContext) {
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::verify(arg1, arg0);
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg5));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::assert_single_execution(&arg3);
        let v0 = ActionsIntent{dummy_field: false};
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_intent<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals, ActionsIntent>(arg1, arg2, arg3, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::new_outcome(arg1), 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::version::current(), v0, arg5);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(&arg4)) {
            let v3 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(&arg4, v2);
            assert!(!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::is_action_type<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::config::ConfigChange>(v3), 1);
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::add_existing_action_spec<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals, ActionsIntent>(&mut v1, *v3, v0);
            v2 = v2 + 1;
        };
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::stage_intent<ActionsIntent>(arg1, arg2, v1, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::version::current(), v0, arg5);
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::emit_intent_created(arg1, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::params_key(&arg3), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::params_description(&arg3), 0x2::tx_context::sender(arg5));
    }

    public fun witness() : ActionsIntent {
        ActionsIntent{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

