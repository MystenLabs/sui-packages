module 0x83c80a6ff7cd08d7483aa6e06291b73f12eaf69065779bb60313cb4211d1720f::unlimited_factory {
    struct UNLIMITED_FACTORY has drop {
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
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
        initial_purchase: u64,
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

    struct CoinGraduated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        final_price: u64,
        total_raised: u64,
        timestamp: u64,
    }

    struct FactoryCoin<phantom T0> has drop {
        dummy_field: bool,
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

    struct TradingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::string::String,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        icon_url: 0x1::option::Option<0x1::string::String>,
        description: 0x1::string::String,
        treasury_cap: 0x2::coin::TreasuryCap<FactoryCoin<T0>>,
        token_balance: 0x2::balance::Balance<FactoryCoin<T0>>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_supply: u64,
        tokens_sold: u64,
        is_graduated: bool,
        total_trades: u64,
        last_trade_timestamp: u64,
        created_at: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun buy_tokens<T0>(arg0: &mut TradingPool<T0>, arg1: &mut Factory, arg2: &StoredWitness, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_graduated, 117);
        assert!(arg2.can_create_tokens, 116);
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 >= 1000000, 104);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.last_trade_timestamp + 100, 108);
        let v2 = calculate_buy_tokens(0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.virtual_token_reserves, arg0.virtual_sui_reserves, v0);
        assert!(v2 >= arg5, 107);
        assert!(v2 <= 0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 103);
        let v3 = v0 * arg1.fee_bps / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v3, arg6)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        arg0.tokens_sold = arg0.tokens_sold + v2;
        arg0.total_trades = arg0.total_trades + 1;
        arg0.last_trade_timestamp = v1;
        arg1.total_volume = arg1.total_volume + v0;
        let v4 = if (v2 > 0) {
            v0 / v2
        } else {
            0
        };
        let v5 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool<T0>>(arg0),
            coin_type       : arg0.coin_type,
            trader          : 0x2::tx_context::sender(arg6),
            is_buy          : true,
            token_amount    : v2,
            sui_amount      : v0,
            price_per_token : v4,
            new_price       : calculate_current_price(0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.virtual_token_reserves, arg0.virtual_sui_reserves),
            fee_amount      : v3,
            timestamp       : v1,
            sui_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<TradeExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FactoryCoin<T0>>>(0x2::coin::from_balance<FactoryCoin<T0>>(0x2::balance::split<FactoryCoin<T0>>(&mut arg0.token_balance, v2), arg6), 0x2::tx_context::sender(arg6));
    }

    fun calculate_buy_tokens(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = arg0 + arg2;
        let v1 = arg1 + arg3;
        v0 - v0 * v1 / (v1 + arg4)
    }

    fun calculate_current_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0 + arg2;
        if (v0 > 0) {
            (arg1 + arg3) / v0
        } else {
            0
        }
    }

    fun calculate_sell_tokens(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = arg0 + arg2;
        let v1 = arg1 + arg3;
        v1 - v0 * v1 / (v0 + arg4)
    }

    public entry fun create_coin<T0: drop>(arg0: &mut Factory, arg1: &StoredWitness, arg2: &0x2::clock::Clock, arg3: T0, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 114);
        assert!(0x1::vector::length<u8>(&arg4) <= 64, 110);
        assert!(0x1::vector::length<u8>(&arg5) <= 16, 111);
        assert!(0x1::vector::length<u8>(&arg6) <= 1000, 112);
        assert!(arg8 <= 18, 109);
        assert!(0x2::object::id<StoredWitness>(arg1) == arg0.stored_witness_id, 116);
        assert!(arg1.can_create_tokens, 116);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x1::string::utf8(arg5);
        let v3 = 0x1::string::utf8(arg4);
        let v4 = 0x1::string::utf8(arg6);
        let v5 = if (0x1::vector::is_empty<u8>(&arg7)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg7))
        };
        let v6 = FactoryCoin<T0>{dummy_field: false};
        let (v7, v8) = 0x2::coin::create_currency<FactoryCoin<T0>>(v6, arg8, *0x1::string::as_bytes(&v2), *0x1::string::as_bytes(&v3), *0x1::string::as_bytes(&v4), v5, arg11);
        let v9 = v7;
        let v10 = 1000000000 * 0x1::u64::pow(10, arg8);
        let v11 = generate_unique_coin_type(arg4, arg5, arg11);
        let v12 = if (0x1::vector::is_empty<u8>(&arg7)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg7))
        };
        let v13 = TradingPool<T0>{
            id                     : 0x2::object::new(arg11),
            coin_type              : v11,
            creator                : v0,
            name                   : 0x1::string::utf8(arg4),
            symbol                 : 0x1::string::utf8(arg5),
            decimals               : arg8,
            icon_url               : v12,
            description            : 0x1::string::utf8(arg6),
            treasury_cap           : v9,
            token_balance          : 0x2::coin::into_balance<FactoryCoin<T0>>(0x2::coin::mint<FactoryCoin<T0>>(&mut v9, v10, arg11)),
            sui_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            total_supply           : v10,
            tokens_sold            : 0,
            is_graduated           : false,
            total_trades           : 0,
            last_trade_timestamp   : v1,
            created_at             : v1,
            virtual_sui_reserves   : 1000000000000,
            virtual_token_reserves : 1000000000000000000,
        };
        let v14 = 0x2::coin::value<0x2::sui::SUI>(&arg9);
        let v15 = 0;
        if (v14 > 0) {
            let v16 = calculate_buy_tokens(0x2::balance::value<FactoryCoin<T0>>(&v13.token_balance), 0x2::balance::value<0x2::sui::SUI>(&v13.sui_balance), v13.virtual_token_reserves, v13.virtual_sui_reserves, v14);
            v15 = v16;
            assert!(v16 >= arg10, 107);
            assert!(v16 <= 0x2::balance::value<FactoryCoin<T0>>(&v13.token_balance), 103);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v14 * arg0.fee_bps / 10000, arg11)));
            0x2::balance::join<0x2::sui::SUI>(&mut v13.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg9));
            v13.tokens_sold = v16;
            v13.total_trades = 1;
            arg0.total_volume = arg0.total_volume + v14;
            0x2::transfer::public_transfer<0x2::coin::Coin<FactoryCoin<T0>>>(0x2::coin::from_balance<FactoryCoin<T0>>(0x2::balance::split<FactoryCoin<T0>>(&mut v13.token_balance, v16), arg11), v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
        };
        arg0.total_pools = arg0.total_pools + 1;
        let v17 = CoinCreated{
            pool_id          : 0x2::object::id<TradingPool<T0>>(&v13),
            coin_type        : v11,
            creator          : v0,
            name             : 0x1::string::utf8(arg4),
            symbol           : 0x1::string::utf8(arg5),
            decimals         : arg8,
            total_supply     : v10,
            initial_purchase : v15,
            timestamp        : v1,
        };
        0x2::event::emit<CoinCreated>(v17);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FactoryCoin<T0>>>(v8);
        0x2::transfer::share_object<TradingPool<T0>>(v13);
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

    public fun get_buy_quote<T0>(arg0: &TradingPool<T0>, arg1: u64) : u64 {
        calculate_buy_tokens(0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg1)
    }

    public fun get_factory_stats(arg0: &Factory) : (u64, u64, u64, u64) {
        (arg0.total_pools, arg0.total_volume, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_balance), arg0.fee_bps)
    }

    public fun get_pool_info<T0>(arg0: &TradingPool<T0>) : (0x1::string::String, 0x1::string::String, u64, u64, u64, bool) {
        (arg0.name, arg0.symbol, 0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.tokens_sold, arg0.is_graduated)
    }

    public fun get_sell_quote<T0>(arg0: &TradingPool<T0>, arg1: u64) : u64 {
        calculate_sell_tokens(0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg1)
    }

    public entry fun graduate_coin<T0>(arg0: &AdminCap, arg1: &mut TradingPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_graduated = true;
        let v0 = if (arg1.tokens_sold > 0) {
            0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) / arg1.tokens_sold
        } else {
            0
        };
        let v1 = CoinGraduated{
            pool_id      : 0x2::object::id<TradingPool<T0>>(arg1),
            coin_type    : arg1.coin_type,
            final_price  : v0,
            total_raised : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance),
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CoinGraduated>(v1);
    }

    fun init(arg0: UNLIMITED_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StoredWitness>(v0);
    }

    public entry fun sell_tokens<T0>(arg0: &mut TradingPool<T0>, arg1: &mut Factory, arg2: &StoredWitness, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<FactoryCoin<T0>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_graduated, 117);
        assert!(arg2.can_create_tokens, 116);
        assert!(!arg1.is_paused, 114);
        let v0 = 0x2::coin::value<FactoryCoin<T0>>(&arg4);
        assert!(v0 >= 1000000, 104);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.last_trade_timestamp + 100, 108);
        let v2 = calculate_sell_tokens(0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.virtual_token_reserves, arg0.virtual_sui_reserves, v0);
        assert!(v2 >= arg5, 107);
        assert!(v2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 102);
        let v3 = v2 * arg1.fee_bps / 10000;
        0x2::balance::join<FactoryCoin<T0>>(&mut arg0.token_balance, 0x2::coin::into_balance<FactoryCoin<T0>>(arg4));
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v2), arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v3, arg6)));
        arg0.tokens_sold = arg0.tokens_sold - v0;
        arg0.total_trades = arg0.total_trades + 1;
        arg0.last_trade_timestamp = v1;
        arg1.total_volume = arg1.total_volume + v2;
        let v5 = if (v0 > 0) {
            v2 / v0
        } else {
            0
        };
        let v6 = TradeExecuted{
            pool_id         : 0x2::object::id<TradingPool<T0>>(arg0),
            coin_type       : arg0.coin_type,
            trader          : 0x2::tx_context::sender(arg6),
            is_buy          : false,
            token_amount    : v0,
            sui_amount      : v2,
            price_per_token : v5,
            new_price       : calculate_current_price(0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg0.virtual_token_reserves, arg0.virtual_sui_reserves),
            fee_amount      : v3,
            timestamp       : v1,
            sui_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<TradeExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg6));
    }

    public entry fun toggle_pause(arg0: &AdminCap, arg1: &mut Factory, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.is_paused = !arg1.is_paused;
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Factory, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 0);
        arg1.fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

