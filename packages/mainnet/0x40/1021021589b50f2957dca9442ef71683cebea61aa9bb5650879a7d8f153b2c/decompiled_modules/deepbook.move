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
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let v14 = v7;
        let v15 = if (0x1::vector::is_empty<u64>(&v14)) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v14, 0)
        };
        let v16 = if (0x1::vector::is_empty<u64>(&v12)) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v12, 0)
        };
        let v17 = 0;
        let v18 = &v13;
        let v19 = 0;
        while (v19 < 0x1::vector::length<u64>(v18)) {
            v17 = v17 + (*0x1::vector::borrow<u64>(v18, v19) as u128);
            v19 = v19 + 1;
        };
        let v20 = 0;
        let v21 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128);
        let v22 = 0;
        while (v22 < 0x1::vector::length<u64>(&v12)) {
            v20 = v20 + (*0x1::vector::borrow<u64>(&v11, v22) as u128) * (*0x1::vector::borrow<u64>(&v12, v22) as u128) / v21;
            v22 = v22 + 1;
        };
        let v23 = 18446744073709551615;
        let v24 = if (v16 == 0) {
            0
        } else {
            v23 / v21 * (v16 as u128)
        };
        let v25 = if (v15 == 0) {
            v23
        } else {
            v23 / (v15 as u128) * v21
        };
        let v26 = vector[];
        let v27 = &arg2;
        let v28 = 0;
        while (v28 < 0x1::vector::length<u64>(v27)) {
            let v29 = 0x1::vector::borrow<u64>(v27, v28);
            let v30 = (*v29 as u128);
            let v31 = if (v15 == 0) {
                true
            } else if (v30 > v25) {
                true
            } else {
                v30 > v17
            };
            if (v31) {
                0x1::vector::push_back<u64>(&mut v26, 18446744073709551615);
            } else {
                let (_, v33, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, *v29, arg4);
                0x1::vector::push_back<u64>(&mut v26, v33);
            };
            v28 = v28 + 1;
        };
        let v35 = vector[];
        let v36 = &arg3;
        let v37 = 0;
        while (v37 < 0x1::vector::length<u64>(v36)) {
            let v38 = 0x1::vector::borrow<u64>(v36, v37);
            let v39 = (*v38 as u128);
            let v40 = if (v16 == 0) {
                true
            } else if (v39 > v24) {
                true
            } else {
                v39 > v20
            };
            if (v40) {
                0x1::vector::push_back<u64>(&mut v35, 18446744073709551615);
            } else {
                let (v41, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, *v38, arg4);
                0x1::vector::push_back<u64>(&mut v35, v41);
            };
            v37 = v37 + 1;
        };
        (v1, v0, v2, v14, v13, v12, v11, v15, v16, v3, v26, v35)
    }

    // decompiled from Move bytecode v7
}

