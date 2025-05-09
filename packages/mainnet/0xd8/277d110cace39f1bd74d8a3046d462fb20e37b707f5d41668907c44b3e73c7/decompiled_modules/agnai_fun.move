module 0xd8277d110cace39f1bd74d8a3046d462fb20e37b707f5d41668907c44b3e73c7::agnai_fun {
    struct AGNAI_FUN has drop {
        dummy_field: bool,
    }

    struct AgnAi<phantom T0> has store, key {
        id: 0x2::object::UID,
        init_coin_fee: u64,
        fee_bps: u64,
        update_fee: u64,
        chat_fee: u64,
        sui_balance: 0x2::balance::Balance<T0>,
        admin: address,
        max_pool_agn: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_agn: 0x2::balance::Balance<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>,
        pool_coin: 0x2::balance::Balance<T0>,
        total_supply: u64,
        virtual_coin_reserves: u128,
        virtual_agn_reserves: u128,
        max_pool_agn: u64,
        complete: bool,
    }

    struct AgentCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        total_supply: u64,
        max_pool_agn: u64,
        virtual_coin_reserves: u128,
        virtual_agn_reserves: u128,
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
        sui_amount: u64,
        coin_amount: u64,
        is_buy: bool,
        pool_agn: u64,
        pool_coin: u64,
        virtual_coin_reserves: u128,
        virtual_agn_reserves: u128,
        token_address: 0x1::type_name::TypeName,
    }

    struct CompletedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_address: 0x1::type_name::TypeName,
    }

    struct UpdateAgentInfoEvent has copy, drop {
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

    public entry fun buy<T0>(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg3);
        if (v1 > 0) {
            let v2 = arg1.max_pool_agn - 0x2::balance::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg1.pool_agn);
            let (v3, v4) = if (v1 * (10000 - arg0.fee_bps) / 10000 < v2) {
                (0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg3), 0x2::coin::split<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg3, v1 * arg0.fee_bps / 10000, arg4))
            } else {
                let v5 = v2 * arg0.fee_bps / (10000 - arg0.fee_bps);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(0x2::coin::split<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg3, v1 - v2 - v5, arg4), v0);
                arg1.complete = true;
                (v2, 0x2::coin::split<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg3, v5, arg4))
            };
            let v6 = arg1.virtual_coin_reserves - arg1.virtual_agn_reserves * arg1.virtual_coin_reserves / (arg1.virtual_agn_reserves + (v3 as u128));
            arg1.virtual_agn_reserves = arg1.virtual_agn_reserves + (v3 as u128);
            arg1.virtual_coin_reserves = arg1.virtual_coin_reserves - v6;
            assert!(v6 >= (arg2 as u128) * (v3 as u128) * 10000 / (v1 as u128) / (10000 - (arg0.fee_bps as u128)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, (v6 as u64), arg4), v0);
            0x2::balance::join<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(v4));
            0x2::balance::join<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg1.pool_agn, 0x2::coin::into_balance<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(arg3));
            let v7 = SwapEvent{
                pool_id               : 0x2::object::id<Pool<T0>>(arg1),
                sender                : v0,
                sui_amount            : v3 * 10000 / (10000 - arg0.fee_bps),
                coin_amount           : (v6 as u64),
                is_buy                : true,
                pool_agn              : 0x2::balance::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg1.pool_agn),
                pool_coin             : 0x2::balance::value<T0>(&arg1.pool_coin),
                virtual_coin_reserves : arg1.virtual_coin_reserves,
                virtual_agn_reserves  : arg1.virtual_agn_reserves,
                token_address         : 0x1::type_name::get<T0>(),
            };
            0x2::event::emit<SwapEvent>(v7);
            if (0x2::balance::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg1.pool_agn) >= arg0.max_pool_agn) {
                arg1.complete = true;
            };
            if (arg1.complete == true) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, 0x2::balance::value<T0>(&arg1.pool_coin), arg4), @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(0x2::coin::take<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg1.pool_agn, 0x2::balance::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg1.pool_agn), arg4), @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
                let v8 = CompletedEvent{
                    pool_id       : 0x2::object::id<Pool<T0>>(arg1),
                    token_address : 0x1::type_name::get<T0>(),
                };
                0x2::event::emit<CompletedEvent>(v8);
            };
        } else {
            0x2::coin::destroy_zero<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(arg3);
        };
    }

    public entry fun collect_fee(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(0x2::coin::take<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg0.sui_balance, 0x2::balance::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg0.sui_balance), arg1), @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
    }

    public entry fun create_new_agent<T0>(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg4: 0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u8, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0);
        assert!(0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg4) == arg0.init_coin_fee, 1);
        assert!(0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg3) == arg5, 1);
        let v0 = Pool<T0>{
            id                    : 0x2::object::new(arg16),
            pool_agn              : 0x2::balance::zero<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(),
            pool_coin             : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg2, 1000000000000000, arg16)),
            total_supply          : 1000000000000000,
            virtual_coin_reserves : 1100000000000000,
            virtual_agn_reserves  : (arg0.max_pool_agn as u128) * 1 / 10,
            max_pool_agn          : arg0.max_pool_agn,
            complete              : false,
        };
        let v1 = AgentCreatedEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(&v0),
            total_supply          : 1000000000000000,
            max_pool_agn          : arg0.max_pool_agn,
            virtual_coin_reserves : 1100000000000000,
            virtual_agn_reserves  : (arg0.max_pool_agn as u128) * 1 / 10,
            name                  : 0x2::coin::get_name<T0>(&arg1),
            symbol                : 0x2::coin::get_symbol<T0>(&arg1),
            decimals              : 0x2::coin::get_decimals<T0>(&arg1),
            description           : 0x2::coin::get_description<T0>(&arg1),
            icon_url              : 0x2::coin::get_icon_url<T0>(&arg1),
            sender                : 0x2::tx_context::sender(arg16),
            token_address         : 0x1::type_name::get<T0>(),
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
        buy<T0>(arg0, v2, 0, arg3, arg16);
        0x2::transfer::public_share_object<Pool<T0>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(arg4, @0x0);
    }

    public entry fun deposit_fee(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: 0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>) {
        0x2::balance::join<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(arg1));
    }

    fun init(arg0: AGNAI_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>{
            id            : 0x2::object::new(arg1),
            init_coin_fee : 0,
            fee_bps       : 100,
            update_fee    : 289800000000,
            chat_fee      : 6900000,
            sui_balance   : 0x2::balance::zero<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(),
            admin         : @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb,
            max_pool_agn  : 12000000000000,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<AGNAI_FUN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(v0);
    }

    public entry fun init_cetus_pool<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg2: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg3: 0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg2.admin, 3);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
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
            let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(arg6, arg5, 60, math_sqrt(340282366920938463463374607431768211456 * (0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg3) as u256) / (0x2::coin::value<T0>(&arg4) as u256)), 0x1::string::utf8(b""), 4294523716, 443580, arg4, arg3, arg0, arg1, true, arg7, arg8);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v8, @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(v10, @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
        } else {
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN, T0>(arg6, arg5, 60, math_sqrt(340282366920938463463374607431768211456 * (0x2::coin::value<T0>(&arg4) as u256) / (0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg3) as u256)), 0x1::string::utf8(b""), 4294523716, 443580, arg3, arg4, arg1, arg0, false, arg7, arg8);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v11, @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(v12, @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb);
        };
    }

    public entry fun init_module(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb, 3);
        let v0 = AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>{
            id            : 0x2::object::new(arg0),
            init_coin_fee : 0,
            fee_bps       : 100,
            update_fee    : 289800000000,
            chat_fee      : 6900000,
            sui_balance   : 0x2::balance::zero<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(),
            admin         : @0xe1d3b11720622398c8e76189cf75c0a931c3d9be5de1f3d5372eea0bbd9985cb,
            max_pool_agn  : 12000000000000,
        };
        0x2::transfer::share_object<AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(v0);
    }

    fun math_sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public entry fun sell<T0>(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = ((arg1.virtual_agn_reserves - arg1.virtual_agn_reserves * arg1.virtual_coin_reserves / (arg1.virtual_coin_reserves + (v1 as u128))) as u64);
        arg1.virtual_coin_reserves = arg1.virtual_coin_reserves + (v1 as u128);
        arg1.virtual_agn_reserves = arg1.virtual_agn_reserves - (v2 as u128);
        assert!(v2 * (10000 - arg0.fee_bps) / 10000 >= arg2, 2);
        let v3 = v2 * arg0.fee_bps / 10000;
        0x2::balance::join<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(0x2::coin::take<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg1.pool_agn, v3, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(0x2::coin::take<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&mut arg1.pool_agn, v2 - v3, arg4), v0);
        0x2::balance::join<T0>(&mut arg1.pool_coin, 0x2::coin::into_balance<T0>(arg3));
        let v4 = SwapEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(arg1),
            sender                : v0,
            sui_amount            : v2 - v3,
            coin_amount           : v1,
            is_buy                : false,
            pool_agn              : 0x2::balance::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg1.pool_agn),
            pool_coin             : 0x2::balance::value<T0>(&arg1.pool_coin),
            virtual_coin_reserves : arg1.virtual_coin_reserves,
            virtual_agn_reserves  : arg1.virtual_agn_reserves,
            token_address         : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public entry fun send_message<T0>(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg2) == arg0.chat_fee, 1);
        let v0 = MessageEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            sender  : 0x2::tx_context::sender(arg4),
            message : arg3,
        };
        0x2::event::emit<MessageEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(arg2, @0x0);
    }

    public entry fun update(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 3);
        arg0.init_coin_fee = arg1;
        arg0.fee_bps = arg2;
        arg0.update_fee = arg3;
        arg0.chat_fee = arg4;
        arg0.admin = arg5;
        arg0.max_pool_agn = arg6;
    }

    public entry fun update_agent_info<T0>(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>(&arg2) == arg0.update_fee, 1);
        let v0 = UpdateAgentInfoEvent{
            pool_id  : 0x2::object::id<Pool<T0>>(arg1),
            x        : arg3,
            telegram : arg4,
            website  : arg5,
        };
        0x2::event::emit<UpdateAgentInfoEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>>(arg2, @0x0);
    }

    public entry fun update_protocol_init_fee(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.init_coin_fee = arg1;
    }

    public entry fun update_protocol_max_pool(arg0: &mut AgnAi<0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn::AGN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.max_pool_agn = arg1;
    }

    // decompiled from Move bytecode v6
}

