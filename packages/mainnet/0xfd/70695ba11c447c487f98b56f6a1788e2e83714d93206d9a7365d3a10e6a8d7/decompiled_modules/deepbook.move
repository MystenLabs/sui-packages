module 0xfd70695ba11c447c487f98b56f6a1788e2e83714d93206d9a7365d3a10e6a8d7::deepbook {
    struct DeepBookSnapshot has drop {
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

    struct DeepBookQuote has drop {
        is_base_to_quote: bool,
        input_amount: u64,
        output_amount: u64,
        input_remain: u64,
        deep_fee: u64,
    }

    public fun fetch_orderbook_quotes<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: vector<u64>, arg3: &0x2::clock::Clock) : vector<DeepBookQuote> {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v4 = v2;
        let v5 = v0;
        let v6 = if (0x1::vector::is_empty<u64>(&v5)) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v5, 0)
        };
        let v7 = if (0x1::vector::is_empty<u64>(&v4)) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v4, 0)
        };
        let v8 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128);
        let v9 = (v6 as u128);
        let v10 = (v7 as u128);
        let v11 = 18446744073709551615;
        let v12 = if (v9 == 0) {
            0
        } else {
            v11 * v8 / v9
        };
        let v13 = if (v10 == 0) {
            0
        } else {
            v11 * v10 / v8
        };
        let v14 = if (arg1) {
            v12
        } else {
            v13
        };
        let v15 = 0x1::vector::empty<DeepBookQuote>();
        let v16 = &arg2;
        let v17 = 0;
        while (v17 < 0x1::vector::length<u64>(v16)) {
            let v18 = 0x1::vector::borrow<u64>(v16, v17);
            let v19 = if ((*v18 as u128) > v14) {
                sentinel_quote(arg1, *v18)
            } else if (arg1) {
                let (v20, v21, v22) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, *v18, arg3);
                DeepBookQuote{is_base_to_quote: true, input_amount: *v18 - v20, output_amount: v21, input_remain: v20, deep_fee: v22}
            } else {
                let (v23, v24, v25) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, *v18, arg3);
                DeepBookQuote{is_base_to_quote: false, input_amount: *v18 - v24, output_amount: v23, input_remain: v24, deep_fee: v25}
            };
            0x1::vector::push_back<DeepBookQuote>(&mut v15, v19);
            v17 = v17 + 1;
        };
        v15
    }

    public fun fetch_orderbook_snapshot<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock) : DeepBookSnapshot {
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
        DeepBookSnapshot{
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

    public fun fetch_orderbook_snapshot_and_quotes<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock) : (DeepBookSnapshot, vector<DeepBookQuote>, vector<DeepBookQuote>) {
        (fetch_orderbook_snapshot<T0, T1>(arg0, arg1, arg4), fetch_orderbook_quotes<T0, T1>(arg0, true, arg2, arg4), fetch_orderbook_quotes<T0, T1>(arg0, false, arg3, arg4))
    }

    fun sentinel_quote(arg0: bool, arg1: u64) : DeepBookQuote {
        DeepBookQuote{
            is_base_to_quote : arg0,
            input_amount     : 0,
            output_amount    : 18446744073709551615,
            input_remain     : arg1,
            deep_fee         : 0,
        }
    }

    // decompiled from Move bytecode v7
}

