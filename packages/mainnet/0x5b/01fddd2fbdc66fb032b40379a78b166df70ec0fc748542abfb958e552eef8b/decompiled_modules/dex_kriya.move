module 0x5b01fddd2fbdc66fb032b40379a78b166df70ec0fc748542abfb958e552eef8b::dex_kriya {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        lp_supply: u64,
        fee_rate: u64,
        admin_fee_rate: u64,
        k_last: u128,
        is_stable: bool,
        is_paused: bool,
        min_liquidity: u64,
    }

    struct LimitOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        price: u128,
        is_buy: bool,
        is_filled: bool,
        created_at: u64,
        expires_at: u64,
    }

    struct OrderBook<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        buy_orders: 0x2::table::Table<u128, vector<LimitOrder<T0, T1>>>,
        sell_orders: 0x2::table::Table<u128, vector<LimitOrder<T0, T1>>>,
        best_bid: u128,
        best_ask: u128,
        last_price: u128,
        volume_24h: u64,
    }

    struct LPToken<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: address,
        liquidity: u64,
        owner: address,
        created_at: u64,
    }

    struct SwapResult has drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        price_impact: u128,
        new_reserve_a: u64,
        new_reserve_b: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: address,
        trader: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        a_to_b: bool,
        fee_amount: u64,
        timestamp: u64,
    }

    fun calculate_constant_product_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0 * (10000 - arg3);
        v0 * arg2 / (arg1 * 10000 + v0)
    }

    fun calculate_d(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg1;
        if (v0 == 0) {
            return 0
        };
        let v1 = v0;
        let v2 = arg2 * 4;
        let v3 = 0;
        while (v3 < 10) {
            let v4 = v1;
            let v5 = (v2 * v0 + 2 * v1) * v1 / ((v2 - 1) * v1 + 3 * v1);
            v1 = v5;
            if (v5 > v4) {
                if (v5 - v4 <= 1) {
                    break
                };
            } else if (v4 - v5 <= 1) {
                break
            };
            v3 = v3 + 1;
        };
        v1
    }

    public fun calculate_price_impact<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u128 {
        let v0 = get_current_price<T0, T1>(arg0);
        let v1 = if (arg2) {
            calculate_constant_product_out(arg1, 0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b), arg0.fee_rate)
        } else {
            calculate_constant_product_out(arg1, 0x2::balance::value<T1>(&arg0.coin_b), 0x2::balance::value<T0>(&arg0.coin_a), arg0.fee_rate)
        };
        let v2 = if (arg2) {
            ((v1 as u128) << 64) / (arg1 as u128)
        } else {
            ((arg1 as u128) << 64) / (v1 as u128)
        };
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            v0 - v2
        };
        (v3 << 64) / v0
    }

    public fun calculate_slippage_tolerance(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    fun calculate_stable_swap_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 1000;
        arg2 - solve_y(arg1 + arg0 * (10000 - arg3) / 10000, calculate_d(arg1, arg2, v0), v0)
    }

    public fun get_current_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        let v0 = 0x2::balance::value<T0>(&arg0.coin_a);
        if (v0 == 0) {
            return 0
        };
        ((0x2::balance::value<T1>(&arg0.coin_b) as u128) << 64) / (v0 as u128)
    }

    public fun get_minimum_liquidity() : u64 {
        1000
    }

    public fun get_order_book_depth<T0, T1>(arg0: &OrderBook<T0, T1>) : (u128, u128, u128, u64) {
        (arg0.best_bid, arg0.best_ask, arg0.last_price, arg0.volume_24h)
    }

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64, bool) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b), arg0.lp_supply, arg0.fee_rate, arg0.is_stable)
    }

    public fun get_protocol_fee_rates() : (u64, u64) {
        (30, 5)
    }

    public fun place_limit_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : LimitOrder<T0, T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = LimitOrder<T0, T1>{
            id            : 0x2::object::new(arg6),
            owner         : 0x2::tx_context::sender(arg6),
            coin_a_amount : v0,
            coin_b_amount : (((v0 as u128) * arg2 >> 64) as u64),
            price         : arg2,
            is_buy        : arg3,
            is_filled     : false,
            created_at    : 0x2::clock::timestamp_ms(arg5),
            expires_at    : arg4,
        };
        let v2 = LimitOrder<T0, T1>{
            id            : 0x2::object::new(arg6),
            owner         : 0x2::tx_context::sender(arg6),
            coin_a_amount : v0,
            coin_b_amount : (((v0 as u128) * arg2 >> 64) as u64),
            price         : arg2,
            is_buy        : arg3,
            is_filled     : false,
            created_at    : 0x2::clock::timestamp_ms(arg5),
            expires_at    : arg4,
        };
        if (arg3) {
            if (!0x2::table::contains<u128, vector<LimitOrder<T0, T1>>>(&arg0.buy_orders, arg2)) {
                0x2::table::add<u128, vector<LimitOrder<T0, T1>>>(&mut arg0.buy_orders, arg2, 0x1::vector::empty<LimitOrder<T0, T1>>());
            };
            0x1::vector::push_back<LimitOrder<T0, T1>>(0x2::table::borrow_mut<u128, vector<LimitOrder<T0, T1>>>(&mut arg0.buy_orders, arg2), v1);
            if (arg2 > arg0.best_bid) {
                arg0.best_bid = arg2;
            };
        } else {
            if (!0x2::table::contains<u128, vector<LimitOrder<T0, T1>>>(&arg0.sell_orders, arg2)) {
                0x2::table::add<u128, vector<LimitOrder<T0, T1>>>(&mut arg0.sell_orders, arg2, 0x1::vector::empty<LimitOrder<T0, T1>>());
            };
            0x1::vector::push_back<LimitOrder<T0, T1>>(0x2::table::borrow_mut<u128, vector<LimitOrder<T0, T1>>>(&mut arg0.sell_orders, arg2), v1);
            if (arg2 < arg0.best_ask) {
                arg0.best_ask = arg2;
            };
        };
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(arg1));
        v2
    }

    fun solve_y(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 10) {
            let v2 = v0;
            let v3 = (v0 * v0 + arg1 * arg1 * arg1 / 4 * arg0) / (2 * v0 + arg0 + arg1 / arg2 * 4 - arg1);
            v0 = v3;
            if (v3 > v2) {
                if (v3 - v2 <= 1) {
                    break
                };
            } else if (v2 - v3 <= 1) {
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = if (arg0.is_stable) {
            calculate_stable_swap_out(v0, 0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b), arg0.fee_rate)
        } else {
            calculate_constant_product_out(v0, 0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b), arg0.fee_rate)
        };
        assert!(v1 >= arg2, 2);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.k_last = (0x2::balance::value<T0>(&arg0.coin_a) as u128) * (0x2::balance::value<T1>(&arg0.coin_b) as u128);
        let v2 = SwapEvent{
            pool_id       : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader        : 0x2::tx_context::sender(arg4),
            coin_a_amount : v0,
            coin_b_amount : v1,
            a_to_b        : true,
            fee_amount    : v0 * arg0.fee_rate / 10000,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SwapEvent>(v2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v1), arg4)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 1);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = if (arg0.is_stable) {
            calculate_stable_swap_out(v0, 0x2::balance::value<T1>(&arg0.coin_b), 0x2::balance::value<T0>(&arg0.coin_a), arg0.fee_rate)
        } else {
            calculate_constant_product_out(v0, 0x2::balance::value<T1>(&arg0.coin_b), 0x2::balance::value<T0>(&arg0.coin_a), arg0.fee_rate)
        };
        assert!(v1 >= arg2, 2);
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.k_last = (0x2::balance::value<T0>(&arg0.coin_a) as u128) * (0x2::balance::value<T1>(&arg0.coin_b) as u128);
        let v2 = SwapEvent{
            pool_id       : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader        : 0x2::tx_context::sender(arg4),
            coin_a_amount : v1,
            coin_b_amount : v0,
            a_to_b        : false,
            fee_amount    : v0 * arg0.fee_rate / 10000,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SwapEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v1), arg4)
    }

    // decompiled from Move bytecode v6
}

