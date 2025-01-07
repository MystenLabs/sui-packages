module 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump {
    struct PoolCreatedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        created_by: address,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        ts: u64,
    }

    struct TradedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        ts: u64,
    }

    struct OwnershipTransferredEvent has copy, drop, store {
        old_admin: address,
        new_admin: address,
        ts: u64,
    }

    struct PoolMigratedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        coin_token_value: u64,
        coin_sui_value: u64,
        ts: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_to: address,
        migrator: address,
        admin: address,
        platform_fee: u64,
        migration_pool_fee: u64,
        pool_deployment_fee: u64,
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

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 1);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        let v0 = 0x1::ascii::string(b"in swap: token amount");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x1::debug::print<u64>(&arg3);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        let v1 = 0x1::ascii::string(b"in swap: sui amount");
        0x1::debug::print<0x1::ascii::String>(&v1);
        0x1::debug::print<u64>(&arg4);
        let v2 = 0x1::ascii::string(b"in swap: pool.virtual_sui_reserves");
        0x1::debug::print<0x1::ascii::String>(&v2);
        0x1::debug::print<u64>(&arg0.virtual_sui_reserves);
        let v3 = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        let v4 = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v5 = 0x1::ascii::string(b"in swap: pool.virtual_sui_reserves");
        0x1::debug::print<0x1::ascii::String>(&v5);
        0x1::debug::print<u64>(&arg0.virtual_sui_reserves);
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, v3, v4);
        arg0.virtual_token_reserves = v3;
        arg0.virtual_sui_reserves = v4;
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    public entry fun new<T0>(arg0: &mut Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::ascii::length(&arg6) <= 300, 1);
        assert!(0x1::ascii::length(&arg7) <= 1000, 1);
        assert!(0x1::ascii::length(&arg8) <= 500, 1);
        assert!(0x1::ascii::length(&arg9) <= 500, 1);
        assert!(0x1::ascii::length(&arg10) <= 500, 1);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 4);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg11),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg11),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg11),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg11),
            is_completed           : false,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get<Pool<T0>>();
        let v3 = PoolCreatedEvent{
            pool_id                : 0x2::object::id<Pool<T0>>(&v0),
            name                   : arg4,
            symbol                 : arg5,
            uri                    : arg6,
            description            : arg7,
            twitter                : arg8,
            telegram               : arg9,
            website                : arg10,
            token_address          : 0x1::type_name::into_string(v1),
            bonding_curve          : 0x1::type_name::get_module(&v2),
            created_by             : 0x2::tx_context::sender(arg11),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolCreatedEvent>(v3);
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1), v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.pool_deployment_fee, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.pool_deployment_fee, arg11), arg0.fee_to);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg11));
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 1);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 5);
    }

    public entry fun buy<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = arg0.fee_to;
        let v1 = arg0.platform_fee;
        let v2 = arg0.migrator;
        let v3 = get_pool_mut<T0>(arg0);
        buy_direct<T0>(arg1, v3, arg2, v1, v0, v2, arg3, arg4);
    }

    fun buy_<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg1.is_completed, 2);
        let v0 = 0x1::ascii::string(b"token amount out");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x1::debug::print<u64>(&arg2);
        assert!(arg2 > 0, 1);
        let v1 = arg1.virtual_token_reserves - 0x2::coin::value<T0>(&arg1.remain_token_reserves);
        let v2 = 0x1::u64::min(arg2, v1);
        let v3 = 0x1::ascii::string(b"token amount out");
        0x1::debug::print<0x1::ascii::String>(&v3);
        0x1::debug::print<u64>(&v2);
        let v4 = 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::curves::calculate_add_liquidity_cost(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v2);
        assert!(0x1::option::is_some<u64>(&v4), 3);
        let v5 = 0x1::option::extract<u64>(&mut v4) + 1;
        let v6 = 0x1::ascii::string(b"sui amount in");
        0x1::debug::print<0x1::ascii::String>(&v6);
        0x1::debug::print<u64>(&v5);
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v8 = v5 * arg3 / 10000;
        assert!(v7 >= v5 + v8, 3);
        let v9 = 0x1::ascii::string(b"in buy_: fee");
        0x1::debug::print<0x1::ascii::String>(&v9);
        0x1::debug::print<u64>(&v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v8, arg7), arg4);
        let v10 = 0x2::coin::zero<T0>(arg7);
        let (v11, v12) = swap<T0>(arg1, v10, arg0, v2, v7 - v5 - v8, arg7);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x1::ascii::string(b"coin_sui");
        0x1::debug::print<0x1::ascii::String>(&v15);
        0x1::debug::print<0x2::coin::Coin<0x2::sui::SUI>>(&v13);
        arg1.virtual_token_reserves = arg1.virtual_token_reserves - 0x2::coin::value<T0>(&v14);
        let v16 = 0x1::ascii::string(b"pool.virtual_token_reserves");
        0x1::debug::print<0x1::ascii::String>(&v16);
        0x1::debug::print<u64>(&arg1.virtual_token_reserves);
        let v17 = 0x1::ascii::string(b"pool.virtual_sui_reserves");
        0x1::debug::print<0x1::ascii::String>(&v17);
        0x1::debug::print<u64>(&arg1.virtual_sui_reserves);
        if (v1 == v2) {
            migrate_pool<T0>(arg1, arg5, arg6, arg7);
        };
        let v18 = TradedEvent{
            pool_id                : 0x2::object::id<Pool<T0>>(arg1),
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg7),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v5,
            token_amount           : v2,
            virtual_sui_reserves   : arg1.virtual_sui_reserves,
            virtual_token_reserves : arg1.virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TradedEvent>(v18);
        (v14, v13)
    }

    fun buy_direct<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
    }

    public fun buy_returns<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        let v0 = arg0.fee_to;
        let v1 = arg0.platform_fee;
        let v2 = arg0.migrator;
        let v3 = get_pool_mut<T0>(arg0);
        buy_<T0>(arg1, v3, arg2, v1, v0, v2, arg3, arg4)
    }

    public fun get_pool<T0>(arg0: &Config) : &Pool<T0> {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0>>(&arg0.id, 0x1::type_name::get_address(&v0))
    }

    public fun get_pool_mut<T0>(arg0: &mut Config) : &mut Pool<T0> {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0))
    }

    public fun get_reserves<T0>(arg0: &Config) : (u64, u64) {
        let v0 = get_pool<T0>(arg0);
        (v0.virtual_token_reserves, v0.virtual_sui_reserves)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                             : 0x2::object::new(arg0),
            version                        : 1,
            fee_to                         : @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7,
            migrator                       : @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7,
            admin                          : @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7,
            platform_fee                   : 100,
            migration_pool_fee             : 0,
            pool_deployment_fee            : 1000000000,
            initial_virtual_sui_reserves   : 100000000,
            initial_virtual_token_reserves : 10000000000000000,
            remain_token_reserves          : 2000000000000000,
            token_decimals                 : 6,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun migrate_pool<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg0.real_token_reserves, 0x2::coin::value<T0>(&arg0.real_token_reserves), arg3);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg0.remain_token_reserves, 0x2::coin::value<T0>(&arg0.remain_token_reserves), arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0.real_sui_reserves);
        let v2 = 0x1::ascii::string(b"in migrate pool: real_sui_reserves");
        0x1::debug::print<0x1::ascii::String>(&v2);
        0x1::debug::print<u64>(&v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, v1, arg3), arg1);
        let v3 = PoolMigratedEvent{
            token_address    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_token_value : 0x2::coin::value<T0>(&v0),
            coin_sui_value   : 0x2::coin::value<0x2::sui::SUI>(&arg0.real_sui_reserves),
            ts               : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolMigratedEvent>(v3);
    }

    entry fun migrate_version(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.admin == v0 || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.version = arg1;
    }

    public entry fun new_and_buy<T0>(arg0: &mut Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::ascii::length(&arg7) <= 300, 1);
        assert!(0x1::ascii::length(&arg8) <= 1000, 1);
        assert!(0x1::ascii::length(&arg9) <= 500, 1);
        assert!(0x1::ascii::length(&arg10) <= 500, 1);
        assert!(0x1::ascii::length(&arg11) <= 500, 1);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 4);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg12),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg12),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg12),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg12),
            is_completed           : false,
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.pool_deployment_fee, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.pool_deployment_fee, arg12), arg0.fee_to);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            let v2 = &mut v0;
            buy_direct<T0>(arg2, v2, arg3, arg0.platform_fee, arg0.fee_to, arg0.migrator, arg4, arg12);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = 0x1::type_name::get<Pool<T0>>();
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1), v0);
        let v4 = PoolCreatedEvent{
            pool_id                : 0x2::object::id<Pool<T0>>(&v0),
            name                   : arg5,
            symbol                 : arg6,
            uri                    : arg7,
            description            : arg8,
            twitter                : arg9,
            telegram               : arg10,
            website                : arg11,
            token_address          : 0x1::type_name::into_string(v1),
            bonding_curve          : 0x1::type_name::get_module(&v3),
            created_by             : 0x2::tx_context::sender(arg12),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PoolCreatedEvent>(v4);
    }

    public fun platform_fee(arg0: &Config) : u64 {
        arg0.platform_fee
    }

    public fun pool_completed<T0>(arg0: &Config) : bool {
        get_pool<T0>(arg0).is_completed
    }

    public entry fun sell<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = sell_returns<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
    }

    public fun sell_returns<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        let v0 = arg0.fee_to;
        let v1 = arg0.platform_fee;
        let v2 = get_pool_mut<T0>(arg0);
        assert!(!v2.is_completed, 2);
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 > 0, 1);
        let v4 = 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::curves::calculate_remove_liquidity_return(v2.virtual_token_reserves, v2.virtual_sui_reserves, v3);
        assert!(0x1::option::is_some<u64>(&v4), 3);
        let v5 = 0x1::option::extract<u64>(&mut v4);
        let v6 = v5 * v1 / 10000;
        assert!(v5 - v6 >= arg2, 3);
        let v7 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v8, v9) = swap<T0>(v2, arg1, v7, 0, v5, arg4);
        let v10 = v9;
        v2.virtual_sui_reserves = v2.virtual_sui_reserves - 0x2::coin::value<0x2::sui::SUI>(&v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v10, v6, arg4), v0);
        let v11 = TradedEvent{
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            is_buy                 : false,
            user                   : 0x2::tx_context::sender(arg4),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v5,
            token_amount           : v3,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v11);
        (v8, v10)
    }

    public fun skim<T0>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        let v1 = get_pool_mut<T0>(arg0);
        assert!(v1.is_completed, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves), arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.real_token_reserves, 0x2::coin::value<T0>(&v1.real_token_reserves), arg1), v0);
    }

    public entry fun transfer_admin(arg0: &mut Config, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.admin == v0 || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.admin = arg1;
        let v1 = OwnershipTransferredEvent{
            old_admin : v0,
            new_admin : arg1,
            ts        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v1);
    }

    public entry fun update_config(arg0: &mut Config, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.fee_to = arg1;
        arg0.migrator = arg2;
        arg0.platform_fee = arg3;
        arg0.migration_pool_fee = arg4;
        arg0.pool_deployment_fee = arg5;
        arg0.initial_virtual_sui_reserves = arg6;
        arg0.initial_virtual_token_reserves = arg7;
        arg0.remain_token_reserves = arg8;
        arg0.token_decimals = arg9;
    }

    entry fun update_fee_to(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.fee_to = arg1;
    }

    entry fun update_initial_virtual_sui_reserves(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.initial_virtual_sui_reserves = arg1;
    }

    entry fun update_initial_virtual_token_reserves(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.initial_virtual_token_reserves = arg1;
    }

    entry fun update_migration_pool_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.migration_pool_fee = arg1;
    }

    entry fun update_migrator(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.migrator = arg1;
    }

    entry fun update_platform_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.platform_fee = arg1;
    }

    entry fun update_pool_deployment_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.pool_deployment_fee = arg1;
    }

    entry fun update_remain_token_reserves(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x6c60a3a8679f00f4f97c678e4396a26018036d87d460c335e4e5ff4aa4d907f7, 0);
        arg0.remain_token_reserves = arg1;
    }

    // decompiled from Move bytecode v6
}

