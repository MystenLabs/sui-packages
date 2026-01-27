module 0xc7e655b91c06be2ca2554579a41e283db4d04ab1d8498e192c80027edffdccd5::orderbook_analyzer {
    struct OrderbookSnapshot has copy, drop {
        bid_prices: vector<u64>,
        bid_quantities: vector<u64>,
        ask_prices: vector<u64>,
        ask_quantities: vector<u64>,
        best_significant_bid: u64,
        best_significant_ask: u64,
        significant_bid_qty: u64,
        significant_ask_qty: u64,
        first_nonzero_bid: u64,
        first_nonzero_ask: u64,
        spread_bps: u64,
        own_bid_qty_filtered: u64,
        own_ask_qty_filtered: u64,
        own_orders_count: u64,
    }

    struct ExistingOrderInfo has copy, drop {
        order_id: u128,
        price: u64,
        expire_timestamp: u64,
        quantity: u64,
        filled_quantity: u64,
    }

    public fun expire_timestamp(arg0: &ExistingOrderInfo) : u64 {
        arg0.expire_timestamp
    }

    public fun filled_quantity(arg0: &ExistingOrderInfo) : u64 {
        arg0.filled_quantity
    }

    public fun order_id(arg0: &ExistingOrderInfo) : u128 {
        arg0.order_id
    }

    public fun quantity(arg0: &ExistingOrderInfo) : u64 {
        arg0.quantity
    }

    public fun analyze_orderbook<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : OrderbookSnapshot {
        assert!(arg3 > 0, 1);
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, arg3, arg4);
        let v4 = v2;
        let v5 = v0;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg0, arg1);
        let v7 = v1;
        let v8 = v3;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        while (v12 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v6)) {
            let v13 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v6, v12);
            v12 = v12 + 1;
            if (0x2::clock::timestamp_ms(arg4) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v13)) {
                continue
            };
            let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v13);
            let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v13);
            if (v14 >= v15) {
                continue
            };
            let (v16, v17, _) = parse_order_id(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v13));
            let v19 = v17;
            let v20 = v15 - v14;
            if (v16) {
                let (v21, v22) = 0x1::vector::index_of<u64>(&v5, &v19);
                if (v21) {
                    let v23 = *0x1::vector::borrow<u64>(&v7, v22);
                    if (v23 >= v20) {
                        *0x1::vector::borrow_mut<u64>(&mut v7, v22) = v23 - v20;
                    } else {
                        *0x1::vector::borrow_mut<u64>(&mut v7, v22) = 0;
                    };
                    v9 = v9 + v20;
                    v11 = v11 + 1;
                    continue
                } else {
                    continue
                };
            };
            let (v24, v25) = 0x1::vector::index_of<u64>(&v4, &v19);
            if (v24) {
                let v26 = *0x1::vector::borrow<u64>(&v8, v25);
                if (v26 >= v20) {
                    *0x1::vector::borrow_mut<u64>(&mut v8, v25) = v26 - v20;
                } else {
                    *0x1::vector::borrow_mut<u64>(&mut v8, v25) = 0;
                };
                v10 = v10 + v20;
                v11 = v11 + 1;
            };
        };
        let v27 = find_first_nonzero_level(&v5, &v7, true);
        let v28 = find_first_nonzero_level(&v4, &v8, false);
        let (v29, v30) = find_significant_level(&v5, &v7, arg2, true);
        let (v31, v32) = find_significant_level(&v4, &v8, arg2, false);
        let v33 = if (v27 > 0) {
            if (v28 > 0) {
                v28 > v27
            } else {
                false
            }
        } else {
            false
        };
        let v34 = if (v33) {
            let v35 = (v27 + v28) / 2;
            if (v35 > 0) {
                (v28 - v27) * 10000 / v35
            } else {
                0
            }
        } else {
            0
        };
        OrderbookSnapshot{
            bid_prices           : v5,
            bid_quantities       : v7,
            ask_prices           : v4,
            ask_quantities       : v8,
            best_significant_bid : v29,
            best_significant_ask : v31,
            significant_bid_qty  : v30,
            significant_ask_qty  : v32,
            first_nonzero_bid    : v27,
            first_nonzero_ask    : v28,
            spread_bps           : v34,
            own_bid_qty_filtered : v9,
            own_ask_qty_filtered : v10,
            own_orders_count     : v11,
        }
    }

    public fun ask_prices(arg0: &OrderbookSnapshot) : &vector<u64> {
        &arg0.ask_prices
    }

    public fun ask_quantities(arg0: &OrderbookSnapshot) : &vector<u64> {
        &arg0.ask_quantities
    }

    public fun best_ask(arg0: &OrderbookSnapshot) : u64 {
        arg0.first_nonzero_ask
    }

    public fun best_bid(arg0: &OrderbookSnapshot) : u64 {
        arg0.first_nonzero_bid
    }

    public fun bid_prices(arg0: &OrderbookSnapshot) : &vector<u64> {
        &arg0.bid_prices
    }

    public fun bid_quantities(arg0: &OrderbookSnapshot) : &vector<u64> {
        &arg0.bid_quantities
    }

    public fun calculate_total_depth(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun find_first_nonzero_level(arg0: &vector<u64>, arg1: &vector<u64>, arg2: bool) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u64>(arg1, v1) > 0) {
                return *0x1::vector::borrow<u64>(arg0, v1)
            };
            v1 = v1 + 1;
        };
        0
    }

    public fun find_optimal_price(arg0: &OrderbookSnapshot, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : u64 {
        let (v0, _) = find_queue_snipe_price(arg0, arg1, arg2, arg3, arg4);
        v0
    }

    public fun find_optimal_price_with_reason(arg0: &OrderbookSnapshot, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : (u64, u8) {
        let (v0, v1) = find_queue_snipe_price(arg0, arg1, arg2, arg3, arg4);
        let v2 = if (v1) {
            1
        } else {
            0
        };
        (v0, v2)
    }

    public fun find_queue_snipe_price(arg0: &OrderbookSnapshot, arg1: u64, arg2: bool, arg3: u64, arg4: u64) : (u64, bool) {
        let v0 = if (arg2) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<u64>(&arg0.bid_prices)) {
                let v2 = *0x1::vector::borrow<u64>(&arg0.bid_prices, v1);
                if (v2 < arg1 && *0x1::vector::borrow<u64>(&arg0.bid_quantities, v1) >= arg4) {
                    return (v2 + arg3, true)
                };
                v1 = v1 + 1;
            };
            false
        } else {
            let v3 = 0;
            while (v3 < 0x1::vector::length<u64>(&arg0.ask_prices)) {
                let v4 = *0x1::vector::borrow<u64>(&arg0.ask_prices, v3);
                if (v4 > arg1 && *0x1::vector::borrow<u64>(&arg0.ask_quantities, v3) >= arg4) {
                    if (v4 > arg3) {
                        return (v4 - arg3, true)
                    };
                };
                v3 = v3 + 1;
            };
            false
        };
        (arg1, v0)
    }

    fun find_significant_level(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: bool) : (u64, u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v1);
            if (v2 >= arg2) {
                return (*0x1::vector::borrow<u64>(arg0, v1), v2)
            };
            v1 = v1 + 1;
        };
        (0, 0)
    }

    public fun get_existing_orders<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock) : (0x1::option::Option<ExistingOrderInfo>, 0x1::option::Option<ExistingOrderInfo>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg0, arg1);
        let v1 = 0x1::option::none<ExistingOrderInfo>();
        let v2 = 0x1::option::none<ExistingOrderInfo>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0)) {
            let v4 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&v0, v3);
            v3 = v3 + 1;
            if (0x2::clock::timestamp_ms(arg2) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v4)) {
                continue
            };
            let (v5, v6, _) = parse_order_id(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v4));
            let v8 = ExistingOrderInfo{
                order_id         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v4),
                price            : v6,
                expire_timestamp : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v4),
                quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v4),
                filled_quantity  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v4),
            };
            if (v5) {
                if (0x1::option::is_none<ExistingOrderInfo>(&v1)) {
                    v1 = 0x1::option::some<ExistingOrderInfo>(v8);
                    continue
                };
                if (v6 > 0x1::option::borrow<ExistingOrderInfo>(&v1).price) {
                    v1 = 0x1::option::some<ExistingOrderInfo>(v8);
                    continue
                } else {
                    continue
                };
            };
            if (0x1::option::is_none<ExistingOrderInfo>(&v2)) {
                v2 = 0x1::option::some<ExistingOrderInfo>(v8);
                continue
            };
            if (v6 < 0x1::option::borrow<ExistingOrderInfo>(&v2).price) {
                v2 = 0x1::option::some<ExistingOrderInfo>(v8);
            };
        };
        (v1, v2)
    }

    public fun has_two_sided_liquidity(arg0: &OrderbookSnapshot) : bool {
        arg0.first_nonzero_bid > 0 && arg0.first_nonzero_ask > 0
    }

    public fun is_partially_filled(arg0: &ExistingOrderInfo) : bool {
        arg0.filled_quantity > 0 && arg0.filled_quantity < arg0.quantity
    }

    public fun mid_price(arg0: &OrderbookSnapshot) : u64 {
        if (arg0.first_nonzero_bid > 0 && arg0.first_nonzero_ask > 0) {
            (arg0.first_nonzero_bid + arg0.first_nonzero_ask) / 2
        } else if (arg0.first_nonzero_bid > 0) {
            arg0.first_nonzero_bid
        } else if (arg0.first_nonzero_ask > 0) {
            arg0.first_nonzero_ask
        } else {
            0
        }
    }

    public fun own_ask_qty_filtered(arg0: &OrderbookSnapshot) : u64 {
        arg0.own_ask_qty_filtered
    }

    public fun own_bid_qty_filtered(arg0: &OrderbookSnapshot) : u64 {
        arg0.own_bid_qty_filtered
    }

    public fun own_orders_count(arg0: &OrderbookSnapshot) : u64 {
        arg0.own_orders_count
    }

    public fun parse_order_id(arg0: u128) : (bool, u64, u64) {
        (arg0 >> 127 == 0, ((arg0 >> 64 & 9223372036854775807) as u64), ((arg0 & 18446744073709551615) as u64))
    }

    public fun price(arg0: &ExistingOrderInfo) : u64 {
        arg0.price
    }

    public fun should_refresh_order(arg0: &ExistingOrderInfo, arg1: u64, arg2: u64) : bool {
        if (arg1 >= arg0.expire_timestamp) {
            return true
        };
        arg0.expire_timestamp - arg1 <= arg2
    }

    public fun significant_ask(arg0: &OrderbookSnapshot) : u64 {
        arg0.best_significant_ask
    }

    public fun significant_ask_qty(arg0: &OrderbookSnapshot) : u64 {
        arg0.significant_ask_qty
    }

    public fun significant_bid(arg0: &OrderbookSnapshot) : u64 {
        arg0.best_significant_bid
    }

    public fun significant_bid_qty(arg0: &OrderbookSnapshot) : u64 {
        arg0.significant_bid_qty
    }

    public fun spread_bps(arg0: &OrderbookSnapshot) : u64 {
        arg0.spread_bps
    }

    public fun total_ask_depth(arg0: &OrderbookSnapshot) : u64 {
        calculate_total_depth(&arg0.ask_quantities)
    }

    public fun total_bid_depth(arg0: &OrderbookSnapshot) : u64 {
        calculate_total_depth(&arg0.bid_quantities)
    }

    // decompiled from Move bytecode v6
}

