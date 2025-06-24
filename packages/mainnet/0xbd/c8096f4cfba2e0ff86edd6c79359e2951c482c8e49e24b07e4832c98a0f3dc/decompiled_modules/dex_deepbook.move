module 0xbdc8096f4cfba2e0ff86edd6c79359e2951c482c8e49e24b07e4832c98a0f3dc::dex_deepbook {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        best_bid_price: u64,
        best_ask_price: u64,
        base_custodian: Custodian<T0>,
        quote_custodian: Custodian<T1>,
        tick_size: u64,
        lot_size: u64,
        maker_fee_rate: u64,
        taker_fee_rate: u64,
    }

    struct Custodian<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    public fun calculate_market_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            arg0.best_ask_price
        } else {
            arg0.best_bid_price
        }
    }

    public fun get_best_prices<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.best_bid_price, arg0.best_ask_price)
    }

    public fun get_liquidity<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.base_custodian.balance), 0x2::balance::value<T1>(&arg0.quote_custodian.balance))
    }

    public fun get_pool_params<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.tick_size, arg0.lot_size, arg0.maker_fee_rate, arg0.taker_fee_rate)
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 3);
        assert!(arg2 >= arg0.lot_size, 1);
        let v0 = arg0.best_ask_price;
        assert!(v0 > 0, 4);
        let v1 = arg2 - arg2 * arg0.taker_fee_rate / 1000000;
        let v2 = v1 * v0 / 1000000000;
        assert!(v2 >= arg3, 2);
        assert!(v2 <= 0x2::balance::value<T1>(&arg0.quote_custodian.balance), 1);
        0x2::balance::join<T0>(&mut arg0.base_custodian.balance, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::balance::split<T1>(&mut arg0.quote_custodian.balance, v2);
        update_prices_after_trade<T0, T1>(arg0, true, v1, v2);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        let v0 = arg0.best_bid_price;
        assert!(v0 > 0, 4);
        let v1 = arg2 - arg2 * arg0.taker_fee_rate / 1000000;
        let v2 = v1 * 1000000000 / v0 / arg0.lot_size * arg0.lot_size;
        assert!(v2 >= arg3, 2);
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.base_custodian.balance), 1);
        0x2::balance::join<T1>(&mut arg0.quote_custodian.balance, 0x2::coin::into_balance<T1>(arg1));
        let v3 = 0x2::balance::split<T0>(&mut arg0.base_custodian.balance, v2);
        update_prices_after_trade<T0, T1>(arg0, false, v1, v2);
        0x2::coin::from_balance<T0>(v3, arg5)
    }

    fun update_prices_after_trade<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64) {
        if (arg1) {
            arg0.best_ask_price = arg0.best_ask_price + arg0.tick_size;
            if (arg0.best_bid_price + arg0.tick_size < arg0.best_ask_price) {
                arg0.best_bid_price = arg0.best_bid_price + arg0.tick_size / 2;
            };
        } else {
            if (arg0.best_bid_price > arg0.tick_size) {
                arg0.best_bid_price = arg0.best_bid_price - arg0.tick_size;
            };
            if (arg0.best_ask_price > arg0.best_bid_price + arg0.tick_size) {
                arg0.best_ask_price = arg0.best_ask_price - arg0.tick_size / 2;
            };
        };
    }

    // decompiled from Move bytecode v6
}

