module 0x931051321bfad33a5e325a35ee2eaa70885982f599d9662e79ddb62ea6f21f95::deepbook {
    struct DeepbookSnapshot has drop {
        lot_size: u64,
        tick_size: u64,
        min_size: u64,
        bid_prices: vector<u64>,
        bid_qtys: vector<u64>,
        ask_prices: vector<u64>,
        ask_qtys: vector<u64>,
        best_bid: u64,
        best_ask: u64,
        taker_fee: u64,
    }

    public fun fetch_orderbook_snapshot<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock) : DeepbookSnapshot {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v6 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::destroy_some<u64>(arg1)
        } else {
            0x1::option::destroy_none<u64>(arg1);
            20
        };
        let (v7, v8, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, v6, arg2);
        let v11 = v9;
        let v12 = v7;
        let v13 = if (0x1::vector::is_empty<u64>(&v12)) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v12, 0)
        };
        let v14 = if (0x1::vector::is_empty<u64>(&v11)) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v11, 0)
        };
        DeepbookSnapshot{
            lot_size   : v1,
            tick_size  : v0,
            min_size   : v2,
            bid_prices : v12,
            bid_qtys   : v8,
            ask_prices : v11,
            ask_qtys   : v10,
            best_bid   : v13,
            best_ask   : v14,
            taker_fee  : v3,
        }
    }

    public fun fetch_orderbook_snapshot_and_quotes<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock) : (DeepbookSnapshot, vector<u64>, vector<u64>) {
        let v0 = fetch_orderbook_snapshot<T0, T1>(arg0, arg1, arg4);
        let v1 = v0.best_bid;
        let v2 = v0.best_ask;
        let v3 = 18446744073709551615;
        let v4 = 340282366920938463463374607431768211455;
        let v5 = ((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128) as u256);
        let v6 = if (v1 == 0) {
            18446744073709551615
        } else {
            let v7 = v3 * v5 / (v1 as u256);
            if (v7 > v4) {
                340282366920938463463374607431768211455
            } else {
                (v7 as u128)
            }
        };
        let v8 = if (v2 == 0) {
            0
        } else {
            let v9 = v3 * (v2 as u256) / v5;
            if (v9 > v4) {
                340282366920938463463374607431768211455
            } else {
                (v9 as u128)
            }
        };
        let v10 = vector[];
        let v11 = &arg2;
        let v12 = 0;
        while (v12 < 0x1::vector::length<u64>(v11)) {
            let v13 = 0x1::vector::borrow<u64>(v11, v12);
            if (v1 == 0 || (*v13 as u128) > v6) {
                0x1::vector::push_back<u64>(&mut v10, 18446744073709551615);
            } else {
                let (_, v15, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, *v13, arg4);
                0x1::vector::push_back<u64>(&mut v10, v15);
            };
            v12 = v12 + 1;
        };
        let v17 = vector[];
        let v18 = &arg3;
        let v19 = 0;
        while (v19 < 0x1::vector::length<u64>(v18)) {
            let v20 = 0x1::vector::borrow<u64>(v18, v19);
            if (v2 == 0 || (*v20 as u128) > v8) {
                0x1::vector::push_back<u64>(&mut v17, 18446744073709551615);
            } else {
                let (v21, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, *v20, arg4);
                0x1::vector::push_back<u64>(&mut v17, v21);
            };
            v19 = v19 + 1;
        };
        (v0, v10, v17)
    }

    // decompiled from Move bytecode v7
}

