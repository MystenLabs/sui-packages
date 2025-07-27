module 0x6a42c8217fde9edf2ad2f5abea2722bbee2e9d24e91757e7f047e17d3e78cc1e::factory_with_stored_witness {
    struct FACTORY_WITH_STORED_WITNESS has drop {
        dummy_field: bool,
    }

    struct StoredWitness has store, key {
        id: 0x2::object::UID,
        can_create_tokens: bool,
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
        stored_witness_id: 0x2::object::ID,
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

    struct SimplifiedPool has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::string::String,
        creator: address,
        owner: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        icon_url: 0x1::option::Option<0x1::string::String>,
        description: 0x1::string::String,
        total_supply: u64,
        created_at: u64,
    }

    public entry fun burn_tokens<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<T0>(arg0, arg1);
    }

    public entry fun buy_tokens<T0>(arg0: &mut TradingPool<T0>, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: &StoredWitness, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.can_create_tokens, 116);
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 >= 1000, 104);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg0.last_trade_timestamp + 1000, 108);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v3 = if (v2 == 0) {
            v0 * 1000
        } else {
            v0 * 0x2::balance::value<T0>(&arg0.token_balance) / (v2 + v0)
        };
        assert!(v3 >= arg6, 107);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.token_balance), 103);
        let v4 = v0 * arg1.fee_bps / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v4, arg7)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        arg0.total_trades = arg0.total_trades + 1;
        arg0.last_trade_timestamp = v1;
        arg1.total_volume = arg1.total_volume + v0;
        let v5 = 0x2::tx_context::sender(arg7);
        if (0x2::dynamic_field::exists_<address>(&arg1.id, v5)) {
            let v6 = 0x2::dynamic_field::borrow_mut<address, UserProfile>(&mut arg1.id, v5);
            v6.total_trades = v6.total_trades + 1;
            v6.volume_traded = v6.volume_traded + v0;
        } else {
            let v7 = UserProfile{
                id            : 0x2::object::new(arg7),
                user          : v5,
                total_trades  : 1,
                volume_traded : v0,
                created_coins : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<address, UserProfile>(&mut arg1.id, v5, v7);
        };
        let v8 = if (v3 > 0) {
            v0 / v3
        } else {
            0
        };
        let v9 = if (0x2::balance::value<T0>(&arg0.token_balance) > 0) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) / 0x2::balance::value<T0>(&arg0.token_balance)
        } else {
            0
        };
        let v10 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool<T0>>(arg0),
            coin_type       : 0x1::string::utf8(b"TODO"),
            trader          : v5,
            is_buy          : true,
            token_amount    : v3,
            sui_amount      : v0,
            price_per_token : v8,
            new_price       : v9,
            fee_amount      : v4,
            timestamp       : v1,
            sui_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<TradeExecuted>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v3), arg7), v5);
    }

    public entry fun create_meme_coin(arg0: &mut Factory, arg1: &mut MemeRegistry, arg2: &StoredWitness, arg3: &0x2::clock::Clock, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 114);
        assert!(0x1::vector::length<u8>(&arg5) <= 64, 110);
        assert!(0x1::vector::length<u8>(&arg6) <= 16, 111);
        assert!(0x1::vector::length<u8>(&arg7) <= 1000, 112);
        assert!(arg9 <= 18, 109);
        assert!(arg4 != @0x0, 115);
        assert!(0x2::object::id<StoredWitness>(arg2) == arg0.stored_witness_id, 116);
        assert!(arg2.can_create_tokens, 116);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = generate_unique_coin_type(arg5, arg6, arg10);
        arg0.total_pools = arg0.total_pools + 1;
        arg1.total_coins = arg1.total_coins + 1;
        let v3 = if (0x1::vector::is_empty<u8>(&arg8)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg8))
        };
        let v4 = SimplifiedPool{
            id           : 0x2::object::new(arg10),
            coin_type    : v2,
            creator      : v0,
            owner        : arg4,
            name         : 0x1::string::utf8(arg5),
            symbol       : 0x1::string::utf8(arg6),
            decimals     : arg9,
            icon_url     : v3,
            description  : 0x1::string::utf8(arg7),
            total_supply : 1000000000 * 0x1::u64::pow(10, (arg9 as u8)),
            created_at   : v1,
        };
        let v5 = 0x2::object::id<SimplifiedPool>(&v4);
        if (0x2::dynamic_field::exists_<address>(&arg0.id, v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut 0x2::dynamic_field::borrow_mut<address, UserProfile>(&mut arg0.id, v0).created_coins, v5);
        } else {
            let v6 = UserProfile{
                id            : 0x2::object::new(arg10),
                user          : v0,
                total_trades  : 0,
                volume_traded : 0,
                created_coins : 0x1::vector::singleton<0x2::object::ID>(v5),
            };
            0x2::dynamic_field::add<address, UserProfile>(&mut arg0.id, v0, v6);
        };
        let v7 = CoinCreated{
            pool_id      : v5,
            coin_type    : v2,
            creator      : v0,
            owner        : arg4,
            name         : 0x1::string::utf8(arg5),
            symbol       : 0x1::string::utf8(arg6),
            decimals     : arg9,
            total_supply : 1000000000 * 0x1::u64::pow(10, (arg9 as u8)),
            timestamp    : v1,
        };
        0x2::event::emit<CoinCreated>(v7);
        0x2::transfer::transfer<SimplifiedPool>(v4, v0);
    }

    fun generate_unique_coin_type(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"MEME_");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"_"));
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, ((0x2::tx_context::epoch(arg2) % 10) as u8) + 48);
        0x1::string::append(&mut v0, 0x1::string::utf8(v1));
        v0
    }

    public fun get_factory_stats(arg0: &Factory) : (u64, u64, u64, u64) {
        (arg0.total_pools, arg0.total_volume, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_balance), arg0.fee_bps)
    }

    public fun get_stored_witness_id(arg0: &Factory) : 0x2::object::ID {
        arg0.stored_witness_id
    }

    fun init(arg0: FACTORY_WITH_STORED_WITNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StoredWitness{
            id                : 0x2::object::new(arg1),
            can_create_tokens : true,
        };
        let v1 = Factory{
            id                : 0x2::object::new(arg1),
            admin             : 0x2::tx_context::sender(arg1),
            fee_bps           : 100,
            total_pools       : 0,
            total_volume      : 0,
            treasury_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            is_paused         : false,
            version           : 1,
            stored_witness_id : 0x2::object::id<StoredWitness>(&v0),
        };
        0x2::transfer::share_object<Factory>(v1);
        let v2 = MemeRegistry{
            id           : 0x2::object::new(arg1),
            total_coins  : 0,
            total_trades : 0,
            volume_24h   : 0,
        };
        0x2::transfer::share_object<MemeRegistry>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StoredWitness>(v0);
    }

    public fun is_stored_witness_valid(arg0: &StoredWitness) : bool {
        arg0.can_create_tokens
    }

    public entry fun sell_tokens<T0>(arg0: &mut TradingPool<T0>, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: &StoredWitness, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.can_create_tokens, 116);
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= 1000, 104);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg0.last_trade_timestamp + 1000, 108);
        let v2 = 0x2::balance::value<T0>(&arg0.token_balance);
        let v3 = if (v2 == 0) {
            v0 / 1000
        } else {
            v0 * 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) / (v2 + v0)
        };
        assert!(v3 >= arg6, 107);
        assert!(v3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 102);
        let v4 = v3 * arg1.fee_bps / 10000;
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(arg5));
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v3), arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v4, arg7)));
        arg0.total_trades = arg0.total_trades + 1;
        arg0.last_trade_timestamp = v1;
        arg1.total_volume = arg1.total_volume + v3;
        let v6 = 0x2::tx_context::sender(arg7);
        if (0x2::dynamic_field::exists_<address>(&arg1.id, v6)) {
            let v7 = 0x2::dynamic_field::borrow_mut<address, UserProfile>(&mut arg1.id, v6);
            v7.total_trades = v7.total_trades + 1;
            v7.volume_traded = v7.volume_traded + v3;
        } else {
            let v8 = UserProfile{
                id            : 0x2::object::new(arg7),
                user          : v6,
                total_trades  : 1,
                volume_traded : v3,
                created_coins : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<address, UserProfile>(&mut arg1.id, v6, v8);
        };
        let v9 = if (v0 > 0) {
            v3 / v0
        } else {
            0
        };
        let v10 = if (0x2::balance::value<T0>(&arg0.token_balance) > 0) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) / 0x2::balance::value<T0>(&arg0.token_balance)
        } else {
            0
        };
        let v11 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool<T0>>(arg0),
            coin_type       : 0x1::string::utf8(b"TODO"),
            trader          : v6,
            is_buy          : false,
            token_amount    : v0,
            sui_amount      : v3,
            price_per_token : v9,
            new_price       : v10,
            fee_amount      : v4,
            timestamp       : v1,
            sui_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<TradeExecuted>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v6);
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

    // decompiled from Move bytecode v6
}

