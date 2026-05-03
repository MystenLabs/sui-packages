module 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_actions {
    struct ExecutionProgressWitness has drop {
        dummy_field: bool,
    }

    struct CreateOracleGrant<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct CancelGrant<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LaunchpadEnforcement has copy, drop, store {
        enabled: bool,
        minimum_multiplier: u64,
        launchpad_price: u128,
    }

    struct PriceCondition has copy, drop, store {
        threshold: u128,
        is_above: bool,
    }

    struct RecipientMint has copy, drop, store {
        recipient: address,
        amount: u64,
    }

    struct PriceTier has copy, drop, store {
        price_condition: 0x1::option::Option<PriceCondition>,
        recipients: vector<RecipientMint>,
        executed: vector<bool>,
        description: 0x1::string::String,
    }

    struct PriceBasedMintGrant<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        tiers: vector<PriceTier>,
        total_amount: u64,
        use_relative_pricing: bool,
        launchpad_enforcement: LaunchpadEnforcement,
        earliest_execution: 0x1::option::Option<u64>,
        latest_execution: 0x1::option::Option<u64>,
        cancelable: bool,
        canceled: bool,
        description: 0x1::string::String,
        created_at: u64,
        dao_id: 0x2::object::ID,
        mint_admin_cap: 0x1::option::Option<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>,
        twap_window_ms: u64,
    }

    struct GrantStorageKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GrantStorage has store {
        grants: 0x2::table::Table<0x2::object::ID, GrantInfo>,
        grant_ids: vector<0x2::object::ID>,
        total_grants: u64,
    }

    struct GrantInfo has copy, drop, store {
        recipient: address,
        cancelable: bool,
    }

    struct GrantCreated has copy, drop {
        grant_id: 0x2::object::ID,
        total_amount: u64,
        tier_count: u64,
        timestamp: u64,
    }

    struct TokensClaimed has copy, drop {
        grant_id: 0x2::object::ID,
        tier_index: u64,
        recipient: address,
        amount_claimed: u64,
        timestamp: u64,
    }

    struct GrantCanceled has copy, drop {
        grant_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ClaimGrantRequest<phantom T0, phantom T1> {
        grant_id: 0x2::object::ID,
        tier_index: u64,
        recipient: address,
        claimable_amount: u64,
        dao_address: address,
    }

    struct TierSpec has copy, drop, store {
        price_threshold: u128,
        is_above: bool,
        recipients: vector<RecipientMint>,
        tier_description: 0x1::string::String,
    }

    struct CreateOracleGrantAction<phantom T0, phantom T1> has copy, drop, store {
        mint_cap_resource_name: 0x1::string::String,
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

    public fun absolute_price_condition(arg0: u128, arg1: bool) : PriceCondition {
        PriceCondition{
            threshold : arg0,
            is_above  : arg1,
        }
    }

    fun assert_not_dissolving(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) {
        assert!(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::operational_state(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_state(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0))) != 1, 10);
    }

    fun cancel_grant_internal<T0, T1>(arg0: &mut PriceBasedMintGrant<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.cancelable, 11);
        assert!(!arg0.canceled, 6);
        arg0.canceled = true;
        0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::destroy_currency_mint_admin_cap<T0>(0x1::option::extract<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&mut arg0.mint_admin_cap));
        let v0 = GrantCanceled{
            grant_id  : 0x2::object::id<PriceBasedMintGrant<T0, T1>>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<GrantCanceled>(v0);
    }

    public(friend) fun cancel_grant_marker<T0, T1>() : CancelGrant<T0, T1> {
        CancelGrant<T0, T1>{dummy_field: false}
    }

    fun check_price_condition(arg0: &PriceCondition, arg1: u128) : bool {
        arg0.is_above && arg1 >= arg0.threshold || arg1 <= arg0.threshold
    }

    public fun claim_grant<T0, T1, T2>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &mut PriceBasedMintGrant<T0, T1>, arg3: u64, arg4: address, arg5: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg6: &0x2::clock::Clock) : ClaimGrantRequest<T0, T1> {
        validate_claim_eligibility<T0, T1>(arg0, arg1, arg2, arg6);
        validate_spot_pool<T0, T1, T2>(arg0, arg5);
        assert!(arg3 < 0x1::vector::length<PriceTier>(&arg2.tiers), 36);
        let v0 = 0x1::vector::borrow_mut<PriceTier>(&mut arg2.tiers, arg3);
        let (v1, v2) = find_recipient_allocation(v0, arg4);
        assert!(!*0x1::vector::borrow<bool>(&v0.executed, v1), 17);
        validate_price_conditions_with_enforcement<T0, T1, T2>(arg2.launchpad_enforcement, arg2.use_relative_pricing, v0, arg5, arg2.twap_window_ms, arg6);
        *0x1::vector::borrow_mut<bool>(&mut v0.executed, v1) = true;
        ClaimGrantRequest<T0, T1>{
            grant_id         : 0x2::object::id<PriceBasedMintGrant<T0, T1>>(arg2),
            tier_index       : arg3,
            recipient        : arg4,
            claimable_amount : v2,
            dao_address      : 0x2::object::id_to_address(&arg2.dao_id),
        }
    }

    fun convert_tier_specs_to_price_tiers(arg0: &vector<TierSpec>) : vector<PriceTier> {
        let v0 = 0x1::vector::empty<PriceTier>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<TierSpec>(arg0)) {
            let v2 = 0x1::vector::borrow<TierSpec>(arg0, v1);
            let v3 = 0x1::vector::length<RecipientMint>(&v2.recipients);
            assert!(v3 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_recipients_per_tier(), 21);
            let v4 = 0x1::vector::empty<bool>();
            let v5 = 0;
            while (v5 < v3) {
                0x1::vector::push_back<bool>(&mut v4, false);
                v5 = v5 + 1;
            };
            let v6 = 0x1::vector::empty<address>();
            let v7 = 0;
            while (v7 < v3) {
                let v8 = 0x1::vector::borrow<RecipientMint>(&v2.recipients, v7);
                assert!(v8.amount > 0, 35);
                let v9 = 0;
                while (v9 < 0x1::vector::length<address>(&v6)) {
                    assert!(*0x1::vector::borrow<address>(&v6, v9) != v8.recipient, 22);
                    v9 = v9 + 1;
                };
                0x1::vector::push_back<address>(&mut v6, v8.recipient);
                v7 = v7 + 1;
            };
            if (!v2.is_above) {
                assert!(v2.price_threshold > 0, 23);
            };
            let v10 = PriceCondition{
                threshold : v2.price_threshold,
                is_above  : v2.is_above,
            };
            let v11 = PriceTier{
                price_condition : 0x1::option::some<PriceCondition>(v10),
                recipients      : v2.recipients,
                executed        : v4,
                description     : v2.tier_description,
            };
            0x1::vector::push_back<PriceTier>(&mut v0, v11);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun create_grant<T0, T1>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: vector<PriceTier>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::string::String, arg9: 0x2::object::ID, arg10: 0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<PriceTier>(&arg2) > 0, 18);
        assert!(0x1::vector::length<PriceTier>(&arg2) <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_oracle_tiers(), 34);
        assert!(arg9 == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 19);
        assert!(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_admin_cap_account_id<T0>(&arg10) == arg9, 33);
        assert!(arg11 >= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::one_week_ms() && arg11 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::ninety_days_ms(), 27);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<PriceTier>(&arg2);
        while (v2 < v3) {
            let v4 = 0x1::vector::borrow<PriceTier>(&arg2, v2);
            if (arg3 && 0x1::option::is_some<PriceCondition>(&v4.price_condition)) {
                assert!(0x1::option::borrow<PriceCondition>(&v4.price_condition).threshold <= (1000000000000000000 as u128), 23);
            };
            let v5 = 0;
            let v6 = 0x1::vector::length<RecipientMint>(&v4.recipients);
            assert!(v6 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_recipients_per_tier(), 21);
            while (v5 < v6) {
                v1 = v1 + 0x1::vector::borrow<RecipientMint>(&v4.recipients, v5).amount;
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 35);
        let v7 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::get_launchpad_initial_price(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0));
        assert!(0x1::option::is_some<u128>(&v7), 3);
        let v8 = *0x1::option::borrow<u128>(&v7);
        assert!(v8 > 0, 3);
        if (arg3) {
            assert!(arg4 <= 1000000000000000000, 29);
            let v9 = 340282366920938463463374607431768211455 * ((0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128) as u256);
            assert!((v8 as u256) * (arg4 as u256) <= v9, 29);
            let v10 = 0;
            while (v10 < v3) {
                let v11 = 0x1::vector::borrow<PriceTier>(&arg2, v10);
                if (0x1::option::is_some<PriceCondition>(&v11.price_condition)) {
                    let v12 = 0x1::option::borrow<PriceCondition>(&v11.price_condition);
                    let v13 = v12.threshold;
                    assert!((v8 as u256) * (v13 as u256) <= v9, 23);
                    if (!v12.is_above && arg4 > 0) {
                        assert!(v13 >= (arg4 as u128), 23);
                    };
                };
                v10 = v10 + 1;
            };
        };
        let v14 = if (arg5 > 0) {
            assert!(arg5 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::ten_years_ms(), 9);
            0x1::option::some<u64>(v0 + arg5)
        } else {
            0x1::option::none<u64>()
        };
        let v15 = v14;
        let v16 = if (arg6 > 0) {
            let v17 = (arg6 as u128) * 365 * 24 * 60 * 60 * 1000;
            let v18 = if (v17 > 18446744073709551615 - (v0 as u128)) {
                18446744073709551615 - v0
            } else {
                (v17 as u64)
            };
            0x1::option::some<u64>(v0 + v18)
        } else {
            0x1::option::none<u64>()
        };
        let v19 = v16;
        if (0x1::option::is_some<u64>(&v15) && 0x1::option::is_some<u64>(&v19)) {
            assert!(*0x1::option::borrow<u64>(&v15) < *0x1::option::borrow<u64>(&v19), 25);
        };
        let v20 = 0x2::object::new(arg13);
        let v21 = 0x2::object::uid_to_inner(&v20);
        let v22 = GrantCreated{
            grant_id     : v21,
            total_amount : v1,
            tier_count   : v3,
            timestamp    : v0,
        };
        0x2::event::emit<GrantCreated>(v22);
        let v23 = arg3 && arg4 > 0;
        let v24 = if (v23) {
            arg4
        } else {
            0
        };
        let v25 = LaunchpadEnforcement{
            enabled            : v23,
            minimum_multiplier : v24,
            launchpad_price    : v8,
        };
        let v26 = PriceBasedMintGrant<T0, T1>{
            id                    : v20,
            tiers                 : arg2,
            total_amount          : v1,
            use_relative_pricing  : arg3,
            launchpad_enforcement : v25,
            earliest_execution    : v15,
            latest_execution      : v19,
            cancelable            : arg7,
            canceled              : false,
            description           : arg8,
            created_at            : v0,
            dao_id                : arg9,
            mint_admin_cap        : 0x1::option::some<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(arg10),
            twap_window_ms        : arg11,
        };
        0x2::transfer::share_object<PriceBasedMintGrant<T0, T1>>(v26);
        ensure_grant_storage(arg0, arg1, arg13);
        register_grant(arg0, arg1, v21, arg7);
        v21
    }

    public(friend) fun create_oracle_grant_marker<T0, T1>() : CreateOracleGrant<T0, T1> {
        CreateOracleGrant<T0, T1>{dummy_field: false}
    }

    public fun description<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : &0x1::string::String {
        &arg0.description
    }

    fun deserialize_recipients(arg0: &mut 0x2::bcs::BCS) : vector<RecipientMint> {
        let v0 = 0x1::vector::empty<RecipientMint>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = RecipientMint{
                recipient : 0x2::bcs::peel_address(arg0),
                amount    : 0x2::bcs::peel_u64(arg0),
            };
            0x1::vector::push_back<RecipientMint>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun deserialize_tier_specs(arg0: &mut 0x2::bcs::BCS) : vector<TierSpec> {
        let v0 = 0x1::vector::empty<TierSpec>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = 0x2::bcs::peel_u128(arg0);
            let v3 = 0x2::bcs::peel_bool(arg0);
            let v4 = deserialize_recipients(arg0);
            let v5 = 0x1::string::try_utf8(0x2::bcs::peel_vec_u8(arg0));
            assert!(0x1::option::is_some<0x1::string::String>(&v5), 32);
            let v6 = TierSpec{
                price_threshold  : v2,
                is_above         : v3,
                recipients       : v4,
                tier_description : 0x1::option::destroy_some<0x1::string::String>(v5),
            };
            0x1::vector::push_back<TierSpec>(&mut v0, v6);
            v1 = v1 + 1;
        };
        v0
    }

    public fun do_cancel_grant<T0, T1, T2: store, T3: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T2>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: T3, arg4: &mut PriceBasedMintGrant<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T2>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T2>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T2>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<CancelGrant<T0, T1>>(v1);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v1) == 1, 20);
        let v2 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v1));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v2);
        let v3 = 0x2::object::id<PriceBasedMintGrant<T0, T1>>(arg4);
        assert!(0x2::object::id_to_address(&v3) == 0x2::bcs::peel_address(&mut v2), 16);
        assert!(arg4.dao_id == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1), 19);
        assert_not_dissolving(arg1, arg2);
        cancel_grant_internal<T0, T1>(arg4, arg5);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T2, CancelGrant<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v4);
    }

    public fun do_create_oracle_grant<T0, T1, T2: store, T3: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<T2>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: T3, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        assert_not_dissolving(arg1, arg2);
        ensure_grant_storage(arg1, arg2, arg5);
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg1);
        let v2 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::stable_type(v1);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == *0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::asset_type(v1), 30);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())) == *v2, 31);
        let v3 = 0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<T2>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::intent<T2>(arg0)), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::action_idx<T2>(arg0));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation::assert_action_type<CreateOracleGrant<T0, T1>>(v3);
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_version(v3) == 1, 20);
        let v4 = 0x2::bcs::new(*0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_data(v3));
        let v5 = &mut v4;
        let v6 = deserialize_tier_specs(v5);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::bcs_validation::validate_all_bytes_consumed(v4);
        let v7 = 0x1::string::try_utf8(0x2::bcs::peel_vec_u8(&mut v4));
        assert!(0x1::option::is_some<0x1::string::String>(&v7), 32);
        let v8 = 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        create_grant<T0, T1>(arg1, arg2, convert_tier_specs_to_price_tiers(&v6), 0x2::bcs::peel_bool(&mut v4), 0x2::bcs::peel_u64(&mut v4), 0x2::bcs::peel_u64(&mut v4), 0x2::bcs::peel_u64(&mut v4), 0x2::bcs::peel_bool(&mut v4), 0x1::option::destroy_some<0x1::string::String>(v7), v8, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable_resources::take_object<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>, T2, ExecutionProgressWitness>(arg0, arg2, v9, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v4))), 0x2::bcs::peel_u64(&mut v4), arg4, arg5);
        let v10 = ExecutionProgressWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::increment_action_idx<T2, CreateOracleGrant<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v10);
    }

    fun ensure_grant_storage(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GrantStorageKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<GrantStorageKey>(arg0, v0)) {
            let v1 = GrantStorageKey{dummy_field: false};
            let v2 = GrantStorage{
                grants       : 0x2::table::new<0x2::object::ID, GrantInfo>(arg2),
                grant_ids    : 0x1::vector::empty<0x2::object::ID>(),
                total_grants : 0,
            };
            0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::add_managed_data_with_package_witness<GrantStorageKey, GrantStorage>(arg0, arg1, v1, v2, 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_version::current());
        };
    }

    fun find_recipient_allocation(arg0: &PriceTier, arg1: address) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<RecipientMint>(&arg0.recipients)) {
            let v4 = 0x1::vector::borrow<RecipientMint>(&arg0.recipients, v3);
            if (v4.recipient == arg1) {
                v0 = v4.amount;
                v1 = v3;
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 5);
        assert!(v0 > 0, 8);
        assert!(v1 < 0x1::vector::length<bool>(&arg0.executed), 36);
        (v1, v0)
    }

    public fun fulfill_claim_grant_from_account<T0, T1>(arg0: ClaimGrantRequest<T0, T1>, arg1: &mut PriceBasedMintGrant<T0, T1>, arg2: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg3: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let ClaimGrantRequest {
            grant_id         : v0,
            tier_index       : v1,
            recipient        : v2,
            claimable_amount : v3,
            dao_address      : v4,
        } = arg0;
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg2) == v4, 16);
        assert!(arg1.dao_id == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg2), 19);
        assert!(0x2::object::id<PriceBasedMintGrant<T0, T1>>(arg1) == v0, 16);
        validate_claim_eligibility<T0, T1>(arg2, arg3, arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::mint_with_admin_cap<T0>(arg2, arg3, 0x1::option::borrow<0xaa682664f419d51af5071ed0449dffbcf3a417fd12961d916b1a433542e9478d::currency::CurrencyMintAdminCap<T0>>(&arg1.mint_admin_cap), v3, arg5), v2);
        let v5 = TokensClaimed{
            grant_id       : v0,
            tier_index     : v1,
            recipient      : v2,
            amount_claimed : v3,
            timestamp      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TokensClaimed>(v5);
    }

    public fun get_all_grant_ids(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry) : vector<0x2::object::ID> {
        let v0 = GrantStorageKey{dummy_field: false};
        if (!0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::has_managed_data<GrantStorageKey>(arg0, v0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v1 = GrantStorageKey{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_with_package_witness<GrantStorageKey, GrantStorage>(arg0, arg1, v1, 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_version::current()).grant_ids
    }

    public fun is_canceled<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : bool {
        arg0.canceled
    }

    public fun new_cancel_grant(arg0: 0x2::object::ID) : CancelGrantAction {
        CancelGrantAction{grant_id: arg0}
    }

    public fun new_create_oracle_grant<T0, T1>(arg0: 0x1::string::String, arg1: vector<TierSpec>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: 0x1::string::String, arg8: u64) : CreateOracleGrantAction<T0, T1> {
        CreateOracleGrantAction<T0, T1>{
            mint_cap_resource_name       : arg0,
            tier_specs                   : arg1,
            use_relative_pricing         : arg2,
            launchpad_multiplier         : arg3,
            earliest_execution_offset_ms : arg4,
            expiry_years                 : arg5,
            cancelable                   : arg6,
            description                  : arg7,
            twap_window_ms               : arg8,
        }
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

    fun register_grant(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: bool) {
        let v0 = GrantStorageKey{dummy_field: false};
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::borrow_managed_data_mut_with_package_witness<GrantStorageKey, GrantStorage>(arg0, arg1, v0, 0xfabcfa08e80041d07da61540451725deddad5996952b8b6e2e295c50be3417c2::oracle_version::current());
        let v2 = GrantInfo{
            recipient  : @0x0,
            cancelable : arg3,
        };
        0x2::table::add<0x2::object::ID, GrantInfo>(&mut v1.grants, arg2, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut v1.grant_ids, arg2);
        v1.total_grants = v1.total_grants + 1;
    }

    public fun relative_to_absolute_threshold(arg0: u128, arg1: u64) : u128 {
        safe_mul_div(arg0, (arg1 as u128), (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128))
    }

    fun safe_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 24);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun tier_count<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : u64 {
        0x1::vector::length<PriceTier>(&arg0.tiers)
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

    public fun total_amount<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : u64 {
        arg0.total_amount
    }

    public fun twap_window_ms<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : u64 {
        arg0.twap_window_ms
    }

    fun validate_claim_eligibility<T0, T1>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: &PriceBasedMintGrant<T0, T1>, arg3: &0x2::clock::Clock) {
        assert!(arg2.dao_id == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg0), 19);
        assert_not_dissolving(arg0, arg1);
        assert!(!arg2.canceled, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (0x1::option::is_some<u64>(&arg2.earliest_execution)) {
            assert!(v0 >= *0x1::option::borrow<u64>(&arg2.earliest_execution), 14);
        };
        if (0x1::option::is_some<u64>(&arg2.latest_execution)) {
            assert!(v0 <= *0x1::option::borrow<u64>(&arg2.latest_execution), 15);
        };
    }

    fun validate_price_conditions_with_enforcement<T0, T1, T2>(arg0: LaunchpadEnforcement, arg1: bool, arg2: &PriceTier, arg3: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::PCW_TWAP_oracle::get_window_twap(0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::get_simple_twap<T0, T1, T2>(arg3), arg4, arg5);
        assert!(0x1::option::is_some<u128>(&v0), 28);
        let v1 = *0x1::option::borrow<u128>(&v0);
        if (0x1::option::is_some<PriceCondition>(&arg2.price_condition)) {
            let v2 = 0x1::option::borrow<PriceCondition>(&arg2.price_condition);
            let v3 = if (arg1) {
                assert!(arg0.launchpad_price > 0, 3);
                safe_mul_div(arg0.launchpad_price, v2.threshold, (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128))
            } else {
                v2.threshold
            };
            let v4 = PriceCondition{
                threshold : v3,
                is_above  : v2.is_above,
            };
            assert!(check_price_condition(&v4, v1), 2);
        };
        if (arg1 && arg0.enabled) {
            assert!(v1 >= safe_mul_div(arg0.launchpad_price, (arg0.minimum_multiplier as u128), (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::price_precision_scale() as u128)), 3);
        };
    }

    fun validate_spot_pool<T0, T1, T2>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>) {
        let v0 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::get_spot_pool_id(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg0));
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 26);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1), 26);
    }

    // decompiled from Move bytecode v6
}

