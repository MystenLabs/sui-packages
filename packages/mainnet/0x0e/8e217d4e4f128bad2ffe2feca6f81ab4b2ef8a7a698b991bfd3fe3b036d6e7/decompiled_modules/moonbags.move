module 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        treasury: address,
        fee_platform_recipient: address,
        platform_fee: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        init_platform_fee_withdraw: u16,
        init_creator_fee_withdraw: u16,
        init_stake_fee_withdraw: u16,
        init_platform_stake_fee_withdraw: u16,
        token_platform_type_name: 0x1::ascii::String,
        pool_creation_fee: u64,
    }

    struct ThresholdConfig has store, key {
        id: 0x2::object::UID,
        threshold: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        fee_recipient: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>,
        is_completed: bool,
        platform_fee_withdraw: u16,
        creator_fee_withdraw: u16,
        stake_fee_withdraw: u16,
        platform_stake_fee_withdraw: u16,
        threshold: u64,
    }

    struct ConfigChangedEvent has copy, drop, store {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
        old_init_platform_fee_withdraw: u16,
        new_init_platform_fee_withdraw: u16,
        old_init_creator_fee_withdraw: u16,
        new_init_creator_fee_withdraw: u16,
        old_init_stake_fee_withdraw: u16,
        new_init_stake_fee_withdraw: u16,
        old_init_platform_stake_fee_withdraw: u16,
        new_init_platform_stake_fee_withdraw: u16,
        old_token_platform_type_name: 0x1::ascii::String,
        new_token_platform_type_name: 0x1::ascii::String,
        ts: u64,
    }

    struct CreatedEvent has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        platform_fee_withdraw: u16,
        creator_fee_withdraw: u16,
        stake_fee_withdraw: u16,
        platform_stake_fee_withdraw: u16,
        threshold: u64,
        ts: u64,
    }

    struct OwnershipTransferredEvent has copy, drop, store {
        old_admin: address,
        new_admin: address,
        ts: u64,
    }

    struct PoolCompletedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
    }

    struct TradedEvent has copy, drop, store {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        pool_id: 0x2::object::ID,
        fee: u64,
        ts: u64,
    }

    struct ConfigChangedEventV2 has copy, drop, store {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
        old_init_platform_fee_withdraw: u16,
        new_init_platform_fee_withdraw: u16,
        old_init_creator_fee_withdraw: u16,
        new_init_creator_fee_withdraw: u16,
        old_init_stake_fee_withdraw: u16,
        new_init_stake_fee_withdraw: u16,
        old_init_platform_stake_fee_withdraw: u16,
        new_init_platform_stake_fee_withdraw: u16,
        old_token_platform_type_name: 0x1::ascii::String,
        new_token_platform_type_name: 0x1::ascii::String,
        ts: u64,
    }

    struct CreatedEventV2 has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        platform_fee_withdraw: u16,
        creator_fee_withdraw: u16,
        stake_fee_withdraw: u16,
        platform_stake_fee_withdraw: u16,
        threshold: u64,
        bonding_dex: u8,
        ts: u64,
    }

    struct OwnershipTransferredEventV2 has copy, drop, store {
        old_admin: address,
        new_admin: address,
        ts: u64,
    }

    struct PoolCompletedEventV2 has copy, drop, store {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
    }

    struct PoolMigratingEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        bonding_dex: u8,
        ts: u64,
    }

    struct TradedEventV2 has copy, drop, store {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        pool_id: 0x2::object::ID,
        fee: u64,
        ts: u64,
    }

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg2) > 0, 1);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 1);
    }

    public fun assert_pool_not_completed<T0>(arg0: &Configuration) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0>>(&arg0.id, 0x1::type_name::get_address(&v0)).is_completed, 7);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 <= 5, 3);
    }

    fun buy_direct<T0>(arg0: address, arg1: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg2: &mut Pool<T0>, arg3: u64, arg4: u64, arg5: &0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::Configuration, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_completed, 4);
        assert!(arg3 > 0, 1);
        let v0 = 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg1);
        let v1 = arg2.virtual_token_reserves - get_virtual_remain_token_reserves<T0>(arg2);
        let v2 = 0x1::u64::min(arg3, v1);
        let v3 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_add_liquidity_cost(arg2.virtual_sui_reserves, arg2.virtual_token_reserves, v2) + 1;
        let v4 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v3), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg4)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        assert!(v0 >= v3 + v4, 5);
        0x2::coin::join<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg2.fee_recipient, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg1, v4, arg8));
        let v5 = 0x2::coin::zero<T0>(arg8);
        let (v6, v7) = swap<T0>(arg2, v5, arg1, v2, v0 - v3 - v4, arg8);
        let v8 = v6;
        arg2.virtual_token_reserves = arg2.virtual_token_reserves - 0x2::coin::value<T0>(&v8);
        let v9 = TradedEventV2{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg8),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v3,
            token_amount           : v2,
            virtual_sui_reserves   : arg2.virtual_sui_reserves,
            virtual_token_reserves : arg2.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg2.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&arg2.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(arg2),
            fee                    : v4,
            ts                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TradedEventV2>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(v7, 0x2::tx_context::sender(arg8));
        if (arg6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg8));
        } else {
            0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::create_lock<T0>(arg5, v8, 0x2::tx_context::sender(arg8), 0x2::coin::value<T0>(&v8), 0x2::clock::timestamp_ms(arg7) + arg6, arg7, arg8);
        };
        if (v1 == v2) {
            transfer_pool<T0>(arg0, arg2, arg7, arg8);
        };
    }

    public fun buy_exact_in_returns_with_lock<T0>(arg0: &mut Configuration, arg1: &0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::Configuration, arg2: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, 0x2::coin::Coin<T0>) {
        assert_version(arg0.version);
        let v0 = 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg2);
        assert!(v0 >= arg3, 5);
        assert!(arg3 > 0, 1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(!v2.is_completed, 4);
        let v3 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_remove_liquidity_return(v2.virtual_sui_reserves, v2.virtual_token_reserves, arg3);
        let v4 = v2.virtual_token_reserves - get_virtual_remain_token_reserves<T0>(v2);
        let (v5, v6) = if (v3 > v4) {
            let v6 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v4) + 1;
            (v4, v6)
        } else {
            (v3, arg3)
        };
        assert!(v5 >= arg4, 1);
        let v7 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v6), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.platform_fee)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        0x2::coin::join<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v2.fee_recipient, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg2, v7, arg6));
        assert!(v0 >= v6 + v7, 5);
        let v8 = 0x2::coin::zero<T0>(arg6);
        let (v9, v10) = swap<T0>(v2, v8, arg2, v5, v0 - v6 - v7, arg6);
        let v11 = v9;
        v2.virtual_token_reserves = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v11);
        let v12 = TradedEventV2{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg6),
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v6,
            token_amount           : v5,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v2.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v2.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            fee                    : v7,
            ts                     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TradedEventV2>(v12);
        if (v5 == v4) {
            transfer_pool<T0>(arg0.admin, v2, arg5, arg6);
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&v2.id, b"pool_creation_timestamp")) {
            let v13 = 0x2::clock::timestamp_ms(arg5);
            if (v13 - *0x2::dynamic_field::borrow<vector<u8>, u64>(&v2.id, b"pool_creation_timestamp") < *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"buy_block_duration")) {
                let v14 = v11;
                0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::create_lock<T0>(arg1, v14, 0x2::tx_context::sender(arg6), 0x2::coin::value<T0>(&v14), v13 + *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"lock_buy_duration"), arg5, arg6);
                v11 = 0x2::coin::zero<T0>(arg6);
            };
        };
        (v10, v11)
    }

    public fun buy_exact_in_returns_with_lock_inline<T0>(arg0: &mut Configuration, arg1: &0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::Configuration, arg2: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg3: u64, arg4: u64, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &0x2::coin::CoinMetadata<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, 0x2::coin::Coin<T0>) {
        assert_version(arg0.version);
        let v0 = 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg2);
        assert!(v0 >= arg3, 5);
        assert!(arg3 > 0, 1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(!v2.is_completed, 4);
        let v3 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_remove_liquidity_return(v2.virtual_sui_reserves, v2.virtual_token_reserves, arg3);
        let v4 = v2.virtual_token_reserves - get_virtual_remain_token_reserves<T0>(v2);
        let (v5, v6) = if (v3 > v4) {
            let v6 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v4) + 1;
            (v4, v6)
        } else {
            (v3, arg3)
        };
        assert!(v5 >= arg4, 1);
        let v7 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v6), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.platform_fee)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        0x2::coin::join<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v2.fee_recipient, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg2, v7, arg11));
        assert!(v0 >= v6 + v7, 5);
        let v8 = 0x2::coin::zero<T0>(arg11);
        let (v9, v10) = swap<T0>(v2, v8, arg2, v5, v0 - v6 - v7, arg11);
        let v11 = v9;
        v2.virtual_token_reserves = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v11);
        let v12 = TradedEventV2{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg11),
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v6,
            token_amount           : v5,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v2.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v2.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            fee                    : v7,
            ts                     : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<TradedEventV2>(v12);
        if (v5 == v4) {
            transfer_pool_inline<T0>(arg0.admin, v2, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&v2.id, b"pool_creation_timestamp")) {
            let v13 = 0x2::clock::timestamp_ms(arg10);
            if (v13 - *0x2::dynamic_field::borrow<vector<u8>, u64>(&v2.id, b"pool_creation_timestamp") < *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"buy_block_duration")) {
                let v14 = v11;
                0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::create_lock<T0>(arg1, v14, 0x2::tx_context::sender(arg11), 0x2::coin::value<T0>(&v14), v13 + *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"lock_buy_duration"), arg10, arg11);
                v11 = 0x2::coin::zero<T0>(arg11);
            };
        };
        (v10, v11)
    }

    public entry fun buy_exact_in_with_lock<T0>(arg0: &mut Configuration, arg1: &0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::Configuration, arg2: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_exact_in_returns_with_lock<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun buy_exact_in_with_lock_inline<T0>(arg0: &mut Configuration, arg1: &0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::Configuration, arg2: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg3: u64, arg4: u64, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &0x2::coin::CoinMetadata<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_exact_in_returns_with_lock_inline<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(v0, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg11));
    }

    fun calculate_init_sui_reserves(arg0: &Configuration, arg1: u64) : u64 {
        let v0 = arg0.remain_token_reserves;
        let v1 = arg0.initial_virtual_token_reserves;
        assert!(v0 > v1, 1);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg1), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v1)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v0 - v1)))
    }

    public fun check_pool_exist<T0>(arg0: &Configuration) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, 0x1::type_name::get_address(&v0))
    }

    public entry fun create_and_lock_first_buy_with_fee<T0>(arg0: &mut Configuration, arg1: &mut 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::Configuration, arg2: &0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_token_lock::Configuration, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg5: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: 0x1::ascii::String, arg16: 0x1::ascii::String, arg17: 0x2::coin::CoinMetadata<T0>, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg12) <= 300, 1);
        assert!(0x1::ascii::length(&arg13) <= 1000, 1);
        assert!(0x1::ascii::length(&arg14) <= 500, 1);
        assert!(0x1::ascii::length(&arg15) <= 500, 1);
        assert!(0x1::ascii::length(&arg16) <= 500, 1);
        assert!(0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg4) >= arg0.pool_creation_fee, 1);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 6);
        let v0 = if (arg7 == 0) {
            2000000000000
        } else {
            arg7
        };
        assert!(v0 >= 1000000000000, 1);
        if (arg8 > 0) {
            assert!(arg8 >= 3600000, 1);
        };
        let v1 = Pool<T0>{
            id                          : 0x2::object::new(arg18),
            real_sui_reserves           : 0x2::coin::zero<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg18),
            real_token_reserves         : 0x2::coin::mint<T0>(&mut arg3, arg0.remain_token_reserves, arg18),
            virtual_token_reserves      : 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves - arg0.initial_virtual_token_reserves))),
            virtual_sui_reserves        : calculate_init_sui_reserves(arg0, v0),
            remain_token_reserves       : 0x2::coin::mint<T0>(&mut arg3, arg0.remain_token_reserves, arg18),
            fee_recipient               : 0x2::coin::zero<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg18),
            is_completed                : false,
            platform_fee_withdraw       : arg0.init_platform_fee_withdraw,
            creator_fee_withdraw        : arg0.init_creator_fee_withdraw,
            stake_fee_withdraw          : arg0.init_stake_fee_withdraw,
            platform_stake_fee_withdraw : arg0.init_platform_stake_fee_withdraw,
            threshold                   : v0,
        };
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"virtual_token_reserves", 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.initial_virtual_token_reserves)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves - arg0.initial_virtual_token_reserves))));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg17);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"fee_lock_time", 0x2::clock::timestamp_ms(arg9) + 300000);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"pool_creation_timestamp", 0x2::clock::timestamp_ms(arg9));
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<Pool<T0>>();
        let v4 = CreatedEventV2{
            name                        : arg10,
            symbol                      : arg11,
            uri                         : arg12,
            description                 : arg13,
            twitter                     : arg14,
            telegram                    : arg15,
            website                     : arg16,
            token_address               : 0x1::type_name::into_string(v2),
            bonding_curve               : 0x1::type_name::get_module(&v3),
            pool_id                     : 0x2::object::id<Pool<T0>>(&v1),
            created_by                  : 0x2::tx_context::sender(arg18),
            virtual_sui_reserves        : v1.virtual_sui_reserves,
            virtual_token_reserves      : v1.virtual_token_reserves,
            real_sui_reserves           : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves),
            real_token_reserves         : 0x2::coin::value<T0>(&v1.real_token_reserves),
            platform_fee_withdraw       : v1.platform_fee_withdraw,
            creator_fee_withdraw        : v1.creator_fee_withdraw,
            stake_fee_withdraw          : v1.stake_fee_withdraw,
            platform_stake_fee_withdraw : v1.platform_stake_fee_withdraw,
            threshold                   : v0,
            bonding_dex                 : 0,
            ts                          : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg3, @0x0);
        if (0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg5) > 0) {
            let v5 = &mut v1;
            buy_direct<T0>(arg0.admin, arg5, v5, arg6, arg0.platform_fee, arg2, arg8, arg9, arg18);
        } else {
            0x2::coin::destroy_zero<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg5);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v2), v1);
        0x2::event::emit<CreatedEventV2>(v4);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::initialize_staking_pool<T0>(arg1, arg9, arg18);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::initialize_creator_pool<T0>(arg1, 0x2::tx_context::sender(arg18), arg9, arg18);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg4, arg0.pool_creation_fee, arg18), arg0.fee_platform_recipient);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(arg4, 0x2::tx_context::sender(arg18));
    }

    public entry fun create_threshold_config(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ThresholdConfig{
            id        : 0x2::object::new(arg2),
            threshold : arg1,
        };
        0x2::transfer::public_share_object<ThresholdConfig>(v0);
    }

    public entry fun create_with_fee<T0>(arg0: &mut Configuration, arg1: &mut 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg9) <= 300, 1);
        assert!(0x1::ascii::length(&arg10) <= 1000, 1);
        assert!(0x1::ascii::length(&arg11) <= 500, 1);
        assert!(0x1::ascii::length(&arg12) <= 500, 1);
        assert!(0x1::ascii::length(&arg13) <= 500, 1);
        assert!(0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg4) >= arg0.pool_creation_fee, 1);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 6);
        let v0 = if (arg5 == 0) {
            2000000000000
        } else {
            arg5
        };
        assert!(v0 >= 1000000000000, 1);
        let v1 = Pool<T0>{
            id                          : 0x2::object::new(arg14),
            real_sui_reserves           : 0x2::coin::zero<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg14),
            real_token_reserves         : 0x2::coin::mint<T0>(&mut arg2, arg0.remain_token_reserves, arg14),
            virtual_token_reserves      : 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves - arg0.initial_virtual_token_reserves))),
            virtual_sui_reserves        : calculate_init_sui_reserves(arg0, v0),
            remain_token_reserves       : 0x2::coin::mint<T0>(&mut arg2, arg0.remain_token_reserves, arg14),
            fee_recipient               : 0x2::coin::zero<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg14),
            is_completed                : false,
            platform_fee_withdraw       : arg0.init_platform_fee_withdraw,
            creator_fee_withdraw        : arg0.init_creator_fee_withdraw,
            stake_fee_withdraw          : arg0.init_stake_fee_withdraw,
            platform_stake_fee_withdraw : arg0.init_platform_stake_fee_withdraw,
            threshold                   : v0,
        };
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"virtual_token_reserves", 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.initial_virtual_token_reserves)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.remain_token_reserves - arg0.initial_virtual_token_reserves))));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg3);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"fee_lock_time", 0x2::clock::timestamp_ms(arg6) + 300000);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"pool_creation_timestamp", 0x2::clock::timestamp_ms(arg6));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg2, @0x0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<Pool<T0>>();
        let v4 = CreatedEventV2{
            name                        : arg7,
            symbol                      : arg8,
            uri                         : arg9,
            description                 : arg10,
            twitter                     : arg11,
            telegram                    : arg12,
            website                     : arg13,
            token_address               : 0x1::type_name::into_string(v2),
            bonding_curve               : 0x1::type_name::get_module(&v3),
            pool_id                     : 0x2::object::id<Pool<T0>>(&v1),
            created_by                  : 0x2::tx_context::sender(arg14),
            virtual_sui_reserves        : v1.virtual_sui_reserves,
            virtual_token_reserves      : v1.virtual_token_reserves,
            real_sui_reserves           : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves),
            real_token_reserves         : 0x2::coin::value<T0>(&v1.real_token_reserves),
            platform_fee_withdraw       : v1.platform_fee_withdraw,
            creator_fee_withdraw        : v1.creator_fee_withdraw,
            stake_fee_withdraw          : v1.stake_fee_withdraw,
            platform_stake_fee_withdraw : v1.platform_stake_fee_withdraw,
            threshold                   : v0,
            bonding_dex                 : 0,
            ts                          : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v2), v1);
        0x2::event::emit<CreatedEventV2>(v4);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::initialize_staking_pool<T0>(arg1, arg6, arg14);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::initialize_creator_pool<T0>(arg1, 0x2::tx_context::sender(arg14), arg6, arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg4, arg0.pool_creation_fee, arg14), arg0.fee_platform_recipient);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(arg4, 0x2::tx_context::sender(arg14));
    }

    fun distribute_fees<T0, T1>(arg0: &mut Pool<T0>, arg1: address, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: &mut 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::Configuration, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"fee_lock_time")) {
            assert!(0x2::clock::timestamp_ms(arg7) >= *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"fee_lock_time"), 11);
        };
        let v0 = 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg0.fee_recipient);
        if (v0 <= 10000) {
            return
        };
        let v1 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v0), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64((arg2 as u64))), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        let v2 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v0), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64((arg3 as u64))), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        let v3 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v0), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64((arg4 as u64))), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        let v4 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v0), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64((arg5 as u64))), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        assert!(v1 + v2 + v3 + v4 <= v0, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg0.fee_recipient, v1, arg8), arg1);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::deposit_creator_pool<T0>(arg6, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg0.fee_recipient, v2, arg8), arg7, arg8);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::update_reward_index<T0>(arg6, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg0.fee_recipient, v3, arg8), arg7, arg8);
        0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::update_reward_index<T1>(arg6, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg0.fee_recipient, v4, arg8), arg7, arg8);
        let v5 = 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg0.fee_recipient);
        if (v5 > 1000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg0.fee_recipient, v5, arg8), @0x2957f0f19ee92eb5283bf1aa6ce7a3742ea7bc79bc9d1dc907fbbf7a11567409);
        };
    }

    public fun early_complete_pool<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut ThresholdConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        v1.is_completed = true;
        let v2 = 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves);
        let v3 = 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v1.real_sui_reserves, v2, arg4);
        let v4 = &v1.remain_token_reserves;
        let v5 = 0x2::coin::split<T0>(&mut v1.real_token_reserves, 0x2::coin::value<T0>(&v1.real_token_reserves), arg4);
        assert!(v2 >= arg2.threshold, 2);
        0x2::coin::join<T0>(&mut v5, 0x2::coin::split<T0>(&mut v1.remain_token_reserves, 0x2::coin::value<T0>(v4), arg4));
        if (v2 >= arg2.threshold) {
            let v6 = 50000000000;
            if (v2 >= arg2.threshold + v6) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v3, v6, arg4), arg1.treasury);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v3, arg2.threshold, arg4), arg1.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg1.remain_token_reserves, arg4), arg1.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(v3, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg4));
        let v7 = PoolCompletedEventV2{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolCompletedEventV2>(v7);
    }

    public fun estimate_amount_out<T0>(arg0: &mut Configuration, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        if (arg1 > 0 && arg2 == 0) {
            (0, 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_token_amount_received(v1.virtual_sui_reserves, v1.virtual_token_reserves, arg1 - 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg1), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.platform_fee)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)))))
        } else if (arg1 == 0 && arg2 > 0) {
            let v4 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, arg2);
            (v4 - 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v4), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.platform_fee)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000))), 0)
        } else {
            (0, 0)
        }
    }

    fun get_virtual_remain_token_reserves<T0>(arg0: &Pool<T0>) : u64 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"virtual_token_reserves")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"virtual_token_reserves")
        } else {
            0x2::coin::value<T0>(&arg0.remain_token_reserves)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Configuration{
            id                               : 0x2::object::new(arg0),
            version                          : 5,
            admin                            : 0x2::tx_context::sender(arg0),
            treasury                         : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
            fee_platform_recipient           : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
            platform_fee                     : 200,
            initial_virtual_token_reserves   : 1066666667000000,
            remain_token_reserves            : 4266666668000000,
            token_decimals                   : 6,
            init_platform_fee_withdraw       : 4000,
            init_creator_fee_withdraw        : 3000,
            init_stake_fee_withdraw          : 1,
            init_platform_stake_fee_withdraw : 2999,
            token_platform_type_name         : 0x1::ascii::string(b"cee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA"),
            pool_creation_fee                : 100000000000000,
        };
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"buy_block_duration", 1000);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"lock_buy_duration", 0);
        0x2::transfer::public_share_object<Configuration>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_cetus_aida_pool<T0>(arg0: address, arg1: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg2: 0x2::coin::Coin<T0>, arg3: &mut Pool<T0>, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        init_cetus_aida_pool_inner<T0>(arg0, arg3, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun init_cetus_aida_pool_inner<T0>(arg0: address, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_completed, 7);
        let v0 = 0x2::coin::get_icon_url<T0>(arg8);
        let v1 = if (0x1::option::is_some<0x2::url::Url>(&v0)) {
            let v2 = 0x2::coin::get_icon_url<T0>(arg8);
            let v3 = 0x1::option::extract<0x2::url::Url>(&mut v2);
            0x1::string::from_ascii(0x2::url::inner_url(&v3))
        } else {
            0x1::string::utf8(b"")
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg6, arg5, 200, sqrt(340282366920938463463374607431768211456 * (0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg2) as u256) / (0x2::coin::value<T0>(&arg3) as u256)), v1, 4294523696, 443600, arg3, arg2, arg8, arg7, true, arg9, arg10);
        0x2::dynamic_object_field::add<vector<u8>, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.id, b"burn_proof", 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v4, arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(v6, arg0);
    }

    public entry fun init_cetus_aida_pool_v2<T0>(arg0: address, arg1: &mut Configuration, arg2: 0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::coin::CoinMetadata<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        init_cetus_aida_pool_inner<T0>(arg0, v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun migrate_version(arg0: &AdminCap, arg1: &mut Configuration) {
        arg1.version = 5;
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 4);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 1);
        let v3 = 0x1::u64::min(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, v2), 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves));
        let v4 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v3), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.platform_fee)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        assert!(v3 - v4 >= arg2, 1);
        let v5 = 0x2::coin::zero<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg4);
        let (v6, v7) = swap<T0>(v1, arg1, v5, 0, v3, arg4);
        let v8 = v7;
        v1.virtual_sui_reserves = v1.virtual_sui_reserves - 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v8);
        0x2::coin::join<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v1.fee_recipient, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v8, v4, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(v8, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg4));
        let v9 = TradedEventV2{
            is_buy                 : false,
            user                   : 0x2::tx_context::sender(arg4),
            token_address          : 0x1::type_name::into_string(v0),
            sui_amount             : v3,
            token_amount           : v2,
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v1.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v1),
            fee                    : v4,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEventV2>(v9);
    }

    public fun sell_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, 0x2::coin::Coin<T0>) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 4);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 1);
        let v3 = 0x1::u64::min(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, v2), 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves));
        let v4 = 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::as_u64(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::div(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::mul(0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(v3), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(arg0.platform_fee)), 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::utils::from_u64(10000)));
        assert!(v3 - v4 >= arg2, 1);
        let v5 = 0x2::coin::zero<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(arg4);
        let (v6, v7) = swap<T0>(v1, arg1, v5, 0, v3, arg4);
        let v8 = v7;
        v1.virtual_sui_reserves = v1.virtual_sui_reserves - 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v8);
        0x2::coin::join<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v1.fee_recipient, 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v8, v4, arg4));
        let v9 = TradedEventV2{
            is_buy                 : false,
            user                   : 0x2::tx_context::sender(arg4),
            token_address          : 0x1::type_name::into_string(v0),
            sui_amount             : v3,
            token_amount           : v2,
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v1.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v1),
            fee                    : v4,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEventV2>(v9);
        (v8, v6)
    }

    public entry fun setter_pool_creation_fee(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64) {
        arg1.pool_creation_fee = arg2;
    }

    public fun skim<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        assert!(v1.is_completed, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut v1.real_sui_reserves, 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1.real_sui_reserves), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.real_token_reserves, 0x2::coin::value<T0>(&v1.real_token_reserves), arg2), 0x2::tx_context::sender(arg2));
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: &mut Configuration, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
        let v0 = OwnershipTransferredEventV2{
            old_admin : 0x2::tx_context::sender(arg4),
            new_admin : arg2,
            ts        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OwnershipTransferredEventV2>(v0);
    }

    fun transfer_pool<T0>(arg0: address, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg1.real_token_reserves, 0x2::coin::value<T0>(&arg1.real_token_reserves), arg3);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg1.remain_token_reserves, 0x2::coin::value<T0>(&arg1.remain_token_reserves), arg3));
        let v1 = 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg1.real_sui_reserves, 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg1.real_sui_reserves), arg3);
        let v2 = PoolCompletedEventV2{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolCompletedEventV2>(v2);
        let v3 = PoolMigratingEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount    : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1),
            token_amount  : 0x2::coin::value<T0>(&v0),
            bonding_dex   : 0,
            ts            : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolMigratingEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>>(v1, arg0);
    }

    fun transfer_pool_inline<T0>(arg0: address, arg1: &mut Pool<T0>, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        arg1.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg1.real_token_reserves, 0x2::coin::value<T0>(&arg1.real_token_reserves), arg8);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg1.remain_token_reserves, 0x2::coin::value<T0>(&arg1.remain_token_reserves), arg8));
        let v1 = 0x2::coin::split<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&mut arg1.real_sui_reserves, 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&arg1.real_sui_reserves), arg8);
        let v2 = PoolCompletedEventV2{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PoolCompletedEventV2>(v2);
        let v3 = PoolMigratingEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount    : 0x2::coin::value<0xcee208b8ae33196244b389e61ffd1202e7a1ae06c8ec210d33402ff649038892::aida::AIDA>(&v1),
            token_amount  : 0x2::coin::value<T0>(&v0),
            bonding_dex   : 0,
            ts            : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PoolMigratingEvent>(v3);
        init_cetus_aida_pool_inner<T0>(arg0, arg1, v1, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun update_buy_block_duration_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"buy_block_duration")) {
            0x2::dynamic_field::remove<vector<u8>, u64>(&mut arg1.id, b"buy_block_duration");
        };
        0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"buy_block_duration", arg2);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u16, arg7: u16, arg8: u16, arg9: u16, arg10: 0x1::ascii::String, arg11: &0x2::clock::Clock) {
        assert!(((arg6 + arg7 + arg8 + arg9) as u64) <= 10000, 1);
        let v0 = ConfigChangedEventV2{
            old_platform_fee                     : arg1.platform_fee,
            new_platform_fee                     : arg2,
            old_initial_virtual_token_reserves   : arg1.initial_virtual_token_reserves,
            new_initial_virtual_token_reserves   : arg3,
            old_remain_token_reserves            : arg1.remain_token_reserves,
            new_remain_token_reserves            : arg4,
            old_token_decimals                   : arg1.token_decimals,
            new_token_decimals                   : arg5,
            old_init_platform_fee_withdraw       : arg1.init_platform_fee_withdraw,
            new_init_platform_fee_withdraw       : arg6,
            old_init_creator_fee_withdraw        : arg1.init_creator_fee_withdraw,
            new_init_creator_fee_withdraw        : arg7,
            old_init_stake_fee_withdraw          : arg1.init_stake_fee_withdraw,
            new_init_stake_fee_withdraw          : arg8,
            old_init_platform_stake_fee_withdraw : arg1.init_platform_stake_fee_withdraw,
            new_init_platform_stake_fee_withdraw : arg9,
            old_token_platform_type_name         : arg1.token_platform_type_name,
            new_token_platform_type_name         : arg10,
            ts                                   : 0x2::clock::timestamp_ms(arg11),
        };
        arg1.platform_fee = arg2;
        arg1.initial_virtual_token_reserves = arg3;
        arg1.remain_token_reserves = arg4;
        arg1.token_decimals = arg5;
        arg1.init_platform_fee_withdraw = arg6;
        arg1.init_creator_fee_withdraw = arg7;
        arg1.init_stake_fee_withdraw = arg8;
        arg1.init_platform_stake_fee_withdraw = arg9;
        arg1.token_platform_type_name = arg10;
        0x2::event::emit<ConfigChangedEventV2>(v0);
    }

    public entry fun update_config_withdraw_fee(arg0: &AdminCap, arg1: &mut Configuration, arg2: u16, arg3: u16, arg4: u16, arg5: u16) {
        arg1.init_platform_fee_withdraw = arg2;
        arg1.init_creator_fee_withdraw = arg3;
        arg1.init_stake_fee_withdraw = arg4;
        arg1.init_platform_stake_fee_withdraw = arg5;
    }

    public entry fun update_fee_recipients(arg0: &AdminCap, arg1: &mut Configuration, arg2: address, arg3: address) {
        arg1.treasury = arg2;
        arg1.fee_platform_recipient = arg3;
    }

    public entry fun update_initial_virtual_token_reserves(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64) {
        arg1.initial_virtual_token_reserves = arg2;
    }

    public entry fun update_lock_buy_duration_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"lock_buy_duration")) {
            0x2::dynamic_field::remove<vector<u8>, u64>(&mut arg1.id, b"lock_buy_duration");
        };
        0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"lock_buy_duration", arg2);
    }

    public entry fun update_threshold_config(arg0: &AdminCap, arg1: &mut ThresholdConfig, arg2: u64) {
        arg1.threshold = arg2;
    }

    public fun withdraw_fee_bonding_curve<T0, T1>(arg0: &mut Configuration, arg1: &mut 0x593a2e87f393dcb14e0f8c88d587c04e9bc98295e13212e8992343377bf7f313::moonbags_stake::Configuration, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T1>()) == arg0.token_platform_type_name, 5);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        distribute_fees<T0, T1>(v1, arg0.fee_platform_recipient, arg0.init_platform_fee_withdraw, arg0.init_creator_fee_withdraw, arg0.init_stake_fee_withdraw, arg0.init_platform_stake_fee_withdraw, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

