module 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::bunpad {
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
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        fee_recipient: 0x2::coin::Coin<0x2::sui::SUI>,
        is_completed: bool,
        platform_fee_withdraw: u16,
        creator_fee_withdraw: u16,
        stake_fee_withdraw: u16,
        threshold: u64,
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
        threshold: u64,
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

    struct PoolCompletedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
    }

    struct PoolMigratingEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        ts: u64,
    }

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 1);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 3);
    }

    fun buy_direct<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_completed, 6);
        assert!(arg2 > 0, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = arg1.virtual_token_reserves - get_virtual_remain_token_reserves<T0>(arg1);
        let v2 = 0x1::u64::min(arg2, v1);
        let v3 = 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::curves::calculate_add_liquidity_cost(arg1.virtual_sui_reserves, arg1.virtual_token_reserves, v2) + 1;
        let v4 = 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(v3), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg3)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(10000)));
        assert!(v0 >= v3 + v4, 2);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg5));
        let v5 = 0x2::coin::zero<T0>(arg5);
        let (v6, v7) = swap<T0>(arg1, v5, arg0, v2, v0 - v3 - v4, arg5);
        let v8 = v6;
        arg1.virtual_token_reserves = arg1.virtual_token_reserves - 0x2::coin::value<T0>(&v8);
        let v9 = TradedEvent{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg5),
            token_address          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount             : v3,
            token_amount           : v2,
            virtual_sui_reserves   : arg1.virtual_sui_reserves,
            virtual_token_reserves : arg1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&arg1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&arg1.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(arg1),
            fee                    : v4,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TradedEvent>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg5));
        if (v1 == v2) {
            transfer_pool<T0>(arg1, arg4, arg5);
        };
    }

    public fun buy_exact_in<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg2 > 0, 1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(!v2.is_completed, 4);
        let v3 = 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::curves::calculate_remove_liquidity_return(v2.virtual_sui_reserves, v2.virtual_token_reserves, arg2);
        let v4 = v2.virtual_token_reserves - get_virtual_remain_token_reserves<T0>(v2);
        let (v5, v6) = if (v3 > v4) {
            let v6 = 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v4) + 1;
            (v4, v6)
        } else {
            (v3, arg2)
        };
        assert!(v5 >= arg3, 1);
        let v7 = 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(v6), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.platform_fee)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(10000)));
        assert!(v0 >= v6 + v7, 5);
        0x2::coin::join<0x2::sui::SUI>(&mut v2.fee_recipient, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v7, arg5));
        let v8 = 0x2::coin::zero<T0>(arg5);
        let (v9, v10) = swap<T0>(v2, v8, arg1, v5, v0 - v6 - v7, arg5);
        let v11 = TradedEvent{
            is_buy                 : true,
            user                   : 0x2::tx_context::sender(arg5),
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v6,
            token_amount           : v5,
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v2.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v2.real_token_reserves),
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
            fee                    : v7,
            ts                     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TradedEvent>(v11);
        if (v5 == v4) {
            transfer_pool<T0>(v2, arg4, arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x2::tx_context::sender(arg5));
    }

    fun calculate_init_sui_reserves(arg0: &Configuration, arg1: u64) : u64 {
        let v0 = arg0.remain_token_reserves;
        let v1 = arg0.initial_virtual_token_reserves;
        assert!(v1 > v0, 8);
        0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg1), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(v0)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(v1 - v0)))
    }

    public fun create_and_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x2::coin::CoinMetadata<T0>, arg15: &mut 0x2::tx_context::TxContext) {
        validate_strings(&arg9, &arg10, &arg11, &arg12, &arg13);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 1);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 4);
        let v0 = 0x1::option::get_with_default<u64>(&arg5, 500000000);
        assert!(v0 >= 400000000, 5);
        let v1 = Pool<T0>{
            id                     : 0x2::object::new(arg15),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg15),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves, arg15),
            virtual_token_reserves : 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.initial_virtual_token_reserves), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.initial_virtual_token_reserves)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.initial_virtual_token_reserves - arg0.remain_token_reserves))),
            virtual_sui_reserves   : calculate_init_sui_reserves(arg0, v0),
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg15),
            fee_recipient          : 0x2::coin::zero<0x2::sui::SUI>(arg15),
            is_completed           : false,
            platform_fee_withdraw  : arg0.init_platform_fee_withdraw,
            creator_fee_withdraw   : arg0.init_creator_fee_withdraw,
            stake_fee_withdraw     : arg0.init_stake_fee_withdraw,
            threshold              : v0,
        };
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"virtual_token_reserves", 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.remain_token_reserves), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.initial_virtual_token_reserves)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.initial_virtual_token_reserves - arg0.remain_token_reserves))));
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v1.id, b"pool_creation_timestamp", 0x2::clock::timestamp_ms(arg6));
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::CoinMetadata<T0>>(&mut v1.id, b"metadata_token", arg14);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<Pool<T0>>();
        let v4 = CreatedEvent{
            name                   : arg7,
            symbol                 : arg8,
            uri                    : arg9,
            description            : arg10,
            twitter                : arg11,
            telegram               : arg12,
            website                : arg13,
            token_address          : 0x1::type_name::into_string(v2),
            bonding_curve          : 0x1::type_name::get_module(&v3),
            pool_id                : 0x2::object::id<Pool<T0>>(&v1),
            created_by             : 0x2::tx_context::sender(arg15),
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            real_sui_reserves      : 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::coin::value<T0>(&v1.real_token_reserves),
            platform_fee_withdraw  : v1.platform_fee_withdraw,
            creator_fee_withdraw   : v1.creator_fee_withdraw,
            stake_fee_withdraw     : v1.stake_fee_withdraw,
            threshold              : v0,
            ts                     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            let v5 = &mut v1;
            buy_direct<T0>(arg3, v5, arg4, arg0.platform_fee, arg6, arg15);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v2), v1);
        0x2::event::emit<CreatedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 1000000000, arg15), arg0.fee_platform_recipient);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg15));
    }

    public fun distribute_fees<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.fee_recipient, 0x2::coin::value<0x2::sui::SUI>(&arg0.fee_recipient), arg1), @0x9341cccd3fe0780ab41afc338581b49600b24c072ee78ac1ff8ecac2400ca956);
    }

    public fun estimate_amount_out<T0>(arg0: &mut Configuration, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        if (arg1 > 0 && arg2 == 0) {
            (0, 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::curves::calculate_token_amount_received(v1.virtual_sui_reserves, v1.virtual_token_reserves, arg1 - 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg1), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.platform_fee)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(10000)))))
        } else if (arg1 == 0 && arg2 > 0) {
            let v4 = 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, arg2);
            (v4 - 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(v4), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.platform_fee)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(10000))), 0)
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
            id                             : 0x2::object::new(arg0),
            version                        : 1,
            admin                          : 0x2::tx_context::sender(arg0),
            treasury                       : 0x2::tx_context::sender(arg0),
            fee_platform_recipient         : 0x2::tx_context::sender(arg0),
            platform_fee                   : 100,
            initial_virtual_token_reserves : 800000000000000,
            remain_token_reserves          : 200000000000000,
            token_decimals                 : 6,
            init_platform_fee_withdraw     : 2000,
            init_creator_fee_withdraw      : 4000,
            init_stake_fee_withdraw        : 4000,
        };
        0x2::transfer::public_share_object<Configuration>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 4);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 1);
        let v3 = 0x1::u64::min(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_sui_reserves, v2), 0x2::coin::value<0x2::sui::SUI>(&v1.real_sui_reserves));
        let v4 = 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::as_u64(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::div(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::mul(0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(v3), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(arg0.platform_fee)), 0xa950091aea5928da3857fd6d03e52df535d867a87dde3d5ba79781d12bf52e0e::utils::from_u64(10000)));
        assert!(v3 - v4 >= arg2, 1);
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

    fun transfer_pool<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        let v0 = 0x2::coin::split<T0>(&mut arg0.real_token_reserves, 0x2::coin::value<T0>(&arg0.real_token_reserves), arg2);
        0x2::coin::join<T0>(&mut v0, 0x2::coin::split<T0>(&mut arg0.remain_token_reserves, 0x2::coin::value<T0>(&arg0.remain_token_reserves), arg2));
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, 0x2::coin::value<0x2::sui::SUI>(&arg0.real_sui_reserves), arg2);
        let v2 = PoolCompletedEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            lp            : 0x1::ascii::string(b"0x0"),
            ts            : 0x2::clock::timestamp_ms(arg1),
        };
        0x1::debug::print<PoolCompletedEvent>(&v2);
        0x2::event::emit<PoolCompletedEvent>(v2);
        let v3 = PoolMigratingEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount    : 0x2::coin::value<0x2::sui::SUI>(&v1),
            token_amount  : 0x2::coin::value<T0>(&v0),
            ts            : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PoolMigratingEvent>(v3);
        let v4 = @0x9341cccd3fe0780ab41afc338581b49600b24c072ee78ac1ff8ecac2400ca956;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(0x2::dynamic_object_field::remove<vector<u8>, 0x2::coin::CoinMetadata<T0>>(&mut arg0.id, b"metadata_token"));
    }

    fun validate_strings(arg0: &0x1::ascii::String, arg1: &0x1::ascii::String, arg2: &0x1::ascii::String, arg3: &0x1::ascii::String, arg4: &0x1::ascii::String) {
        assert!(0x1::ascii::length(arg0) <= 300, 1);
        assert!(0x1::ascii::length(arg1) <= 1000, 1);
        assert!(0x1::ascii::length(arg2) <= 500, 1);
        assert!(0x1::ascii::length(arg3) <= 500, 1);
        assert!(0x1::ascii::length(arg4) <= 500, 1);
    }

    // decompiled from Move bytecode v6
}

