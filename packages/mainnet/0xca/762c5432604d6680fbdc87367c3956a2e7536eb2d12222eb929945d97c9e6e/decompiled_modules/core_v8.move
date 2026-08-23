module 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::core_v8 {
    public fun assert_activation_scaffold_ready_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8) : (0x2::object::ID, vector<u8>, u64) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_activation_scaffold_ready_v8<T0>(arg0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::assert_activation_ready_v8<T0>(arg1, arg0)
    }

    public fun new_initial_maker_draft_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u8>, arg6: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionCountsV8, arg7: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionCommitmentsV8, arg8: vector<u8>, arg9: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::EconomicsSnapshotV8, arg10: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::RightsSnapshotV8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8) {
        let (v0, v1) = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::new_initial_maker_draft_v8<T0>(arg0, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::total_count_v8(&arg6), *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::aggregate_commitment_v8(&arg7), arg8, arg1, arg2, arg3, arg4, arg5, arg9, arg10, arg11, arg12);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::new_base_definition_registry_v8<T0>(&v3, &v2, arg6, arg7, arg12);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::finalize_base_registry_binding_v8<T0>(&mut v3, &v2, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(&v4));
        (v3, v4, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::new_maker_treasury_v8<T0>(&mut v3, &v2, arg12), v2)
    }

    public fun new_successor_maker_draft_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg1: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::SuccessorAuthorityV8<T0>, arg4: u64, arg5: vector<u8>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionCountsV8, arg10: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionCommitmentsV8, arg11: vector<u8>, arg12: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::EconomicsSnapshotV8, arg13: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::RightsSnapshotV8, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8) {
        let (v0, v1) = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::new_successor_maker_draft_v8<T0>(arg0, arg1, arg2, arg3, arg4, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::total_count_v8(&arg9), *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::aggregate_commitment_v8(&arg10), arg11, arg5, arg6, arg7, arg8, arg12, arg13, arg14, arg15);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::new_base_definition_registry_v8<T0>(&v3, &v2, arg9, arg10, arg15);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::finalize_base_registry_binding_v8<T0>(&mut v3, &v2, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(&v4));
        (v3, v4, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::new_maker_treasury_v8<T0>(&mut v3, &v2, arg15), v2)
    }

    public fun share_maker_draft_v8<T0>(arg0: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, arg3: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg4: &0x2::tx_context::TxContext) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::assert_draft_registry_identity_v8<T0>(&arg1, &arg0, &arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_treasury_v8<T0>(&arg0, &arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::share_base_definition_registry_v8(arg1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::share_maker_treasury_v8<T0>(arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::share_maker_root_and_admin_v8<T0>(arg0, arg3, arg4);
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

