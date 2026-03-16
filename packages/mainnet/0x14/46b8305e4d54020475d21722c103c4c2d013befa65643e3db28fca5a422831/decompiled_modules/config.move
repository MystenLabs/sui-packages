module 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::config {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct ConfigChangeIntent has copy, drop {
        dummy_field: bool,
    }

    struct ConfigChange has drop {
        dummy_field: bool,
    }

    public fun cancel_expired_config_change(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::cancel_expired_intent_for_cleanup(arg0, arg2, arg3, arg4);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::destroy_expired(v0);
    }

    public fun cancel_pending_config_change(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::cancel_pending_intent_for_cleanup(arg0, arg2, arg3);
        if (0x1::option::is_some<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired>(&v0)) {
            let v1 = 0x1::option::extract<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired>(&mut v0);
            let v2 = &mut v1;
            delete_config_change(arg0, arg1, v2);
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::destroy_expired(v1);
        };
        0x1::option::destroy_none<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired>(v0);
    }

    public fun cancel_stale_config_change(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::cancel_stale_intent_for_cleanup(arg0, arg2, arg3);
        let v1 = &mut v0;
        delete_config_change(arg0, arg1, v1);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::destroy_expired(v0);
    }

    public fun cleanup_expired_config_changes(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: vector<0x1::string::String>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg3 <= 128, 2);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2) && v0 < arg3) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            let v3 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::intents(arg0);
            let v4 = if (!0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::contains(v3, v2)) {
                false
            } else {
                let v5 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::get<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(v3, v2);
                if (0x2::clock::timestamp_ms(arg4) < 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::expiration_time<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(v5)) {
                    false
                } else {
                    let v6 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_specs<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(v5);
                    0x1::vector::length<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(v6) > 0 && 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_validation::is_action_type<ConfigChange>(0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(v6, 0))
                }
            };
            if (v4) {
                let v7 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::cancel_expired_intent_for_cleanup(arg0, v2, arg4, arg5);
                let v8 = &mut v7;
                delete_config_change(arg0, arg1, v8);
                0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::destroy_expired(v7);
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun delete_config_change(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg2: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Expired) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::assert_expired_is_account(arg2, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::addr(arg0));
        let (v0, _) = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::remove_action_spec(arg2);
        let v2 = v0;
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::action_validation::assert_action_type<ConfigChange>(&v2);
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_version(&v2) == 1, 0);
        let v3 = 0x2::bcs::new(*0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_data(&v2));
        let v4 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v3));
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::bcs_validation::validate_all_bytes_consumed(v3);
        assert!(v4 == 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::expired_key(arg2), 1);
        let v5 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::new_proposed_config_key(v4);
        if (0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::has_managed_data<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::ProposedConfigKey>(arg0, v5)) {
            0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::remove_managed_data_with_package_witness<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::ProposedConfigKey, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::MultisigConfig>(arg0, arg1, v5, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::version::current());
        };
    }

    public fun execute_config_change(arg0: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::Executable<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::assert_is_account<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(arg0), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::addr(arg1));
        let v0 = 0x1::vector::borrow<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::ActionSpec>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_specs<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(arg0)), 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::action_idx<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(arg0));
        assert!(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_version(v0) == 1, 0);
        let v1 = 0x2::bcs::new(*0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::action_spec_data(v0));
        let v2 = 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1));
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::bcs_validation::validate_all_bytes_consumed(v1);
        assert!(v2 == 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::key<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::intent<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals>(arg0)), 1);
        let v3 = ExecutionProgressWitness{dummy_field: false};
        let v4 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::remove_managed_data<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::ProposedConfigKey, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::MultisigConfig, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals, ExecutionProgressWitness>(arg1, arg2, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::new_proposed_config_key(v2), arg0, v3);
        let v5 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config_mut_authorized<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::MultisigConfig>(arg1, arg2, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::version::current());
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::set_config_nonce(&mut v4, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::config_nonce(v5) + 1);
        *v5 = v4;
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::emit_config_changed(arg1);
        let v6 = ExecutionProgressWitness{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::executable::increment_action_idx<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals, ConfigChange, ExecutionProgressWitness>(arg0, arg2, v6);
    }

    public fun max_cleanup_per_call() : u64 {
        128
    }

    public fun request_config_change(arg0: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Auth, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Params, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::execution_timelock_ms(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::MultisigConfig>(arg1));
        request_config_change_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8);
    }

    fun request_config_change_impl(arg0: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Auth, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Params, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::verify(arg1, arg0);
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::assert_sender_can_propose(arg1, 0x2::tx_context::sender(arg9));
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::assert_single_execution(&arg3);
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::params_key(&arg3);
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::add_managed_data_with_package_witness<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::ProposedConfigKey, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::MultisigConfig>(arg1, arg2, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::new_proposed_config_key(v0), 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::new_config_with_timelock(arg4, arg5, arg6, arg7, arg8), 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::version::current());
        let v1 = ConfigChangeIntent{dummy_field: false};
        let v2 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::create_intent<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals, ConfigChangeIntent>(arg1, arg2, arg3, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::new_outcome(arg1), 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::version::current(), v1, arg9);
        let v3 = ConfigChange{dummy_field: false};
        0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::add_action_spec<0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::Approvals, ConfigChange, ConfigChangeIntent>(&mut v2, v3, 0x2::bcs::to_bytes<0x1::string::String>(&v0), v1);
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::stage_intent<ConfigChangeIntent>(arg1, arg2, v2, 0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::version::current(), v1, arg9);
        0x1446b8305e4d54020475d21722c103c4c2d013befa65643e3db28fca5a422831::multisig::emit_intent_created(arg1, v0, 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::params_description(&arg3), 0x2::tx_context::sender(arg9));
    }

    public fun request_config_change_with_timelock(arg0: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Auth, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::intents::Params, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        request_config_change_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

