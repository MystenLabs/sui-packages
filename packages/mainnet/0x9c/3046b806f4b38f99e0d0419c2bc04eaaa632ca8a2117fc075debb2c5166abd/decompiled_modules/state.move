module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::state {
    struct FeeParams has copy, drop, store {
        performance_fee_bps: u64,
        management_fee_bps: u64,
        withdrawal_fee_bps: u64,
    }

    struct StateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        lp_decimals: u64,
        type_names: vector<0x1::type_name::TypeName>,
        decimals: vector<u64>,
        deposit_caps: vector<u64>,
        total_deposits: vector<u64>,
        idle_liquidity: vector<u64>,
        active_liquidity: vector<vector<u64>>,
        cache_staleness_threshold_ms: u64,
        last_cache_update_timestamp_ms: u64,
        price_feed_storages: vector<0x2::object::ID>,
        staleness_thresholds_ms: vector<u64>,
        fee_params: FeeParams,
        extensions: vector<0x1::type_name::TypeName>,
        whitelisted_depositors: vector<address>,
        withdraw_queue: vector<WithdrawTicket<T0>>,
        force_withdraw_delay_ms: u64,
        lock_duration_ms: u64,
        active_assistant: 0x2::object::ID,
    }

    struct WithdrawTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        lp_coin: 0x2::coin::Coin<T0>,
        coin_out_type: 0x1::type_name::TypeName,
        recipient: address,
        request_timestamp_ms: u64,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : StateV1<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        let v0 = StateV1<T0>{
            id                             : 0x2::object::new(arg7),
            vault_id                       : arg0,
            treasury                       : arg1,
            lp_decimals                    : (0x2::coin::get_decimals<T0>(&arg2) as u64),
            type_names                     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            decimals                       : vector[],
            deposit_caps                   : vector[],
            total_deposits                 : vector[],
            idle_liquidity                 : vector[],
            active_liquidity               : vector[],
            cache_staleness_threshold_ms   : arg5,
            last_cache_update_timestamp_ms : 0x2::clock::timestamp_ms(arg6),
            price_feed_storages            : 0x1::vector::empty<0x2::object::ID>(),
            staleness_thresholds_ms        : vector[],
            fee_params                     : default(),
            extensions                     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            whitelisted_depositors         : vector[],
            withdraw_queue                 : 0x1::vector::empty<WithdrawTicket<T0>>(),
            force_withdraw_delay_ms        : arg3,
            lock_duration_ms               : arg4,
            active_assistant               : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        v0
    }

    public(friend) fun vault_id<T0>(arg0: &StateV1<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun active_liquidity<T0>(arg0: &StateV1<T0>) : vector<vector<u64>> {
        arg0.active_liquidity
    }

    public(friend) fun active_liquidity_of_type<T0, T1>(arg0: &StateV1<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                return if (0x1::option::is_some<u64>(&v3)) {
                    let v5 = 0;
                    let v6 = *0x1::vector::borrow<vector<u64>>(&arg0.active_liquidity, 0x1::option::extract<u64>(&mut v3));
                    0x1::vector::reverse<u64>(&mut v6);
                    let v7 = 0;
                    while (v7 < 0x1::vector::length<u64>(&v6)) {
                        v5 = v5 + 0x1::vector::pop_back<u64>(&mut v6);
                        v7 = v7 + 1;
                    };
                    0x1::vector::destroy_empty<u64>(v6);
                    v5
                } else {
                    0
                }
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun add_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: T2, arg3: T3, arg4: &mut 0x2::tx_context::TxContext) {
        assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        assert!(!supports_extension<T0, T2>(arg0, arg2), 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.type_names)) {
            0x1::vector::push_back<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.active_liquidity, v0), 0);
            v0 = v0 + 1;
        };
        let v1 = 0x1::type_name::get<T2>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.extensions, v1);
        0x2::dynamic_object_field::add<T2, T3>(&mut arg0.id, arg2, arg3);
        0x2::dynamic_object_field::add<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::ExtensionMetadataKey, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::metadata::ExtensionMetadataV1>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_extension_metadata_key(v1), 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::metadata::default_extension_metadata(0x2::object::uid_to_inner(&arg0.id), size<T0>(arg0), arg4));
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_add_extension_event(0x2::object::uid_to_inner(&arg0.id), v1);
    }

    public(friend) fun add_yield<T0, T1>(arg0: &mut StateV1<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_deposits, v4);
                let v6 = 0x2::coin::value<T1>(&arg1);
                assert!(*v5 + v6 <= *0x1::vector::borrow<u64>(&arg0.deposit_caps, v4), 8);
                0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v0)), arg1);
                *v5 = *v5 + v6;
                *0x1::vector::borrow_mut<u64>(&mut arg0.idle_liquidity, v4) = *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v4) + v6;
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun allow_deposits_of_type<T0, T1, T2>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg3: &0x2::coin::CoinMetadata<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::get<T2>();
        assert!(!supports_type_name<T0>(arg0, &v0), 3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.type_names, v0);
        0x1::vector::push_back<u64>(&mut arg0.decimals, (0x2::coin::get_decimals<T2>(arg3) as u64));
        0x1::vector::push_back<u64>(&mut arg0.deposit_caps, 18446744073709551615);
        0x1::vector::push_back<u64>(&mut arg0.total_deposits, 0);
        0x1::vector::push_back<u64>(&mut arg0.idle_liquidity, 0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.extensions)) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<vector<u64>>(&mut arg0.active_liquidity, v1);
        0x2::dynamic_object_field::add<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T2>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v0), 0x2::coin::zero<T2>(arg5));
        0x2::dynamic_object_field::add<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::FeeKey, 0x2::coin::Coin<T2>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_fee_key(v0), 0x2::coin::zero<T2>(arg5));
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.price_feed_storages, 0x2::object::id<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>(arg2));
        0x1::vector::push_back<u64>(&mut arg0.staleness_thresholds_ms, arg4);
        let v3 = arg0.extensions;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::metadata::append_vector_fields_with_defaults(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::ExtensionMetadataKey, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::metadata::ExtensionMetadataV1>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_extension_metadata_key(0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3))));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_allow_deposits_of_type_event<T0, T2>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>(arg2), arg4);
    }

    public(friend) fun assert_can_be_mutated_by<T0, T1>(arg0: &StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::vault_id<T1>(arg1) == arg0.vault_id && (0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::is_admin(v0) || 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>>(arg1)), 1);
    }

    public(friend) fun begin_force_withdraw<T0, T1>(arg0: &mut StateV1<T0>, arg1: 0x2::object::ID, arg2: &vector<u256>, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u256, u64, address) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = &mut arg0.withdraw_queue;
                let v6 = 0;
                let v7;
                while (v6 < 0x1::vector::length<WithdrawTicket<T0>>(v5)) {
                    if (0x2::object::id<WithdrawTicket<T0>>(0x1::vector::borrow<WithdrawTicket<T0>>(v5, v6)) == arg1) {
                        v7 = 0x1::option::some<u64>(v6);
                        /* label 13 */
                        if (0x1::option::is_none<u64>(&v7)) {
                            abort 11
                        };
                        let v8 = 0x1::vector::remove<WithdrawTicket<T0>>(v5, 0x1::option::extract<u64>(&mut v7));
                        assert!(v8.request_timestamp_ms + arg0.force_withdraw_delay_ms <= 0x2::clock::timestamp_ms(arg4), 12);
                        assert!(v8.coin_out_type == v0, 10);
                        let WithdrawTicket {
                            id                   : v9,
                            lp_coin              : v10,
                            coin_out_type        : _,
                            recipient            : _,
                            request_timestamp_ms : _,
                        } = v8;
                        0x2::object::delete(v9);
                        let v14 = v10;
                        let v15 = *0x1::vector::borrow<u256>(arg2, v4);
                        let v16 = 0x2::coin::value<T0>(&v14);
                        let v17 = arg0.lp_decimals;
                        let v18 = if (v17 == 18) {
                            (v16 as u256)
                        } else if (v17 < 18) {
                            (v16 as u256) * 0x1::u256::pow(10, ((18 - v17) as u8))
                        } else {
                            (v16 as u256) / 0x1::u256::pow(10, ((v17 - 18) as u8))
                        };
                        let v19 = if (v17 == 18) {
                            (0x2::coin::total_supply<T0>(&arg0.treasury) as u256)
                        } else if (v17 < 18) {
                            (0x2::coin::total_supply<T0>(&arg0.treasury) as u256) * 0x1::u256::pow(10, ((18 - v17) as u8))
                        } else {
                            (0x2::coin::total_supply<T0>(&arg0.treasury) as u256) / 0x1::u256::pow(10, ((v17 - 18) as u8))
                        };
                        let v20 = *0x1::vector::borrow<u64>(&arg0.decimals, v4);
                        let v21 = if (v20 == 18) {
                            v18 * arg3 / v19 * 1000000000000000000 / v15
                        } else if (v20 < 18) {
                            v18 * arg3 / v19 * 1000000000000000000 / v15 / 0x1::u256::pow(10, ((18 - v20) as u8))
                        } else {
                            v18 * arg3 / v19 * 1000000000000000000 / v15 * 0x1::u256::pow(10, ((v20 - 18) as u8))
                        };
                        let v22 = (v21 as u64);
                        let v23 = idle_liquidity_of_type<T0, T1>(arg0);
                        let v24 = if (v23 > 0) {
                            let v25 = 0x1::u64::min(v23, v22);
                            *0x1::vector::borrow_mut<u64>(&mut arg0.total_deposits, v4) = *0x1::vector::borrow<u64>(&arg0.total_deposits, v4) - v25;
                            *0x1::vector::borrow_mut<u64>(&mut arg0.idle_liquidity, v4) = *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v4) - v25;
                            0x2::coin::split<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v0)), v25, arg5)
                        } else {
                            0x2::coin::zero<T1>(arg5)
                        };
                        let v26 = if (v20 == 18) {
                            (v22 as u256)
                        } else if (v20 < 18) {
                            (v22 as u256) * 0x1::u256::pow(10, ((18 - v20) as u8))
                        } else {
                            (v22 as u256) / 0x1::u256::pow(10, ((v20 - 18) as u8))
                        };
                        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_force_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg1, v16, v22);
                        return (v14, v24, v22, v26 * v15 / 1000000000000000000, v4, v8.recipient)
                    };
                    v6 = v6 + 1;
                };
                v7 = 0x1::option::none<u64>();
                /* goto 13 */
            } else {
                v2 = v2 + 1;
            };
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun begin_session_tx<T0>(arg0: &StateV1<T0>, arg1: &vector<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>, arg2: &0x2::clock::Clock) : (vector<u256>, u256) {
        assert!(arg0.cache_staleness_threshold_ms != 0, 14);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.last_cache_update_timestamp_ms + arg0.cache_staleness_threshold_ms, 15);
        derive_prices_and_calculate_total_value<T0>(arg0, arg1, arg2)
    }

    public(friend) fun begin_update_liquidity_cache_tx<T0>(arg0: &StateV1<T0>) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>, vector<vector<u64>>) {
        (arg0.type_names, arg0.extensions, arg0.active_liquidity)
    }

    public(friend) fun borrow_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &StateV1<T0>, arg1: T1) : &T2 {
        assert!(0x2::dynamic_object_field::exists_<T1>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow<T1, T2>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut_extension<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut StateV1<T0>, arg1: T1) : &mut T2 {
        assert!(0x2::dynamic_object_field::exists_<T1>(&arg0.id, arg1), 4);
        0x2::dynamic_object_field::borrow_mut<T1, T2>(&mut arg0.id, arg1)
    }

    public(friend) fun cache_staleness_threshold_ms<T0>(arg0: &StateV1<T0>) : u64 {
        arg0.cache_staleness_threshold_ms
    }

    fun calculate_total_value<T0>(arg0: &StateV1<T0>, arg1: &vector<u256>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.type_names)) {
            let v2 = 0;
            let v3 = *0x1::vector::borrow<vector<u64>>(&arg0.active_liquidity, v1);
            0x1::vector::reverse<u64>(&mut v3);
            let v4 = 0;
            while (v4 < 0x1::vector::length<u64>(&v3)) {
                v2 = v2 + 0x1::vector::pop_back<u64>(&mut v3);
                v4 = v4 + 1;
            };
            0x1::vector::destroy_empty<u64>(v3);
            let v5 = *0x1::vector::borrow<u64>(&arg0.decimals, v1);
            let v6 = if (v5 == 18) {
                ((*0x1::vector::borrow<u64>(&arg0.idle_liquidity, v1) + v2) as u256)
            } else if (v5 < 18) {
                ((*0x1::vector::borrow<u64>(&arg0.idle_liquidity, v1) + v2) as u256) * 0x1::u256::pow(10, ((18 - v5) as u8))
            } else {
                ((*0x1::vector::borrow<u64>(&arg0.idle_liquidity, v1) + v2) as u256) / 0x1::u256::pow(10, ((v5 - 18) as u8))
            };
            v0 = v0 + v6 * *0x1::vector::borrow<u256>(arg1, v1) / 1000000000000000000;
            v1 = v1 + 1;
        };
        v0
    }

    fun default() : FeeParams {
        FeeParams{
            performance_fee_bps : 0,
            management_fee_bps  : 0,
            withdrawal_fee_bps  : 0,
        }
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut StateV1<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &vector<u256>, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xc2f79696c4b1fa4625b0bcc143abdaf96f082fcdb7751a0d72144503b4a5bbbb::locked::Locked<0x2::coin::Coin<T0>>, u256) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = 0x2::coin::value<T1>(&arg1);
                0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v0)), arg1);
                *0x1::vector::borrow_mut<u64>(&mut arg0.idle_liquidity, v4) = *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v4) + v5;
                let v6 = 0x2::tx_context::sender(arg5);
                assert!(depositor_is_whitelisted<T0>(arg0, &v6), 16);
                let v7 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_deposits, v4);
                assert!(*v7 + v5 <= *0x1::vector::borrow<u64>(&arg0.deposit_caps, v4), 8);
                let v8 = *0x1::vector::borrow<u64>(&arg0.decimals, v4);
                let v9 = if (v8 == 18) {
                    (v5 as u256)
                } else if (v8 < 18) {
                    (v5 as u256) * 0x1::u256::pow(10, ((18 - v8) as u8))
                } else {
                    (v5 as u256) / 0x1::u256::pow(10, ((v8 - 18) as u8))
                };
                let v10 = v9 * *0x1::vector::borrow<u256>(arg2, v4) / 1000000000000000000;
                let v11 = 0x2::coin::total_supply<T0>(&arg0.treasury);
                let v12 = arg0.lp_decimals;
                let v13 = if (v11 == 0) {
                    let v14 = if (v12 == 18) {
                        v9
                    } else if (v12 < 18) {
                        v9 / 0x1::u256::pow(10, ((18 - v12) as u8))
                    } else {
                        v9 * 0x1::u256::pow(10, ((v12 - 18) as u8))
                    };
                    (v14 as u64)
                } else {
                    let v15 = if (v12 == 18) {
                        (v11 as u256)
                    } else if (v12 < 18) {
                        (v11 as u256) * 0x1::u256::pow(10, ((18 - v12) as u8))
                    } else {
                        (v11 as u256) / 0x1::u256::pow(10, ((v12 - 18) as u8))
                    };
                    let v16 = if (v12 == 18) {
                        v10 * v15 / arg3
                    } else if (v12 < 18) {
                        v10 * v15 / arg3 / 0x1::u256::pow(10, ((18 - v12) as u8))
                    } else {
                        v10 * v15 / arg3 * 0x1::u256::pow(10, ((v12 - 18) as u8))
                    };
                    (v16 as u64)
                };
                assert!(v13 > 0, 13);
                *v7 = *v7 + v5;
                0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_deposit_event<T0>(0x2::object::uid_to_inner(&arg0.id), v13, 0x1::type_name::into_string(v0), v5);
                return (0xc2f79696c4b1fa4625b0bcc143abdaf96f082fcdb7751a0d72144503b4a5bbbb::locked::lock<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury, v13, arg5), arg4, arg0.lock_duration_ms, arg5), v10)
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun deposit_cap<T0, T1>(arg0: &StateV1<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                return if (0x1::option::is_some<u64>(&v3)) {
                    *0x1::vector::borrow<u64>(&arg0.deposit_caps, 0x1::option::extract<u64>(&mut v3))
                } else {
                    0
                }
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun deposit_funds<T0, T1, T2: copy + drop + store>(arg0: &mut StateV1<T0>, arg1: T2, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::get<T2>();
        let v1 = &arg0.extensions;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 4
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = 0x1::type_name::get<T1>();
                let v6 = &arg0.type_names;
                let v7 = 0;
                let v8;
                while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
                    if (0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7) == &v5) {
                        v8 = 0x1::option::some<u64>(v7);
                        /* label 15 */
                        if (0x1::option::is_none<u64>(&v8)) {
                            abort 2
                        };
                        let v9 = 0x1::option::extract<u64>(&mut v8);
                        let v10 = 0x2::coin::value<T1>(&arg2);
                        0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v5)), arg2);
                        *0x1::vector::borrow_mut<u64>(&mut arg0.idle_liquidity, v9) = *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v9) + v10;
                        *0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.active_liquidity, v9), v4) = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.active_liquidity, v9), v4) - v10;
                        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_withdraw_funds_from_extension_event<T1>(0x2::object::uid_to_inner(&arg0.id), v0, v10);
                        return
                    };
                    v7 = v7 + 1;
                };
                v8 = 0x1::option::none<u64>();
                /* goto 15 */
            } else {
                v2 = v2 + 1;
            };
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun depositor_is_whitelisted<T0>(arg0: &StateV1<T0>, arg1: &address) : bool {
        0x1::vector::is_empty<address>(&arg0.whitelisted_depositors) || 0x1::vector::contains<address>(&arg0.whitelisted_depositors, arg1)
    }

    fun derive_prices<T0>(arg0: &StateV1<T0>, arg1: &vector<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>, arg2: &0x2::clock::Clock) : vector<u256> {
        derive_prices_dummy<T0>(arg0)
    }

    fun derive_prices_and_calculate_total_value<T0>(arg0: &StateV1<T0>, arg1: &vector<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>, arg2: &0x2::clock::Clock) : (vector<u256>, u256) {
        let v0 = derive_prices<T0>(arg0, arg1, arg2);
        (v0, calculate_total_value<T0>(arg0, &v0))
    }

    fun derive_prices_dummy<T0>(arg0: &StateV1<T0>) : vector<u256> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < size<T0>(arg0)) {
            0x1::vector::push_back<u256>(&mut v0, 1000000000000000000);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun end_update_liquidity_cache_and_begin_session_tx<T0>(arg0: &mut StateV1<T0>, arg1: vector<vector<u64>>, arg2: &vector<0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage>, arg3: &0x2::clock::Clock) : (vector<u256>, u256) {
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.last_cache_update_timestamp_ms + arg0.cache_staleness_threshold_ms, 15);
        end_update_liquidity_cache_tx<T0>(arg0, arg1, arg3);
        derive_prices_and_calculate_total_value<T0>(arg0, arg2, arg3)
    }

    public(friend) fun end_update_liquidity_cache_tx<T0>(arg0: &mut StateV1<T0>, arg1: vector<vector<u64>>, arg2: &0x2::clock::Clock) {
        arg0.active_liquidity = arg1;
        arg0.last_cache_update_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun extensions<T0>(arg0: &StateV1<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.extensions
    }

    public(friend) fun extensions_size<T0>(arg0: &StateV1<T0>) : u64 {
        0x1::vector::length<0x1::type_name::TypeName>(&arg0.extensions)
    }

    public(friend) fun finish_force_withdraw<T0, T1>(arg0: &mut StateV1<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        let v0 = &mut arg2;
        0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::FeeKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_fee_key(0x1::type_name::get<T1>())), 0x2::coin::split<T1>(v0, (((0x2::coin::value<T1>(v0) as u128) * (arg0.fee_params.withdrawal_fee_bps as u128) / 10000) as u64), arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, arg4);
        *0x1::vector::borrow_mut<u64>(&mut arg0.total_deposits, arg3) = *0x1::vector::borrow<u64>(&arg0.total_deposits, arg3) - 0x2::coin::value<T1>(&arg2);
    }

    public(friend) fun force_deposit_funds_into_extension<T0, T1, T2: copy + drop + store>(arg0: &mut StateV1<T0>, arg1: &T2, arg2: &0x2::coin::Coin<T1>, arg3: &vector<u256>, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xc2f79696c4b1fa4625b0bcc143abdaf96f082fcdb7751a0d72144503b4a5bbbb::locked::Locked<0x2::coin::Coin<T0>>, u256) {
        let v0 = 0x1::type_name::get<T2>();
        let v1 = &arg0.extensions;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 4
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = 0x1::type_name::get<T1>();
                let v6 = &arg0.type_names;
                let v7 = 0;
                let v8;
                while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
                    if (0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7) == &v5) {
                        v8 = 0x1::option::some<u64>(v7);
                        /* label 14 */
                        if (0x1::option::is_none<u64>(&v8)) {
                            abort 2
                        };
                        let v9 = 0x1::option::extract<u64>(&mut v8);
                        let v10 = 0x2::coin::value<T1>(arg2);
                        *0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.active_liquidity, v9), v4) = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.active_liquidity, v9), v4) + v10;
                        let v11 = 0x2::tx_context::sender(arg6);
                        assert!(depositor_is_whitelisted<T0>(arg0, &v11), 16);
                        let v12 = 0x1::vector::borrow_mut<u64>(&mut arg0.total_deposits, v9);
                        assert!(*v12 + v10 <= *0x1::vector::borrow<u64>(&arg0.deposit_caps, v9), 8);
                        let v13 = *0x1::vector::borrow<u64>(&arg0.decimals, v9);
                        let v14 = if (v13 == 18) {
                            (v10 as u256)
                        } else if (v13 < 18) {
                            (v10 as u256) * 0x1::u256::pow(10, ((18 - v13) as u8))
                        } else {
                            (v10 as u256) / 0x1::u256::pow(10, ((v13 - 18) as u8))
                        };
                        let v15 = v14 * *0x1::vector::borrow<u256>(arg3, v9) / 1000000000000000000;
                        let v16 = 0x2::coin::total_supply<T0>(&arg0.treasury);
                        let v17 = arg0.lp_decimals;
                        let v18 = if (v16 == 0) {
                            let v19 = if (v17 == 18) {
                                v14
                            } else if (v17 < 18) {
                                v14 / 0x1::u256::pow(10, ((18 - v17) as u8))
                            } else {
                                v14 * 0x1::u256::pow(10, ((v17 - 18) as u8))
                            };
                            (v19 as u64)
                        } else {
                            let v20 = if (v17 == 18) {
                                (v16 as u256)
                            } else if (v17 < 18) {
                                (v16 as u256) * 0x1::u256::pow(10, ((18 - v17) as u8))
                            } else {
                                (v16 as u256) / 0x1::u256::pow(10, ((v17 - 18) as u8))
                            };
                            let v21 = if (v17 == 18) {
                                v15 * v20 / arg4
                            } else if (v17 < 18) {
                                v15 * v20 / arg4 / 0x1::u256::pow(10, ((18 - v17) as u8))
                            } else {
                                v15 * v20 / arg4 * 0x1::u256::pow(10, ((v17 - 18) as u8))
                            };
                            (v21 as u64)
                        };
                        assert!(v18 > 0, 13);
                        *v12 = *v12 + v10;
                        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_deposit_event<T0>(0x2::object::uid_to_inner(&arg0.id), v18, 0x1::type_name::into_string(v5), v10);
                        return (0xc2f79696c4b1fa4625b0bcc143abdaf96f082fcdb7751a0d72144503b4a5bbbb::locked::lock<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury, v18, arg6), arg5, arg0.lock_duration_ms, arg6), v15)
                    };
                    v7 = v7 + 1;
                };
                v8 = 0x1::option::none<u64>();
                /* goto 14 */
            } else {
                v2 = v2 + 1;
            };
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun force_withdraw_delay_ms<T0>(arg0: &StateV1<T0>) : u64 {
        arg0.force_withdraw_delay_ms
    }

    public(friend) fun force_withdraw_funds<T0, T1, T2: copy + drop + store>(arg0: &mut StateV1<T0>, arg1: T2, arg2: &0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::get<T2>();
        let v1 = &arg0.extensions;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 4
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = 0x1::type_name::get<T1>();
                let v6 = &arg0.type_names;
                let v7 = 0;
                let v8;
                while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
                    if (0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7) == &v5) {
                        v8 = 0x1::option::some<u64>(v7);
                        /* label 15 */
                        if (0x1::option::is_none<u64>(&v8)) {
                            abort 2
                        };
                        let v9 = 0x1::option::extract<u64>(&mut v8);
                        let v10 = 0x2::coin::value<T1>(arg2);
                        *0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.active_liquidity, v9), v4) = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.active_liquidity, v9), v4) - v10;
                        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_withdraw_funds_from_extension_event<T1>(0x2::object::uid_to_inner(&arg0.id), v0, v10);
                        return
                    };
                    v7 = v7 + 1;
                };
                v8 = 0x1::option::none<u64>();
                /* goto 15 */
            } else {
                v2 = v2 + 1;
            };
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun idle_liquidity<T0>(arg0: &StateV1<T0>) : vector<u64> {
        arg0.idle_liquidity
    }

    public(friend) fun idle_liquidity_of_type<T0, T1>(arg0: &StateV1<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                return if (0x1::option::is_some<u64>(&v3)) {
                    *0x1::vector::borrow<u64>(&arg0.idle_liquidity, 0x1::option::extract<u64>(&mut v3))
                } else {
                    0
                }
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun lock_duration_ms<T0>(arg0: &StateV1<T0>) : u64 {
        arg0.lock_duration_ms
    }

    public(friend) fun lp_supply<T0>(arg0: &StateV1<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public(friend) fun management_fee_bps<T0>(arg0: &StateV1<T0>) : u64 {
        arg0.fee_params.management_fee_bps
    }

    public(friend) fun performance_fee_bps<T0>(arg0: &StateV1<T0>) : u64 {
        arg0.fee_params.performance_fee_bps
    }

    public(friend) fun price_feed_storages<T0>(arg0: &StateV1<T0>) : &vector<0x2::object::ID> {
        &arg0.price_feed_storages
    }

    public(friend) fun process_pending_withdraw<T0, T1>(arg0: &mut StateV1<T0>, arg1: &vector<u256>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                assert!(0x1::vector::length<WithdrawTicket<T0>>(&arg0.withdraw_queue) > 0, 9);
                let v5 = 0x1::vector::borrow_mut<WithdrawTicket<T0>>(&mut arg0.withdraw_queue, 0);
                let v6 = v5.recipient;
                let v7 = 0x2::object::uid_to_inner(&v5.id);
                assert!(v5.coin_out_type == v0, 10);
                let v8 = *0x1::vector::borrow<u256>(arg1, v4);
                let v9 = &mut v5.lp_coin;
                let v10 = 0x2::coin::value<T0>(v9);
                let v11 = arg0.lp_decimals;
                let v12 = if (v11 == 18) {
                    (v10 as u256)
                } else if (v11 < 18) {
                    (v10 as u256) * 0x1::u256::pow(10, ((18 - v11) as u8))
                } else {
                    (v10 as u256) / 0x1::u256::pow(10, ((v11 - 18) as u8))
                };
                let v13 = if (v11 == 18) {
                    (0x2::coin::total_supply<T0>(&arg0.treasury) as u256)
                } else if (v11 < 18) {
                    (0x2::coin::total_supply<T0>(&arg0.treasury) as u256) * 0x1::u256::pow(10, ((18 - v11) as u8))
                } else {
                    (0x2::coin::total_supply<T0>(&arg0.treasury) as u256) / 0x1::u256::pow(10, ((v11 - 18) as u8))
                };
                let v14 = *0x1::vector::borrow<u64>(&arg0.decimals, v4);
                let v15 = if (v14 == 18) {
                    v12 * arg2 / v13 * 1000000000000000000 / v8
                } else if (v14 < 18) {
                    v12 * arg2 / v13 * 1000000000000000000 / v8 / 0x1::u256::pow(10, ((18 - v14) as u8))
                } else {
                    v12 * arg2 / v13 * 1000000000000000000 / v8 * 0x1::u256::pow(10, ((v14 - 18) as u8))
                };
                let v16 = (v15 as u64);
                let v17 = 0x1::u64::min(idle_liquidity_of_type<T0, T1>(arg0), v16);
                if (v17 == 0) {
                    return 0
                };
                if (v17 == v16) {
                    let WithdrawTicket {
                        id                   : v18,
                        lp_coin              : v19,
                        coin_out_type        : _,
                        recipient            : _,
                        request_timestamp_ms : _,
                    } = 0x1::vector::remove<WithdrawTicket<T0>>(&mut arg0.withdraw_queue, 0);
                    0x2::object::delete(v18);
                    0x2::coin::burn<T0>(&mut arg0.treasury, v19);
                    0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_process_pending_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v7, v10, v10, v17);
                } else {
                    let v23 = (((v10 as u256) * (v17 as u256) / (v16 as u256)) as u64);
                    0x2::coin::burn<T0>(&mut arg0.treasury, 0x2::coin::split<T0>(v9, v23, arg3));
                    0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_process_pending_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v7, v10, v23, v17);
                };
                let v24 = arg0.fee_params.withdrawal_fee_bps;
                let v25 = 0x2::coin::split<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v0)), v17, arg3);
                *0x1::vector::borrow_mut<u64>(&mut arg0.total_deposits, v4) = *0x1::vector::borrow<u64>(&arg0.total_deposits, v4) - v17;
                *0x1::vector::borrow_mut<u64>(&mut arg0.idle_liquidity, v4) = *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v4) - v17;
                if (v24 > 0) {
                    let v26 = &mut v25;
                    0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::FeeKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_fee_key(0x1::type_name::get<T1>())), 0x2::coin::split<T1>(v26, (((0x2::coin::value<T1>(v26) as u128) * (v24 as u128) / 10000) as u64), arg3));
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v25, v6);
                let v27 = if (v14 == 18) {
                    (v17 as u256)
                } else if (v14 < 18) {
                    (v17 as u256) * 0x1::u256::pow(10, ((18 - v14) as u8))
                } else {
                    (v17 as u256) / 0x1::u256::pow(10, ((v14 - 18) as u8))
                };
                return v27 * v8 / 1000000000000000000
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun remove_extension<T0, T1, T2: copy + drop + store, T3: store + key>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: T2) : T3 {
        assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::get<T2>();
        let v1 = &arg0.extensions;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 4
                };
                0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.extensions, 0x1::option::extract<u64>(&mut v3));
                0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::metadata::destroy_extension_metadata(0x2::dynamic_object_field::remove<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::ExtensionMetadataKey, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::metadata::ExtensionMetadataV1>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_extension_metadata_key(v0)));
                0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_remove_extension_event(0x2::object::uid_to_inner(&arg0.id), v0);
                return 0x2::dynamic_object_field::remove<T2, T3>(&mut arg0.id, arg2)
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun rotate_assistant<T0>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::ADMIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_can_be_mutated_by<T0, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::ADMIN>(arg0, arg1);
        let v0 = 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::create_vault_assistant_cap(0x2::object::uid_to_inner(&arg0.id), arg3);
        arg0.active_assistant = 0x2::object::id<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::ASSISTANT>>(&v0);
        0x2::transfer::public_transfer<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::ASSISTANT>>(v0, arg2);
    }

    public(friend) fun set_deposit_cap<T0, T1, T2>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: u64) {
        assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::get<T2>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.deposit_caps, 0x1::option::extract<u64>(&mut v3)) = arg2;
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun set_fees<T0, T1>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::Config, arg3: u64, arg4: u64, arg5: u64) {
        assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::assert_fees_are_valid(arg2, arg3, arg4, arg5);
        let v0 = FeeParams{
            performance_fee_bps : arg3,
            management_fee_bps  : arg4,
            withdrawal_fee_bps  : arg5,
        };
        arg0.fee_params = v0;
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_set_fees_event(0x2::object::uid_to_inner(&arg0.id), arg3, arg4, arg5);
    }

    public(friend) fun size<T0>(arg0: &StateV1<T0>) : u64 {
        0x1::vector::length<0x1::type_name::TypeName>(&arg0.type_names)
    }

    public(friend) fun staleness_thresholds_ms<T0>(arg0: &StateV1<T0>) : vector<u64> {
        arg0.staleness_thresholds_ms
    }

    public(friend) fun supports<T0, T1>(arg0: &StateV1<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.type_names, &v0)
    }

    public(friend) fun supports_extension<T0, T1: copy + drop + store>(arg0: &StateV1<T0>, arg1: T1) : bool {
        0x2::dynamic_object_field::exists_<T1>(&arg0.id, arg1)
    }

    public(friend) fun supports_type_name<T0>(arg0: &StateV1<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.type_names, arg1)
    }

    public(friend) fun total_active_deposits<T0, T1>(arg0: &StateV1<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                return if (0x1::option::is_some<u64>(&v3)) {
                    let v5 = 0x1::option::extract<u64>(&mut v3);
                    *0x1::vector::borrow<u64>(&arg0.total_deposits, v5) - *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v5)
                } else {
                    0
                }
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun total_deposits<T0, T1>(arg0: &StateV1<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                return if (0x1::option::is_some<u64>(&v3)) {
                    *0x1::vector::borrow<u64>(&arg0.total_deposits, 0x1::option::extract<u64>(&mut v3))
                } else {
                    0
                }
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun version() : u64 {
        1
    }

    public(friend) fun whitelist_depositor<T0, T1>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: address) {
        assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        if (!0x1::vector::contains<address>(&arg0.whitelisted_depositors, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_depositors, arg2);
        };
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut StateV1<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &vector<u256>, arg3: u256, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u256) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &arg0.type_names;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = *0x1::vector::borrow<u256>(arg2, v4);
                let v6 = 0x2::coin::value<T0>(&arg1);
                let v7 = arg0.lp_decimals;
                let v8 = if (v7 == 18) {
                    (v6 as u256)
                } else if (v7 < 18) {
                    (v6 as u256) * 0x1::u256::pow(10, ((18 - v7) as u8))
                } else {
                    (v6 as u256) / 0x1::u256::pow(10, ((v7 - 18) as u8))
                };
                let v9 = if (v7 == 18) {
                    (0x2::coin::total_supply<T0>(&arg0.treasury) as u256)
                } else if (v7 < 18) {
                    (0x2::coin::total_supply<T0>(&arg0.treasury) as u256) * 0x1::u256::pow(10, ((18 - v7) as u8))
                } else {
                    (0x2::coin::total_supply<T0>(&arg0.treasury) as u256) / 0x1::u256::pow(10, ((v7 - 18) as u8))
                };
                let v10 = *0x1::vector::borrow<u64>(&arg0.decimals, v4);
                let v11 = if (v10 == 18) {
                    v8 * arg3 / v9 * 1000000000000000000 / v5
                } else if (v10 < 18) {
                    v8 * arg3 / v9 * 1000000000000000000 / v5 / 0x1::u256::pow(10, ((18 - v10) as u8))
                } else {
                    v8 * arg3 / v9 * 1000000000000000000 / v5 * 0x1::u256::pow(10, ((v10 - 18) as u8))
                };
                let v12 = (v11 as u64);
                let v13 = if (!0x1::vector::is_empty<WithdrawTicket<T0>>(&arg0.withdraw_queue)) {
                    0
                } else {
                    0x1::u64::min(idle_liquidity_of_type<T0, T1>(arg0), v12)
                };
                if (v13 == v12) {
                    0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
                    0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::id_from_address(@0x0), v6, v6, v13);
                } else {
                    let v14 = WithdrawTicket<T0>{
                        id                   : 0x2::object::new(arg5),
                        lp_coin              : arg1,
                        coin_out_type        : v0,
                        recipient            : 0x2::tx_context::sender(arg5),
                        request_timestamp_ms : 0x2::clock::timestamp_ms(arg4),
                    };
                    let v15 = if (v6 > 0) {
                        let v16 = (((v6 as u256) * (v13 as u256) / (v12 as u256)) as u64);
                        0x2::coin::burn<T0>(&mut arg0.treasury, 0x2::coin::split<T0>(&mut v14.lp_coin, v16, arg5));
                        v16
                    } else {
                        0
                    };
                    0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), 0x2::object::uid_to_inner(&v14.id), v6, v15, v13);
                    0x1::vector::push_back<WithdrawTicket<T0>>(&mut arg0.withdraw_queue, v14);
                };
                let v17 = arg0.fee_params.withdrawal_fee_bps;
                let v18 = 0x2::coin::split<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v0)), v13, arg5);
                *0x1::vector::borrow_mut<u64>(&mut arg0.total_deposits, v4) = *0x1::vector::borrow<u64>(&arg0.total_deposits, v4) - v13;
                *0x1::vector::borrow_mut<u64>(&mut arg0.idle_liquidity, v4) = *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v4) - v13;
                if (v17 > 0) {
                    let v19 = &mut v18;
                    0x2::coin::join<T1>(0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::FeeKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_fee_key(0x1::type_name::get<T1>())), 0x2::coin::split<T1>(v19, (((0x2::coin::value<T1>(v19) as u128) * (v17 as u128) / 10000) as u64), arg5));
                };
                let v20 = if (v10 == 18) {
                    (v13 as u256)
                } else if (v10 < 18) {
                    (v13 as u256) * 0x1::u256::pow(10, ((18 - v10) as u8))
                } else {
                    (v13 as u256) / 0x1::u256::pow(10, ((v10 - 18) as u8))
                };
                return (v18, v20 * v5 / 1000000000000000000)
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun withdraw_fees<T0, T1, T2>(arg0: &mut StateV1<T0>, arg1: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::VAULT, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_can_be_mutated_by<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::get<T2>();
        assert!(supports_type_name<T0>(arg0, &v0), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::FeeKey, 0x2::coin::Coin<T2>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_fee_key(v0));
        0x2::coin::split<T2>(v1, 0x2::coin::value<T2>(v1), arg2)
    }

    public(friend) fun withdraw_funds<T0, T1, T2: copy + drop + store>(arg0: &mut StateV1<T0>, arg1: T2, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::get<T2>();
        let v1 = &arg0.extensions;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 4
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = 0x1::type_name::get<T1>();
                let v6 = &arg0.type_names;
                let v7 = 0;
                let v8;
                while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
                    if (0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7) == &v5) {
                        v8 = 0x1::option::some<u64>(v7);
                        /* label 14 */
                        if (0x1::option::is_none<u64>(&v8)) {
                            abort 2
                        };
                        let v9 = 0x1::option::extract<u64>(&mut v8);
                        let v10 = 0x2::dynamic_object_field::borrow_mut<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::IdleLiquidityKey, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::keys::to_idle_liquidity_key(v5));
                        assert!(arg2 <= 0x2::coin::value<T1>(v10), 6);
                        *0x1::vector::borrow_mut<u64>(&mut arg0.idle_liquidity, v9) = *0x1::vector::borrow<u64>(&arg0.idle_liquidity, v9) - arg2;
                        *0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.active_liquidity, v9), v4) = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.active_liquidity, v9), v4) + arg2;
                        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::events::emit_deposit_funds_into_extension_event<T1>(0x2::object::uid_to_inner(&arg0.id), v0, arg2);
                        return 0x2::coin::split<T1>(v10, arg2, arg3)
                    };
                    v7 = v7 + 1;
                };
                v8 = 0x1::option::none<u64>();
                /* goto 14 */
            } else {
                v2 = v2 + 1;
            };
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun withdraw_queue<T0>(arg0: &StateV1<T0>) : &vector<WithdrawTicket<T0>> {
        &arg0.withdraw_queue
    }

    public(friend) fun withdrawal_fee_bps<T0>(arg0: &StateV1<T0>) : u64 {
        arg0.fee_params.withdrawal_fee_bps
    }

    // decompiled from Move bytecode v6
}

