module 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        platform_fee: u64,
        graduated_fee: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        init_platform_fee_withdraw: u16,
        init_creator_fee_withdraw: u16,
        init_stake_fee_withdraw: u16,
        init_platform_stake_fee_withdraw: u16,
        token_platform_type_name: 0x1::ascii::String,
    }

    struct ThresholdConfig has store, key {
        id: 0x2::object::UID,
        threshold: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        fee_recipient: 0x2::coin::Coin<0x2::sui::SUI>,
        position_graduated: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
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
        old_graduated_fee: u64,
        new_graduated_fee: u64,
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

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 2);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 2);
    }

    public fun assert_pool_not_completed<T0>(arg0: &Configuration) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0>>(&arg0.id, 0x1::type_name::get_address(&v0)).is_completed, 9);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 4);
    }

    fun buy_direct<T0>(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut Pool<T0>, arg4: u64, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_completed, 5);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = arg3.virtual_token_reserves - 0x2::coin::value<T0>(&arg3.remain_token_reserves);
        let v2 = 0x1::u64::min(arg4, v1);
        let v3 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_add_liquidity_cost(arg3.virtual_sui_reserves, arg3.virtual_token_reserves, v2) + 1;
        let v4 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v3), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg5)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        assert!(v0 >= v3 + v4, 6);
        0x2::coin::join<0x2::sui::SUI>(&mut arg3.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg11));
        let v5 = 0x2::coin::zero<T0>(arg11);
        let (v6, v7) = swap<T0>(arg3, v5, arg2, v2, v0 - v3 - v4, arg11);
        let v8 = v6;
        arg3.virtual_token_reserves = arg3.virtual_token_reserves - 0x2::coin::value<T0>(&v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg11));
        let v9 = TradedEvent{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg11),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v3,
            token_amount           : v2,
            virtual_sui_reserves   : arg3.virtual_sui_reserves,
            virtual_token_reserves : arg3.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&arg3.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&arg3.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(arg3),
            fee                    : v4,
            ts                     : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<TradedEvent>(v9);
        if (v1 == v2) {
            transfer_pool<T0>(arg0, arg1, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
        };
    }

    public entry fun buy_exact_in<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        let v3 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v0), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        0x2::coin::join<0x2::sui::SUI>(&mut v2.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg7));
        let v4 = v0 - v3;
        assert!(!v2.is_completed, 5);
        assert!(v0 > 0, 2);
        let v5 = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v2.remain_token_reserves);
        let v6 = 0x1::u64::min(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_remove_liquidity_return(v2.virtual_sui_reserves, v2.virtual_token_reserves, v4) - 1, v5);
        let v7 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v6) + 1;
        assert!(v0 >= v4 + v3, 6);
        let v8 = 0x2::coin::zero<T0>(arg7);
        let (v9, v10) = swap<T0>(v2, v8, arg1, v6, v4 - v7, arg7);
        let v11 = v9;
        v2.virtual_token_reserves = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, 0x2::tx_context::sender(arg7));
        let v12 = TradedEvent{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg7),
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v7,
            token_amount           : v6,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v2.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            fee                    : v3,
            ts                     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TradedEvent>(v12);
        if (v6 == v5) {
            transfer_pool<T0>(arg0.admin, arg0.graduated_fee, v2, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    public fun buy_exact_in_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert_version(arg0.version);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        let v3 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v0), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        0x2::coin::join<0x2::sui::SUI>(&mut v2.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg7));
        let v4 = v0 - v3;
        assert!(!v2.is_completed, 5);
        assert!(v0 > 0, 2);
        let v5 = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v2.remain_token_reserves);
        let v6 = 0x1::u64::min(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_remove_liquidity_return(v2.virtual_sui_reserves, v2.virtual_token_reserves, v4), v5);
        let v7 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v6) + 1;
        assert!(v0 >= v4 + v3, 6);
        let v8 = 0x2::coin::zero<T0>(arg7);
        let (v9, v10) = swap<T0>(v2, v8, arg1, v6, v0 - v7 - v3, arg7);
        let v11 = TradedEvent{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg7),
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v7,
            token_amount           : v6,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v2.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            fee                    : v3,
            ts                     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TradedEvent>(v11);
        if (v6 == v5) {
            transfer_pool<T0>(arg0.admin, arg0.graduated_fee, v2, arg2, arg3, arg4, arg5, arg6, arg7);
        };
        (v10, v9)
    }

    public entry fun buy_exact_out<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 5);
        assert!(arg2 > 0, 2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = v1.virtual_token_reserves - 0x2::coin::value<T0>(&v1.remain_token_reserves);
        let v4 = 0x1::u64::min(arg2, v3);
        let v5 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_add_liquidity_cost(v1.virtual_sui_reserves, v1.virtual_token_reserves, v4) + 1;
        let v6 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v5), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        0x2::coin::join<0x2::sui::SUI>(&mut v1.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v6, arg8));
        assert!(v2 >= v5 + v6, 6);
        let v7 = 0x2::coin::zero<T0>(arg8);
        let (v8, v9) = swap<T0>(v1, v7, arg1, v4, v2 - v5 - v6, arg8);
        let v10 = v8;
        v1.virtual_token_reserves = v1.virtual_token_reserves - 0x2::coin::value<T0>(&v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x2::tx_context::sender(arg8));
        let v11 = TradedEvent{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg8),
            token_address          : 0x1::type_name::into_string(v0),
            sui_amount             : v5,
            token_amount           : v4,
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v1.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v1),
            fee                    : v6,
            ts                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TradedEvent>(v11);
        if (v4 == v3) {
            transfer_pool<T0>(arg0.admin, arg0.graduated_fee, v1, arg3, arg4, arg5, arg6, arg7, arg8);
        };
    }

    public fun buy_exact_out_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 5);
        assert!(arg2 > 0, 2);
        let v2 = v1.virtual_token_reserves - 0x2::coin::value<T0>(&v1.remain_token_reserves);
        let v3 = 0x1::u64::min(arg2, v2);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v5 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_add_liquidity_cost(v1.virtual_sui_reserves, v1.virtual_token_reserves, v3) + 1;
        let v6 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v5), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        assert!(v4 >= v5 + v6, 6);
        0x2::coin::join<0x2::sui::SUI>(&mut v1.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v6, arg8));
        let v7 = 0x2::coin::zero<T0>(arg8);
        let (v8, v9) = swap<T0>(v1, v7, arg1, v3, v4 - v5 - v6, arg8);
        let v10 = v8;
        v1.virtual_token_reserves = v1.virtual_token_reserves - 0x2::coin::value<T0>(&v10);
        let v11 = TradedEvent{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg8),
            token_address          : 0x1::type_name::into_string(v0),
            sui_amount             : v5,
            token_amount           : v3,
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v1.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v1),
            fee                    : v6,
            ts                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TradedEvent>(v11);
        if (v2 == v3) {
            transfer_pool<T0>(arg0.admin, arg0.graduated_fee, v1, arg3, arg4, arg5, arg6, arg7, arg8);
        };
        (v9, v10)
    }

    fun calculate_init_sui_reserves(arg0: &Configuration, arg1: u64) : u64 {
        let v0 = arg0.remain_token_reserves;
        let v1 = arg0.initial_virtual_token_reserves;
        assert!(v1 > v0, 2);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg1), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v0)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v1 - v0)))
    }

    public fun check_pool_exist<T0>(arg0: &Configuration) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, 0x1::type_name::get_address(&v0))
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: &mut 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg7) <= 300, 2);
        assert!(0x1::ascii::length(&arg8) <= 1000, 2);
        assert!(0x1::ascii::length(&arg9) <= 500, 2);
        assert!(0x1::ascii::length(&arg10) <= 500, 2);
        assert!(0x1::ascii::length(&arg11) <= 500, 2);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 7);
        let v0 = 0x1::option::get_with_default<u64>(&arg3, 3000000000);
        assert!(v0 >= 2000000000, 2);
        let v1 = Pool<T0>{
            id                          : 0x2::object::new(arg12),
            real_sui_reserves           : 0x2::coin::zero<0x2::sui::SUI>(arg12),
            real_token_reserves         : 0x2::coin::mint<T0>(&mut arg2, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg12),
            virtual_token_reserves      : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves        : calculate_init_sui_reserves(arg0, v0),
            remain_token_reserves       : 0x2::coin::mint<T0>(&mut arg2, arg0.remain_token_reserves, arg12),
            fee_recipient               : 0x2::coin::zero<0x2::sui::SUI>(arg12),
            position_graduated          : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            is_completed                : false,
            platform_fee_withdraw       : arg0.init_platform_fee_withdraw,
            creator_fee_withdraw        : arg0.init_creator_fee_withdraw,
            stake_fee_withdraw          : arg0.init_stake_fee_withdraw,
            platform_stake_fee_withdraw : arg0.init_platform_stake_fee_withdraw,
            threshold                   : v0,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg2, @0x0);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<Pool<T0>>();
        let v4 = CreatedEvent{
            name                        : arg5,
            symbol                      : arg6,
            uri                         : arg7,
            description                 : arg8,
            twitter                     : arg9,
            telegram                    : arg10,
            website                     : arg11,
            token_address               : 0x1::type_name::into_string(v2),
            bonding_curve               : 0x1::type_name::get_module(&v3),
            pool_id                     : 0x2::object::id<Pool<T0>>(&v1),
            created_by                  : 0x2::tx_context::sender(arg12),
            virtual_sui_reserves        : v1.virtual_sui_reserves,
            virtual_token_reserves      : v1.virtual_token_reserves,
            real_sui_reserves           : 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves         : 0x2::coin::value<T0>(&v1.real_token_reserves),
            platform_fee_withdraw       : v1.platform_fee_withdraw,
            creator_fee_withdraw        : v1.creator_fee_withdraw,
            stake_fee_withdraw          : v1.stake_fee_withdraw,
            platform_stake_fee_withdraw : v1.platform_stake_fee_withdraw,
            threshold                   : v0,
            ts                          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v2), v1);
        0x2::event::emit<CreatedEvent>(v4);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::initialize_staking_pool<T0>(arg1, arg4, arg12);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::initialize_creator_pool<T0>(arg1, 0x2::tx_context::sender(arg12), arg4, arg12);
    }

    public entry fun create_and_first_buy<T0>(arg0: &mut Configuration, arg1: &mut 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::Configuration, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg15: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg16: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg17: &0x2::coin::CoinMetadata<T0>, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg9) <= 300, 2);
        assert!(0x1::ascii::length(&arg10) <= 1000, 2);
        assert!(0x1::ascii::length(&arg11) <= 500, 2);
        assert!(0x1::ascii::length(&arg12) <= 500, 2);
        assert!(0x1::ascii::length(&arg13) <= 500, 2);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 7);
        let v0 = 0x1::option::get_with_default<u64>(&arg5, 3000000000);
        assert!(v0 >= 2000000000, 2);
        let v1 = Pool<T0>{
            id                          : 0x2::object::new(arg18),
            real_sui_reserves           : 0x2::coin::zero<0x2::sui::SUI>(arg18),
            real_token_reserves         : 0x2::coin::mint<T0>(&mut arg2, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg18),
            virtual_token_reserves      : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves        : calculate_init_sui_reserves(arg0, v0),
            remain_token_reserves       : 0x2::coin::mint<T0>(&mut arg2, arg0.remain_token_reserves, arg18),
            fee_recipient               : 0x2::coin::zero<0x2::sui::SUI>(arg18),
            position_graduated          : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            is_completed                : false,
            platform_fee_withdraw       : arg0.init_platform_fee_withdraw,
            creator_fee_withdraw        : arg0.init_creator_fee_withdraw,
            stake_fee_withdraw          : arg0.init_stake_fee_withdraw,
            platform_stake_fee_withdraw : arg0.init_platform_stake_fee_withdraw,
            threshold                   : v0,
        };
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<Pool<T0>>();
        let v4 = CreatedEvent{
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
            created_by                  : 0x2::tx_context::sender(arg18),
            virtual_sui_reserves        : v1.virtual_sui_reserves,
            virtual_token_reserves      : v1.virtual_token_reserves,
            real_sui_reserves           : 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves         : 0x2::coin::value<T0>(&v1.real_token_reserves),
            platform_fee_withdraw       : v1.platform_fee_withdraw,
            creator_fee_withdraw        : v1.creator_fee_withdraw,
            stake_fee_withdraw          : v1.stake_fee_withdraw,
            platform_stake_fee_withdraw : v1.platform_stake_fee_withdraw,
            threshold                   : v0,
            ts                          : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg2, @0x0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            let v5 = &mut v1;
            buy_direct<T0>(arg0.admin, arg0.graduated_fee, arg3, v5, arg4, arg0.platform_fee, arg14, arg15, arg16, arg17, arg6, arg18);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v2), v1);
        0x2::event::emit<CreatedEvent>(v4);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::initialize_staking_pool<T0>(arg1, arg6, arg18);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::initialize_creator_pool<T0>(arg1, 0x2::tx_context::sender(arg18), arg6, arg18);
    }

    public entry fun create_threshold_config(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ThresholdConfig{
            id        : 0x2::object::new(arg2),
            threshold : arg1,
        };
        0x2::transfer::public_share_object<ThresholdConfig>(v0);
    }

    public fun early_complete_pool<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut ThresholdConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        v1.is_completed = true;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves);
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut v1.real_sui_reserves, v2, arg4);
        let v4 = &v1.remain_token_reserves;
        let v5 = 0x2::coin::split<T0>(&mut v1.real_token_reserves, 0x2::coin::value<T0>(&v1.real_token_reserves), arg4);
        assert!(v2 >= arg2.threshold, 3);
        0x2::coin::join<T0>(&mut v5, 0x2::coin::split<T0>(&mut v1.remain_token_reserves, 0x2::coin::value<T0>(v4), arg4));
        if (v2 >= arg2.threshold) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, arg2.threshold, arg4), arg1.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v5, arg1.remain_token_reserves, arg4), arg1.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg4));
        let v6 = PoolCompletedEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolCompletedEvent>(v6);
    }

    public fun estimate_amount_out<T0>(arg0: &mut Configuration, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        if (arg1 > 0 && arg2 == 0) {
            (0, 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_token_amount_received(v1.virtual_sui_reserves, v1.virtual_token_reserves, arg1 - 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg1), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)))))
        } else if (arg1 == 0 && arg2 > 0) {
            let v4 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, arg2);
            (v4 - 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v4), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000))), 0)
        } else {
            (0, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Configuration{
            id                               : 0x2::object::new(arg0),
            version                          : 1,
            admin                            : 0x2::tx_context::sender(arg0),
            platform_fee                     : 100,
            graduated_fee                    : 10,
            initial_virtual_token_reserves   : 10000000000000,
            remain_token_reserves            : 2000000000000,
            token_decimals                   : 6,
            init_platform_fee_withdraw       : 1500,
            init_creator_fee_withdraw        : 3000,
            init_stake_fee_withdraw          : 3500,
            init_platform_stake_fee_withdraw : 2000,
            token_platform_type_name         : 0x1::ascii::string(b"58ebd732c49a6441edb64ce519741a74461dc11d7383b078cac1292ba0d2fee7::shro::SHRO"),
        };
        0x2::transfer::public_share_object<Configuration>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_cetus_pool<T0>(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &mut Pool<T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(&v1)) {
            let v6 = *0x1::vector::borrow<u8>(&v3, v4);
            let v7 = *0x1::vector::borrow<u8>(&v1, v4);
            if (v7 < v6) {
                v5 = false;
                break
            };
            if (v7 > v6) {
                v5 = true;
                break
            };
            v4 = v4 + 1;
        };
        if (v5) {
            let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0x2::sui::SUI>(arg5, arg4, 60, sqrt(340282366920938463463374607431768211456 * (0x2::coin::value<0x2::sui::SUI>(&arg1) as u256) / (0x2::coin::value<T0>(&arg2) as u256)), 0x1::string::utf8(b""), 4294523716, 443580, arg2, arg1, arg7, arg6, true, arg8, arg9);
            0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg3.position_graduated, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, arg0);
        } else {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<0x2::sui::SUI, T0>(arg5, arg4, 60, sqrt(340282366920938463463374607431768211456 * (0x2::coin::value<T0>(&arg2) as u256) / (0x2::coin::value<0x2::sui::SUI>(&arg1) as u256)), 0x1::string::utf8(b""), 4294523716, 443580, arg1, arg2, arg6, arg7, false, arg8, arg9);
            0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg3.position_graduated, v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, arg0);
        };
    }

    public entry fun migrate_version(arg0: &AdminCap, arg1: &mut Configuration) {
        assert!(arg1.version < 1, 10);
        arg1.version = 1;
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 5);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 2);
        let v3 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, v2);
        let v4 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v3), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        assert!(v3 - v4 >= arg2, 2);
        let v5 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v6, v7) = swap<T0>(v1, arg1, v5, 0, v3, arg4);
        let v8 = v7;
        v1.virtual_sui_reserves = v1.virtual_sui_reserves - 0x2::coin::value<0x2::sui::SUI>(&v8);
        0x2::coin::join<0x2::sui::SUI>(&mut v1.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v4, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg4));
        let v9 = TradedEvent{
            is_buy                 : false,
            user                   : 0x2::tx_context::sender(arg4),
            token_address          : 0x1::type_name::into_string(v0),
            sui_amount             : v3,
            token_amount           : v2,
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v1.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v1),
            fee                    : v4,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v9);
    }

    public fun sell_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 5);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 2);
        let v3 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, v2);
        let v4 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v3), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg0.platform_fee)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        assert!(v3 - v4 >= arg2, 2);
        let v5 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v6, v7) = swap<T0>(v1, arg1, v5, 0, v3, arg4);
        let v8 = v7;
        v1.virtual_sui_reserves = v1.virtual_sui_reserves - 0x2::coin::value<0x2::sui::SUI>(&v8);
        0x2::coin::join<0x2::sui::SUI>(&mut v1.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v4, arg4));
        let v9 = TradedEvent{
            is_buy                 : false,
            user                   : 0x2::tx_context::sender(arg4),
            token_address          : 0x1::type_name::into_string(v0),
            sui_amount             : v3,
            token_amount           : v2,
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v1.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v1),
            fee                    : v4,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v9);
        (v8, v6)
    }

    public fun skim<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        assert!(v1.is_completed, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.real_token_reserves, 0x2::coin::value<T0>(&v1.real_token_reserves), arg2), 0x2::tx_context::sender(arg2));
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 2);
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
        let v0 = OwnershipTransferredEvent{
            old_admin : 0x2::tx_context::sender(arg4),
            new_admin : arg2,
            ts        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v0);
    }

    fun transfer_pool<T0>(arg0: address, arg1: u64, arg2: &mut Pool<T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        arg2.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg2.real_token_reserves, 0x2::coin::value<T0>(&arg2.real_token_reserves), arg8);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg2.remain_token_reserves, 0x2::coin::value<T0>(&arg2.remain_token_reserves), arg8));
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&arg2.real_sui_reserves), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(0x2::coin::value<0x2::sui::SUI>(&v1)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(arg1)), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000))), arg8), arg0);
        let v2 = PoolCompletedEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PoolCompletedEvent>(v2);
        init_cetus_pool<T0>(arg0, v1, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u16, arg8: u16, arg9: u16, arg10: u16, arg11: 0x1::ascii::String, arg12: &0x2::clock::Clock) {
        assert!(((arg7 + arg8 + arg9 + arg10) as u64) <= 10000, 2);
        let v0 = ConfigChangedEvent{
            old_platform_fee                     : arg1.platform_fee,
            new_platform_fee                     : arg2,
            old_graduated_fee                    : arg1.graduated_fee,
            new_graduated_fee                    : arg3,
            old_initial_virtual_token_reserves   : arg1.initial_virtual_token_reserves,
            new_initial_virtual_token_reserves   : arg4,
            old_remain_token_reserves            : arg1.remain_token_reserves,
            new_remain_token_reserves            : arg5,
            old_token_decimals                   : arg1.token_decimals,
            new_token_decimals                   : arg6,
            old_init_platform_fee_withdraw       : arg1.init_platform_fee_withdraw,
            new_init_platform_fee_withdraw       : arg7,
            old_init_creator_fee_withdraw        : arg1.init_creator_fee_withdraw,
            new_init_creator_fee_withdraw        : arg8,
            old_init_stake_fee_withdraw          : arg1.init_stake_fee_withdraw,
            new_init_stake_fee_withdraw          : arg9,
            old_init_platform_stake_fee_withdraw : arg1.init_platform_stake_fee_withdraw,
            new_init_platform_stake_fee_withdraw : arg10,
            old_token_platform_type_name         : arg1.token_platform_type_name,
            new_token_platform_type_name         : arg11,
            ts                                   : 0x2::clock::timestamp_ms(arg12),
        };
        arg1.platform_fee = arg2;
        arg1.graduated_fee = arg3;
        arg1.initial_virtual_token_reserves = arg4;
        arg1.remain_token_reserves = arg5;
        arg1.token_decimals = arg6;
        arg1.init_platform_fee_withdraw = arg7;
        arg1.init_creator_fee_withdraw = arg8;
        arg1.init_stake_fee_withdraw = arg9;
        arg1.init_platform_stake_fee_withdraw = arg10;
        arg1.token_platform_type_name = arg11;
        0x2::event::emit<ConfigChangedEvent>(v0);
    }

    public entry fun update_threshold_config(arg0: &AdminCap, arg1: &mut ThresholdConfig, arg2: u64) {
        arg1.threshold = arg2;
    }

    public fun withdraw_fee<T0, T1>(arg0: &mut Configuration, arg1: &mut 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::Configuration, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3)) {
            assert!(v1.is_completed, 11);
            assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1.position_graduated), 11);
            let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, 0x2::sui::SUI>(arg2, 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg3), 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1.position_graduated), true);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), arg0.admin);
            0x2::coin::join<0x2::sui::SUI>(&mut v1.fee_recipient, 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg5));
        };
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v1.fee_recipient);
        if (v4 <= 10000) {
            return
        };
        assert!(0x1::type_name::into_string(0x1::type_name::get<T1>()) == arg0.token_platform_type_name, 6);
        let v5 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v4), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64((v1.platform_fee_withdraw as u64))), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        let v6 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v4), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64((v1.creator_fee_withdraw as u64))), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        let v7 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v4), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64((v1.stake_fee_withdraw as u64))), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        let v8 = 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::as_u64(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::div(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::mul(0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(v4), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64((v1.platform_stake_fee_withdraw as u64))), 0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::utils::from_u64(10000)));
        assert!(v5 + v6 + v7 + v8 <= v4, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1.fee_recipient, v5, arg5), arg0.admin);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::deposit_creator_pool<T0>(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v1.fee_recipient, v6, arg5), arg4, arg5);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::update_reward_index<T0>(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v1.fee_recipient, v7, arg5), arg4, arg5);
        0x15da812fbabc572dcfeaa66e97886fe417b2a8454a361de164e6dda76823f838::moonbags_stake::update_reward_index<T1>(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut v1.fee_recipient, v8, arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

