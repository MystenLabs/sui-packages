module 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_init_actions {
    public fun new_recipient_mint(arg0: address, arg1: u64) : 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::new_recipient_mint(arg0, arg1)
    }

    public fun new_tier_spec(arg0: u128, arg1: bool, arg2: vector<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint>, arg3: 0x1::string::String) : 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::new_tier_spec(arg0, arg1, arg2, arg3)
    }

    public fun recipient_address(arg0: &0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint) : address {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::recipient_address(arg0)
    }

    public fun recipient_amount(arg0: &0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint) : u64 {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::recipient_amount(arg0)
    }

    public fun tier_description(arg0: &0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec) : &0x1::string::String {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_description(arg0)
    }

    public fun tier_is_above(arg0: &0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec) : bool {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_is_above(arg0)
    }

    public fun tier_price_threshold(arg0: &0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec) : u128 {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_price_threshold(arg0)
    }

    public fun tier_recipients(arg0: &0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec) : &vector<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint> {
        0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_recipients(arg0)
    }

    public fun add_cancel_grant_spec<T0, T1>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x2::object::ID) {
        let v0 = 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::new_cancel_grant(arg1);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::CancelGrant<T0, T1>>(0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::cancel_grant_marker<T0, T1>(), 0x2::bcs::to_bytes<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::CancelGrantAction>(&v0), 1));
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_id(&mut v1, b"grant_id", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v1, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::CancelGrant<T0, T1>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_oracle_grant_spec<T0, T1>(arg0: &mut 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::Builder, arg1: 0x1::string::String, arg2: vector<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::string::String, arg9: u64) {
        assert!(0x1::vector::length<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec>(&arg2) > 0, 1);
        assert!(0x1::vector::length<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec>(&arg2) <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_oracle_tiers(), 6);
        assert!(arg6 <= 10000000, 5);
        assert!(arg5 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::ten_years_ms(), 11);
        assert!(arg9 >= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::one_week_ms() && arg9 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::ninety_days_ms(), 9);
        if (arg3) {
            assert!(arg4 <= 1000000000000000000, 12);
        };
        if (arg5 > 0 && arg6 > 0) {
            assert!(arg5 < arg6 * 365 * 24 * 60 * 60 * 1000, 13);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec>(&arg2, v0);
            let v2 = 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_recipients(v1);
            assert!(0x1::vector::length<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint>(v2) > 0, 2);
            assert!(0x1::vector::length<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint>(v2) <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_recipients_per_tier(), 4);
            let v3 = 0x1::vector::empty<address>();
            let v4 = 0;
            while (v4 < 0x1::vector::length<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint>(v2)) {
                let v5 = 0x1::vector::borrow<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::RecipientMint>(v2, v4);
                assert!(0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::recipient_amount(v5) > 0, 3);
                let v6 = 0;
                while (v6 < 0x1::vector::length<address>(&v3)) {
                    assert!(*0x1::vector::borrow<address>(&v3, v6) != 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::recipient_address(v5), 7);
                    v6 = v6 + 1;
                };
                0x1::vector::push_back<address>(&mut v3, 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::recipient_address(v5));
                v4 = v4 + 1;
            };
            if (!0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_is_above(v1)) {
                assert!(0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_price_threshold(v1) > 0, 8);
            };
            if (arg3) {
                assert!(0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_price_threshold(v1) <= (1000000000000000000 as u128), 8);
                if (!0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_is_above(v1) && arg4 > 0) {
                    assert!(0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::tier_price_threshold(v1) >= (arg4 as u128), 8);
                };
            };
            v0 = v0 + 1;
        };
        let v7 = 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::new_create_oracle_grant<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::add(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_action_spec<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::CreateOracleGrant<T0, T1>>(0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::create_oracle_grant_marker<T0, T1>(), 0x2::bcs::to_bytes<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::CreateOracleGrantAction<T0, T1>>(&v7), 1));
        let v8 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::new_builder();
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v8, b"mint_cap_resource_name", arg1);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v8, b"tier_count", 0x1::vector::length<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::TierSpec>(&arg2));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_bool(&mut v8, b"use_relative_pricing", arg3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v8, b"launchpad_multiplier", arg4);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v8, b"earliest_execution_offset_ms", arg5);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v8, b"expiry_years", arg6);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_bool(&mut v8, b"cancelable", arg7);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_string(&mut v8, b"description", arg8);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::add_u64(&mut v8, b"twap_window_ms", arg9);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_events::emit_action_params(v8, 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_type(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::source_id(arg0), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions::CreateOracleGrant<T0, T1>>())), 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::action_spec_builder::next_action_index(arg0));
    }

    // decompiled from Move bytecode v6
}

