module 0xe74879da0860962c05aa385888f8b6ab3b46bed308a2208097d09b4a0294d26c::hfe12a {
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
        h6da71: u64,
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
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::open_orders(&v8);
        let v10 = 0x2::vec_set::keys<u128>(&v9);
        let v11 = 0x1::vector::empty<Ha24a5>();
        let v12 = 0x1::vector::empty<Ha24a5>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<u128>(v10)) {
            let v14 = *0x1::vector::borrow<u128>(v10, v13);
            let H74d1b {
                h6f039 : v15,
                had3bb : v16,
                hc6bea : _,
            } = h6c149(v14);
            let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg0, v14);
            let v19 = Ha24a5{
                h8b91e : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v18),
                had3bb : v16,
                h6f039 : v15,
                h6da71 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v18),
                hc9f99 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(&v18),
            };
            v13 = v13 + 1;
            if (v19.hc9f99 < 0x2::clock::timestamp_ms(arg2)) {
                continue
            };
            if (v15) {
                0x1::vector::push_back<Ha24a5>(&mut v11, v19);
                continue
            };
            0x1::vector::push_back<Ha24a5>(&mut v12, v19);
        };
        let v20 = 0x1::vector::empty<u64>();
        let v21 = 0x1::vector::empty<u64>();
        let v22 = 0x1::vector::empty<u64>();
        let v23 = 0x1::vector::empty<u64>();
        let v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v3)) {
            let v25 = *0x1::vector::borrow<u64>(&v3, v24);
            let v26 = 0;
            let v27 = 0;
            while (v27 < 0x1::vector::length<Ha24a5>(&v11)) {
                let v28 = *0x1::vector::borrow<Ha24a5>(&v11, v27);
                if (v28.had3bb == v25) {
                    v26 = v26 + v28.h8b91e - v28.h6da71;
                };
                v27 = v27 + 1;
            };
            if (v26 > 0) {
                0x1::vector::push_back<u64>(&mut v22, v25);
                0x1::vector::push_back<u64>(&mut v23, v26);
            };
            let v29 = *0x1::vector::borrow<u64>(&v2, v24) - v26;
            if (v29 > 0) {
                0x1::vector::push_back<u64>(&mut v20, v25);
                0x1::vector::push_back<u64>(&mut v21, v29);
            };
            v24 = v24 + 1;
        };
        let v30 = 0x1::vector::empty<u64>();
        let v31 = 0x1::vector::empty<u64>();
        let v32 = 0x1::vector::empty<u64>();
        let v33 = 0x1::vector::empty<u64>();
        v24 = 0;
        while (v24 < 0x1::vector::length<u64>(&v7)) {
            let v34 = *0x1::vector::borrow<u64>(&v7, v24);
            let v35 = 0;
            let v36 = 0;
            while (v36 < 0x1::vector::length<Ha24a5>(&v12)) {
                let v37 = *0x1::vector::borrow<Ha24a5>(&v12, v36);
                if (v37.had3bb == v34) {
                    v35 = v35 + v37.h8b91e - v37.h6da71;
                };
                v36 = v36 + 1;
            };
            if (v35 > 0) {
                0x1::vector::push_back<u64>(&mut v32, v34);
                0x1::vector::push_back<u64>(&mut v33, v35);
            };
            let v38 = *0x1::vector::borrow<u64>(&v6, v24) - v35;
            if (v38 > 0) {
                0x1::vector::push_back<u64>(&mut v30, v34);
                0x1::vector::push_back<u64>(&mut v31, v38);
            };
            v24 = v24 + 1;
        };
        Hb42c4{
            h11fc2 : v3,
            hc11fa : v2,
            h7b1a0 : v7,
            h0d934 : v6,
            h356a6 : v22,
            ha6896 : v23,
            h23853 : v32,
            h54cb9 : v33,
            hafaf6 : v20,
            h0c1e8 : v21,
            h7a882 : v30,
            h88c20 : v31,
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

    // decompiled from Move bytecode v6
}

