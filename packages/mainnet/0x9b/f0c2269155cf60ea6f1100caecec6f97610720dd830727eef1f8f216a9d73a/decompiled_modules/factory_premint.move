module 0x9bf0c2269155cf60ea6f1100caecec6f97610720dd830727eef1f8f216a9d73a::factory_premint {
    struct FACTORY_PREMINT has drop {
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
    }

    struct MemeRegistry has key {
        id: 0x2::object::UID,
        total_coins: u64,
        total_trades: u64,
        volume_24h: u64,
    }

    struct TradingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::string::String,
        creator: address,
        owner: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        icon_url: 0x1::option::Option<0x1::string::String>,
        description: 0x1::string::String,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_balance: 0x2::balance::Balance<T0>,
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

    public entry fun burn_tokens<T0>(arg0: &AdminCap, arg1: &mut TradingPool<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(&mut arg1.treasury_cap, arg2);
        arg1.current_supply = arg1.current_supply - 0x2::coin::value<T0>(&arg2);
    }

    public entry fun buy_tokens<T0>(arg0: &mut TradingPool<T0>, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.last_trade_timestamp + 1000, 108);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v1 >= 1000, 104);
        let v2 = calculate_tokens_out_premint(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), v1, arg0.current_supply);
        assert!(v2 >= arg5, 107);
        let v3 = v1 * arg1.fee_bps / 10000;
        let v4 = if (0x2::balance::value<T0>(&arg0.token_balance) >= v2) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v2), arg6)
        } else {
            0x2::coin::mint<T0>(&mut arg0.treasury_cap, v2, arg6)
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
        let v6 = calculate_current_price_premint(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), arg0.current_supply);
        let v7 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool<T0>>(arg0),
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
    }

    fun calculate_current_price_premint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            6600000000000 / arg2
        } else if (arg0 == 0) {
            0
        } else {
            arg0 * 1000000 / arg1
        }
    }

    fun calculate_sui_out_premint(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            arg0 * arg2 / (arg1 + arg2)
        }
    }

    fun calculate_tokens_out_premint(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            arg2 * arg3 / 6600000000000
        } else {
            arg1 * arg2 / (arg0 + arg2)
        }
    }

    public entry fun create_meme_coin<T0: drop>(arg0: T0, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: &0x2::clock::Clock, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 114);
        assert!(0x1::vector::length<u8>(&arg5) <= 64, 110);
        assert!(0x1::vector::length<u8>(&arg6) <= 16, 111);
        assert!(0x1::vector::length<u8>(&arg7) <= 1000, 112);
        assert!(arg9 <= 18, 109);
        assert!(arg4 != @0x0, 115);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = if (0x1::vector::is_empty<u8>(&arg8)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg8))
        };
        let (v3, v4) = 0x2::coin::create_currency<T0>(arg0, arg9, arg6, arg5, arg7, v2, arg10);
        let v5 = v3;
        let v6 = 1000000000 * 0x1::u64::pow(10, (arg9 as u8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut v5, v6, arg10), arg4);
        let v7 = if (0x1::vector::is_empty<u8>(&arg8)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg8))
        };
        let v8 = TradingPool<T0>{
            id                   : 0x2::object::new(arg10),
            coin_type            : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
            creator              : v0,
            owner                : arg4,
            name                 : 0x1::string::utf8(arg5),
            symbol               : 0x1::string::utf8(arg6),
            decimals             : arg9,
            icon_url             : v7,
            description          : 0x1::string::utf8(arg7),
            treasury_cap         : v5,
            token_balance        : 0x2::balance::zero<T0>(),
            sui_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            current_supply       : v6,
            total_trades         : 0,
            last_trade_timestamp : 0,
            volume_24h           : 0,
            created_at           : v1,
        };
        let v9 = 0x2::object::id<TradingPool<T0>>(&v8);
        arg1.total_pools = arg1.total_pools + 1;
        arg2.total_coins = arg2.total_coins + 1;
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg2.id, v9, true);
        if (0x2::dynamic_field::exists_<address>(&arg1.id, v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut 0x2::dynamic_field::borrow_mut<address, UserProfile>(&mut arg1.id, v0).created_coins, v9);
        } else {
            let v10 = UserProfile{
                id            : 0x2::object::new(arg10),
                user          : v0,
                total_trades  : 0,
                volume_traded : 0,
                created_coins : 0x1::vector::singleton<0x2::object::ID>(v9),
            };
            0x2::dynamic_field::add<address, UserProfile>(&mut arg1.id, v0, v10);
        };
        let v11 = CoinCreated{
            pool_id      : v9,
            coin_type    : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
            creator      : v0,
            owner        : arg4,
            name         : v8.name,
            symbol       : v8.symbol,
            decimals     : arg9,
            total_supply : v6,
            timestamp    : v1,
        };
        0x2::event::emit<CoinCreated>(v11);
        0x2::transfer::share_object<TradingPool<T0>>(v8);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T0>>(v4, v0);
    }

    public fun get_factory_stats(arg0: &Factory) : (u64, u64, u64, u64) {
        (arg0.total_pools, arg0.total_volume, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_balance), arg0.fee_bps)
    }

    public fun get_pool_stats<T0>(arg0: &TradingPool<T0>) : (u64, u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.current_supply, arg0.total_trades, arg0.volume_24h)
    }

    public fun get_token_price<T0>(arg0: &TradingPool<T0>) : u64 {
        calculate_current_price_premint(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), arg0.current_supply)
    }

    fun init(arg0: FACTORY_PREMINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id               : 0x2::object::new(arg1),
            admin            : 0x2::tx_context::sender(arg1),
            fee_bps          : 100,
            total_pools      : 0,
            total_volume     : 0,
            treasury_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            is_paused        : false,
            version          : 1,
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

    public entry fun mint_tokens<T0>(arg0: &AdminCap, arg1: &mut TradingPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.current_supply = arg1.current_supply + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, arg2, arg4), arg3);
    }

    public entry fun sell_tokens<T0>(arg0: &mut TradingPool<T0>, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.last_trade_timestamp + 1000, 108);
        let v1 = 0x2::coin::value<T0>(&arg4);
        assert!(v1 > 0, 104);
        let v2 = calculate_sui_out_premint(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), v1, arg0.current_supply);
        assert!(v2 >= arg5, 107);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v2, 102);
        let v3 = v2 * arg1.fee_bps / 10000;
        let v4 = v2 - v3;
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg4);
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
        let v6 = calculate_current_price_premint(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), arg0.current_supply);
        let v7 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool<T0>>(arg0),
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

