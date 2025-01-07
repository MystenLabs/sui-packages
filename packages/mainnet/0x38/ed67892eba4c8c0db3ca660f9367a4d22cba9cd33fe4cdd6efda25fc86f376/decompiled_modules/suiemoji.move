module 0x5927544009047b9346d4a60f49815a0e3bd82b9c07a5bcf6d82921b5f4743c0d::suiemoji {
    struct SUIEMOJI has drop {
        dummy_field: bool,
    }

    struct SuiEmoji has store, key {
        id: 0x2::object::UID,
        create_coin_fee: u64,
        trading_fee: u64,
        update_info_fee: u64,
        pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        max_sui_raise: u64,
        event_index: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_coin: 0x2::balance::Balance<T0>,
        total_supply: u64,
        virtual_coin_reserves: u128,
        virtual_sui_reserves: u128,
        max_sui_raise: u64,
        complete: bool,
    }

    struct NewCoinStarted has copy, drop {
        pool_id: 0x2::object::ID,
        total_supply: u64,
        max_sui_raise: u64,
        virtual_coin_reserves: u128,
        virtual_sui_reserves: u128,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        decimals: u8,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        sender: address,
        event_index: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        sui_amount: u64,
        coin_amount: u64,
        type: u8,
        event_index: u64,
        pool_sui: u64,
        pool_coin: u64,
        virtual_coin_reserves: u128,
        virtual_sui_reserves: u128,
        coin_type: 0x1::type_name::TypeName,
    }

    struct EndEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        event_index: u64,
    }

    struct UpdateInfoEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        tele: 0x1::string::String,
        twitter: 0x1::string::String,
        website: 0x1::string::String,
        event_index: u64,
    }

    public entry fun buy<T0>(arg0: &mut SuiEmoji, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        if (v1 > 0) {
            let v2 = arg1.max_sui_raise - 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui);
            let (v3, v4) = if (v1 * (10000 - arg0.trading_fee) / 10000 < v2) {
                (0x2::coin::value<0x2::sui::SUI>(&arg3), 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 * arg0.trading_fee / 10000, arg4))
            } else {
                let v5 = v2 * arg0.trading_fee / (10000 - arg0.trading_fee);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 - v2 - v5, arg4), v0);
                arg1.complete = true;
                (v2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg4))
            };
            let v6 = arg1.virtual_coin_reserves - arg1.virtual_sui_reserves * arg1.virtual_coin_reserves / (arg1.virtual_sui_reserves + (v3 as u128));
            arg1.virtual_sui_reserves = arg1.virtual_sui_reserves + (v3 as u128);
            arg1.virtual_coin_reserves = arg1.virtual_coin_reserves - v6;
            assert!(v6 >= (arg2 as u128) * (v3 as u128) * 10000 / (v1 as u128) / (10000 - (arg0.trading_fee as u128)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, (v6 as u64), arg4), v0);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
            let v7 = SwapEvent{
                pool_id               : 0x2::object::id<Pool<T0>>(arg1),
                sender                : v0,
                sui_amount            : v3 * 10000 / (10000 - arg0.trading_fee),
                coin_amount           : (v6 as u64),
                type                  : 1,
                event_index           : arg0.event_index,
                pool_sui              : 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui),
                pool_coin             : 0x2::balance::value<T0>(&arg1.pool_coin),
                virtual_coin_reserves : arg1.virtual_coin_reserves,
                virtual_sui_reserves  : arg1.virtual_sui_reserves,
                coin_type             : 0x1::type_name::get<T0>(),
            };
            0x2::event::emit<SwapEvent>(v7);
            arg0.event_index = arg0.event_index + 1;
            if (arg1.complete == true) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, 0x2::balance::value<T0>(&arg1.pool_coin), arg4), @0x3d107efcf7c451c6132c4a2a97a044c49430c105d709641fcf54815a3c730f13);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui), arg4), @0x3d107efcf7c451c6132c4a2a97a044c49430c105d709641fcf54815a3c730f13);
                let v8 = EndEvent{
                    pool_id     : 0x2::object::id<Pool<T0>>(arg1),
                    coin_type   : 0x1::type_name::get<T0>(),
                    event_index : arg0.event_index,
                };
                0x2::event::emit<EndEvent>(v8);
                arg0.event_index = arg0.event_index + 1;
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
    }

    public entry fun deposit_fee(arg0: &mut SuiEmoji, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut SuiEmoji, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, 0x2::balance::value<T0>(&arg1.pool_coin), arg2), @0x3d107efcf7c451c6132c4a2a97a044c49430c105d709641fcf54815a3c730f13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui), arg2), @0x3d107efcf7c451c6132c4a2a97a044c49430c105d709641fcf54815a3c730f13);
        arg1.complete = true;
    }

    fun init(arg0: SUIEMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SUIEMOJI>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = SuiEmoji{
            id              : 0x2::object::new(arg1),
            create_coin_fee : 1000000000,
            trading_fee     : 100,
            update_info_fee : 29000000000,
            pool_sui        : 0x2::balance::zero<0x2::sui::SUI>(),
            admin           : @0x3d107efcf7c451c6132c4a2a97a044c49430c105d709641fcf54815a3c730f13,
            max_sui_raise   : 600000000,
            event_index     : 0,
        };
        0x2::transfer::share_object<SuiEmoji>(v0);
    }

    public entry fun sell<T0>(arg0: &mut SuiEmoji, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = ((arg1.virtual_sui_reserves - arg1.virtual_sui_reserves * arg1.virtual_coin_reserves / (arg1.virtual_coin_reserves + (v1 as u128))) as u64);
        arg1.virtual_coin_reserves = arg1.virtual_coin_reserves + (v1 as u128);
        arg1.virtual_sui_reserves = arg1.virtual_sui_reserves - (v2 as u128);
        assert!(v2 * (10000 - arg0.trading_fee) / 10000 >= arg2, 2);
        let v3 = v2 * arg0.trading_fee / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v3, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v2 - v3, arg4), v0);
        0x2::balance::join<T0>(&mut arg1.pool_coin, 0x2::coin::into_balance<T0>(arg3));
        let v4 = SwapEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(arg1),
            sender                : v0,
            sui_amount            : v2 - v3,
            coin_amount           : v1,
            type                  : 2,
            event_index           : arg0.event_index,
            pool_sui              : 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui),
            pool_coin             : 0x2::balance::value<T0>(&arg1.pool_coin),
            virtual_coin_reserves : arg1.virtual_coin_reserves,
            virtual_sui_reserves  : arg1.virtual_sui_reserves,
            coin_type             : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SwapEvent>(v4);
        arg0.event_index = arg0.event_index + 1;
    }

    fun sqrt(arg0: u128) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public entry fun start_new_coin<T0>(arg0: &mut SuiEmoji, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0);
        let v0 = 0x2::coin::mint<T0>(&mut arg2, 1000000000000000, arg8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg4, 1);
        let v1 = (1000000000000000 as u128) / 5 / 100000;
        let v2 = (arg0.max_sui_raise as u128) / 3 * 11 / 12 / 100000;
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::create_pool_with_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, 2, sqrt(v2 * (1 << 128) / v1), 0x1::string::utf8(b""), 4294523660, 443636, 0x2::coin::split<T0>(&mut v0, (v1 as u64), arg8), 0x2::coin::take<0x2::sui::SUI>(&mut arg0.pool_sui, (v2 as u64), arg8), (v1 as u64), (v2 as u64), true, arg7, arg8);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, @0x0);
        let v6 = Pool<T0>{
            id                    : 0x2::object::new(arg8),
            pool_sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_coin             : 0x2::coin::into_balance<T0>(v0),
            total_supply          : 1000000000000000,
            virtual_coin_reserves : (1000000000000000 as u128) * 16 / 15,
            virtual_sui_reserves  : (arg0.max_sui_raise as u128) / 3 * 11 / 12,
            max_sui_raise         : arg0.max_sui_raise,
            complete              : false,
        };
        let v7 = NewCoinStarted{
            pool_id               : 0x2::object::id<Pool<T0>>(&v6),
            total_supply          : 1000000000000000,
            max_sui_raise         : arg0.max_sui_raise,
            virtual_coin_reserves : (1000000000000000 as u128) * 16 / 15,
            virtual_sui_reserves  : (arg0.max_sui_raise as u128) / 3 * 11 / 12,
            name                  : 0x2::coin::get_name<T0>(&arg1),
            symbol                : 0x2::coin::get_symbol<T0>(&arg1),
            decimals              : 0x2::coin::get_decimals<T0>(&arg1),
            description           : 0x2::coin::get_description<T0>(&arg1),
            icon_url              : 0x2::coin::get_icon_url<T0>(&arg1),
            sender                : 0x2::tx_context::sender(arg8),
            event_index           : arg0.event_index,
            coin_type             : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<NewCoinStarted>(v7);
        arg0.event_index = arg0.event_index + 1;
        let v8 = &mut v6;
        buy<T0>(arg0, v8, 0, arg3, arg8);
        0x2::transfer::public_share_object<Pool<T0>>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
    }

    public entry fun update_info<T0>(arg0: &mut SuiEmoji, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.update_info_fee, 1);
        let v0 = UpdateInfoEvent{
            pool_id     : 0x2::object::id<Pool<T0>>(arg1),
            coin_type   : 0x1::type_name::get<T0>(),
            tele        : arg3,
            twitter     : arg4,
            website     : arg5,
            event_index : arg0.event_index,
        };
        0x2::event::emit<UpdateInfoEvent>(v0);
        arg0.event_index = arg0.event_index + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun update_pump(arg0: &mut SuiEmoji, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 3);
        arg0.create_coin_fee = arg1;
        arg0.trading_fee = arg2;
        arg0.admin = arg3;
        arg0.max_sui_raise = arg4;
    }

    public entry fun withdraw_fee(arg0: &mut SuiEmoji, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pool_sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.pool_sui), arg1), @0x3d107efcf7c451c6132c4a2a97a044c49430c105d709641fcf54815a3c730f13);
    }

    // decompiled from Move bytecode v6
}

