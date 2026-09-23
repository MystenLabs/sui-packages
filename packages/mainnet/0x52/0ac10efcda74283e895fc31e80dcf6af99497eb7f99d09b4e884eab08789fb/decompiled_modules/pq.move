module 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::pq {
    public(friend) fun q<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = if (arg4 == 0) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::paused(arg0)) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::paused(arg1)) {
            true
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_paused<T0, T1>(arg2)
        };
        if (v0) {
            return 0
        };
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_mm_id<T0, T1>(arg2) == 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg1), 170);
        let v1 = if (0x1::option::is_some<u16>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_fee_override<T0, T1>(arg2))) {
            *0x1::option::borrow<u16>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_fee_override<T0, T1>(arg2))
        } else {
            assert!(0x1::option::is_some<u16>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::fee_override(arg1)), 171);
            *0x1::option::borrow<u16>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::fee_override(arg1))
        };
        assert!(v1 <= 100, 170);
        let v2 = if (arg3) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg2)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg2)
        };
        if (0x1::option::is_none<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v2)) {
            return 0
        };
        let v3 = 0x2::bcs::new(0x2::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::OrderBookParams>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::params(arg0)));
        0x2::bcs::peel_u16(&mut v3);
        let v4 = 0x2::bcs::into_remainder_bytes(v3);
        assert!(0x1::vector::is_empty<u8>(&v4), 170);
        let v5 = if (arg3) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_quote_value<T0, T1>(arg2)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_base_value<T0, T1>(arg2)
        };
        r(0x2::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v2)), arg3, arg4, 0x2::clock::timestamp_ms(arg5), 0x2::bcs::peel_u16(&mut v3), 0x2::bcs::peel_u8(&mut v3), v1, v5)
    }

    fun r(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u16, arg5: u8, arg6: u16, arg7: u64) : u64 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x1::vector::length<u8>(&v1) == 32, 170);
        let v2 = 0x2::bcs::peel_vec_length(&mut v0);
        let v3 = if (v2 > 0) {
            if (v2 <= 16) {
                arg5 <= 16
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 170);
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v7 < v2) {
            let v10 = 0x2::bcs::peel_u128(&mut v0);
            let v11 = 0x2::bcs::peel_u64(&mut v0);
            let v12 = 0x2::bcs::peel_u64(&mut v0);
            assert!(v10 > 0 && v12 <= v11, 170);
            0x1::vector::push_back<u128>(&mut v4, v10);
            0x1::vector::push_back<u64>(&mut v5, v11);
            0x1::vector::push_back<u64>(&mut v6, v12);
            v8 = v8 + (v11 as u128);
            v9 = v9 + (v12 as u128);
            v7 = v7 + 1;
        };
        let v13 = 0x2::bcs::peel_u32(&mut v0);
        let v14 = 0x2::bcs::peel_u16(&mut v0);
        let v15 = 0x2::bcs::peel_u64(&mut v0);
        let v16 = 0x2::bcs::peel_u64(&mut v0);
        let v17 = 0x2::bcs::peel_u64(&mut v0);
        let v18 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v18), 170);
        assert!(v8 == (v17 as u128) && v9 == (v16 as u128), 170);
        assert!(arg4 <= 10000 && (v14 == 0 || v13 > 0), 170);
        let v19 = if (arg2 == 0) {
            true
        } else if (0x2::bcs::peel_bool(&mut v0)) {
            true
        } else if (v16 >= v17) {
            true
        } else {
            0x2::bcs::peel_u64(&mut v0) <= arg3
        };
        if (v19) {
            return 0
        };
        let v20 = if (arg3 >= v15) {
            arg3 - v15
        } else {
            0
        };
        let v21 = if (v14 == 0) {
            0
        } else {
            (v20 as u128) * (v14 as u128) / (v13 as u128)
        };
        let v22 = if (v21 > (arg4 as u128)) {
            (arg4 as u128)
        } else {
            v21
        };
        let v23 = if (arg1) {
            10000 - v22
        } else {
            10000 + v22
        };
        let v24 = arg2;
        let v25 = 0;
        let v26 = 0;
        v7 = 0;
        while (v7 < v2 && v24 > 0) {
            let v27 = *0x1::vector::borrow<u64>(&v5, v7) - *0x1::vector::borrow<u64>(&v6, v7);
            if (v27 > 0) {
                let v28 = (*0x1::vector::borrow<u128>(&v4, v7) as u256) * (v23 as u256);
                assert!(v28 <= 340282366920938463463374607431768211455, 170);
                let v29 = v28 / 10000;
                if (v29 == 0) {
                    return 0
                };
                let (v30, v31) = if (arg1) {
                    let v32 = if (v24 < v27) {
                        v24
                    } else {
                        v27
                    };
                    let v33 = (v32 as u256) * v29 / 1000000000000000000;
                    if (v33 > 18446744073709551615) {
                        return 0
                    };
                    (v32, (v33 as u64))
                } else {
                    let v34 = (v24 as u256) * 1000000000000000000 / v29;
                    let v35 = if (v34 > 18446744073709551615) {
                        18446744073709551615
                    } else {
                        v34
                    };
                    if (v35 < (v27 as u256)) {
                        ((v35 as u64), v24)
                    } else {
                        let v36 = (v27 as u256) * v29 / 1000000000000000000;
                        if (v36 > 18446744073709551615) {
                            return 0
                        };
                        (v27, (v36 as u64))
                    }
                };
                if (v30 > 0) {
                    v25 = v25 + (v30 as u128);
                    v26 = v26 + (v31 as u128);
                    let v37 = if (arg1) {
                        v30
                    } else {
                        v31
                    };
                    v24 = v24 - v37;
                };
            };
            v7 = v7 + 1;
        };
        if (v24 != 0 || 0x2::bcs::peel_bool(&mut v0) && v25 != (v17 as u128)) {
            return 0
        };
        let v38 = if (arg1) {
            v25
        } else {
            v26
        };
        let v39 = if (arg1) {
            v26
        } else {
            v25
        };
        let v40 = if (v38 < (0x2::bcs::peel_u64(&mut v0) as u128)) {
            true
        } else if (v39 > (arg7 as u128)) {
            true
        } else {
            v39 > 18446744073709551615
        };
        if (v40) {
            return 0
        };
        ((v39 - v39 * (arg6 as u128) / 10000) as u64)
    }

    // decompiled from Move bytecode v7
}

