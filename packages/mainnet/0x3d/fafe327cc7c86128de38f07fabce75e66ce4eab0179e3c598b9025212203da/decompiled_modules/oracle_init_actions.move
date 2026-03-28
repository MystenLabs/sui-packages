module 0x3dfafe327cc7c86128de38f07fabce75e66ce4eab0179e3c598b9025212203da::oracle_init_actions {
    struct RecipientMint has copy, drop, store {
        recipient: address,
        amount: u64,
    }

    struct TierSpec has copy, drop, store {
        price_threshold: u128,
        is_above: bool,
        recipients: vector<RecipientMint>,
        tier_description: 0x1::string::String,
    }

    struct CreateOracleGrantAction<phantom T0, phantom T1> has copy, drop, store {
        tier_specs: vector<TierSpec>,
        use_relative_pricing: bool,
        launchpad_multiplier: u64,
        earliest_execution_offset_ms: u64,
        expiry_years: u64,
        cancelable: bool,
        description: 0x1::string::String,
        twap_window_ms: u64,
    }

    struct CancelGrantAction has copy, drop, store {
        grant_id: 0x2::object::ID,
    }

    public fun add_cancel_grant_spec<T0, T1>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: 0x2::object::ID) {
        let v0 = CancelGrantAction{grant_id: arg1};
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3dfafe327cc7c86128de38f07fabce75e66ce4eab0179e3c598b9025212203da::oracle_actions::CancelGrant<T0, T1>>(), 0x2::bcs::to_bytes<CancelGrantAction>(&v0), 1));
        let v1 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_id(&mut v1, b"grant_id", arg1);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v1, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3dfafe327cc7c86128de38f07fabce75e66ce4eab0179e3c598b9025212203da::oracle_actions::CancelGrant<T0, T1>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun add_create_oracle_grant_spec<T0, T1>(arg0: &mut 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::Builder, arg1: vector<TierSpec>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::string::String, arg8: u64) {
        assert!(0x1::vector::length<TierSpec>(&arg1) > 0, 1);
        assert!(0x1::vector::length<TierSpec>(&arg1) <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_oracle_tiers(), 6);
        assert!(arg5 <= 10, 5);
        assert!(arg4 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::ten_years_ms(), 11);
        assert!(arg8 >= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::one_week_ms() && arg8 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::ninety_days_ms(), 9);
        if (arg2) {
            assert!(arg3 <= 1000000000000000000, 12);
        };
        if (arg4 > 0 && arg5 > 0) {
            assert!(arg4 < arg5 * 365 * 24 * 60 * 60 * 1000, 13);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<TierSpec>(&arg1)) {
            let v1 = 0x1::vector::borrow<TierSpec>(&arg1, v0);
            let v2 = &v1.recipients;
            assert!(0x1::vector::length<RecipientMint>(v2) > 0, 2);
            assert!(0x1::vector::length<RecipientMint>(v2) <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_recipients_per_tier(), 4);
            let v3 = 0x1::vector::empty<address>();
            let v4 = 0;
            while (v4 < 0x1::vector::length<RecipientMint>(v2)) {
                let v5 = 0x1::vector::borrow<RecipientMint>(v2, v4);
                assert!(v5.amount > 0, 3);
                let v6 = 0;
                while (v6 < 0x1::vector::length<address>(&v3)) {
                    assert!(*0x1::vector::borrow<address>(&v3, v6) != v5.recipient, 7);
                    v6 = v6 + 1;
                };
                0x1::vector::push_back<address>(&mut v3, v5.recipient);
                v4 = v4 + 1;
            };
            if (!v1.is_above) {
                assert!(v1.price_threshold > 0, 8);
            };
            if (arg2) {
                assert!(v1.price_threshold <= (1000000000000000000 as u128), 8);
                if (!v1.is_above && arg3 > 0) {
                    assert!(v1.price_threshold >= (arg3 as u128), 8);
                };
            };
            v0 = v0 + 1;
        };
        let v7 = CreateOracleGrantAction<T0, T1>{
            tier_specs                   : arg1,
            use_relative_pricing         : arg2,
            launchpad_multiplier         : arg3,
            earliest_execution_offset_ms : arg4,
            expiry_years                 : arg5,
            cancelable                   : arg6,
            description                  : arg7,
            twap_window_ms               : arg8,
        };
        0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::add(arg0, 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::new_action_spec_with_typename(0x1::type_name::with_original_ids<0x3dfafe327cc7c86128de38f07fabce75e66ce4eab0179e3c598b9025212203da::oracle_actions::CreateOracleGrant<T0, T1>>(), 0x2::bcs::to_bytes<CreateOracleGrantAction<T0, T1>>(&v7), 1));
        let v8 = 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::new_builder();
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v8, b"tier_count", 0x1::vector::length<TierSpec>(&arg1));
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v8, b"use_relative_pricing", arg2);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v8, b"launchpad_multiplier", arg3);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v8, b"earliest_execution_offset_ms", arg4);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v8, b"expiry_years", arg5);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_bool(&mut v8, b"cancelable", arg6);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_string(&mut v8, b"description", arg7);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::add_u64(&mut v8, b"twap_window_ms", arg8);
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_events::emit_action_params(v8, 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_type(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::source_id(arg0), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::outcome_index(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<0x3dfafe327cc7c86128de38f07fabce75e66ce4eab0179e3c598b9025212203da::oracle_actions::CreateOracleGrant<T0, T1>>())), 0x8ad26c8279c79b4fc53466d6ae5a514830df1942f3b067d7d78458ca5fe94a64::action_spec_builder::next_action_index(arg0));
    }

    public fun new_recipient_mint(arg0: address, arg1: u64) : RecipientMint {
        RecipientMint{
            recipient : arg0,
            amount    : arg1,
        }
    }

    public fun new_tier_spec(arg0: u128, arg1: bool, arg2: vector<RecipientMint>, arg3: 0x1::string::String) : TierSpec {
        TierSpec{
            price_threshold  : arg0,
            is_above         : arg1,
            recipients       : arg2,
            tier_description : arg3,
        }
    }

    public fun recipient_address(arg0: &RecipientMint) : address {
        arg0.recipient
    }

    public fun recipient_amount(arg0: &RecipientMint) : u64 {
        arg0.amount
    }

    public fun tier_description(arg0: &TierSpec) : &0x1::string::String {
        &arg0.tier_description
    }

    public fun tier_is_above(arg0: &TierSpec) : bool {
        arg0.is_above
    }

    public fun tier_price_threshold(arg0: &TierSpec) : u128 {
        arg0.price_threshold
    }

    public fun tier_recipients(arg0: &TierSpec) : &vector<RecipientMint> {
        &arg0.recipients
    }

    // decompiled from Move bytecode v6
}

