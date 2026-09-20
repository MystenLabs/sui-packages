module 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::tide {
    public fun check<T0, T1>(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg5: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg6: &0x2::clock::Clock) {
        if (!0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::checking(arg0)) {
            return
        };
        let (v0, v1) = quote<T0, T1>(arg1, arg2, 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_amount(arg0), arg4, arg5, arg6);
        0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_step(arg0, v0, v1, arg3);
    }

    fun effective_price(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : u256 {
        if (arg0 == 0) {
            return 0
        };
        if (arg2 == 0) {
            return (arg0 as u256)
        };
        if (arg1 == 0) {
            return 0
        };
        let v0 = if (arg4 > arg3) {
            arg4 - arg3
        } else {
            0
        };
        let v1 = (v0 as u256) * (arg2 as u256) / (arg1 as u256);
        let v2 = v1;
        if (v1 > (arg5 as u256)) {
            v2 = (arg5 as u256);
        };
        if (arg6 && v2 > 10000) {
            return 0
        };
        let v3 = if (arg6) {
            10000 - v2
        } else {
            10000 + v2
        };
        let v4 = (arg0 as u256) * v3;
        if (v4 > 340282366920938463463374607431768211455) {
            return 0
        };
        v4 / 10000
    }

    fun fee_bound<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker) : u16 {
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_fee_override<T0, T1>(arg0);
        if (0x1::option::is_some<u16>(v0)) {
            return *0x1::option::borrow<u16>(v0)
        };
        let v1 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::fee_override(arg1);
        if (0x1::option::is_some<u16>(v1)) {
            return *0x1::option::borrow<u16>(v1)
        };
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::hard_max_fee_bps()
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg2: bool, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &0x2::clock::Clock) {
        let (v0, v1) = quote<T0, T1>(arg1, arg2, 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::reference_input(arg0), arg3, arg4, arg5);
        if (v0 == 0 || v1 == 0) {
            0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::fold_closed(arg0);
            return
        };
        0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    public fun live_hash<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: bool) : vector<u8> {
        let v0 = if (arg1) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg0)
        };
        *0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_hash(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v0))
    }

    public fun quote<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &0x2::clock::Clock) : (u64, u64) {
        let v0 = if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_paused<T0, T1>(arg0)) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::paused(arg3)) {
            true
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::paused(arg4)
        };
        if (v0) {
            return (0, 0)
        };
        let v1 = if (arg1) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg0)
        };
        if (0x1::option::is_none<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v1)) {
            return (0, 0)
        };
        let v2 = 0x2::bcs::new(0x2::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v1)));
        0x2::bcs::peel_vec_u8(&mut v2);
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x2::bcs::peel_vec_length(&mut v2)) {
            0x1::vector::push_back<u128>(&mut v4, 0x2::bcs::peel_u128(&mut v2));
            0x1::vector::push_back<u64>(&mut v3, 0x2::bcs::peel_u64(&mut v2) - 0x2::bcs::peel_u64(&mut v2));
            v5 = v5 + 1;
        };
        let v6 = 0x2::bcs::peel_u64(&mut v2);
        let v7 = 0x2::clock::timestamp_ms(arg5);
        let v8 = room(false, 0x2::bcs::peel_bool(&mut v2), 0x2::bcs::peel_u64(&mut v2), v6, 0x2::bcs::peel_u64(&mut v2), v7);
        if (v8 == 0) {
            return (0, 0)
        };
        let v9 = 0x2::bcs::new(0x2::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::OrderBookParams>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::params(arg3)));
        0x2::bcs::peel_u16(&mut v9);
        let v10 = if (arg1) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_quote_value<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_base_value<T0, T1>(arg0)
        };
        let (v11, v12) = walk(arg1, arg2, &v4, &v3, (0x2::bcs::peel_u32(&mut v2) as u64), (0x2::bcs::peel_u16(&mut v2) as u64), 0x2::bcs::peel_u64(&mut v2), v7, (0x2::bcs::peel_u16(&mut v9) as u64), v8, v10, 0);
        let v13 = if (arg1) {
            v11
        } else {
            v12
        };
        if (v11 < 0x2::bcs::peel_u64(&mut v2) || 0x2::bcs::peel_bool(&mut v2) && v13 != v6) {
            return (0, 0)
        };
        (v11, v12 - (((v12 as u256) * (fee_bound<T0, T1>(arg0, arg4) as u256) / 10000) as u64))
    }

    public fun room(arg0: bool, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg0) {
            true
        } else if (arg1) {
            true
        } else if (arg2 >= arg3) {
            true
        } else {
            arg4 <= arg5
        };
        if (v0) {
            return 0
        };
        arg3 - arg2
    }

    public fun walk(arg0: bool, arg1: u64, arg2: &vector<u128>, arg3: &vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : (u64, u64) {
        let v0 = 0x1::vector::length<u128>(arg2);
        let v1 = v0;
        if (0x1::vector::length<u64>(arg3) < v0) {
            v1 = 0x1::vector::length<u64>(arg3);
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        loop {
            let v5 = if (v4 < v1) {
                if (arg1 > 0) {
                    arg9 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                let v6 = *0x1::vector::borrow<u128>(arg2, v4);
                let v7 = *0x1::vector::borrow<u64>(arg3, v4);
                let v8 = v7;
                v4 = v4 + 1;
                if (v7 > arg9) {
                    v8 = arg9;
                };
                if (v8 == 0) {
                    continue
                };
                let v9 = effective_price(v6, arg4, arg5, arg6, arg7, arg8, arg0);
                if (v9 == 0) {
                    return (0, 0)
                };
                let (v10, v11) = if (arg0) {
                    let v12 = if (arg1 < v8) {
                        arg1
                    } else {
                        v8
                    };
                    (v12, (v12 as u256) * v9 / 1000000000000000000)
                } else {
                    let v13 = (arg1 as u256) * 1000000000000000000 / v9;
                    let v14 = v13;
                    if (v13 > 18446744073709551615) {
                        v14 = 18446744073709551615;
                    };
                    let v15 = (v14 as u64);
                    if (v15 < v8) {
                        (v15, (arg1 as u256))
                    } else {
                        (v8, (v8 as u256) * v9 / 1000000000000000000)
                    }
                };
                if (v11 > 18446744073709551615) {
                    return (0, 0)
                };
                if (v10 == 0) {
                    continue
                };
                let v16 = (v11 as u64);
                let (v17, v18) = if (arg0) {
                    (v10, v16)
                } else {
                    (v16, v10)
                };
                let v19 = if (arg0) {
                    v2
                } else {
                    v3
                };
                if (v18 > arg10 - v19) {
                    return (0, 0)
                };
                v3 = v3 + v10;
                v2 = v2 + v16;
                arg1 = arg1 - v17;
                arg9 = arg9 - v10;
            } else {
                break
            };
        };
        let (v20, v21) = if (arg0) {
            (v3, v2)
        } else {
            (v2, v3)
        };
        (v20, v21 - (((v21 as u256) * (arg11 as u256) / 10000) as u64))
    }

    // decompiled from Move bytecode v7
}

