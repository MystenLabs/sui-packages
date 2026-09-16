module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_route {
    struct RouteLegBinding has copy, drop, store {
        leg_id: 0x2::object::ID,
        kind: u8,
        source_asset: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding,
        destination_asset: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding,
        target_opportunity_id: 0x1::option::Option<vector<u8>>,
    }

    struct ReallocationRouteLeg has copy, drop, store {
        leg_id: 0x2::object::ID,
        kind: u8,
        source_asset: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding,
        destination_asset: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding,
        endpoint_opportunity_id: 0x1::option::Option<vector<u8>>,
    }

    struct ReallocationRouteCanonicalV1 has drop {
        domain: vector<u8>,
        schema_version: u8,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        allocation_bps: u64,
        ordered_legs: vector<ReallocationRouteLeg>,
    }

    public(friend) fun assert_bound_to_accounting<T0>(arg0: &vector<RouteLegBinding>, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: vector<u8>) {
        let v0 = 0x1::vector::length<RouteLegBinding>(arg0);
        assert!(v0 > 0, 11);
        assert!(arg2 == 0x1::type_name::with_original_ids<T0>(), 6);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::sui_asset_binding<T0>();
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&0x1::vector::borrow<RouteLegBinding>(arg0, 0).source_asset, &v1), 15);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<RouteLegBinding>(arg0, v2);
            let v4 = if (v3.kind == 1) {
                true
            } else if (v3.kind == 2) {
                true
            } else {
                v3.kind == 3
            };
            assert!(v4, 12);
            if (v3.kind == 3) {
                assert!(v2 + 1 == v0, 14);
            };
            let v5 = v2 + 1;
            while (v5 < v0) {
                assert!(v3.leg_id != 0x1::vector::borrow<RouteLegBinding>(arg0, v5).leg_id, 13);
                v5 = v5 + 1;
            };
            if (v2 + 1 < v0) {
                assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v3.destination_asset, &0x1::vector::borrow<RouteLegBinding>(arg0, v2 + 1).source_asset), 18);
            };
            v2 = v2 + 1;
        };
        let v6 = 0x1::vector::borrow<RouteLegBinding>(arg0, v0 - 1);
        assert!(v6.kind == 3, 14);
        assert!(v6.leg_id == arg1, 15);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v6.source_asset, &v1) && 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v6.destination_asset, &v1), 15);
        assert!(0x1::option::is_some<vector<u8>>(&v6.target_opportunity_id), 15);
        assert!(*0x1::option::borrow<vector<u8>>(&v6.target_opportunity_id) == arg3, 15);
    }

    public(friend) fun assert_managed_entry_route_allowed<T0>(arg0: &vector<RouteLegBinding>, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: u64, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: vector<u8>) {
        assert_bound_to_accounting<T0>(arg0, arg3, arg4, arg5);
        let v0 = 0x1::vector::length<RouteLegBinding>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<RouteLegBinding>(arg0, v1);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_and_chain_allowed(arg1, &v2.source_asset);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_and_chain_allowed(arg1, &v2.destination_asset);
            v1 = v1 + 1;
        };
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_allocation_allowed(arg1, &0x1::vector::borrow<RouteLegBinding>(arg0, v0 - 1).destination_asset, arg5, arg2);
    }

    public(friend) fun bridge_leg(arg0: 0x2::object::ID, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg2: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) : RouteLegBinding {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg1) != 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg2), 25);
        RouteLegBinding{
            leg_id                : arg0,
            kind                  : 2,
            source_asset          : arg1,
            destination_asset     : arg2,
            target_opportunity_id : 0x1::option::none<vector<u8>>(),
        }
    }

    public(friend) fun deposit_leg<T0>(arg0: 0x2::object::ID, arg1: vector<u8>) : RouteLegBinding {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 8);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::sui_asset_binding<T0>();
        RouteLegBinding{
            leg_id                : arg0,
            kind                  : 3,
            source_asset          : v0,
            destination_asset     : v0,
            target_opportunity_id : 0x1::option::some<vector<u8>>(arg1),
        }
    }

    public fun destination_chain(arg0: &RouteLegBinding) : vector<u8> {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg0.destination_asset)
    }

    public(friend) fun reallocation_bridge_leg(arg0: 0x2::object::ID, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg2: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) : ReallocationRouteLeg {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg1) != 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg2), 25);
        ReallocationRouteLeg{
            leg_id                  : arg0,
            kind                    : 2,
            source_asset            : arg1,
            destination_asset       : arg2,
            endpoint_opportunity_id : 0x1::option::none<vector<u8>>(),
        }
    }

    public(friend) fun reallocation_deposit_leg(arg0: 0x2::object::ID, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg2: vector<u8>) : ReallocationRouteLeg {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg1);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 8);
        ReallocationRouteLeg{
            leg_id                  : arg0,
            kind                    : 3,
            source_asset            : arg1,
            destination_asset       : arg1,
            endpoint_opportunity_id : 0x1::option::some<vector<u8>>(arg2),
        }
    }

    public(friend) fun reallocation_swap_leg(arg0: 0x2::object::ID, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg2: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) : ReallocationRouteLeg {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg1) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg2), 18);
        ReallocationRouteLeg{
            leg_id                  : arg0,
            kind                    : 1,
            source_asset            : arg1,
            destination_asset       : arg2,
            endpoint_opportunity_id : 0x1::option::none<vector<u8>>(),
        }
    }

    public(friend) fun reallocation_withdraw_leg(arg0: 0x2::object::ID, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg2: vector<u8>) : ReallocationRouteLeg {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg1);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 8);
        ReallocationRouteLeg{
            leg_id                  : arg0,
            kind                    : 4,
            source_asset            : arg1,
            destination_asset       : arg1,
            endpoint_opportunity_id : 0x1::option::some<vector<u8>>(arg2),
        }
    }

    public fun source_chain(arg0: &RouteLegBinding) : vector<u8> {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg0.source_asset)
    }

    public(friend) fun swap_leg(arg0: 0x2::object::ID, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg2: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) : RouteLegBinding {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&arg2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg1) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&arg2), 18);
        RouteLegBinding{
            leg_id                : arg0,
            kind                  : 1,
            source_asset          : arg1,
            destination_asset     : arg2,
            target_opportunity_id : 0x1::option::none<vector<u8>>(),
        }
    }

    public fun target_opportunity(arg0: &RouteLegBinding) : 0x1::option::Option<vector<u8>> {
        arg0.target_opportunity_id
    }

    public(friend) fun validated_accounting_reallocation_route_canonical_v1(arg0: &vector<ReallocationRouteLeg>, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: u64, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) : (vector<u8>, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(arg5);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(arg8);
        let (v0, v1, v2) = validated_reallocation_route_canonical_v1(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v4, arg5), 31);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v3, arg8), 31);
        (v0, v4, v3)
    }

    public(friend) fun validated_reallocation_route_canonical_v1(arg0: &vector<ReallocationRouteLeg>, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: u64, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: 0x2::object::ID, arg6: vector<u8>) : (vector<u8>, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::NativeAssetBinding) {
        assert!(!0x1::vector::is_empty<u8>(&arg4), 8);
        assert!(!0x1::vector::is_empty<u8>(&arg6), 8);
        assert!(arg3 != arg5, 27);
        assert!(arg4 != arg6, 30);
        let v0 = 0x1::vector::length<ReallocationRouteLeg>(arg0);
        assert!(v0 >= 2, 11);
        let v1 = 0x1::vector::borrow<ReallocationRouteLeg>(arg0, 0);
        assert!(v1.kind == 4, 26);
        assert!(v1.leg_id == arg3, 15);
        assert!(0x1::option::is_some<vector<u8>>(&v1.endpoint_opportunity_id), 28);
        assert!(*0x1::option::borrow<vector<u8>>(&v1.endpoint_opportunity_id) == arg4, 15);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v1.source_asset, &v1.destination_asset), 15);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<ReallocationRouteLeg>(arg0, v2);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&v3.source_asset);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_binding(&v3.destination_asset);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_and_chain_allowed(arg1, &v3.source_asset);
            0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_asset_and_chain_allowed(arg1, &v3.destination_asset);
            if (v2 == 0) {
                assert!(v3.kind == 4, 26);
            } else if (v2 + 1 == v0) {
                assert!(v3.kind == 3, 14);
            } else {
                assert!(v3.kind == 1 || v3.kind == 2, 12);
                assert!(!0x1::option::is_some<vector<u8>>(&v3.endpoint_opportunity_id), 29);
                if (v3.kind == 1) {
                    assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&v3.source_asset) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&v3.destination_asset), 18);
                } else {
                    assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&v3.source_asset) != 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::native_asset_chain_id(&v3.destination_asset), 25);
                };
            };
            let v4 = v2 + 1;
            while (v4 < v0) {
                assert!(v3.leg_id != 0x1::vector::borrow<ReallocationRouteLeg>(arg0, v4).leg_id, 13);
                v4 = v4 + 1;
            };
            if (v2 + 1 < v0) {
                assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v3.destination_asset, &0x1::vector::borrow<ReallocationRouteLeg>(arg0, v2 + 1).source_asset), 18);
            };
            v2 = v2 + 1;
        };
        let v5 = 0x1::vector::borrow<ReallocationRouteLeg>(arg0, v0 - 1);
        assert!(v5.leg_id == arg5, 15);
        assert!(0x1::option::is_some<vector<u8>>(&v5.endpoint_opportunity_id), 28);
        assert!(*0x1::option::borrow<vector<u8>>(&v5.endpoint_opportunity_id) == arg6, 15);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::same_native_asset_binding(&v5.source_asset, &v5.destination_asset), 15);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_allocation_allowed(arg1, &v1.source_asset, arg4, arg2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_native_allocation_allowed(arg1, &v5.destination_asset, arg6, arg2);
        let v6 = ReallocationRouteCanonicalV1{
            domain          : b"DAY_REALLOCATION_ROUTE",
            schema_version  : 1,
            guardrails_id   : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg1),
            guardrails_hash : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg1),
            allocation_bps  : arg2,
            ordered_legs    : *arg0,
        };
        (0x1::bcs::to_bytes<ReallocationRouteCanonicalV1>(&v6), v1.source_asset, v5.destination_asset)
    }

    // decompiled from Move bytecode v7
}

