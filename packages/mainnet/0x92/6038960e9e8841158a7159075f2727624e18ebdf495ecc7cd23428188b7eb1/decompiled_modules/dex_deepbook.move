module 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::dex_deepbook {
    struct DeepBookOrderExecuted has copy, drop {
        order_book: address,
        order_type: u8,
        is_bid: bool,
        quantity: u64,
        price: u64,
        filled_quantity: u64,
        commission: u64,
        timestamp: u64,
    }

    struct DeepBookOrderCancelled has copy, drop {
        order_book: address,
        order_id: u128,
        timestamp: u64,
    }

    fun calculate_ioc_fill(arg0: u64, arg1: u64, arg2: address) : (u64, u64) {
        let v0 = get_available_liquidity(arg2, arg1);
        if (arg0 <= v0) {
            (arg0, 0)
        } else {
            (v0, arg0 - v0)
        }
    }

    fun calculate_market_impact(arg0: u64, arg1: address) : u64 {
        if (arg0 > 10000000000) {
            50
        } else if (arg0 > 1000000000) {
            20
        } else if (arg0 > 100000000) {
            8
        } else {
            3
        }
    }

    public fun cancel_order(arg0: address, arg1: u128, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepBookOrderCancelled{
            order_book : arg0,
            order_id   : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DeepBookOrderCancelled>(v0);
    }

    fun get_available_liquidity(arg0: address, arg1: u64) : u64 {
        if (arg1 > 1000000) {
            10000000000
        } else if (arg1 > 500000) {
            5000000000
        } else {
            1000000000
        }
    }

    public fun get_order_book_stats(arg0: address) : (u64, u64, u64) {
        let v0 = 999000;
        let v1 = 1001000;
        (v0, v1, v1 - v0)
    }

    public fun is_valid_order_book(arg0: address) : bool {
        arg0 != @0x0
    }

    public fun place_ioc_order<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 802);
        let v1 = v0 * 10 / 10000;
        let (v2, v3) = calculate_ioc_fill(v0 - v1, arg3, arg0);
        let v4 = DeepBookOrderExecuted{
            order_book      : arg0,
            order_type      : 2,
            is_bid          : arg2,
            quantity        : v0,
            price           : arg3,
            filled_quantity : v2,
            commission      : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepBookOrderExecuted>(v4);
        0x2::coin::destroy_zero<T0>(arg1);
        (0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5), v3)
    }

    public fun place_limit_order<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 802);
        let v1 = DeepBookOrderExecuted{
            order_book      : arg0,
            order_type      : 1,
            is_bid          : arg2,
            quantity        : v0,
            price           : arg3,
            filled_quantity : 0,
            commission      : v0 * 5 / 10000,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DeepBookOrderExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg1);
        (0x2::clock::timestamp_ms(arg5) as u128) << 64 | (v0 as u128)
    }

    public fun place_market_order<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 802);
        let v1 = v0 * 10 / 10000;
        let v2 = v0 - v1;
        let v3 = v2 - v2 * calculate_market_impact(v0, arg0) / 10000;
        assert!(v3 >= arg3, 803);
        let v4 = DeepBookOrderExecuted{
            order_book      : arg0,
            order_type      : 0,
            is_bid          : arg2,
            quantity        : v0,
            price           : 0,
            filled_quantity : v3,
            commission      : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepBookOrderExecuted>(v4);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5)
    }

    // decompiled from Move bytecode v6
}

