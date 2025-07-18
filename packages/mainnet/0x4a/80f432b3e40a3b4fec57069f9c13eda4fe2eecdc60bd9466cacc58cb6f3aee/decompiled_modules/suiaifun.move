module 0xe499337f4f7364e37332bd286f6a8c0791f9851741531e94f9949a68f8081695::suiaifun {
    struct SUIAIFUN has drop {
        dummy_field: bool,
    }

    struct SuiAiFun has store, key {
        id: 0x2::object::UID,
        init_coin_fee: u64,
        fee_bps: u64,
        update_fee: u64,
        change_creator_fee: u64,
        chat_fee: u64,
        admin: address,
        max_pool_sui: u64,
        version: u64,
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
        creator: address,
        created_by: address,
        bot_created: bool,
        creator_changeable: bool,
        creation_time: u64,
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
        creator: address,
        token_address: 0x1::type_name::TypeName,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        created_by: address,
        bot_created: bool,
        creator_changeable: bool,
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

    struct ChangeCreatorEvent has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
    }

    struct BotChangeCreatorEvent has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
    }

    struct MessageEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        message: 0x1::string::String,
    }

    public entry fun add_bot(arg0: &mut SuiAiFun, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, arg1, true);
    }

    public entry fun bot_change_creator<T0>(arg0: &mut SuiAiFun, arg1: &mut Pool<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0) && v0 == arg1.created_by, 5);
        arg1.creator = arg2;
        let v1 = BotChangeCreatorEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            creator : arg1.creator,
        };
        0x2::event::emit<BotChangeCreatorEvent>(v1);
    }

    public entry fun bot_start_new_coin<T0>(arg0: &mut SuiAiFun, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: address, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0);
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg0.init_coin_fee, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg5, 1);
        let v1 = Pool<T0>{
            id                    : 0x2::object::new(arg12),
            pool_sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_coin             : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg2, 1000000000000000, arg12)),
            total_supply          : 1000000000000000,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_sui_reserves  : (arg0.max_pool_sui as u128) * 3 / 8,
            max_pool_sui          : arg0.max_pool_sui,
            complete              : false,
            creator               : arg9,
            created_by            : v0,
            bot_created           : true,
            creator_changeable    : arg10,
            creation_time         : 0x2::clock::timestamp_ms(arg11),
        };
        let v2 = PoolCreatedEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(&v1),
            total_supply          : 1000000000000000,
            max_pool_sui          : arg0.max_pool_sui,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_sui_reserves  : (arg0.max_pool_sui as u128) * 3 / 8,
            name                  : 0x2::coin::get_name<T0>(&arg1),
            symbol                : 0x2::coin::get_symbol<T0>(&arg1),
            decimals              : 0x2::coin::get_decimals<T0>(&arg1),
            description           : 0x2::coin::get_description<T0>(&arg1),
            icon_url              : 0x2::coin::get_icon_url<T0>(&arg1),
            creator               : arg9,
            token_address         : 0x1::type_name::get<T0>(),
            x                     : arg6,
            telegram              : arg7,
            website               : arg8,
            created_by            : v0,
            bot_created           : true,
            creator_changeable    : arg10,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        0x2::transfer::public_share_object<Pool<T0>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
    }

    public entry fun buy<T0>(arg0: &mut SuiAiFun, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        if (arg1.creation_time > 0 && arg1.creation_time + 120000 > 0x2::clock::timestamp_ms(arg5)) {
            assert!(v0 == arg1.creator, 6);
            arg1.creation_time = 0;
        };
        if (v1 > 0) {
            let v2 = arg1.max_pool_sui - 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui);
            let (v3, v4) = if (v1 * (10000 - arg0.fee_bps) / 10000 < v2) {
                let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 * arg0.fee_bps / 10000, arg6);
                (0x2::coin::value<0x2::sui::SUI>(&arg3), v4)
            } else {
                let v5 = v2 * arg0.fee_bps / (10000 - arg0.fee_bps);
                let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg6);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1 - v2 - v5, arg6), v0);
                arg1.complete = true;
                (v2, v4)
            };
            let v6 = arg1.virtual_coin_reserves - arg1.virtual_sui_reserves * arg1.virtual_coin_reserves / (arg1.virtual_sui_reserves + (v3 as u128));
            arg1.virtual_sui_reserves = arg1.virtual_sui_reserves + (v3 as u128);
            arg1.virtual_coin_reserves = arg1.virtual_coin_reserves - v6;
            assert!(v6 >= (arg2 as u128) * (v3 as u128) * 10000 / (v1 as u128) / (10000 - (arg0.fee_bps as u128)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, (v6 as u64), arg6), v0);
            let v7 = 0x2::coin::value<0x2::sui::SUI>(&v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v7 / 20 * 7, arg6), arg1.creator);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v7 / 8, arg6), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
            let v8 = SwapEvent{
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
            0x2::event::emit<SwapEvent>(v8);
            if (arg1.complete == true) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, 0x2::balance::value<T0>(&arg1.pool_coin), arg6), @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui), arg6), @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
                let v9 = CompletedEvent{
                    pool_id       : 0x2::object::id<Pool<T0>>(arg1),
                    token_address : 0x1::type_name::get<T0>(),
                };
                0x2::event::emit<CompletedEvent>(v9);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
    }

    public entry fun change_creator<T0>(arg0: &mut SuiAiFun, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(arg1.creator_changeable, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.change_creator_fee, 1);
        arg1.creator = 0x2::tx_context::sender(arg6);
        arg1.creator_changeable = false;
        let v0 = ChangeCreatorEvent{
            pool_id  : 0x2::object::id<Pool<T0>>(arg1),
            creator  : arg1.creator,
            x        : arg3,
            telegram : arg4,
            website  : arg5,
        };
        0x2::event::emit<ChangeCreatorEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut SuiAiFun, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool_coin, 0x2::balance::value<T0>(&arg1.pool_coin), arg2), @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_sui), arg2), @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
    }

    fun init(arg0: SUIAIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiAiFun{
            id                 : 0x2::object::new(arg1),
            init_coin_fee      : 0,
            fee_bps            : 100,
            update_fee         : 0,
            change_creator_fee : 10000000000,
            chat_fee           : 0,
            admin              : @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb,
            max_pool_sui       : 2400000000000,
            version            : 0,
        };
        0x2::transfer::share_object<SuiAiFun>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SUIAIFUN>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_bot(arg0: &mut SuiAiFun, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::dynamic_field::remove<address, bool>(&mut arg0.id, arg1);
    }

    public entry fun sell<T0>(arg0: &mut SuiAiFun, arg1: &mut Pool<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = ((arg1.virtual_sui_reserves - arg1.virtual_sui_reserves * arg1.virtual_coin_reserves / (arg1.virtual_coin_reserves + (v1 as u128))) as u64);
        arg1.virtual_coin_reserves = arg1.virtual_coin_reserves + (v1 as u128);
        arg1.virtual_sui_reserves = arg1.virtual_sui_reserves - (v2 as u128);
        assert!(v2 * (10000 - arg0.fee_bps) / 10000 >= arg2, 2);
        let v3 = v2 * arg0.fee_bps / 10000;
        let v4 = 0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v3 / 2, arg5), arg1.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v3 / 8, arg5), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool_sui, v2 - v3, arg5), v0);
        0x2::balance::join<T0>(&mut arg1.pool_coin, 0x2::coin::into_balance<T0>(arg3));
        let v5 = SwapEvent{
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
        0x2::event::emit<SwapEvent>(v5);
    }

    public entry fun send_message<T0>(arg0: &mut SuiAiFun, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.chat_fee, 1);
        let v0 = MessageEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            sender  : 0x2::tx_context::sender(arg4),
            message : arg3,
        };
        0x2::event::emit<MessageEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
    }

    public entry fun start_new_coin<T0>(arg0: &mut SuiAiFun, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg0.version == 0, 4);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg0.init_coin_fee, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg5, 1);
        let v1 = Pool<T0>{
            id                    : 0x2::object::new(arg10),
            pool_sui              : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_coin             : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg2, 1000000000000000, arg10)),
            total_supply          : 1000000000000000,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_sui_reserves  : (arg0.max_pool_sui as u128) * 3 / 8,
            max_pool_sui          : arg0.max_pool_sui,
            complete              : false,
            creator               : v0,
            created_by            : v0,
            bot_created           : false,
            creator_changeable    : false,
            creation_time         : 0,
        };
        let v2 = PoolCreatedEvent{
            pool_id               : 0x2::object::id<Pool<T0>>(&v1),
            total_supply          : 1000000000000000,
            max_pool_sui          : arg0.max_pool_sui,
            virtual_coin_reserves : (1000000000000000 as u128) * 11 / 10,
            virtual_sui_reserves  : (arg0.max_pool_sui as u128) * 3 / 8,
            name                  : 0x2::coin::get_name<T0>(&arg1),
            symbol                : 0x2::coin::get_symbol<T0>(&arg1),
            decimals              : 0x2::coin::get_decimals<T0>(&arg1),
            description           : 0x2::coin::get_description<T0>(&arg1),
            icon_url              : 0x2::coin::get_icon_url<T0>(&arg1),
            creator               : v0,
            token_address         : 0x1::type_name::get<T0>(),
            x                     : arg6,
            telegram              : arg7,
            website               : arg8,
            created_by            : v0,
            bot_created           : false,
            creator_changeable    : false,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        let v3 = &mut v1;
        buy<T0>(arg0, v3, 0, arg3, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb, arg9, arg10);
        0x2::transfer::public_share_object<Pool<T0>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0x66f25ca6d8edc0bb161b53e67eac7bf7e680251dc095cb4f973f10051f9d63cb);
    }

    public entry fun update(arg0: &mut SuiAiFun, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 3);
        arg0.init_coin_fee = arg1;
        arg0.fee_bps = arg2;
        arg0.update_fee = arg3;
        arg0.change_creator_fee = arg4;
        arg0.chat_fee = arg5;
        arg0.admin = arg6;
        arg0.max_pool_sui = arg7;
    }

    public entry fun update_init_fee(arg0: &mut SuiAiFun, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.init_coin_fee = arg1;
    }

    public entry fun update_max_pool(arg0: &mut SuiAiFun, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.max_pool_sui = arg1;
    }

    // decompiled from Move bytecode v6
}

