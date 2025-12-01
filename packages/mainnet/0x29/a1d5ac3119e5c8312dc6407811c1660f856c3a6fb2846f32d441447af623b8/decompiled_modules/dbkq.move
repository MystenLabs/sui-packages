module 0x29a1d5ac3119e5c8312dc6407811c1660f856c3a6fb2846f32d441447af623b8::dbkq {
    struct CP has copy, drop, store {
        l: u64,
        f: u64,
    }

    struct P has copy, drop, store {
        b: CP,
        q: CP,
        d: CP,
    }

    struct ACP has copy, drop, store {
        a: 0x1::string::String,
        l: u64,
        f: u64,
    }

    struct DO has copy, drop, store {
        b: bool,
        p: u64,
        o: u64,
    }

    struct CO has copy, drop, store {
        q: u64,
        p: u64,
        b: bool,
        f: u64,
        e: u64,
    }

    struct BD has copy, drop, store {
        bp: vector<u64>,
        bq: vector<u64>,
        ap: vector<u64>,
        aq: vector<u64>,
        bpo: vector<u64>,
        bqo: vector<u64>,
        apo: vector<u64>,
        aqo: vector<u64>,
        bpw: vector<u64>,
        bqw: vector<u64>,
        apw: vector<u64>,
        aqw: vector<u64>,
    }

    fun do(arg0: u128) : DO {
        DO{
            b : arg0 >> 127 == 0,
            p : ((arg0 >> 64) as u64) & 9223372036854775807,
            o : ((arg0 & 18446744073709551615) as u64),
        }
    }

    public fun fod<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2::clock::Clock) : BD {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), true, arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), false, arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account<T0, T1>(arg0, arg1);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::account::open_orders(&v8);
        let v10 = 0x2::vec_set::keys<u128>(&v9);
        let v11 = 0x1::vector::empty<CO>();
        let v12 = 0x1::vector::empty<CO>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<u128>(v10)) {
            let v14 = *0x1::vector::borrow<u128>(v10, v13);
            let DO {
                b : v15,
                p : v16,
                o : _,
            } = do(v14);
            let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg0, v14);
            let v19 = CO{
                q : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v18),
                p : v16,
                b : v15,
                f : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v18),
                e : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(&v18),
            };
            v13 = v13 + 1;
            if (v19.e < 0x2::clock::timestamp_ms(arg2)) {
                continue
            };
            if (v15) {
                0x1::vector::push_back<CO>(&mut v11, v19);
                continue
            };
            0x1::vector::push_back<CO>(&mut v12, v19);
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
            while (v27 < 0x1::vector::length<CO>(&v11)) {
                let v28 = *0x1::vector::borrow<CO>(&v11, v27);
                if (v28.p == v25) {
                    v26 = v26 + v28.q - v28.f;
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
            while (v36 < 0x1::vector::length<CO>(&v12)) {
                let v37 = *0x1::vector::borrow<CO>(&v12, v36);
                if (v37.p == v34) {
                    v35 = v35 + v37.q - v37.f;
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
        BD{
            bp  : v3,
            bq  : v2,
            ap  : v7,
            aq  : v6,
            bpo : v22,
            bqo : v23,
            apo : v32,
            aqo : v33,
            bpw : v20,
            bqw : v21,
            apw : v30,
            aqw : v31,
        }
    }

    public fun gp<T0, T1, T2>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : P {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg0, arg1);
        let v3 = CP{
            l : v0,
            f : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1),
        };
        let v4 = CP{
            l : v1,
            f : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1),
        };
        let v5 = CP{
            l : v2,
            f : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg1),
        };
        P{
            b : v3,
            q : v4,
            d : v5,
        }
    }

    public fun gps<T0, T1, T2>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T2>(arg0, arg2);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T1, T2>(arg1, arg2);
        let v6 = ACP{
            a : 0x1::string::utf8(b"SUI"),
            l : v0,
            f : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2),
        };
        0x2::event::emit<ACP>(v6);
        let v7 = ACP{
            a : 0x1::string::utf8(b"USDC"),
            l : v1 + v4,
            f : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2),
        };
        0x2::event::emit<ACP>(v7);
        let v8 = ACP{
            a : 0x1::string::utf8(b"DEEP"),
            l : v2 + v5,
            f : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2),
        };
        0x2::event::emit<ACP>(v8);
    }

    // decompiled from Move bytecode v6
}

