module 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::order_book {
    struct OrderBook has drop {
        bid_prices: vector<u64>,
        bid_quantities: vector<u64>,
        ask_prices: vector<u64>,
        ask_quantities: vector<u64>,
        best_bid: u64,
        best_ask: u64,
        best_bid_on_all_orders_except_ours: u64,
        best_ask_on_all_orders_except_ours: u64,
    }

    public fun ask_prices(arg0: &OrderBook) : &vector<u64> {
        &arg0.ask_prices
    }

    public fun ask_quantities(arg0: &OrderBook) : &vector<u64> {
        &arg0.ask_quantities
    }

    public fun best_ask(arg0: &OrderBook) : u64 {
        arg0.best_ask
    }

    public fun best_ask_on_all_orders_except_ours(arg0: &OrderBook) : u64 {
        arg0.best_ask_on_all_orders_except_ours
    }

    public fun best_bid(arg0: &OrderBook) : u64 {
        arg0.best_bid
    }

    public fun best_bid_on_all_orders_except_ours(arg0: &OrderBook) : u64 {
        arg0.best_bid_on_all_orders_except_ours
    }

    public fun bid_prices(arg0: &OrderBook) : &vector<u64> {
        &arg0.bid_prices
    }

    public fun bid_quantities(arg0: &OrderBook) : &vector<u64> {
        &arg0.bid_quantities
    }

    public(friend) fun get_dimed_price(arg0: &OrderBook, arg1: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::Parameters, arg2: u64, arg3: bool, arg4: u64) : u64 {
        if (arg3) {
            let v0 = 0;
            while (v0 < 0x1::vector::length<u64>(&arg0.bid_prices)) {
                let v1 = *0x1::vector::borrow<u64>(&arg0.bid_prices, v0);
                if (v1 >= arg2) {
                    v0 = v0 + 1;
                    continue
                };
                if (*0x1::vector::borrow<u64>(&arg0.bid_quantities, v0) < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::minimum_considered_volume(arg1)) {
                    v0 = v0 + 1;
                    continue
                };
                return v1 + arg4
            };
        } else {
            let v2 = 0;
            while (v2 < 0x1::vector::length<u64>(&arg0.ask_prices)) {
                let v3 = *0x1::vector::borrow<u64>(&arg0.ask_prices, v2);
                if (v3 <= arg2) {
                    v2 = v2 + 1;
                    continue
                };
                if (*0x1::vector::borrow<u64>(&arg0.ask_quantities, v2) < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::minimum_considered_volume(arg1)) {
                    v2 = v2 + 1;
                    continue
                };
                return v3 - arg4
            };
        };
        arg2
    }

    public(friend) fun get_order_book_without_our_orders(arg0: &0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::Parameters, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>, arg3: u64, arg4: &0x2::clock::Clock) : OrderBook {
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg2)) {
            let v9 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(arg2, v8);
            v8 = v8 + 1;
            if (0x2::clock::timestamp_ms(arg4) > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v9)) {
                continue
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v9) == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v9)) {
                continue
            };
            let (v10, v11, _) = 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::common::decode_order_id(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v9));
            let v13 = v11;
            if (v10) {
                let (v14, v15) = 0x1::vector::index_of<u64>(&v7, &v13);
                if (!v14) {
                    continue
                };
                let v16 = 0x1::vector::borrow_mut<u64>(&mut v6, v15);
                let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v9) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v9);
                assert!(*v16 >= v17, 13906834887307952127);
                *v16 = *v16 - v17;
                continue
            };
            let (v18, v19) = 0x1::vector::index_of<u64>(&v5, &v13);
            if (!v18) {
                continue
            };
            let v20 = 0x1::vector::borrow_mut<u64>(&mut v4, v19);
            let v21 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v9) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v9);
            assert!(*v20 >= v21, 13906834943142526975);
            *v20 = *v20 - v21;
        };
        let v22 = 0;
        while (v22 < 0x1::vector::length<u64>(&v7)) {
            if (*0x1::vector::borrow<u64>(&v6, v22) < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::minimum_considered_volume(arg0)) {
                v22 = v22 + 1;
            } else {
                break
            };
        };
        let v23 = 0;
        while (v23 < 0x1::vector::length<u64>(&v5)) {
            if (*0x1::vector::borrow<u64>(&v4, v23) < 0xe1248ae8e9e0800e4507cbf5c1832dc4040e84897e93e9e72183457abf5ba16a::parameters::minimum_considered_volume(arg0)) {
                v23 = v23 + 1;
            } else {
                break
            };
        };
        let v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v7)) {
            if (*0x1::vector::borrow<u64>(&v6, v24) == 0) {
                v24 = v24 + 1;
            } else {
                break
            };
        };
        let v25 = 0;
        while (v25 < 0x1::vector::length<u64>(&v5)) {
            if (*0x1::vector::borrow<u64>(&v4, v25) == 0) {
                v25 = v25 + 1;
            } else {
                break
            };
        };
        OrderBook{
            bid_prices                         : v7,
            bid_quantities                     : v6,
            ask_prices                         : v5,
            ask_quantities                     : v4,
            best_bid                           : *0x1::vector::borrow<u64>(&v7, v22),
            best_ask                           : *0x1::vector::borrow<u64>(&v5, v23),
            best_bid_on_all_orders_except_ours : *0x1::vector::borrow<u64>(&v7, v24),
            best_ask_on_all_orders_except_ours : *0x1::vector::borrow<u64>(&v5, v25),
        }
    }

    // decompiled from Move bytecode v6
}

