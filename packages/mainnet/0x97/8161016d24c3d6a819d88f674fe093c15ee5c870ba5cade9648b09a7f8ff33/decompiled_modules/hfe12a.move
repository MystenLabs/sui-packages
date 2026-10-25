module 0x978161016d24c3d6a819d88f674fe093c15ee5c870ba5cade9648b09a7f8ff33::hfe12a {
    struct Ha4659 has copy, drop, store {
        hefd3b: 0x1::string::String,
        h43b2e: u64,
        h6da71: u64,
    }

    struct H74d1b has copy, drop, store {
        h6f039: bool,
        had3bb: u64,
        hc6bea: u64,
    }

    struct Ha24a5 has copy, drop, store {
        h8b91e: u64,
        had3bb: u64,
        h6f039: bool,
        he4718: u64,
        hc9f99: u64,
    }

    struct Hb42c4 has copy, drop, store {
        h11fc2: vector<u64>,
        hc11fa: vector<u64>,
        h7b1a0: vector<u64>,
        h0d934: vector<u64>,
        h356a6: vector<u64>,
        ha6896: vector<u64>,
        h23853: vector<u64>,
        h54cb9: vector<u64>,
        hafaf6: vector<u64>,
        h0c1e8: vector<u64>,
        h7a882: vector<u64>,
        h88c20: vector<u64>,
    }

    public fun h1ea8f<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock) : Hb42c4 {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), true, arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), false, arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg0, arg1);
        let v9 = 0x2::vec_set::keys<u128>(&v8);
        let v10 = 0x1::vector::empty<Ha24a5>();
        let v11 = 0x1::vector::empty<Ha24a5>();
        let v12 = 0;
        while (v12 < 0x1::vector::length<u128>(v9)) {
            let v13 = *0x1::vector::borrow<u128>(v9, v12);
            let H74d1b {
                h6f039 : v14,
                had3bb : v15,
                hc6bea : _,
            } = h6c149(v13);
            let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg0, v13);
            let v18 = Ha24a5{
                h8b91e : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v17),
                had3bb : v15,
                h6f039 : v14,
                he4718 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v17),
                hc9f99 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(&v17),
            };
            v12 = v12 + 1;
            if (v18.hc9f99 < 0x2::clock::timestamp_ms(arg2)) {
                continue
            };
            if (v14) {
                0x1::vector::push_back<Ha24a5>(&mut v10, v18);
                continue
            };
            0x1::vector::push_back<Ha24a5>(&mut v11, v18);
        };
        let v19 = vector[];
        let v20 = vector[];
        let v21 = vector[];
        let v22 = vector[];
        let v23 = 0;
        while (v23 < 0x1::vector::length<u64>(&v3)) {
            let v24 = *0x1::vector::borrow<u64>(&v3, v23);
            let v25 = 0;
            let v26 = 0;
            while (v26 < 0x1::vector::length<Ha24a5>(&v10)) {
                let v27 = *0x1::vector::borrow<Ha24a5>(&v10, v26);
                if (v27.had3bb == v24) {
                    v25 = v25 + v27.h8b91e - v27.he4718;
                };
                v26 = v26 + 1;
            };
            if (v25 > 0) {
                0x1::vector::push_back<u64>(&mut v21, v24);
                0x1::vector::push_back<u64>(&mut v22, v25);
            };
            let v28 = *0x1::vector::borrow<u64>(&v2, v23) - v25;
            if (v28 > 0) {
                0x1::vector::push_back<u64>(&mut v19, v24);
                0x1::vector::push_back<u64>(&mut v20, v28);
            };
            v23 = v23 + 1;
        };
        let v29 = vector[];
        let v30 = vector[];
        let v31 = vector[];
        let v32 = vector[];
        v23 = 0;
        while (v23 < 0x1::vector::length<u64>(&v7)) {
            let v33 = *0x1::vector::borrow<u64>(&v7, v23);
            let v34 = 0;
            let v35 = 0;
            while (v35 < 0x1::vector::length<Ha24a5>(&v11)) {
                let v36 = *0x1::vector::borrow<Ha24a5>(&v11, v35);
                if (v36.had3bb == v33) {
                    v34 = v34 + v36.h8b91e - v36.he4718;
                };
                v35 = v35 + 1;
            };
            if (v34 > 0) {
                0x1::vector::push_back<u64>(&mut v31, v33);
                0x1::vector::push_back<u64>(&mut v32, v34);
            };
            let v37 = *0x1::vector::borrow<u64>(&v6, v23) - v34;
            if (v37 > 0) {
                0x1::vector::push_back<u64>(&mut v29, v33);
                0x1::vector::push_back<u64>(&mut v30, v37);
            };
            v23 = v23 + 1;
        };
        Hb42c4{
            h11fc2 : v3,
            hc11fa : v2,
            h7b1a0 : v7,
            h0d934 : v6,
            h356a6 : v21,
            ha6896 : v22,
            h23853 : v31,
            h54cb9 : v32,
            hafaf6 : v19,
            h0c1e8 : v20,
            h7a882 : v29,
            h88c20 : v30,
        }
    }

    fun h6c149(arg0: u128) : H74d1b {
        H74d1b{
            h6f039 : arg0 >> 127 == 0,
            had3bb : ((arg0 >> 64) as u64) & 9223372036854775807,
            hc6bea : ((arg0 & 18446744073709551615) as u64),
        }
    }

    public fun h879e4<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: vector<u8>, arg3: vector<u8>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg0, arg1);
        let v3 = Ha4659{
            hefd3b : 0x1::string::utf8(arg2),
            h43b2e : v0,
            h6da71 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1),
        };
        0x2::event::emit<Ha4659>(v3);
        let v4 = Ha4659{
            hefd3b : 0x1::string::utf8(arg3),
            h43b2e : v1,
            h6da71 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1),
        };
        0x2::event::emit<Ha4659>(v4);
        let v5 = Ha4659{
            hefd3b : 0x1::string::utf8(b"DEEP"),
            h43b2e : v2,
            h6da71 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1),
        };
        0x2::event::emit<Ha4659>(v5);
    }

    // decompiled from Move bytecode v7
}

