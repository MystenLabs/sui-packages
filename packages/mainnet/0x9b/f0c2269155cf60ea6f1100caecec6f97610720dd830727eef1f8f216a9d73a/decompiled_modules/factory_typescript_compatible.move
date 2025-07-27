module 0x9bf0c2269155cf60ea6f1100caecec6f97610720dd830727eef1f8f216a9d73a::factory_typescript_compatible {
    struct FACTORY_TYPESCRIPT_COMPATIBLE has drop {
        dummy_field: bool,
    }

    struct DynamicCoin has drop {
        dummy_field: bool,
    }

    struct CoinCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
        owner: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
        timestamp: u64,
    }

    struct TradeExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        trader: address,
        is_buy: bool,
        token_amount: u64,
        sui_amount: u64,
        price_per_token: u64,
        new_price: u64,
        fee_amount: u64,
        timestamp: u64,
        sui_balance: u64,
    }

    struct FactoryConfigUpdated has copy, drop {
        admin: address,
        fee_bps: u64,
        timestamp: u64,
    }

    struct EmergencyAction has copy, drop {
        admin: address,
        action: 0x1::string::String,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        timestamp: u64,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        fee_bps: u64,
        total_pools: u64,
        total_volume: u64,
        treasury_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        is_paused: bool,
        version: u64,
        coin_counter: u64,
    }

    struct MemeRegistry has key {
        id: 0x2::object::UID,
        total_coins: u64,
        total_trades: u64,
        volume_24h: u64,
    }

    struct TradingPool has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::string::String,
        creator: address,
        owner: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        icon_url: 0x1::option::Option<0x1::string::String>,
        description: 0x1::string::String,
        treasury_cap: 0x2::coin::TreasuryCap<DynamicCoin>,
        token_balance: 0x2::balance::Balance<DynamicCoin>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        current_supply: u64,
        total_trades: u64,
        last_trade_timestamp: u64,
        volume_24h: u64,
        created_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserProfile has store, key {
        id: 0x2::object::UID,
        user: address,
        total_trades: u64,
        volume_traded: u64,
        created_coins: vector<0x2::object::ID>,
    }

    public entry fun buy_tokens(arg0: &mut TradingPool, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.last_trade_timestamp + 1000, 108);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v1 >= 1000, 104);
        let v2 = calculate_tokens_out(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<DynamicCoin>(&arg0.token_balance), v1, arg0.current_supply);
        assert!(v2 >= arg5, 107);
        let v3 = v1 * arg1.fee_bps / 10000;
        let v4 = if (0x2::balance::value<DynamicCoin>(&arg0.token_balance) >= v2) {
            0x2::coin::from_balance<DynamicCoin>(0x2::balance::split<DynamicCoin>(&mut arg0.token_balance, v2), arg6)
        } else {
            0x2::coin::mint<DynamicCoin>(&mut arg0.treasury_cap, v2, arg6)
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        arg0.current_supply = arg0.current_supply + v2;
        arg0.total_trades = arg0.total_trades + 1;
        arg0.volume_24h = arg0.volume_24h + v1;
        arg0.last_trade_timestamp = v0;
        arg1.total_volume = arg1.total_volume + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v3));
        arg2.total_trades = arg2.total_trades + 1;
        arg2.volume_24h = arg2.volume_24h + v1;
        let v5 = 0x2::tx_context::sender(arg6);
        update_user_profile(arg1, v5, v1, true, arg6);
        let v6 = calculate_current_price(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<DynamicCoin>(&arg0.token_balance), arg0.current_supply);
        let v7 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool>(arg0),
            coin_type       : arg0.coin_type,
            trader          : 0x2::tx_context::sender(arg6),
            is_buy          : true,
            token_amount    : v2,
            sui_amount      : v1,
            price_per_token : v6,
            new_price       : v6,
            fee_amount      : v3,
            timestamp       : v0,
            sui_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<TradeExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<DynamicCoin>>(v4, 0x2::tx_context::sender(arg6));
    }

    fun calculate_current_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            6600000000000 / arg2
        } else if (arg0 == 0) {
            0
        } else {
            arg0 * 1000000 / arg1
        }
    }

    fun calculate_sui_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            arg0 * arg2 / (arg1 + arg2)
        }
    }

    fun calculate_tokens_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            arg2 * arg3 / 6600000000000
        } else {
            arg1 * arg2 / (arg0 + arg2)
        }
    }

    public entry fun create_meme_coin(arg0: &mut Factory, arg1: &mut MemeRegistry, arg2: &0x2::clock::Clock, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 114);
        assert!(0x1::vector::length<u8>(&arg4) <= 64, 110);
        assert!(0x1::vector::length<u8>(&arg5) <= 16, 111);
        assert!(0x1::vector::length<u8>(&arg6) <= 1000, 112);
        assert!(arg8 <= 18, 109);
        assert!(arg3 != @0x0, 115);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.coin_counter = arg0.coin_counter + 1;
        let v2 = 0x1::string::utf8(b"DynamicCoin");
        let v3 = if (0x1::vector::is_empty<u8>(&arg7)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg7))
        };
        let v4 = DynamicCoin{dummy_field: false};
        let (v5, v6) = 0x2::coin::create_currency<DynamicCoin>(v4, arg8, arg5, arg4, arg6, v3, arg9);
        let v7 = v5;
        let v8 = 1000000000 * 0x1::u64::pow(10, (arg8 as u8));
        0x2::transfer::public_transfer<0x2::coin::Coin<DynamicCoin>>(0x2::coin::mint<DynamicCoin>(&mut v7, v8, arg9), arg3);
        let v9 = if (0x1::vector::is_empty<u8>(&arg7)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg7))
        };
        let v10 = TradingPool{
            id                   : 0x2::object::new(arg9),
            coin_type            : v2,
            creator              : v0,
            owner                : arg3,
            name                 : 0x1::string::utf8(arg4),
            symbol               : 0x1::string::utf8(arg5),
            decimals             : arg8,
            icon_url             : v9,
            description          : 0x1::string::utf8(arg6),
            treasury_cap         : v7,
            token_balance        : 0x2::balance::zero<DynamicCoin>(),
            sui_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            current_supply       : v8,
            total_trades         : 0,
            last_trade_timestamp : 0,
            volume_24h           : 0,
            created_at           : v1,
        };
        let v11 = 0x2::object::id<TradingPool>(&v10);
        arg0.total_pools = arg0.total_pools + 1;
        arg1.total_coins = arg1.total_coins + 1;
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg1.id, v11, true);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut 0x2::dynamic_field::borrow_mut<address, UserProfile>(&mut arg0.id, v0).created_coins, v11);
        } else {
            let v12 = UserProfile{
                id            : 0x2::object::new(arg9),
                user          : v0,
                total_trades  : 0,
                volume_traded : 0,
                created_coins : 0x1::vector::singleton<0x2::object::ID>(v11),
            };
            0x2::dynamic_field::add<address, UserProfile>(&mut arg0.id, v0, v12);
        };
        let v13 = CoinCreated{
            pool_id      : v11,
            coin_type    : v2,
            creator      : v0,
            owner        : arg3,
            name         : v10.name,
            symbol       : v10.symbol,
            decimals     : arg8,
            total_supply : v8,
            timestamp    : v1,
        };
        0x2::event::emit<CoinCreated>(v13);
        0x2::transfer::share_object<TradingPool>(v10);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DynamicCoin>>(v6, v0);
    }

    public fun get_factory_stats(arg0: &Factory) : (u64, u64, u64, u64) {
        (arg0.total_pools, arg0.total_volume, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_balance), arg0.fee_bps)
    }

    public fun get_pool_stats(arg0: &TradingPool) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<DynamicCoin>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.current_supply, arg0.total_trades, arg0.volume_24h)
    }

    public fun get_token_price(arg0: &TradingPool) : u64 {
        calculate_current_price(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<DynamicCoin>(&arg0.token_balance), arg0.current_supply)
    }

    fun init(arg0: FACTORY_TYPESCRIPT_COMPATIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id               : 0x2::object::new(arg1),
            admin            : 0x2::tx_context::sender(arg1),
            fee_bps          : 100,
            total_pools      : 0,
            total_volume     : 0,
            treasury_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            is_paused        : false,
            version          : 1,
            coin_counter     : 0,
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = MemeRegistry{
            id           : 0x2::object::new(arg1),
            total_coins  : 0,
            total_trades : 0,
            volume_24h   : 0,
        };
        0x2::transfer::share_object<MemeRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun sell_tokens(arg0: &mut TradingPool, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<DynamicCoin>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.last_trade_timestamp + 1000, 108);
        let v1 = 0x2::coin::value<DynamicCoin>(&arg4);
        assert!(v1 > 0, 104);
        let v2 = calculate_sui_out(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<DynamicCoin>(&arg0.token_balance), v1, arg0.current_supply);
        assert!(v2 >= arg5, 107);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v2, 102);
        let v3 = v2 * arg1.fee_bps / 10000;
        let v4 = v2 - v3;
        0x2::coin::burn<DynamicCoin>(&mut arg0.treasury_cap, arg4);
        arg0.current_supply = arg0.current_supply - v1;
        arg0.total_trades = arg0.total_trades + 1;
        arg0.volume_24h = arg0.volume_24h + v2;
        arg0.last_trade_timestamp = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v3));
        arg1.total_volume = arg1.total_volume + v2;
        arg2.total_trades = arg2.total_trades + 1;
        arg2.volume_24h = arg2.volume_24h + v2;
        let v5 = 0x2::tx_context::sender(arg6);
        update_user_profile(arg1, v5, v2, false, arg6);
        let v6 = calculate_current_price(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<DynamicCoin>(&arg0.token_balance), arg0.current_supply);
        let v7 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool>(arg0),
            coin_type       : arg0.coin_type,
            trader          : 0x2::tx_context::sender(arg6),
            is_buy          : false,
            token_amount    : v1,
            sui_amount      : v2,
            price_per_token : v6,
            new_price       : v6,
            fee_amount      : v3,
            timestamp       : v0,
            sui_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) - v4,
        };
        0x2::event::emit<TradeExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v4), arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun toggle_pause(arg0: &AdminCap, arg1: &mut Factory, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_paused = !arg1.is_paused;
        let v0 = if (arg1.is_paused) {
            0x1::string::utf8(b"pause")
        } else {
            0x1::string::utf8(b"unpause")
        };
        let v1 = EmergencyAction{
            admin     : 0x2::tx_context::sender(arg3),
            action    : v0,
            pool_id   : 0x1::option::none<0x2::object::ID>(),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EmergencyAction>(v1);
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Factory, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 1000, 101);
        arg1.fee_bps = arg3;
        let v0 = FactoryConfigUpdated{
            admin     : 0x2::tx_context::sender(arg4),
            fee_bps   : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FactoryConfigUpdated>(v0);
    }

    fun update_user_profile(arg0: &mut Factory, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            let v0 = UserProfile{
                id            : 0x2::object::new(arg4),
                user          : arg1,
                total_trades  : 1,
                volume_traded : arg2,
                created_coins : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<address, UserProfile>(&mut arg0.id, arg1, v0);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<address, UserProfile>(&mut arg0.id, arg1);
            v1.total_trades = v1.total_trades + 1;
            v1.volume_traded = v1.volume_traded + arg2;
        };
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Factory, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_balance) >= arg2, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_balance, arg2), arg3), arg1.admin);
    }

    // decompiled from Move bytecode v6
}

