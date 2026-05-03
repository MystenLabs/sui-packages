module 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::config {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct ConfigChangeIntent has copy, drop {
        dummy_field: bool,
    }

    struct ConfigChange has drop {
        dummy_field: bool,
    }

    public fun cancel_expired_config_change(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_expired_intent_for_cleanup(arg0, arg2, arg3, arg4);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(v0);
    }

    public fun cancel_pending_config_change(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_pending_intent_for_cleanup(arg0, arg2, arg3, arg4);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(v0);
    }

    public fun cancel_rejected_config_change(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_rejected_intent_for_cleanup(arg0, arg2, arg3);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(v0);
    }

    public fun cancel_stale_config_change(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_stale_intent_for_cleanup(arg0, arg2, arg3);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(v0);
    }

    public fun cleanup_expired_config_changes(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: vector<0x1::string::String>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg3 <= 128, 2);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2) && v0 < arg3) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents(arg0);
            let v4 = if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::contains(v3, v2)) {
                false
            } else {
                let v5 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(v3, v2);
                if (0x2::clock::timestamp_ms(arg4) < 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::expiration_time<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(v5)) {
                    false
                } else {
                    let v6 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(v5);
                    if (0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v6) > 0 && 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::is_action_type<ConfigChange>(0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v6, 0))) {
                        assert!(0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v6) == 1, 3);
                        true
                    } else {
                        false
                    }
                }
            };
            if (v4) {
                let v7 = 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::cancel_expired_intent_for_cleanup(arg0, v2, arg4, arg5);
                let v8 = &mut v7;
                delete_config_change(arg0, arg1, v8);
                0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::drain_and_destroy_expired(v7);
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun delete_config_change(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired) {
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::assert_expired_is_account(arg2, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg0));
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::expired_action_count(arg2) == 1, 3);
        let (v0, _) = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::remove_action_spec(arg2);
        let v2 = v0;
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<ConfigChange>(&v2);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(&v2) == 1, 0);
        let v3 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(&v2));
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v3));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v3);
        assert!(v4 == 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::expired_key(arg2), 1);
        let v5 = 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::new_proposed_config_key(v4);
        if (0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::ProposedConfigKey>(arg0, v5)) {
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::remove_managed_data_with_package_witness<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::ProposedConfigKey, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::MultisigConfig>(arg0, arg1, v5, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::version::current());
        };
    }

    public fun execute_config_change(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) {
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::assert_is_account<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(arg0), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg1));
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(arg0));
        assert!(0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v0) == 1, 3);
        let v1 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<ConfigChange>(v1);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v1) == 1, 0);
        let v2 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v1));
        let v3 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v2);
        assert!(v3 == 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::key<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals>(arg0)), 1);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        let v5 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::remove_managed_data<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::ProposedConfigKey, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::MultisigConfig, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals, ExecutionProgressWitness>(arg1, arg2, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::new_proposed_config_key(v3), arg0, v4);
        let v6 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config_mut_authorized<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::MultisigConfig>(arg1, arg2, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::version::current());
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::set_config_nonce(&mut v5, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::config_nonce(v6) + 1);
        *v6 = v5;
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::emit_config_changed(arg1);
        let v7 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals, ConfigChange, ExecutionProgressWitness>(arg0, arg2, v7);
    }

    public fun max_cleanup_per_call() : u64 {
        128
    }

    public fun request_config_change(arg0: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Auth, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Params, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: vector<address>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: vector<u64>, arg16: vector<u64>, arg17: vector<u64>, arg18: vector<u64>, arg19: vector<u64>, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::verify(arg1, arg0);
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg21));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::assert_single_execution(&arg3);
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::params_key(&arg3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::add_managed_data_with_package_witness<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::ProposedConfigKey, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::MultisigConfig>(arg1, arg2, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::new_proposed_config_key(v0), 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::build_config_from_flat_vectors(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20), 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::version::current());
        let v1 = ConfigChangeIntent{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_intent<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals, ConfigChangeIntent>(arg1, arg2, arg3, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::new_outcome(arg1), 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::version::current(), v1, arg21);
        let v3 = ConfigChange{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::add_action_spec<0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::Approvals, ConfigChange, ConfigChangeIntent>(&mut v2, v3, 0x2::bcs::to_bytes<0x1::string::String>(&v0), v1);
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::stage_intent<ConfigChangeIntent>(arg1, arg2, v2, 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::version::current(), v1, arg21);
        0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig::emit_intent_created(arg1, v0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::params_description(&arg3), 0x2::tx_context::sender(arg21));
    }

    // decompiled from Move bytecode v6
}

