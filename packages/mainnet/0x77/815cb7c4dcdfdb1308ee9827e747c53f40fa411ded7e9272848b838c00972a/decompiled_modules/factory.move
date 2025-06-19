module 0x77815cb7c4dcdfdb1308ee9827e747c53f40fa411ded7e9272848b838c00972a::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        total_pools: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
    }

    struct TradeExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        amount: u64,
    }

    public entry fun buy<T0>(arg0: &mut Pool<T0>, arg1: &mut Factory, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = v0 * arg1.fee_bps / 10000;
        let v2 = (v0 - v1) * 1000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v1));
        let v3 = TradeExecuted{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            trader  : 0x2::tx_context::sender(arg3),
            is_buy  : true,
            amount  : v2,
        };
        0x2::event::emit<TradeExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, v2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_coin<T0: drop>(arg0: T0, arg1: &mut Factory, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg4, arg3, arg2, b"", 0x1::option::none<0x2::url::Url>(), arg5);
        let v2 = Pool<T0>{
            id            : 0x2::object::new(arg5),
            treasury_cap  : v0,
            token_reserve : 0x2::balance::zero<T0>(),
            sui_reserve   : 0x2::balance::zero<0x2::sui::SUI>(),
            creator       : 0x2::tx_context::sender(arg5),
        };
        arg1.total_pools = arg1.total_pools + 1;
        let v3 = PoolCreated{
            pool_id : 0x2::object::id<Pool<T0>>(&v2),
            creator : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<Pool<T0>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T0>>(v1, 0x2::tx_context::sender(arg5));
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id          : 0x2::object::new(arg1),
            fee_bps     : 100,
            total_pools : 0,
            treasury    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    public entry fun sell<T0>(arg0: &mut Pool<T0>, arg1: &mut Factory, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = v0 / 1000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v1, 2);
        let v2 = v1 * arg1.fee_bps / 10000;
        let v3 = v1 - v2;
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v2));
        let v4 = TradeExecuted{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            trader  : 0x2::tx_context::sender(arg3),
            is_buy  : false,
            amount  : v3,
        };
        0x2::event::emit<TradeExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

