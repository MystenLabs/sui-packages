module 0x9379b41604c2ba2e9c3364f4ad31634e1d9648c043d1b0e455ab30d096bc2673::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        total_pools: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MemeRegistry has key {
        id: 0x2::object::UID,
        total_coins: u64,
        total_trades: u64,
        volume_24h: u64,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
        total_trades: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        coin_type: 0x1::string::String,
    }

    struct TradeExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        amount: u64,
    }

    public entry fun buy_tokens<T0>(arg0: &mut Pool<T0>, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 1);
        let v1 = v0 * arg1.fee_bps / 10000;
        let v2 = (v0 - v1) * 1000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v1));
        arg0.total_trades = arg0.total_trades + 1;
        arg2.total_trades = arg2.total_trades + 1;
        arg2.volume_24h = arg2.volume_24h + v0;
        let v3 = TradeExecuted{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            trader  : 0x2::tx_context::sender(arg4),
            is_buy  : true,
            amount  : v2,
        };
        0x2::event::emit<TradeExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, v2, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun create_meme_coin<T0: drop>(arg0: T0, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg6, arg5, arg4, b"A meme coin created via factory", 0x1::option::none<0x2::url::Url>(), arg7);
        let v2 = Pool<T0>{
            id            : 0x2::object::new(arg7),
            treasury_cap  : v0,
            token_reserve : 0x2::balance::zero<T0>(),
            sui_reserve   : 0x2::balance::zero<0x2::sui::SUI>(),
            creator       : 0x2::tx_context::sender(arg7),
            total_trades  : 0,
        };
        arg1.total_pools = arg1.total_pools + 1;
        arg2.total_coins = arg2.total_coins + 1;
        let v3 = PoolCreated{
            pool_id   : 0x2::object::id<Pool<T0>>(&v2),
            creator   : 0x2::tx_context::sender(arg7),
            coin_type : 0x1::string::utf8(b"Unknown"),
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<Pool<T0>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public fun get_factory_stats(arg0: &Factory) : (u64, u64) {
        (arg0.total_pools, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    public fun get_pool_stats<T0>(arg0: &Pool<T0>) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<T0>(&arg0.token_reserve), arg0.total_trades)
    }

    public fun get_registry_stats(arg0: &MemeRegistry) : (u64, u64, u64) {
        (arg0.total_coins, arg0.total_trades, arg0.volume_24h)
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id          : 0x2::object::new(arg1),
            fee_bps     : 100,
            total_pools : 0,
            treasury    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Factory>(v0);
        let v1 = MemeRegistry{
            id           : 0x2::object::new(arg1),
            total_coins  : 0,
            total_trades : 0,
            volume_24h   : 0,
        };
        0x2::transfer::share_object<MemeRegistry>(v1);
    }

    public entry fun sell_tokens<T0>(arg0: &mut Pool<T0>, arg1: &mut Factory, arg2: &mut MemeRegistry, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 1);
        let v1 = v0 / 1000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v1, 2);
        let v2 = v1 * arg1.fee_bps / 10000;
        let v3 = v1 - v2;
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2));
        arg0.total_trades = arg0.total_trades + 1;
        arg2.total_trades = arg2.total_trades + 1;
        arg2.volume_24h = arg2.volume_24h + v1;
        let v4 = TradeExecuted{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            trader  : 0x2::tx_context::sender(arg4),
            is_buy  : false,
            amount  : v3,
        };
        0x2::event::emit<TradeExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

