module 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::config {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct ConfigChangeIntent has copy, drop {
        dummy_field: bool,
    }

    struct ConfigChange has drop {
        dummy_field: bool,
    }

    public fun cancel_expired_config_change(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_expired_intent_for_cleanup(arg0, arg2, arg3, arg4);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(v0);
    }

    public fun cancel_pending_config_change(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_pending_intent_for_cleanup(arg0, arg2, arg3);
        if (0x1::option::is_some<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired>(&v0)) {
            let v1 = 0x1::option::extract<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired>(&mut v0);
            let v2 = &mut v1;
            delete_config_change(arg0, arg1, v2);
            0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(v1);
        };
        0x1::option::destroy_none<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired>(v0);
    }

    public fun cancel_rejected_config_change(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_rejected_intent_for_cleanup(arg0, arg2, arg3);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(v0);
    }

    public fun cancel_stale_config_change(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_stale_intent_for_cleanup(arg0, arg2, arg3);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(v0);
    }

    public fun cleanup_expired_config_changes(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: vector<0x1::string::String>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg3 <= 128, 2);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2) && v0 < arg3) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            let v3 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::intents(arg0);
            let v4 = if (!0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::contains(v3, v2)) {
                false
            } else {
                let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::get<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(v3, v2);
                if (0x2::clock::timestamp_ms(arg4) < 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::expiration_time<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(v5)) {
                    false
                } else {
                    let v6 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(v5);
                    0x1::vector::length<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(v6) > 0 && 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::is_action_type<ConfigChange>(0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(v6, 0))
                }
            };
            if (v4) {
                let v7 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::cancel_expired_intent_for_cleanup(arg0, v2, arg4, arg5);
                let v8 = &mut v7;
                delete_config_change(arg0, arg1, v8);
                0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::drain_and_destroy_expired(v7);
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun delete_config_change(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg1: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg2: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Expired) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_expired_is_account(arg2, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg0));
        let (v0, _) = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::remove_action_spec(arg2);
        let v2 = v0;
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<ConfigChange>(&v2);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(&v2) == 1, 0);
        let v3 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(&v2));
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v3));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v3);
        assert!(v4 == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::expired_key(arg2), 1);
        let v5 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::new_proposed_config_key(v4);
        if (0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::has_managed_data<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::ProposedConfigKey>(arg0, v5)) {
            0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::remove_managed_data_with_package_witness<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::ProposedConfigKey, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::MultisigConfig>(arg0, arg1, v5, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::version::current());
        };
    }

    public fun execute_config_change(arg0: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::Executable<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_is_account<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(arg0), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_specs<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(arg0)), 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::action_idx<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(arg0));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::action_validation::assert_action_type<ConfigChange>(v0);
        assert!(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_version(v0) == 1, 0);
        let v1 = 0x2::bcs::new(*0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(v2 == 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::key<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::intent<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals>(arg0)), 1);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        let v4 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::remove_managed_data<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::ProposedConfigKey, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::MultisigConfig, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals, ExecutionProgressWitness>(arg1, arg2, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::new_proposed_config_key(v2), arg0, v3);
        let v5 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config_mut_authorized<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::MultisigConfig>(arg1, arg2, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::version::current());
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::set_config_nonce(&mut v4, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::config_nonce(v5) + 1);
        *v5 = v4;
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::emit_config_changed(arg1);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::executable::increment_action_idx<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals, ConfigChange, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun max_cleanup_per_call() : u64 {
        128
    }

    public fun request_config_change(arg0: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Auth, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Params, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        request_config_change_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun request_config_change_impl(arg0: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Auth, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Params, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::verify(arg1, arg0);
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg10));
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::assert_single_execution(&arg3);
        let v0 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::params_key(&arg3);
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::add_managed_data_with_package_witness<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::ProposedConfigKey, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::MultisigConfig>(arg1, arg2, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::new_proposed_config_key(v0), 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::new_config_with_policy(arg4, arg5, arg6, arg7, arg8, arg9), 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::version::current());
        let v1 = ConfigChangeIntent{dummy_field: false};
        let v2 = 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::create_intent<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals, ConfigChangeIntent>(arg1, arg2, arg3, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::new_outcome(arg1), 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::version::current(), v1, arg10);
        let v3 = ConfigChange{dummy_field: false};
        0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::add_action_spec<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::Approvals, ConfigChange, ConfigChangeIntent>(&mut v2, v3, 0x2::bcs::to_bytes<0x1::string::String>(&v0), v1);
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::stage_intent<ConfigChangeIntent>(arg1, arg2, v2, 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::version::current(), v1, arg10);
        0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::emit_intent_created(arg1, v0, 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::params_description(&arg3), 0x2::tx_context::sender(arg10));
    }

    public fun request_config_change_with_timelock(arg0: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Auth, arg1: &mut 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::Account, arg2: &0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::package_registry::PackageRegistry, arg3: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::Params, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::intent_expiry_ms(0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::account::config<0xa0204bc5da36783c8808928356d0b935dd99f17057f741d684931f6992477d85::multisig::MultisigConfig>(arg1));
        request_config_change_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, arg9);
    }

    // decompiled from Move bytecode v6
}

