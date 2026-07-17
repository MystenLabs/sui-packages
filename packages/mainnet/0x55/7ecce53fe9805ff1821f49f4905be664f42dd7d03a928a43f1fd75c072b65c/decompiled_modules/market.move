module 0x557ecce53fe9805ff1821f49f4905be664f42dd7d03a928a43f1fd75c072b65c::market {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        liquidity: 0x2::balance::Balance<T0>,
        lp_supply: u64,
        rake_bps: u64,
        rake_vault: 0x2::balance::Balance<T0>,
        price: u64,
        oi_long: u64,
        oi_short: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct LpReceipt has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        shares: u64,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        owner: address,
        is_long: bool,
        size: u64,
        entry_price: u64,
        margin: 0x2::balance::Balance<T0>,
        opened_at: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        rake_bps: u64,
        price: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        shares: u64,
        lp_supply: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        shares: u64,
        amount: u64,
        lp_supply: u64,
    }

    struct PositionOpened has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        is_long: bool,
        size: u64,
        entry_price: u64,
        margin: u64,
        rake: u64,
    }

    struct PositionClosed has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        is_long: bool,
        size: u64,
        entry_price: u64,
        exit_price: u64,
        profit: bool,
        pnl: u64,
        payout: u64,
        rake: u64,
    }

    struct PriceUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        price: u64,
    }

    struct RakeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun add_liquidity<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<T0>(&arg0.liquidity);
        let v2 = if (arg0.lp_supply == 0 || v1 == 0) {
            v0
        } else {
            (((v0 as u128) * (arg0.lp_supply as u128) / (v1 as u128)) as u64)
        };
        assert!(v2 > 0, 0);
        0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::coin::into_balance<T0>(arg1));
        arg0.lp_supply = arg0.lp_supply + v2;
        let v3 = 0x2::object::id<Pool<T0>>(arg0);
        let v4 = LpReceipt{
            id      : 0x2::object::new(arg2),
            pool_id : v3,
            shares  : v2,
        };
        let v5 = LiquidityAdded{
            pool_id   : v3,
            provider  : 0x2::tx_context::sender(arg2),
            amount    : v0,
            shares    : v2,
            lp_supply : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityAdded>(v5);
        0x2::transfer::public_transfer<LpReceipt>(v4, 0x2::tx_context::sender(arg2));
    }

    public entry fun close_position<T0>(arg0: &mut Pool<T0>, arg1: Position<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let Position {
            id          : v0,
            pool_id     : v1,
            owner       : v2,
            is_long     : v3,
            size        : v4,
            entry_price : v5,
            margin      : v6,
            opened_at   : _,
        } = arg1;
        assert!(v1 == 0x2::object::id<Pool<T0>>(arg0), 2);
        0x2::object::delete(v0);
        let v8 = v6;
        let v9 = arg0.price;
        let (v10, v11) = if (v9 >= v5) {
            ((((v4 as u128) * ((v9 - v5) as u128) / (v5 as u128)) as u64), v3)
        } else {
            ((((v4 as u128) * ((v5 - v9) as u128) / (v5 as u128)) as u64), !v3)
        };
        let v12 = if (v11) {
            let v13 = 0x2::balance::value<T0>(&arg0.liquidity);
            let v14 = if (v10 <= v13) {
                v10
            } else {
                v13
            };
            0x2::balance::join<T0>(&mut v8, 0x2::balance::split<T0>(&mut arg0.liquidity, v14));
            v14
        } else {
            let v15 = 0x2::balance::value<T0>(&v8);
            let v16 = if (v10 <= v15) {
                v10
            } else {
                v15
            };
            0x2::balance::join<T0>(&mut arg0.liquidity, 0x2::balance::split<T0>(&mut v8, v16));
            v16
        };
        let v17 = (((v4 as u128) * (arg0.rake_bps as u128) / (10000 as u128)) as u64);
        let v18 = 0x2::balance::value<T0>(&v8);
        let v19 = if (v17 <= v18) {
            v17
        } else {
            v18
        };
        if (v19 > 0) {
            0x2::balance::join<T0>(&mut arg0.rake_vault, 0x2::balance::split<T0>(&mut v8, v19));
        };
        if (v3) {
            let v20 = if (arg0.oi_long >= v4) {
                arg0.oi_long - v4
            } else {
                0
            };
            arg0.oi_long = v20;
        } else {
            let v21 = if (arg0.oi_short >= v4) {
                arg0.oi_short - v4
            } else {
                0
            };
            arg0.oi_short = v21;
        };
        let v22 = PositionClosed{
            pool_id     : v1,
            owner       : v2,
            is_long     : v3,
            size        : v4,
            entry_price : v5,
            exit_price  : v9,
            profit      : v11,
            pnl         : v12,
            payout      : 0x2::balance::value<T0>(&v8),
            rake        : v19,
        };
        0x2::event::emit<PositionClosed>(v22);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg2), v2);
    }

    public entry fun collect_rake<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool_id == 0x2::object::id<Pool<T0>>(arg1), 3);
        let v0 = 0x2::balance::value<T0>(&arg1.rake_vault);
        assert!(v0 > 0, 0);
        let v1 = RakeCollected{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            amount  : v0,
        };
        0x2::event::emit<RakeCollected>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.rake_vault, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_pool<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 10000, 6);
        assert!(arg1 > 0, 4);
        let v0 = Pool<T0>{
            id         : 0x2::object::new(arg2),
            liquidity  : 0x2::balance::zero<T0>(),
            lp_supply  : 0,
            rake_bps   : arg0,
            rake_vault : 0x2::balance::zero<T0>(),
            price      : arg1,
            oi_long    : 0,
            oi_short   : 0,
        };
        let v1 = 0x2::object::id<Pool<T0>>(&v0);
        let v2 = AdminCap{
            id      : 0x2::object::new(arg2),
            pool_id : v1,
        };
        let v3 = PoolCreated{
            pool_id  : v1,
            rake_bps : arg0,
            price    : arg1,
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<Pool<T0>>(v0);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun lp_supply<T0>(arg0: &Pool<T0>) : u64 {
        arg0.lp_supply
    }

    public fun open_interest<T0>(arg0: &Pool<T0>) : (u64, u64) {
        (arg0.oi_long, arg0.oi_short)
    }

    public entry fun open_position<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = (((arg3 as u128) * (arg0.rake_bps as u128) / (10000 as u128)) as u64);
        assert!(v0 > v1, 7);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.rake_vault, 0x2::balance::split<T0>(&mut v2, v1));
        };
        let v3 = 0x2::object::id<Pool<T0>>(arg0);
        let v4 = arg0.price;
        if (arg2) {
            arg0.oi_long = arg0.oi_long + arg3;
        } else {
            arg0.oi_short = arg0.oi_short + arg3;
        };
        let v5 = 0x2::tx_context::sender(arg4);
        let v6 = Position<T0>{
            id          : 0x2::object::new(arg4),
            pool_id     : v3,
            owner       : v5,
            is_long     : arg2,
            size        : arg3,
            entry_price : v4,
            margin      : v2,
            opened_at   : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        let v7 = PositionOpened{
            pool_id     : v3,
            owner       : v5,
            is_long     : arg2,
            size        : arg3,
            entry_price : v4,
            margin      : 0x2::balance::value<T0>(&v6.margin),
            rake        : v1,
        };
        0x2::event::emit<PositionOpened>(v7);
        0x2::transfer::public_transfer<Position<T0>>(v6, v5);
    }

    public fun price<T0>(arg0: &Pool<T0>) : u64 {
        arg0.price
    }

    public fun price_scale() : u64 {
        1000000
    }

    public fun rake_bps<T0>(arg0: &Pool<T0>) : u64 {
        arg0.rake_bps
    }

    public fun rake_collected<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rake_vault)
    }

    public entry fun remove_liquidity<T0>(arg0: &mut Pool<T0>, arg1: LpReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let LpReceipt {
            id      : v0,
            pool_id : v1,
            shares  : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Pool<T0>>(arg0), 2);
        assert!(v2 > 0, 0);
        assert!(arg0.lp_supply >= v2, 5);
        let v3 = 0x2::balance::value<T0>(&arg0.liquidity);
        let v4 = (((v2 as u128) * (v3 as u128) / (arg0.lp_supply as u128)) as u64);
        assert!(v4 <= v3, 1);
        arg0.lp_supply = arg0.lp_supply - v2;
        0x2::object::delete(v0);
        let v5 = LiquidityRemoved{
            pool_id   : v1,
            provider  : 0x2::tx_context::sender(arg2),
            shares    : v2,
            amount    : v4,
            lp_supply : arg0.lp_supply,
        };
        0x2::event::emit<LiquidityRemoved>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.liquidity, v4, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun set_price<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg0.pool_id == 0x2::object::id<Pool<T0>>(arg1), 3);
        assert!(arg2 > 0, 4);
        arg1.price = arg2;
        let v0 = PriceUpdated{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            price   : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public entry fun set_rake_bps<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg0.pool_id == 0x2::object::id<Pool<T0>>(arg1), 3);
        assert!(arg2 < 10000, 6);
        arg1.rake_bps = arg2;
    }

    public fun tvl<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.liquidity)
    }

    // decompiled from Move bytecode v7
}

