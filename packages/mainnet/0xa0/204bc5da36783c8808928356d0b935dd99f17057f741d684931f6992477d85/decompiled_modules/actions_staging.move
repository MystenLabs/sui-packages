module 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::actions_staging {
    struct ActionsIntent has copy, drop {
        dummy_field: bool,
    }

    fun assert_not_config_change(arg0: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: 0x1::string::String) {
        assert!(!0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_data<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::ProposedConfigKey>(arg0, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::new_proposed_config_key(arg1)), 0);
    }

    public fun cancel_expired_actions(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_expired_intent(arg0, arg1, arg2, arg3));
    }

    public fun cancel_pending_actions(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        let v0 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_pending_intent(arg0, arg1, arg2);
        if (0x1::option::is_some<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired>(&v0)) {
            0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(0x1::option::extract<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired>(&mut v0));
        };
        0x1::option::destroy_none<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired>(v0);
    }

    public fun cancel_rejected_actions(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_rejected_intent(arg0, arg1, arg2));
    }

    public fun cancel_stale_actions(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_config_change(arg0, arg1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_stale_intent(arg0, arg1, arg2));
    }

    public fun request_actions(arg0: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Auth, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Params, arg4: vector<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>, arg5: &mut 0x2::tx_context::TxContext) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::verify(arg1, arg0);
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg5));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_single_execution(&arg3);
        let v0 = ActionsIntent{dummy_field: false};
        let v1 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::create_intent<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals, ActionsIntent>(arg1, arg2, arg3, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::new_outcome(arg1), 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::version::current(), v0, arg5);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(&arg4)) {
            assert!(!0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::is_action_type<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::config::ConfigChange>(0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(&arg4, v2)), 1);
            0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::add_existing_action_spec<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals, ActionsIntent>(&mut v1, *0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(&arg4, v2), v0);
            v2 = v2 + 1;
        };
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::stage_intent<ActionsIntent>(arg1, arg2, v1, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::version::current(), v0, arg5);
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::emit_intent_created(arg1, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::params_key(&arg3), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::params_description(&arg3), 0x2::tx_context::sender(arg5));
    }

    public fun witness() : ActionsIntent {
        ActionsIntent{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

