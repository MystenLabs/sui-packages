module 0x69b6fb5eaab144781bf4412edffde4757eff38c626ee5fbcd40c8d39b8704ee::simple_factory {
    struct SIMPLE_FACTORY has drop {
        dummy_field: bool,
    }

    struct CoinCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
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
        timestamp: u64,
    }

    struct TokensBurned has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        burner: address,
        amount: u64,
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
        is_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balance: 0x2::balance::Balance<FactoryCoin<T0>>,
        total_supply: u64,
        creator: address,
        last_trade_time: u64,
    }

    struct CoinInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        decimals: u8,
        treasury_cap: 0x2::coin::TreasuryCap<FactoryCoin<T0>>,
    }

    public entry fun burn_tokens<T0>(arg0: &mut Pool<T0>, arg1: &mut CoinInfo<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<FactoryCoin<T0>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<FactoryCoin<T0>>(&arg3);
        assert!(v0 > 0, 104);
        0x2::coin::burn<FactoryCoin<T0>>(&mut arg1.treasury_cap, arg3);
        arg0.total_supply = arg0.total_supply - v0;
        let v1 = TokensBurned{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<FactoryCoin<T0>>())),
            burner    : 0x2::tx_context::sender(arg4),
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public entry fun buy_tokens<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 104);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) + 1000000000000;
        let v4 = 0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance) + 1000000000000000000;
        let v5 = v4 - v3 * v4 / (v3 + v0);
        assert!(v5 >= arg3, 107);
        assert!(0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance) >= v5, 103);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.last_trade_time = v1;
        let v6 = TradeExecuted{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<FactoryCoin<T0>>())),
            trader       : v2,
            is_buy       : true,
            token_amount : v5,
            sui_amount   : v0,
            timestamp    : v1,
        };
        0x2::event::emit<TradeExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<FactoryCoin<T0>>>(0x2::coin::take<FactoryCoin<T0>>(&mut arg0.token_balance, v5, arg4), v2);
    }

    public entry fun create_coin<T0: drop>(arg0: &mut Factory, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 114);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = FactoryCoin<T0>{dummy_field: false};
        let (v3, v4) = 0x2::coin::create_currency<FactoryCoin<T0>>(v2, arg6, arg3, arg2, arg4, 0x1::option::none<0x2::url::Url>(), arg7);
        let v5 = v3;
        let v6 = 1000000000 * 1000000000;
        let v7 = Pool<T0>{
            id              : 0x2::object::new(arg7),
            sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            token_balance   : 0x2::coin::into_balance<FactoryCoin<T0>>(0x2::coin::mint<FactoryCoin<T0>>(&mut v5, v6, arg7)),
            total_supply    : v6,
            creator         : v0,
            last_trade_time : v1,
        };
        let v8 = CoinInfo<T0>{
            id           : 0x2::object::new(arg7),
            name         : 0x1::string::utf8(arg2),
            symbol       : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            icon_url     : 0x1::string::utf8(arg5),
            decimals     : arg6,
            treasury_cap : v5,
        };
        arg0.total_pools = arg0.total_pools + 1;
        let v9 = CoinCreated{
            pool_id      : 0x2::object::id<Pool<T0>>(&v7),
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<FactoryCoin<T0>>())),
            creator      : v0,
            name         : 0x1::string::utf8(arg2),
            symbol       : 0x1::string::utf8(arg3),
            decimals     : arg6,
            total_supply : v6,
            timestamp    : v1,
        };
        0x2::event::emit<CoinCreated>(v9);
        0x2::transfer::share_object<Pool<T0>>(v7);
        0x2::transfer::share_object<CoinInfo<T0>>(v8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FactoryCoin<T0>>>(v4);
    }

    public fun get_factory_stats(arg0: &Factory) : (u64, u64, bool, address) {
        (arg0.total_pools, arg0.fee_bps, arg0.is_paused, arg0.admin)
    }

    public fun get_pool_info<T0>(arg0: &Pool<T0>) : (u64, u64, u64, address, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance), arg0.total_supply, arg0.creator, arg0.last_trade_time)
    }

    fun init(arg0: SIMPLE_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id          : 0x2::object::new(arg1),
            admin       : 0x2::tx_context::sender(arg1),
            fee_bps     : 100,
            total_pools : 0,
            is_paused   : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Factory>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun sell_tokens<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<FactoryCoin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<FactoryCoin<T0>>(&arg2);
        assert!(v0 > 0, 104);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) + 1000000000000;
        let v4 = 0x2::balance::value<FactoryCoin<T0>>(&arg0.token_balance) + 1000000000000000000;
        let v5 = v3 - v3 * v4 / (v4 + v0);
        assert!(v5 >= arg3, 107);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= v5, 102);
        0x2::balance::join<FactoryCoin<T0>>(&mut arg0.token_balance, 0x2::coin::into_balance<FactoryCoin<T0>>(arg2));
        arg0.last_trade_time = v1;
        let v6 = TradeExecuted{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<FactoryCoin<T0>>())),
            trader       : v2,
            is_buy       : false,
            token_amount : v0,
            sui_amount   : v5,
            timestamp    : v1,
        };
        0x2::event::emit<TradeExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v5, arg4), v2);
    }

    public entry fun toggle_pause(arg0: &AdminCap, arg1: &mut Factory) {
        arg1.is_paused = !arg1.is_paused;
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Factory, arg2: u64) {
        arg1.fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

