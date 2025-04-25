module 0x7a22996f088769f6306645ea1e6b04cc78d670919a45925c059370ee7481a260::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    struct SuiPump has store, key {
        id: 0x2::object::UID,
        init_coin_fee: u64,
        fee_bps: u64,
        update_fee: u64,
        chat_fee: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        max_pool_sui: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_coin: 0x2::balance::Balance<T0>,
        total_supply: u64,
        virtual_coin_reserves: u128,
        virtual_sui_reserves: u128,
        max_pool_sui: u64,
        complete: bool,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        total_supply: u64,
        max_pool_sui: u64,
        virtual_coin_reserves: u128,
        virtual_sui_reserves: u128,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        decimals: u8,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        sender: address,
        token_address: 0x1::type_name::TypeName,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        sui_amount: u64,
        coin_amount: u64,
        is_buy: bool,
        pool_sui: u64,
        pool_coin: u64,
        virtual_coin_reserves: u128,
        virtual_sui_reserves: u128,
        token_address: 0x1::type_name::TypeName,
    }

    struct CompletedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_address: 0x1::type_name::TypeName,
    }

    struct UpdateInfoEvent has copy, drop {
        pool_id: 0x2::object::ID,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
    }

    struct MessageEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        message: 0x1::string::String,
    }

    public entry fun buy<T0>(arg0: &mut SuiPump, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        if (v1 > 0) {
            let v2 = arg1.max_pool_sui - 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui);
            let (v3, v4) = if (v1 * (10000 - arg0.fee_bps) / 10000 < v2) {
                (0x2::coin::value<0x2::sui::SUI>(&arg3), 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 * arg0.fee_bps / 10000, arg4))
            } else {
                let v5 = v2 * arg0.fee_bps / (10000 - arg0.fee_bps);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 - v2 - v5, arg4), v0);
                arg1.complete = true;
                (v2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg4))
            };
            let v6 = arg1.virtual_coin_reserves - arg1.virtual_sui_reserves * arg1.virtual_coin_reserves / (arg1.virtual_sui_reserves + (v3 as u128));
            arg1.virtual_sui_reserves = arg1.virtual_sui_reserves + (v3 as u128);
            arg1.virtual_coin_reserves = arg1.virtual_coin_reserves - v6;
            assert!(v6 >= (arg2 as u128) * (v3 as u128) * 10000 / (v1 as u128) / (10000 - (arg0.fee_bps as u128)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, (v6 as u64), arg4), v0);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
            let v7 = SwapEvent{
                pool_id               : 0x2::object::id<Pool<T0>>(arg1),
                sender                : v0,
                sui_amount            : v3 * 10000 / (10000 - arg0.fee_bps),
                coin_amount           : (v6 as u64),
                is_buy                : true,
                pool_sui              : 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui),
                pool_coin             : 0x2::balance::value<T0>(&arg1.pool_coin),
                virtual_coin_reserves : arg1.virtual_coin_reserves,
                virtual_sui_reserves  : arg1.virtual_sui_reserves,
                token_address         : 0x1::type_name::get<T0>(),
            };
            0x2::event::emit<SwapEvent>(v7);
            if (arg1.complete == true) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, 0x2::balance::value<T0>(&arg1.pool_coin), arg4), @0x5e043294d640c39421755318da31da61da9198fae82392c44f425816c8b23def);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui), arg4), @0x5e043294d640c39421755318da31da61da9198fae82392c44f425816c8b23def);
                let v8 = CompletedEvent{
                    pool_id       : 0x2::object::id<Pool<T0>>(arg1),
                    token_address : 0x1::type_name::get<T0>(),
                };
                0x2::event::emit<CompletedEvent>(v8);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
    }

    public entry fun collect_fee(arg0: &mut SuiPump, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg1), @0x5e043294d640c39421755318da31da61da9198fae82392c44f425816c8b23def);
    }

    public entry fun deposit_fee(arg0: &mut SuiPump, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut SuiPump, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, 0x2::balance::value<T0>(&arg1.pool_coin), arg2), @0x5e043294d640c39421755318da31da61da9198fae82392c44f425816c8b23def);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui), arg2), @0x5e043294d640c39421755318da31da61da9198fae82392c44f425816c8b23def);
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiPump{
            id            : 0x2::object::new(arg1),
            init_coin_fee : 0,
            fee_bps       : 100,
            update_fee    : 500000,
            chat_fee      : 0,
            sui_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            admin         : @0x5e043294d640c39421755318da31da61da9198fae82392c44f425816c8b23def,
            max_pool_sui  : 60000000,
        };
        0x2::transfer::share_object<SuiPump>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SUIPUMP>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun sell<T0>(arg0: &mut SuiPump, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = ((arg1.virtual_sui_reserves - arg1.virtual_sui_reserves * arg1.virtual_coin_reserves / (arg1.virtual_coin_reserves + (v1 as u128))) as u64);
        arg1.virtual_coin_reserves = arg1.virtual_coin_reserves + (v1 as u128);
        arg1.virtual_sui_reserves = arg1.virtual_sui_reserves - (v2 as u128);
        assert!(v2 * (10000 - arg0.fee_bps) / 10000 >= arg2, 2);
        let v3 = v2 * arg0.fee_bps / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v3, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v2 - v3, arg4), v0);
        0x2::balance::join<T0>(&mut arg1.pool_coin, 0x2::coin::into_balance<T0>(arg3));
        let v4 = SwapEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(arg1),
            sender                : v0,
            sui_amount            : v2 - v3,
            coin_amount           : v1,
            is_buy                : false,
            pool_sui              : 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui),
            pool_coin             : 0x2::balance::value<T0>(&arg1.pool_coin),
            virtual_coin_reserves : arg1.virtual_coin_reserves,
            virtual_sui_reserves  : arg1.virtual_sui_reserves,
            token_address         : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public entry fun send_message<T0>(arg0: &mut SuiPump, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.chat_fee, 1);
        let v0 = MessageEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            sender  : 0x2::tx_context::sender(arg4),
            message : arg3,
        };
        0x2::event::emit<MessageEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x0);
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

    public entry fun start_new_coin<T0>(arg0: &mut SuiPump, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0);
        let v0 = 0x2::coin::mint<T0>(&mut arg2, 1000000000000000, arg12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg0.init_coin_fee, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg5, 1);
        let v1 = (1000000000000000 as u256) / 5 / 100000;
        let v2 = (arg0.max_pool_sui as u256) * 11 / 12 / 100000;
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::create_pool_with_liquidity<T0, 0x2::sui::SUI>(arg9, arg10, 60, sqrt(340282366920938463463374607431768211456 * v2 / v1), 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::split<T0>(&mut v0, (v1 as u64), arg12), 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, (v2 as u64), arg12), (v1 as u64), (v2 as u64), true, arg11, arg12);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, @0x0);
        let v6 = Pool<T0>{
            id                    : 0x2::object::new(arg12),
            pool_sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_coin             : 0x2::coin::into_balance<T0>(v0),
            total_supply          : 1000000000000000,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_sui_reserves  : (arg0.max_pool_sui as u128) * 3 / 8,
            max_pool_sui          : arg0.max_pool_sui,
            complete              : false,
        };
        let v7 = PoolCreatedEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(&v6),
            total_supply          : 1000000000000000,
            max_pool_sui          : arg0.max_pool_sui,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_sui_reserves  : (arg0.max_pool_sui as u128) * 3 / 8,
            name                  : 0x2::coin::get_name<T0>(&arg1),
            symbol                : 0x2::coin::get_symbol<T0>(&arg1),
            decimals              : 0x2::coin::get_decimals<T0>(&arg1),
            description           : 0x2::coin::get_description<T0>(&arg1),
            icon_url              : 0x2::coin::get_icon_url<T0>(&arg1),
            sender                : 0x2::tx_context::sender(arg12),
            token_address         : 0x1::type_name::get<T0>(),
            x                     : arg6,
            telegram              : arg7,
            website               : arg8,
        };
        0x2::event::emit<PoolCreatedEvent>(v7);
        let v8 = &mut v6;
        buy<T0>(arg0, v8, 0, arg3, arg12);
        0x2::transfer::public_share_object<Pool<T0>>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0x0);
    }

    public entry fun update(arg0: &mut SuiPump, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 3);
        arg0.init_coin_fee = arg1;
        arg0.fee_bps = arg2;
        arg0.update_fee = arg3;
        arg0.chat_fee = arg4;
        arg0.admin = arg5;
        arg0.max_pool_sui = arg6;
    }

    public entry fun update_info<T0>(arg0: &mut SuiPump, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.update_fee, 1);
        let v0 = UpdateInfoEvent{
            pool_id  : 0x2::object::id<Pool<T0>>(arg1),
            x        : arg3,
            telegram : arg4,
            website  : arg5,
        };
        0x2::event::emit<UpdateInfoEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x5e043294d640c39421755318da31da61da9198fae82392c44f425816c8b23def);
    }

    public entry fun update_init_fee(arg0: &mut SuiPump, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.init_coin_fee = arg1;
    }

    public entry fun update_max_pool(arg0: &mut SuiPump, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.max_pool_sui = arg1;
    }

    // decompiled from Move bytecode v6
}

