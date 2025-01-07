module 0x662a92d5d6912d399001eaee891f8ad185f5238db221e28bb521cc0783d7ad1a::hydro_pump {
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
        real_sui_reserves: u64,
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
        target_sui_reserves: u64,
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
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        let v0 = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        let v1 = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, v0, v1);
        arg0.virtual_token_reserves = v0;
        arg0.virtual_sui_reserves = v1;
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    public entry fun new<T0>(arg0: &mut Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::ascii::length(&arg4) <= 50, 1);
        assert!(0x1::ascii::length(&arg5) <= 20, 1);
        assert!(0x1::ascii::length(&arg6) <= 500, 1);
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
        let v3 = arg0.target_sui_reserves;
        let v4 = get_pool_mut<T0>(arg0);
        buy_direct<T0>(arg1, v4, arg2, v1, v0, v2, v3, arg3, arg4);
    }

    fun buy_<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg1.is_completed, 2);
        assert!(arg2 > 0, 1);
        let v0 = arg1.virtual_token_reserves - 0x2::coin::value<T0>(&arg1.remain_token_reserves);
        let v1 = 0x1::u64::min(arg2, v0);
        let v2 = 0x662a92d5d6912d399001eaee891f8ad185f5238db221e28bb521cc0783d7ad1a::curves::calculate_add_liquidity_cost(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v1);
        assert!(0x1::option::is_some<u64>(&v2), 3);
        let v3 = 0x1::option::extract<u64>(&mut v2) + 1;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = v3 * arg3 / 10000;
        assert!(v4 >= v3 + v5, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v5, arg8), arg4);
        let v6 = 0x2::coin::zero<T0>(arg8);
        let (v7, v8) = swap<T0>(arg1, v6, arg0, v1, v4 - v3 - v5, arg8);
        let v9 = v7;
        arg1.virtual_token_reserves = arg1.virtual_token_reserves - 0x2::coin::value<T0>(&v9);
        if (v0 == v1 || 0x2::coin::value<0x2::sui::SUI>(&arg1.real_sui_reserves) >= arg6) {
            migrate_pool<T0>(arg1, arg5, arg7, arg8);
        };
        let v10 = TradedEvent{
            pool_id                : 0x2::object::id<Pool<T0>>(arg1),
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg8),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v3,
            token_amount           : v1,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            virtual_sui_reserves   : arg1.virtual_sui_reserves,
            virtual_token_reserves : arg1.virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<TradedEvent>(v10);
        (v9, v8)
    }

    fun buy_direct<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
    }

    public fun buy_returns<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        let v0 = arg0.fee_to;
        let v1 = arg0.platform_fee;
        let v2 = arg0.migrator;
        let v3 = arg0.target_sui_reserves;
        let v4 = get_pool_mut<T0>(arg0);
        buy_<T0>(arg1, v4, arg2, v1, v0, v2, v3, arg3, arg4)
    }

    public fun deployment_fee(arg0: &Config) : u64 {
        arg0.pool_deployment_fee
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
            fee_to                         : @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631,
            migrator                       : @0x3c78da08d05a1a31ac060166e5129a77ffb9f28c8f61101ae4f79b9fccb90b2d,
            admin                          : @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631,
            platform_fee                   : 100,
            migration_pool_fee             : 0,
            pool_deployment_fee            : 2000000000,
            initial_virtual_sui_reserves   : 1150000000000,
            initial_virtual_token_reserves : 1000000000000000,
            remain_token_reserves          : 200000000000000,
            target_sui_reserves            : 4600000000000,
            token_decimals                 : 6,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun migrate_pool<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg0.real_token_reserves, 0x2::coin::value<T0>(&arg0.real_token_reserves), arg3);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg0.remain_token_reserves, 0x2::coin::value<T0>(&arg0.remain_token_reserves), arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&arg0.real_sui_reserves), arg3), arg1);
        let v1 = PoolMigratedEvent{
            token_address    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_token_value : 0x2::coin::value<T0>(&v0),
            coin_sui_value   : 0x2::coin::value<0x2::sui::SUI>(&arg0.real_sui_reserves),
            ts               : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolMigratedEvent>(v1);
    }

    entry fun migrate_version(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.admin == v0 || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.version = arg1;
    }

    public entry fun new_and_buy<T0>(arg0: &mut Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::ascii::length(&arg5) <= 50, 1);
        assert!(0x1::ascii::length(&arg6) <= 20, 1);
        assert!(0x1::ascii::length(&arg7) <= 500, 1);
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
            buy_direct<T0>(arg2, v2, arg3, arg0.platform_fee, arg0.fee_to, arg0.migrator, arg0.target_sui_reserves, arg4, arg12);
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

    public entry fun quick_buy<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = arg0.fee_to;
        let v1 = arg0.platform_fee;
        let v2 = arg0.migrator;
        let v3 = arg0.target_sui_reserves;
        let v4 = get_pool_mut<T0>(arg0);
        assert!(!v4.is_completed, 2);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v6 = 0x662a92d5d6912d399001eaee891f8ad185f5238db221e28bb521cc0783d7ad1a::curves::calculate_token_amount_received(v4.virtual_sui_reserves, v4.virtual_token_reserves, v5 - v5 * v1 / 10000);
        let v7 = 0x1::u64::min(0x1::option::extract<u64>(&mut v6), v4.virtual_token_reserves - 0x2::coin::value<T0>(&v4.remain_token_reserves));
        let v8 = get_pool_mut<T0>(arg0);
        buy_direct<T0>(arg1, v8, v7, v1, v0, v2, v3, arg2, arg3);
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
        let v4 = 0x662a92d5d6912d399001eaee891f8ad185f5238db221e28bb521cc0783d7ad1a::curves::calculate_remove_liquidity_return(v2.virtual_token_reserves, v2.virtual_sui_reserves, v3);
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
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves),
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            ts                     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TradedEvent>(v11);
        (v8, v10)
    }

    public fun skim<T0>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        let v1 = get_pool_mut<T0>(arg0);
        assert!(v1.is_completed, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves), arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.real_token_reserves, 0x2::coin::value<T0>(&v1.real_token_reserves), arg1), v0);
    }

    public entry fun transfer_admin(arg0: &mut Config, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.admin == v0 || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.admin = arg1;
        let v1 = OwnershipTransferredEvent{
            old_admin : v0,
            new_admin : arg1,
            ts        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v1);
    }

    public entry fun update_config(arg0: &mut Config, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.fee_to = arg1;
        arg0.migrator = arg2;
        arg0.platform_fee = arg3;
        arg0.migration_pool_fee = arg4;
        arg0.pool_deployment_fee = arg5;
        arg0.initial_virtual_sui_reserves = arg6;
        arg0.initial_virtual_token_reserves = arg7;
        arg0.remain_token_reserves = arg8;
        arg0.target_sui_reserves = arg9;
        arg0.token_decimals = arg10;
    }

    entry fun update_fee_to(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.fee_to = arg1;
    }

    entry fun update_initial_virtual_sui_reserves(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.initial_virtual_sui_reserves = arg1;
    }

    entry fun update_initial_virtual_token_reserves(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.initial_virtual_token_reserves = arg1;
    }

    entry fun update_migration_pool_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.migration_pool_fee = arg1;
    }

    entry fun update_migrator(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.migrator = arg1;
    }

    entry fun update_platform_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.platform_fee = arg1;
    }

    entry fun update_pool_deployment_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.pool_deployment_fee = arg1;
    }

    entry fun update_remain_token_reserves(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.remain_token_reserves = arg1;
    }

    entry fun update_target_sui_reserves(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == @0x811628c4ce168601a68ebf569ccda48435a90f4855e193d37dcf7a8a555df631, 0);
        arg0.target_sui_reserves = arg1;
    }

    // decompiled from Move bytecode v6
}

