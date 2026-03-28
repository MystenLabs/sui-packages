module 0x32707d2af1f314007843523cb0b5f32aa9f39595778f7f69c6af693d4af7fdac::oracle_actions {
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

    struct ClaimGrantAction<phantom T0, phantom T1> has drop, store {
        grant_id: 0x2::object::ID,
        tier_index: u64,
        recipient: address,
        claimable_amount: u64,
        dao_address: address,
    }

    struct ClaimGrantRequest<phantom T0, phantom T1> {
        inner: 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::resource_requests::ResourceRequest<ClaimGrantAction<T0, T1>>,
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

    public fun absolute_price_condition(arg0: u128, arg1: bool) : PriceCondition {
        PriceCondition{
            threshold : arg0,
            is_above  : arg1,
        }
    }

    fun assert_not_dissolving(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) {
        assert!(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::operational_state(0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::dao_state(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg0))) != 1, 10);
    }

    fun cancel_grant_internal<T0, T1>(arg0: &mut PriceBasedMintGrant<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.cancelable, 11);
        assert!(!arg0.canceled, 6);
        arg0.canceled = true;
        let v0 = GrantCanceled{
            grant_id  : 0x2::object::id<PriceBasedMintGrant<T0, T1>>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<GrantCanceled>(v0);
    }

    fun check_price_condition(arg0: &PriceCondition, arg1: u128) : bool {
        arg0.is_above && arg1 >= arg0.threshold || arg1 <= arg0.threshold
    }

    public fun claim_grant<T0, T1, T2>(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &mut PriceBasedMintGrant<T0, T1>, arg3: u64, arg4: address, arg5: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : ClaimGrantRequest<T0, T1> {
        validate_claim_eligibility<T0, T1>(arg0, arg1, arg2, arg6);
        validate_spot_pool<T0, T1, T2>(arg0, arg5);
        assert!(arg3 < 0x1::vector::length<PriceTier>(&arg2.tiers), 0);
        let v0 = 0x1::vector::borrow_mut<PriceTier>(&mut arg2.tiers, arg3);
        let (v1, v2) = find_recipient_allocation(v0, arg4);
        assert!(!*0x1::vector::borrow<bool>(&v0.executed, v1), 17);
        validate_price_conditions_with_enforcement<T0, T1, T2>(arg2.launchpad_enforcement, arg2.use_relative_pricing, v0, arg5, arg2.twap_window_ms, arg6);
        *0x1::vector::borrow_mut<bool>(&mut v0.executed, v1) = true;
        let v3 = ClaimGrantAction<T0, T1>{
            grant_id         : 0x2::object::id<PriceBasedMintGrant<T0, T1>>(arg2),
            tier_index       : arg3,
            recipient        : arg4,
            claimable_amount : v2,
            dao_address      : 0x2::object::id_to_address(&arg2.dao_id),
        };
        ClaimGrantRequest<T0, T1>{inner: 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::resource_requests::new_resource_request<ClaimGrantAction<T0, T1>>(v3, arg7)}
    }

    fun convert_tier_specs_to_price_tiers(arg0: &vector<TierSpec>) : vector<PriceTier> {
        let v0 = 0x1::vector::empty<PriceTier>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<TierSpec>(arg0)) {
            let v2 = 0x1::vector::borrow<TierSpec>(arg0, v1);
            let v3 = 0x1::vector::length<RecipientMint>(&v2.recipients);
            assert!(v3 <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::max_recipients_per_tier(), 21);
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
                assert!(v8.amount > 0, 0);
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

    public(friend) fun create_grant<T0, T1>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: vector<PriceTier>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::string::String, arg9: 0x2::object::ID, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<PriceTier>(&arg2) > 0, 18);
        assert!(0x1::vector::length<PriceTier>(&arg2) <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::max_oracle_tiers(), 0);
        assert!(arg9 == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg0), 19);
        assert!(arg10 >= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::one_week_ms() && arg10 <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::ninety_days_ms(), 27);
        let v0 = 0x2::clock::timestamp_ms(arg11);
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
            assert!(v6 <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::max_recipients_per_tier(), 21);
            while (v5 < v6) {
                v1 = v1 + 0x1::vector::borrow<RecipientMint>(&v4.recipients, v5).amount;
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 0);
        let v7 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_launchpad_initial_price(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg0));
        let v8 = if (0x1::option::is_some<u128>(&v7)) {
            *0x1::option::borrow<u128>(&v7)
        } else {
            0
        };
        if (arg3) {
            assert!(v8 > 0, 3);
            assert!(arg4 <= 1000000000000000000, 29);
            let v9 = 340282366920938463463374607431768211455 * ((0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::price_precision_scale() as u128) as u256);
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
            assert!(arg5 <= 0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::ten_years_ms(), 9);
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
        let v20 = 0x2::object::new(arg12);
        let v21 = 0x2::object::uid_to_inner(&v20);
        let v22 = GrantCreated{
            grant_id     : v21,
            total_amount : v1,
            tier_count   : v3,
            timestamp    : v0,
        };
        0x2::event::emit<GrantCreated>(v22);
        let v23 = LaunchpadEnforcement{
            enabled            : arg4 > 0,
            minimum_multiplier : arg4,
            launchpad_price    : v8,
        };
        let v24 = PriceBasedMintGrant<T0, T1>{
            id                    : v20,
            tiers                 : arg2,
            total_amount          : v1,
            use_relative_pricing  : arg3,
            launchpad_enforcement : v23,
            earliest_execution    : v15,
            latest_execution      : v19,
            cancelable            : arg7,
            canceled              : false,
            description           : arg8,
            created_at            : v0,
            dao_id                : arg9,
            twap_window_ms        : arg10,
        };
        0x2::transfer::share_object<PriceBasedMintGrant<T0, T1>>(v24);
        ensure_grant_storage(arg0, arg1, arg12);
        register_grant(arg0, arg1, v21, arg7);
        v21
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

    public fun do_cancel_grant<T0, T1, T2: store, T3: drop>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T2>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: T3, arg4: &mut PriceBasedMintGrant<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        let v1 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T2>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T2>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T2>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<CancelGrant<T0, T1>>(v1);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v1) == 1, 20);
        let v2 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v1));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v2);
        let v3 = 0x2::object::id<PriceBasedMintGrant<T0, T1>>(arg4);
        assert!(0x2::object::id_to_address(&v3) == 0x2::bcs::peel_address(&mut v2), 16);
        assert!(arg4.dao_id == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1), 19);
        assert_not_dissolving(arg1, arg2);
        cancel_grant_internal<T0, T1>(arg4, arg5);
        let v4 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T2, CancelGrant<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v4);
    }

    public fun do_create_oracle_grant<T0, T1, T2: store, T3: drop>(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::Executable<T2>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: T3, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::assert_execution_authorized<T2, ExecutionProgressWitness>(arg1, arg2, arg0, v0);
        assert_not_dissolving(arg1, arg2);
        ensure_grant_storage(arg1, arg2, arg5);
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg1);
        let v2 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::stable_type(v1);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == *0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::asset_type(v1), 30);
        assert!(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())) == *v2, 31);
        let v3 = 0x1::vector::borrow<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::ActionSpec>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_specs<T2>(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::intent<T2>(arg0)), 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::action_idx<T2>(arg0));
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_validation::assert_action_type<CreateOracleGrant<T0, T1>>(v3);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_version(v3) == 1, 20);
        let v4 = 0x2::bcs::new(*0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::intents::action_spec_data(v3));
        let v5 = &mut v4;
        let v6 = deserialize_tier_specs(v5);
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::bcs_validation::validate_all_bytes_consumed(v4);
        let v7 = 0x1::string::try_utf8(0x2::bcs::peel_vec_u8(&mut v4));
        assert!(0x1::option::is_some<0x1::string::String>(&v7), 32);
        let v8 = 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg1);
        create_grant<T0, T1>(arg1, arg2, convert_tier_specs_to_price_tiers(&v6), 0x2::bcs::peel_bool(&mut v4), 0x2::bcs::peel_u64(&mut v4), 0x2::bcs::peel_u64(&mut v4), 0x2::bcs::peel_u64(&mut v4), 0x2::bcs::peel_bool(&mut v4), 0x1::option::destroy_some<0x1::string::String>(v7), v8, 0x2::bcs::peel_u64(&mut v4), arg4, arg5);
        let v9 = ExecutionProgressWitness{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::executable::increment_action_idx<T2, CreateOracleGrant<T0, T1>, ExecutionProgressWitness>(arg0, arg2, v9);
    }

    fun ensure_grant_storage(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GrantStorageKey{dummy_field: false};
        if (!0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::has_managed_data<GrantStorageKey>(arg0, v0)) {
            let v1 = GrantStorageKey{dummy_field: false};
            let v2 = GrantStorage{
                grants       : 0x2::table::new<0x2::object::ID, GrantInfo>(arg2),
                grant_ids    : 0x1::vector::empty<0x2::object::ID>(),
                total_grants : 0,
            };
            0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::add_managed_data_with_package_witness<GrantStorageKey, GrantStorage>(arg0, arg1, v1, v2, 0x32707d2af1f314007843523cb0b5f32aa9f39595778f7f69c6af693d4af7fdac::oracle_version::current());
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
        assert!(v1 < 0x1::vector::length<bool>(&arg0.executed), 0);
        (v1, v0)
    }

    public fun fulfill_claim_grant_from_account<T0, T1>(arg0: ClaimGrantRequest<T0, T1>, arg1: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg2: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let ClaimGrantRequest { inner: v0 } = arg0;
        let v1 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::resource_requests::extract_action<ClaimGrantAction<T0, T1>>(v0);
        assert!(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::addr(arg1) == v1.dao_address, 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x88ef34a7087d4713deabe0ac6807a06558bac9169c29baa652e31275ebb2ea88::currency::mint_with_package_witness<T0>(arg1, arg2, v1.claimable_amount, 0x32707d2af1f314007843523cb0b5f32aa9f39595778f7f69c6af693d4af7fdac::oracle_version::current(), arg4), v1.recipient);
        let v2 = TokensClaimed{
            grant_id       : v1.grant_id,
            tier_index     : v1.tier_index,
            recipient      : v1.recipient,
            amount_claimed : v1.claimable_amount,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokensClaimed>(v2);
    }

    public fun get_all_grant_ids(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry) : vector<0x2::object::ID> {
        let v0 = GrantStorageKey{dummy_field: false};
        if (!0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::has_managed_data<GrantStorageKey>(arg0, v0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v1 = GrantStorageKey{dummy_field: false};
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::borrow_managed_data_with_package_witness<GrantStorageKey, GrantStorage>(arg0, arg1, v1, 0x32707d2af1f314007843523cb0b5f32aa9f39595778f7f69c6af693d4af7fdac::oracle_version::current()).grant_ids
    }

    public fun is_canceled<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : bool {
        arg0.canceled
    }

    public fun new_cancel_grant(arg0: 0x2::object::ID) : CancelGrantAction {
        CancelGrantAction{grant_id: arg0}
    }

    public fun new_create_oracle_grant<T0, T1>(arg0: vector<TierSpec>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::string::String, arg7: u64) : CreateOracleGrantAction<T0, T1> {
        CreateOracleGrantAction<T0, T1>{
            tier_specs                   : arg0,
            use_relative_pricing         : arg1,
            launchpad_multiplier         : arg2,
            earliest_execution_offset_ms : arg3,
            expiry_years                 : arg4,
            cancelable                   : arg5,
            description                  : arg6,
            twap_window_ms               : arg7,
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

    fun register_grant(arg0: &mut 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: 0x2::object::ID, arg3: bool) {
        let v0 = GrantStorageKey{dummy_field: false};
        let v1 = 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::borrow_managed_data_mut_with_package_witness<GrantStorageKey, GrantStorage>(arg0, arg1, v0, 0x32707d2af1f314007843523cb0b5f32aa9f39595778f7f69c6af693d4af7fdac::oracle_version::current());
        let v2 = GrantInfo{
            recipient  : @0x0,
            cancelable : arg3,
        };
        0x2::table::add<0x2::object::ID, GrantInfo>(&mut v1.grants, arg2, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut v1.grant_ids, arg2);
        v1.total_grants = v1.total_grants + 1;
    }

    public fun relative_to_absolute_threshold(arg0: u128, arg1: u64) : u128 {
        safe_mul_div(arg0, (arg1 as u128), (0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::price_precision_scale() as u128))
    }

    fun safe_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 24);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun tier_count<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : u64 {
        0x1::vector::length<PriceTier>(&arg0.tiers)
    }

    public fun total_amount<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : u64 {
        arg0.total_amount
    }

    public fun twap_window_ms<T0, T1>(arg0: &PriceBasedMintGrant<T0, T1>) : u64 {
        arg0.twap_window_ms
    }

    fun validate_claim_eligibility<T0, T1>(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::package_registry::PackageRegistry, arg2: &PriceBasedMintGrant<T0, T1>, arg3: &0x2::clock::Clock) {
        assert!(arg2.dao_id == 0x2::object::id<0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account>(arg0), 19);
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

    fun validate_price_conditions_with_enforcement<T0, T1, T2>(arg0: LaunchpadEnforcement, arg1: bool, arg2: &PriceTier, arg3: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::PCW_TWAP_oracle::get_window_twap(0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_simple_twap<T0, T1, T2>(arg3), arg4, arg5);
        assert!(0x1::option::is_some<u128>(&v0), 28);
        let v1 = *0x1::option::borrow<u128>(&v0);
        if (0x1::option::is_some<PriceCondition>(&arg2.price_condition)) {
            let v2 = 0x1::option::borrow<PriceCondition>(&arg2.price_condition);
            let v3 = if (arg1) {
                assert!(arg0.launchpad_price > 0, 3);
                safe_mul_div(arg0.launchpad_price, v2.threshold, (0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::price_precision_scale() as u128))
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
            assert!(v1 >= safe_mul_div(arg0.launchpad_price, (arg0.minimum_multiplier as u128), (0x9770f391e82370d06c368c058fd9d6fad5ab036b29b2efd823a8de2c84317e0c::constants::price_precision_scale() as u128)), 3);
        };
    }

    fun validate_spot_pool<T0, T1, T2>(arg0: &0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::Account, arg1: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>) {
        let v0 = 0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::get_spot_pool_id(0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::account::config<0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::futarchy_config::FutarchyConfig>(arg0));
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 26);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1), 26);
    }

    // decompiled from Move bytecode v6
}

