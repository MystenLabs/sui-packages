module 0x935c31aaf3bfa604f8c28f8bf87552e09371be06bd45ad4d3df492df28d8494c::deepbook {
    public fun fetch_orderbook_snapshot<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock) : (u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64, u64, u64) {
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
        (v1, v0, v2, v12, v8, v11, v10, v13, v14, v3)
    }

    public fun fetch_snapshot_and_quotes<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::clock::Clock) : (u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64, u64, u64, vector<u64>, vector<u64>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v6 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::destroy_some<u64>(arg1)
        } else {
            0x1::option::destroy_none<u64>(arg1);
            20
        };
        let (v7, v8, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg0, v6, arg4);
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
        let v15 = vector[];
        let v16 = &arg2;
        let v17 = 0;
        while (v17 < 0x1::vector::length<u64>(v16)) {
            let (_, v19, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, *0x1::vector::borrow<u64>(v16, v17), arg4);
            0x1::vector::push_back<u64>(&mut v15, v19);
            v17 = v17 + 1;
        };
        let v21 = vector[];
        let v22 = &arg3;
        let v23 = 0;
        while (v23 < 0x1::vector::length<u64>(v22)) {
            let (v24, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, *0x1::vector::borrow<u64>(v22, v23), arg4);
            0x1::vector::push_back<u64>(&mut v21, v24);
            v23 = v23 + 1;
        };
        (v1, v0, v2, v12, v8, v11, v10, v13, v14, v3, v15, v21)
    }

    // decompiled from Move bytecode v7
}

