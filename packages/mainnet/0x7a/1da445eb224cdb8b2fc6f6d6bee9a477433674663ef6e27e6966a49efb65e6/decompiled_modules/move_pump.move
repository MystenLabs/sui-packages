module 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        platform_fee: u64,
        graduated_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        is_completed: bool,
    }

    struct ConfigChangedEvent has copy, drop, store {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_graduated_fee: u64,
        new_graduated_fee: u64,
        old_initial_virtual_sui_reserves: u64,
        new_initial_virtual_sui_reserves: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
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
        pool_id: 0x2::object::ID,
        ts: u64,
    }

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    public fun asert_pool_not_completed<T0>(arg0: &Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        0x1::type_name::into_string(v0);
        assert!(0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0>>(&arg0.id, 0x1::type_name::get_address(&v0)).is_completed, 9);
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 2);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 10, 4);
    }

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_version(arg0.version);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        let v3 = 0x2::object::id<Pool<T0>>(v2);
        assert!(!v2.is_completed, 5);
        assert!(arg3 > 0, 2);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v5 = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v2.remain_token_reserves);
        let v6 = 0x2::math::min(arg3, v5);
        let v7 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v6) + 1;
        let v8 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::as_u64(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::div(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::mul(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(v7), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(arg0.platform_fee)), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(10000)));
        assert!(v4 >= v7 + v8, 6);
        let v9 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v8, arg5);
        let v10 = 0x2::coin::zero<T0>(arg5);
        let (v11, v12) = swap<T0>(v2, v10, arg1, v6, v4 - v7 - v8, arg5);
        let v13 = v11;
        v2.virtual_token_reserves = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, v0);
        let v14 = arg0.admin;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v14);
        if (v5 == v6 || 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves) >= 6000000000000) {
            transfer_pool<T0>(v2, arg2, v14, arg0.graduated_fee, arg4, arg5);
        };
        let v15 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v7,
            token_amount           : v6,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            pool_id                : v3,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TradedEvent>(v15);
    }

    fun buy_direct<T0>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Pool<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::id<Pool<T0>>(arg2);
        assert!(!arg2.is_completed, 5);
        assert!(arg3 > 0, 2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = arg2.virtual_token_reserves - 0x2::coin::value<T0>(&arg2.remain_token_reserves);
        let v4 = 0x2::math::min(arg3, v3);
        let v5 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::curves::calculate_add_liquidity_cost(arg2.virtual_sui_reserves, arg2.virtual_token_reserves, v4) + 1;
        let v6 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::as_u64(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::div(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::mul(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(v5), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(arg4)), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(10000)));
        assert!(v2 >= v5 + v6, 6);
        let v7 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v6, arg8);
        let v8 = 0x2::coin::zero<T0>(arg8);
        let (v9, v10) = swap<T0>(arg2, v8, arg1, v4, v2 - v5 - v6, arg8);
        let v11 = v9;
        arg2.virtual_token_reserves = arg2.virtual_token_reserves - 0x2::coin::value<T0>(&v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, arg5);
        if (v3 == v4 || 0x2::coin::value<0x2::sui::SUI>(&arg2.real_sui_reserves) >= 6000000000000) {
            transfer_pool<T0>(arg2, arg0, arg5, arg6, arg7, arg8);
        };
        let v12 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v5,
            token_amount           : v4,
            virtual_sui_reserves   : arg2.virtual_sui_reserves,
            virtual_token_reserves : arg2.virtual_token_reserves,
            pool_id                : v1,
            ts                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TradedEvent>(v12);
    }

    public fun buy_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_version(arg0.version);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        let v3 = 0x2::object::id<Pool<T0>>(v2);
        assert!(!v2.is_completed, 5);
        assert!(arg3 > 0, 2);
        let v4 = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v2.remain_token_reserves);
        let v5 = 0x2::math::min(arg3, v4);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v7 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v5) + 1;
        let v8 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::as_u64(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::div(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::mul(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(v7), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(arg0.platform_fee)), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(10000)));
        assert!(v6 >= v7 + v8, 6);
        let v9 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v8, arg5);
        let v10 = 0x2::coin::zero<T0>(arg5);
        let (v11, v12) = swap<T0>(v2, v10, arg1, v5, v6 - v7 - v8, arg5);
        let v13 = v11;
        v2.virtual_token_reserves = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v13);
        let v14 = arg0.admin;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v14);
        if (v4 == v5 || 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves) >= 6000000000000) {
            transfer_pool<T0>(v2, arg2, v14, arg0.graduated_fee, arg4, arg5);
        };
        let v15 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v7,
            token_amount           : v5,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            pool_id                : v3,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TradedEvent>(v15);
        (v12, v13)
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public entry fun create_and_first_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public entry fun create_and_first_buy_v2<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::DenyCap<T0>, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::ascii::String, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg10) <= 300, 2);
        assert!(0x1::ascii::length(&arg11) <= 1000, 2);
        assert!(0x1::ascii::length(&arg12) <= 500, 2);
        assert!(0x1::ascii::length(&arg13) <= 500, 2);
        assert!(0x1::ascii::length(&arg14) <= 500, 2);
        assert!(0x2::coin::get_decimals<T0>(arg1) == 6, 2);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 7);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<T0>>(arg2, @0x0);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg15),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg15),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg3, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg15),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg3, arg0.remain_token_reserves, arg15),
            is_completed           : false,
        };
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            let v2 = &mut v0;
            buy_direct<T0>(arg4, arg5, v2, arg6, arg0.platform_fee, arg0.admin, arg0.graduated_fee, arg7, arg15);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1), v0);
        let v3 = 0x1::type_name::get<Pool<T0>>();
        let v4 = CreatedEvent{
            name                   : arg8,
            symbol                 : arg9,
            uri                    : arg10,
            description            : arg11,
            twitter                : arg12,
            telegram               : arg13,
            website                : arg14,
            token_address          : 0x1::type_name::into_string(v1),
            bonding_curve          : 0x1::type_name::get_module(&v3),
            pool_id                : 0x2::object::id<Pool<T0>>(&v0),
            created_by             : 0x2::tx_context::sender(arg15),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<CreatedEvent>(v4);
    }

    public entry fun create_v2<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::DenyCap<T0>, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg7) <= 300, 2);
        assert!(0x1::ascii::length(&arg8) <= 1000, 2);
        assert!(0x1::ascii::length(&arg9) <= 500, 2);
        assert!(0x1::ascii::length(&arg10) <= 500, 2);
        assert!(0x1::ascii::length(&arg11) <= 500, 2);
        assert!(0x2::coin::get_decimals<T0>(arg1) == 6, 2);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 7);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<T0>>(arg2, @0x0);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg12),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg12),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg3, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg12),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg3, arg0.remain_token_reserves, arg12),
            is_completed           : false,
        };
        let v1 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1), v0);
        let v2 = 0x1::type_name::get<Pool<T0>>();
        let v3 = CreatedEvent{
            name                   : arg5,
            symbol                 : arg6,
            uri                    : arg7,
            description            : arg8,
            twitter                : arg9,
            telegram               : arg10,
            website                : arg11,
            token_address          : 0x1::type_name::into_string(v1),
            bonding_curve          : 0x1::type_name::get_module(&v2),
            pool_id                : 0x2::object::id<Pool<T0>>(&v0),
            created_by             : 0x2::tx_context::sender(arg12),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CreatedEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                             : 0x2::object::new(arg0),
            version                        : 10,
            admin                          : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            platform_fee                   : 50,
            graduated_fee                  : 300000000000,
            initial_virtual_sui_reserves   : 3000000000000,
            initial_virtual_token_reserves : 10000000000000000,
            remain_token_reserves          : 2000000000000000,
            token_decimals                 : 6,
        };
        0x2::transfer::public_share_object<Configuration>(v0);
    }

    public entry fun migrate_version(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.admin == v0 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.version = arg1;
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        let v3 = 0x2::object::id<Pool<T0>>(v2);
        assert_version(arg0.version);
        assert!(!v2.is_completed, 5);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 > 0, 2);
        let v5 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::curves::calculate_remove_liquidity_return(v2.virtual_token_reserves, v2.virtual_sui_reserves, v4);
        let v6 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::as_u64(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::div(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::mul(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(v5), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(arg0.platform_fee)), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(10000)));
        assert!(v5 - v6 >= arg2, 2);
        let v7 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v8, v9) = swap<T0>(v2, arg1, v7, 0, v5, arg4);
        let v10 = v9;
        v2.virtual_sui_reserves = v2.virtual_sui_reserves - 0x2::coin::value<0x2::sui::SUI>(&v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v6, arg4), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v0);
        let v11 = TradedEvent{
            is_buy                 : false,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v5,
            token_amount           : v4,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            pool_id                : v3,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v11);
    }

    public fun sell_returns<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        let v3 = 0x2::object::id<Pool<T0>>(v2);
        assert!(!v2.is_completed, 5);
        assert_version(arg0.version);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 > 0, 2);
        let v5 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::curves::calculate_remove_liquidity_return(v2.virtual_token_reserves, v2.virtual_sui_reserves, v4);
        let v6 = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::as_u64(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::div(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::mul(0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(v5), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(arg0.platform_fee)), 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::utils::from_u64(10000)));
        assert!(v5 - v6 >= arg2, 2);
        let v7 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v8, v9) = swap<T0>(v2, arg1, v7, 0, v5, arg4);
        let v10 = v9;
        v2.virtual_sui_reserves = v2.virtual_sui_reserves - 0x2::coin::value<0x2::sui::SUI>(&v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v6, arg4), arg0.admin);
        let v11 = TradedEvent{
            is_buy                 : false,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v5,
            token_amount           : v4,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            pool_id                : v3,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v11);
        (v10, v8)
    }

    public fun skim<T0>(arg0: &mut Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(v2.is_completed, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves), arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v2.real_token_reserves, 0x2::coin::value<T0>(&v2.real_token_reserves), arg1), v0);
    }

    public entry fun transfer_admin(arg0: &mut Configuration, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.admin == v0 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.admin = arg1;
        let v1 = OwnershipTransferredEvent{
            old_admin : v0,
            new_admin : arg1,
            ts        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v1);
    }

    fun transfer_pool<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg0.real_token_reserves, 0x2::coin::value<T0>(&arg0.real_token_reserves), arg5);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg0.remain_token_reserves, 0x2::coin::value<T0>(&arg0.remain_token_reserves), arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&arg0.real_sui_reserves), arg5), @0x1937f2c5ce1cbab08893b63945c20cde349e4a7850eea317b965ff8da383c80e);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, @0x1937f2c5ce1cbab08893b63945c20cde349e4a7850eea317b965ff8da383c80e);
        let v1 = PoolCompletedEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PoolCompletedEvent>(v1);
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg0.admin == v0 || v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 1);
        arg0.platform_fee = arg1;
        arg0.graduated_fee = arg2;
        arg0.initial_virtual_sui_reserves = arg3;
        arg0.initial_virtual_token_reserves = arg4;
        arg0.remain_token_reserves = arg5;
        arg0.token_decimals = arg6;
        let v1 = ConfigChangedEvent{
            old_platform_fee                   : arg0.platform_fee,
            new_platform_fee                   : arg1,
            old_graduated_fee                  : arg0.graduated_fee,
            new_graduated_fee                  : arg2,
            old_initial_virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            new_initial_virtual_sui_reserves   : arg3,
            old_initial_virtual_token_reserves : arg0.initial_virtual_token_reserves,
            new_initial_virtual_token_reserves : arg4,
            old_remain_token_reserves          : arg0.remain_token_reserves,
            new_remain_token_reserves          : arg5,
            old_token_decimals                 : arg0.token_decimals,
            new_token_decimals                 : arg6,
            ts                                 : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ConfigChangedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

