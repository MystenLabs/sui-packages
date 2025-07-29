module 0x69b6fb5eaab144781bf4412edffde4757eff38c626ee5fbcd40c8d39b8704ee::basic_factory {
    struct BASIC_FACTORY has drop {
        dummy_field: bool,
    }

    struct MemeToken has drop {
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

    struct Factory has key {
        id: 0x2::object::UID,
        admin: address,
        fee_bps: u64,
        total_pools: u64,
        is_paused: bool,
        stored_witness_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StoredWitness has store, key {
        id: 0x2::object::UID,
        can_create_tokens: bool,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balance: 0x2::balance::Balance<MemeToken>,
        total_supply: u64,
        creator: address,
        symbol: 0x1::string::String,
        last_trade_time: u64,
    }

    struct CoinInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        decimals: u8,
        treasury_cap: 0x2::coin::TreasuryCap<MemeToken>,
    }

    public entry fun burn_tokens(arg0: &mut Pool, arg1: &mut CoinInfo, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<MemeToken>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<MemeToken>(&arg3);
        assert!(v0 > 0, 104);
        0x2::coin::burn<MemeToken>(&mut arg1.treasury_cap, arg3);
        arg0.total_supply = arg0.total_supply - v0;
        let v1 = TokensBurned{
            pool_id   : 0x2::object::id<Pool>(arg0),
            coin_type : 0x1::string::utf8(b"MemeToken"),
            burner    : 0x2::tx_context::sender(arg4),
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public entry fun buy_tokens(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 104);
        assert!(arg3 > 0, 104);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::sender(arg4);
        assert!(0x2::balance::value<MemeToken>(&arg0.token_balance) >= arg3, 103);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.last_trade_time = v1;
        let v3 = TradeExecuted{
            pool_id      : 0x2::object::id<Pool>(arg0),
            coin_type    : 0x1::string::utf8(b"MemeToken"),
            trader       : v2,
            is_buy       : true,
            token_amount : arg3,
            sui_amount   : v0,
            timestamp    : v1,
        };
        0x2::event::emit<TradeExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<MemeToken>>(0x2::coin::take<MemeToken>(&mut arg0.token_balance, arg3, arg4), v2);
    }

    public entry fun create_coin(arg0: &mut Factory, arg1: &StoredWitness, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 114);
        assert!(0x2::object::id<StoredWitness>(arg1) == arg0.stored_witness_id, 116);
        assert!(arg1.can_create_tokens, 116);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = MemeToken{dummy_field: false};
        let (v3, v4) = 0x2::coin::create_currency<MemeToken>(v2, arg7, arg4, arg3, arg5, 0x1::option::none<0x2::url::Url>(), arg8);
        let v5 = v3;
        let v6 = 1000000000 * 0x1::u64::pow(10, (arg7 as u8));
        let v7 = Pool{
            id              : 0x2::object::new(arg8),
            sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            token_balance   : 0x2::coin::into_balance<MemeToken>(0x2::coin::mint<MemeToken>(&mut v5, v6, arg8)),
            total_supply    : v6,
            creator         : v0,
            symbol          : 0x1::string::utf8(arg4),
            last_trade_time : v1,
        };
        let v8 = CoinInfo{
            id           : 0x2::object::new(arg8),
            name         : 0x1::string::utf8(arg3),
            symbol       : 0x1::string::utf8(arg4),
            description  : 0x1::string::utf8(arg5),
            icon_url     : 0x1::string::utf8(arg6),
            decimals     : arg7,
            treasury_cap : v5,
        };
        arg0.total_pools = arg0.total_pools + 1;
        let v9 = CoinCreated{
            pool_id      : 0x2::object::id<Pool>(&v7),
            coin_type    : 0x1::string::utf8(b"MemeToken"),
            creator      : v0,
            name         : 0x1::string::utf8(arg3),
            symbol       : 0x1::string::utf8(arg4),
            decimals     : arg7,
            total_supply : v6,
            timestamp    : v1,
        };
        0x2::event::emit<CoinCreated>(v9);
        0x2::transfer::share_object<Pool>(v7);
        0x2::transfer::share_object<CoinInfo>(v8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MemeToken>>(v4);
    }

    public fun get_factory_stats(arg0: &Factory) : (u64, u64, bool, address) {
        (arg0.total_pools, arg0.fee_bps, arg0.is_paused, arg0.admin)
    }

    public fun get_pool_info(arg0: &Pool) : (u64, u64, u64, address, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<MemeToken>(&arg0.token_balance), arg0.total_supply, arg0.creator, arg0.last_trade_time)
    }

    public fun get_stored_witness_id(arg0: &Factory) : 0x2::object::ID {
        arg0.stored_witness_id
    }

    fun init(arg0: BASIC_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StoredWitness{
            id                : 0x2::object::new(arg1),
            can_create_tokens : true,
        };
        let v1 = Factory{
            id                : 0x2::object::new(arg1),
            admin             : 0x2::tx_context::sender(arg1),
            fee_bps           : 100,
            total_pools       : 0,
            is_paused         : false,
            stored_witness_id : 0x2::object::id<StoredWitness>(&v0),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Factory>(v1);
        0x2::transfer::share_object<StoredWitness>(v0);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_stored_witness_valid(arg0: &StoredWitness) : bool {
        arg0.can_create_tokens
    }

    public entry fun sell_tokens(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<MemeToken>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<MemeToken>(&arg2);
        assert!(v0 > 0, 104);
        assert!(arg3 > 0, 104);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::sender(arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg3, 102);
        0x2::balance::join<MemeToken>(&mut arg0.token_balance, 0x2::coin::into_balance<MemeToken>(arg2));
        arg0.last_trade_time = v1;
        let v3 = TradeExecuted{
            pool_id      : 0x2::object::id<Pool>(arg0),
            coin_type    : 0x1::string::utf8(b"MemeToken"),
            trader       : v2,
            is_buy       : false,
            token_amount : v0,
            sui_amount   : arg3,
            timestamp    : v1,
        };
        0x2::event::emit<TradeExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, arg3, arg4), v2);
    }

    public entry fun toggle_pause(arg0: &AdminCap, arg1: &mut Factory) {
        arg1.is_paused = !arg1.is_paused;
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Factory, arg2: u64) {
        arg1.fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

