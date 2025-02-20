module 0xe40f69a56807b601a16cb465de141d4856acff3d31cb8f905f9bd85f532814ab::daox_ai {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DAOX_AI has drop {
        dummy_field: bool,
    }

    struct DaoxAi<phantom T0> has store, key {
        id: 0x2::object::UID,
        init_coin_fee: u64,
        fee_bps: u64,
        update_fee: u64,
        chat_fee: u64,
        daox_balance: 0x2::balance::Balance<T0>,
        admin: address,
        max_pool_daox: u64,
        paused: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_daox: 0x2::balance::Balance<T0>,
        pool_coin: 0x2::balance::Balance<T1>,
        total_supply: u64,
        virtual_coin_reserves: u128,
        virtual_daox_reserves: u128,
        max_pool_daox: u64,
        complete: bool,
    }

    struct AgentCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        total_supply: u64,
        max_pool_daox: u64,
        virtual_coin_reserves: u128,
        virtual_daox_reserves: u128,
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
        agent_age: u8,
        personality: 0x1::string::String,
        first_message: 0x1::string::String,
        lore: 0x1::string::String,
        style: 0x1::string::String,
        adjective: 0x1::string::String,
        knowledge: 0x1::string::String,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        daox_amount: u64,
        coin_amount: u64,
        is_buy: bool,
        pool_daox: u64,
        pool_coin: u64,
        virtual_coin_reserves: u128,
        virtual_daox_reserves: u128,
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

    public entry fun buy<T0, T1>(arg0: &mut DaoxAi<T0>, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.complete, 4);
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg3);
        if (v1 > 0) {
            let v2 = arg1.max_pool_daox - 0x2::balance::value<T0>(&arg1.pool_daox);
            let (v3, v4) = if (v1 * (10000 - arg0.fee_bps) / 10000 < v2) {
                (0x2::coin::value<T0>(&arg3), 0x2::coin::split<T0>(&mut arg3, v1 * arg0.fee_bps / 10000, arg9))
            } else {
                let v5 = v2 * arg0.fee_bps / (10000 - arg0.fee_bps);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v1 - v2 - v5, arg9), v0);
                arg1.complete = true;
                (v2, 0x2::coin::split<T0>(&mut arg3, v5, arg9))
            };
            let v6 = arg1.virtual_coin_reserves - arg1.virtual_daox_reserves * arg1.virtual_coin_reserves / (arg1.virtual_daox_reserves + (v3 as u128));
            arg1.virtual_daox_reserves = arg1.virtual_daox_reserves + (v3 as u128);
            arg1.virtual_coin_reserves = arg1.virtual_coin_reserves - v6;
            assert!(v6 >= (arg2 as u128) * (v3 as u128) * (10000 as u128) / (v1 as u128) * ((10000 - arg0.fee_bps) as u128), 3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.pool_coin, (v6 as u64), arg9), v0);
            0x2::balance::join<T0>(&mut arg0.daox_balance, 0x2::coin::into_balance<T0>(v4));
            0x2::balance::join<T0>(&mut arg1.pool_daox, 0x2::coin::into_balance<T0>(arg3));
            let v7 = SwapEvent{
                pool_id               : 0x2::object::id<Pool<T0, T1>>(arg1),
                sender                : v0,
                daox_amount           : v3 * 10000 / (10000 - arg0.fee_bps),
                coin_amount           : (v6 as u64),
                is_buy                : true,
                pool_daox             : 0x2::balance::value<T0>(&arg1.pool_daox),
                pool_coin             : 0x2::balance::value<T1>(&arg1.pool_coin),
                virtual_coin_reserves : arg1.virtual_coin_reserves,
                virtual_daox_reserves : arg1.virtual_daox_reserves,
                token_address         : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<SwapEvent>(v7);
            if (0x2::balance::value<T0>(&arg1.pool_daox) >= arg0.max_pool_daox) {
                arg1.complete = true;
            };
            if (arg1.complete == true) {
                let v8 = CompletedEvent{
                    pool_id       : 0x2::object::id<Pool<T0, T1>>(arg1),
                    token_address : 0x1::type_name::get<T1>(),
                };
                0x2::event::emit<CompletedEvent>(v8);
                let v9 = 0x2::coin::take<T0>(&mut arg1.pool_daox, 0x2::balance::value<T0>(&arg1.pool_daox), arg9);
                let v10 = 0x2::coin::take<T1>(&mut arg1.pool_coin, 0x2::balance::value<T1>(&arg1.pool_coin), arg9);
                init_cetus_pool<T0, T1>(arg0, v9, v10, arg6, arg7, arg4, arg5, arg8, arg9);
            };
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
    }

    public entry fun collect_fee<T0>(arg0: &mut DaoxAi<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.daox_balance, 0x2::balance::value<T0>(&arg0.daox_balance), arg1), arg0.admin);
    }

    public entry fun deposit_fee<T0>(arg0: &mut DaoxAi<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.daox_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: DAOX_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_cetus_pool<T0, T1>(arg0: &DaoxAi<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = *0x1::ascii::as_bytes(&v0);
        let v3 = *0x1::ascii::as_bytes(&v1);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
            let v6 = *0x1::vector::borrow<u8>(&v3, v4);
            let v7 = *0x1::vector::borrow<u8>(&v2, v4);
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
            let v8 = sqrt((0x2::coin::value<T1>(&arg2) as u256) / (0x2::coin::value<T0>(&arg1) as u256)) * 18446744073709551615;
            let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v8));
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg4, arg3, 60, v8, 0x1::string::utf8(b""), v9 - v9 % 60 - 60, 443580, arg2, arg1, arg6, arg5, true, arg7, arg8);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v10, arg0.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, arg0.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, arg0.admin);
        } else {
            let v13 = sqrt((0x2::coin::value<T0>(&arg1) as u256) / (0x2::coin::value<T1>(&arg2) as u256)) * 18446744073709551615;
            let v14 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(v13));
            let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg4, arg3, 60, v13, 0x1::string::utf8(b""), 4294523716, v14 - v14 % 60 + 60, arg1, arg2, arg5, arg6, false, arg7, arg8);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v15, arg0.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, arg0.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v17, arg0.admin);
        };
    }

    public entry fun init_module<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DaoxAi<T0>{
            id            : 0x2::object::new(arg1),
            init_coin_fee : 0,
            fee_bps       : 100,
            update_fee    : 289800000000,
            chat_fee      : 6900000,
            daox_balance  : 0x2::balance::zero<T0>(),
            admin         : 0x2::tx_context::sender(arg1),
            max_pool_daox : 10000000000000,
            paused        : false,
        };
        0x2::transfer::share_object<DaoxAi<T0>>(v0);
    }

    public entry fun sell<T0, T1>(arg0: &mut DaoxAi<T0>, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.complete, 4);
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = ((arg1.virtual_daox_reserves - arg1.virtual_daox_reserves * arg1.virtual_coin_reserves / (arg1.virtual_coin_reserves + (v1 as u128))) as u64);
        arg1.virtual_coin_reserves = arg1.virtual_coin_reserves + (v1 as u128);
        arg1.virtual_daox_reserves = arg1.virtual_daox_reserves - (v2 as u128);
        assert!(v2 * (10000 - arg0.fee_bps) / 10000 >= arg2, 3);
        let v3 = v2 * arg0.fee_bps / 10000;
        0x2::balance::join<T0>(&mut arg0.daox_balance, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg1.pool_daox, v3, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_daox, v2 - v3, arg4), v0);
        0x2::balance::join<T1>(&mut arg1.pool_coin, 0x2::coin::into_balance<T1>(arg3));
        let v4 = SwapEvent{
            pool_id               : 0x2::object::id<Pool<T0, T1>>(arg1),
            sender                : v0,
            daox_amount           : v2 - v3,
            coin_amount           : v1,
            is_buy                : false,
            pool_daox             : 0x2::balance::value<T0>(&arg1.pool_daox),
            pool_coin             : 0x2::balance::value<T1>(&arg1.pool_coin),
            virtual_coin_reserves : arg1.virtual_coin_reserves,
            virtual_daox_reserves : arg1.virtual_daox_reserves,
            token_address         : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public entry fun send_message<T0, T1>(arg0: &mut DaoxAi<T0>, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.chat_fee, 5);
        let v0 = MessageEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg1),
            sender  : 0x2::tx_context::sender(arg4),
            message : arg3,
        };
        0x2::event::emit<MessageEvent>(v0);
        0x2::balance::join<T0>(&mut arg0.daox_balance, 0x2::coin::into_balance<T0>(arg2));
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

    public entry fun start_new_coin<T0, T1>(arg0: &mut DaoxAi<T0>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: 0x2::coin::TreasuryCap<T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u8, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: &0x2::coin::CoinMetadata<T0>, arg17: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg18: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(0x2::coin::total_supply<T1>(&arg2) == 0, 2);
        assert!(0x2::coin::value<T0>(&arg3) == arg5, 2);
        assert!(0x2::coin::value<T0>(&arg4) == arg0.init_coin_fee, 5);
        let v0 = Pool<T0, T1>{
            id                    : 0x2::object::new(arg20),
            pool_daox             : 0x2::balance::zero<T0>(),
            pool_coin             : 0x2::coin::into_balance<T1>(0x2::coin::mint<T1>(&mut arg2, 1000000000000000, arg20)),
            total_supply          : 1000000000000000,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_daox_reserves : (arg0.max_pool_daox as u128) * 3 / 8,
            max_pool_daox         : arg0.max_pool_daox,
            complete              : false,
        };
        let v1 = AgentCreatedEvent{
            pool_id               : 0x2::object::id<Pool<T0, T1>>(&v0),
            total_supply          : 1000000000000000,
            max_pool_daox         : arg0.max_pool_daox,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_daox_reserves : (arg0.max_pool_daox as u128) * 3 / 8,
            name                  : 0x2::coin::get_name<T1>(arg1),
            symbol                : 0x2::coin::get_symbol<T1>(arg1),
            decimals              : 0x2::coin::get_decimals<T1>(arg1),
            description           : 0x2::coin::get_description<T1>(arg1),
            icon_url              : 0x2::coin::get_icon_url<T1>(arg1),
            sender                : 0x2::tx_context::sender(arg20),
            token_address         : 0x1::type_name::get<T1>(),
            x                     : arg6,
            telegram              : arg7,
            website               : arg8,
            agent_age             : arg9,
            personality           : arg10,
            first_message         : arg11,
            lore                  : arg12,
            style                 : arg13,
            adjective             : arg14,
            knowledge             : arg15,
        };
        0x2::event::emit<AgentCreatedEvent>(v1);
        let v2 = &mut v0;
        buy<T0, T1>(arg0, v2, 0, arg3, arg16, arg1, arg17, arg18, arg19, arg20);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T1>>(arg2);
        0x2::balance::join<T0>(&mut arg0.daox_balance, 0x2::coin::into_balance<T0>(arg4));
    }

    public entry fun update<T0>(arg0: &mut DaoxAi<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 1);
        arg0.init_coin_fee = arg1;
        arg0.fee_bps = arg2;
        arg0.update_fee = arg3;
        arg0.chat_fee = arg4;
        arg0.admin = arg5;
        arg0.max_pool_daox = arg6;
        arg0.paused = arg7;
    }

    public entry fun update_info<T0, T1>(arg0: &mut DaoxAi<T0>, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        assert!(!arg0.paused, 6);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.update_fee, 5);
        let v0 = UpdateInfoEvent{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg1),
            x        : arg3,
            telegram : arg4,
            website  : arg5,
        };
        0x2::event::emit<UpdateInfoEvent>(v0);
        0x2::balance::join<T0>(&mut arg0.daox_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun update_init_fee<T0>(arg0: &mut DaoxAi<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.init_coin_fee = arg1;
    }

    public entry fun update_max_pool<T0>(arg0: &mut DaoxAi<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.max_pool_daox = arg1;
    }

    public entry fun update_pause<T0>(arg0: &mut DaoxAi<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

