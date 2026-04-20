module 0x935c31aaf3bfa604f8c28f8bf87552e09371be06bd45ad4d3df492df28d8494c::deepbook {
    struct SnapshotInner has drop {
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

    public fun fetch_orderbook_snapshot<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock) : (u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64, u64, u64) {
        let SnapshotInner {
            lot_size   : v0,
            tick_size  : v1,
            min_size   : v2,
            bid_prices : v3,
            bid_qtys   : v4,
            ask_prices : v5,
            ask_qtys   : v6,
            best_bid   : v7,
            best_ask   : v8,
            taker_fee  : v9,
        } = snapshot_inner<T0, T1>(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun fetch_snapshot_and_quotes<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock) : (u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64, u64, u64, vector<u64>, vector<u64>) {
        let SnapshotInner {
            lot_size   : v0,
            tick_size  : v1,
            min_size   : v2,
            bid_prices : v3,
            bid_qtys   : v4,
            ask_prices : v5,
            ask_qtys   : v6,
            best_bid   : v7,
            best_ask   : v8,
            taker_fee  : v9,
        } = snapshot_inner<T0, T1>(arg0, arg1, arg4);
        let v10 = 18446744073709551615;
        let v11 = 340282366920938463463374607431768211455;
        let v12 = ((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128) as u256);
        let v13 = if (v7 == 0) {
            18446744073709551615
        } else {
            let v14 = v10 * v12 / (v7 as u256);
            if (v14 > v11) {
                340282366920938463463374607431768211455
            } else {
                (v14 as u128)
            }
        };
        let v15 = if (v8 == 0) {
            0
        } else {
            let v16 = v10 * (v8 as u256) / v12;
            if (v16 > v11) {
                340282366920938463463374607431768211455
            } else {
                (v16 as u128)
            }
        };
        let v17 = vector[];
        let v18 = &arg2;
        let v19 = 0;
        while (v19 < 0x1::vector::length<u64>(v18)) {
            let v20 = 0x1::vector::borrow<u64>(v18, v19);
            if (v7 == 0 || (*v20 as u128) > v13) {
                0x1::vector::push_back<u64>(&mut v17, 18446744073709551615);
            } else {
                let (_, v22, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, *v20, arg4);
                0x1::vector::push_back<u64>(&mut v17, v22);
            };
            v19 = v19 + 1;
        };
        let v24 = vector[];
        let v25 = &arg3;
        let v26 = 0;
        while (v26 < 0x1::vector::length<u64>(v25)) {
            let v27 = 0x1::vector::borrow<u64>(v25, v26);
            if (v8 == 0 || (*v27 as u128) > v15) {
                0x1::vector::push_back<u64>(&mut v24, 18446744073709551615);
            } else {
                let (v28, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, *v27, arg4);
                0x1::vector::push_back<u64>(&mut v24, v28);
            };
            v26 = v26 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v17, v24)
    }

    fun snapshot_inner<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock) : SnapshotInner {
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
        SnapshotInner{
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

    // decompiled from Move bytecode v7
}

