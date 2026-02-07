module 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::pool {
    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ShareKey has copy, drop, store {
        lp: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        admin: address,
        min_rate: u64,
        max_rate: u64,
        num_buckets: u64,
    }

    struct LiquidityDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        lp: address,
        amount: u64,
        shares_minted: u64,
    }

    struct LiquidityWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        lp: address,
        amount: u64,
        shares_burned: u64,
    }

    struct PoolRebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        orders_cancelled: u64,
        orders_placed: u64,
        total_deployed: u64,
    }

    struct LiquidityPool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        book_id: 0x2::object::ID,
        total_shares: u64,
        min_rate: u64,
        max_rate: u64,
        num_buckets: u64,
        deployed_balance: u64,
        placed_order_ids: vector<u64>,
        is_active: bool,
    }

    public(friend) fun new<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : LiquidityPool<T0> {
        assert!(arg2 < arg3, 604);
        assert!(arg4 >= 2, 604);
        let v0 = LiquidityPool<T0>{
            id               : 0x2::object::new(arg5),
            admin            : arg0,
            book_id          : arg1,
            total_shares     : 0,
            min_rate         : arg2,
            max_rate         : arg3,
            num_buckets      : arg4,
            deployed_balance : 0,
            placed_order_ids : 0x1::vector::empty<u64>(),
            is_active        : true,
        };
        let v1 = BalanceKey{dummy_field: false};
        0x2::dynamic_field::add<BalanceKey, 0x2::balance::Balance<T0>>(&mut v0.id, v1, 0x2::balance::zero<T0>());
        let v2 = PoolCreated{
            pool_id     : 0x2::object::id<LiquidityPool<T0>>(&v0),
            book_id     : arg1,
            admin       : arg0,
            min_rate    : arg2,
            max_rate    : arg3,
            num_buckets : arg4,
        };
        0x2::event::emit<PoolCreated>(v2);
        v0
    }

    public fun available_balance<T0>(arg0: &LiquidityPool<T0>) : u64 {
        get_available_balance<T0>(arg0)
    }

    public fun book_id<T0>(arg0: &LiquidityPool<T0>) : 0x2::object::ID {
        arg0.book_id
    }

    public fun deployed_balance<T0>(arg0: &LiquidityPool<T0>) : u64 {
        arg0.deployed_balance
    }

    entry fun deposit<T0>(arg0: &mut LiquidityPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 600);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 605);
        let v1 = if (arg0.total_shares == 0) {
            v0
        } else {
            v0 * arg0.total_shares / (get_available_balance<T0>(arg0) + arg0.deployed_balance)
        };
        let v2 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v1;
        let v3 = 0x2::tx_context::sender(arg2);
        let v4 = ShareKey{lp: v3};
        if (0x2::dynamic_field::exists_<ShareKey>(&arg0.id, v4)) {
            let v5 = ShareKey{lp: v3};
            let v6 = 0x2::dynamic_field::borrow_mut<ShareKey, u64>(&mut arg0.id, v5);
            *v6 = *v6 + v1;
        } else {
            let v7 = ShareKey{lp: v3};
            0x2::dynamic_field::add<ShareKey, u64>(&mut arg0.id, v7, v1);
        };
        let v8 = LiquidityDeposited{
            pool_id       : 0x2::object::id<LiquidityPool<T0>>(arg0),
            lp            : v3,
            amount        : v0,
            shares_minted : v1,
        };
        0x2::event::emit<LiquidityDeposited>(v8);
    }

    fun get_available_balance<T0>(arg0: &LiquidityPool<T0>) : u64 {
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey, 0x2::balance::Balance<T0>>(&arg0.id, v0))
    }

    public fun is_active<T0>(arg0: &LiquidityPool<T0>) : bool {
        arg0.is_active
    }

    public fun lp_shares<T0>(arg0: &LiquidityPool<T0>, arg1: address) : u64 {
        let v0 = ShareKey{lp: arg1};
        if (0x2::dynamic_field::exists_<ShareKey>(&arg0.id, v0)) {
            let v2 = ShareKey{lp: arg1};
            *0x2::dynamic_field::borrow<ShareKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun max_rate<T0>(arg0: &LiquidityPool<T0>) : u64 {
        arg0.max_rate
    }

    public fun min_rate<T0>(arg0: &LiquidityPool<T0>) : u64 {
        arg0.min_rate
    }

    public fun num_buckets<T0>(arg0: &LiquidityPool<T0>) : u64 {
        arg0.num_buckets
    }

    public fun num_placed_orders<T0>(arg0: &LiquidityPool<T0>) : u64 {
        0x1::vector::length<u64>(&arg0.placed_order_ids)
    }

    public fun pool_admin<T0>(arg0: &LiquidityPool<T0>) : address {
        arg0.admin
    }

    public fun rebalance<T0, T1>(arg0: &mut LiquidityPool<T0>, arg1: &mut 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::OrderBook<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 603);
        let v0 = arg0.admin;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0.placed_order_ids)) {
            let v3 = *0x1::vector::borrow<u64>(&arg0.placed_order_ids, v2);
            if (0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::has_active_order<T0, T1>(arg1, v3)) {
                0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::remove_order<T0, T1>(arg1, v3, v0);
                v1 = v1 + 1;
                if (0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::has_deposit<T0, T1>(arg1, v3)) {
                    let v4 = BalanceKey{dummy_field: false};
                    0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v4), 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::withdraw_deposit<T0, T1>(arg1, v3));
                };
            };
            v2 = v2 + 1;
        };
        arg0.placed_order_ids = 0x1::vector::empty<u64>();
        arg0.deployed_balance = 0;
        let v5 = get_available_balance<T0>(arg0);
        if (v5 == 0) {
            let v6 = PoolRebalanced{
                pool_id          : 0x2::object::id<LiquidityPool<T0>>(arg0),
                orders_cancelled : v1,
                orders_placed    : 0,
                total_deployed   : 0,
            };
            0x2::event::emit<PoolRebalanced>(v6);
            return
        };
        let v7 = v5 / arg0.num_buckets;
        if (v7 == 0) {
            let v8 = PoolRebalanced{
                pool_id          : 0x2::object::id<LiquidityPool<T0>>(arg0),
                orders_cancelled : v1,
                orders_placed    : 0,
                total_deployed   : 0,
            };
            0x2::event::emit<PoolRebalanced>(v8);
            return
        };
        let v9 = 0;
        let v10 = 0;
        while (v9 < arg0.num_buckets) {
            let v11 = BalanceKey{dummy_field: false};
            let v12 = 0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::add_order<T0, T1>(arg1, 0, v7, arg0.min_rate + v9 * (arg0.max_rate - arg0.min_rate) / (arg0.num_buckets - 1), 0x2::clock::timestamp_ms(arg2), v0);
            0x220caae17de736a4f02d34c2e3a62deb7f7981e7eeb970ccb477c7b23576d3b7::orderbook::store_deposit<T0, T1>(arg1, v12, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v11), v7));
            0x1::vector::push_back<u64>(&mut arg0.placed_order_ids, v12);
            v10 = v10 + v7;
            v9 = v9 + 1;
        };
        arg0.deployed_balance = v10;
        let v13 = PoolRebalanced{
            pool_id          : 0x2::object::id<LiquidityPool<T0>>(arg0),
            orders_cancelled : v1,
            orders_placed    : arg0.num_buckets,
            total_deployed   : v10,
        };
        0x2::event::emit<PoolRebalanced>(v13);
    }

    public(friend) fun share<T0>(arg0: LiquidityPool<T0>) {
        0x2::transfer::share_object<LiquidityPool<T0>>(arg0);
    }

    public fun total_shares<T0>(arg0: &LiquidityPool<T0>) : u64 {
        arg0.total_shares
    }

    entry fun withdraw<T0>(arg0: &mut LiquidityPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = ShareKey{lp: v0};
        assert!(0x2::dynamic_field::exists_<ShareKey>(&arg0.id, v1), 601);
        let v2 = ShareKey{lp: v0};
        assert!(*0x2::dynamic_field::borrow<ShareKey, u64>(&arg0.id, v2) >= arg1, 601);
        let v3 = arg1 * get_available_balance<T0>(arg0) / arg0.total_shares;
        let v4 = ShareKey{lp: v0};
        let v5 = 0x2::dynamic_field::borrow_mut<ShareKey, u64>(&mut arg0.id, v4);
        *v5 = *v5 - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        let v6 = BalanceKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v6), v3), arg2), v0);
        let v7 = LiquidityWithdrawn{
            pool_id       : 0x2::object::id<LiquidityPool<T0>>(arg0),
            lp            : v0,
            amount        : v3,
            shares_burned : arg1,
        };
        0x2::event::emit<LiquidityWithdrawn>(v7);
    }

    // decompiled from Move bytecode v6
}

