module 0xaa602c4058788794c3977cca07413c2d1320e95a1976148b9aedb66200e968ae::tide_venue {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Layer has copy, drop {
        price: u128,
        depth: u64,
        filled: u64,
    }

    public fun quote_cetus_tide<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T2, T3>, arg5: bool, arg6: u64, arg7: bool, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T2, T3>>(arg4);
        let v1 = if (arg5) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v2, v0, arg6, arg7)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v3, v0, arg6, arg7)
        };
        let (v4, v5) = quote_state<T2, T3>(arg2, arg3, arg4, arg5, v1, &arg8, arg9);
        if (arg5) {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v6, 8, v0, arg5, v1, v4, v5);
        } else {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v7, 8, v0, arg5, v1, v4, v5);
        };
    }

    public fun quote_state<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &vector<u8>, arg6: &0x2::clock::Clock) : (u64, bool) {
        let v0 = if (arg4 == 0) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::paused(arg0)) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::paused(arg1)) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_paused<T0, T1>(arg2)) {
            true
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_mm_id<T0, T1>(arg2) != 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg1)
        };
        if (v0) {
            return (0, false)
        };
        let v1 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_fee_override<T0, T1>(arg2);
        let v2 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::fee_override(arg1);
        let v3 = if (0x1::option::is_some<u16>(v1)) {
            *0x1::option::borrow<u16>(v1)
        } else if (0x1::option::is_some<u16>(v2)) {
            *0x1::option::borrow<u16>(v2)
        } else {
            return (0, false)
        };
        let v4 = 0x2::bcs::new(0x1::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::OrderBookParams>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::params(arg0)));
        0x2::bcs::peel_u16(&mut v4);
        0x2::bcs::peel_u8(&mut v4);
        let v5 = 0x2::bcs::into_remainder_bytes(v4);
        assert!(0x1::vector::is_empty<u8>(&v5), 0);
        let v6 = if (arg3) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg2)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg2)
        };
        if (0x1::option::is_none<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v6)) {
            return (0, false)
        };
        let (v7, v8) = walk(0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v6), arg5, arg4, arg3, 0x2::clock::timestamp_ms(arg6), 0x2::bcs::peel_u16(&mut v4));
        let v9 = if (arg3) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_quote_value<T0, T1>(arg2)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_base_value<T0, T1>(arg2)
        };
        if (!v8 || v7 > v9) {
            return (0, false)
        };
        (v7 - 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::fee::compute_fee(v7, v3), true)
    }

    public fun swap_cetus_tide<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg4: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg5: &mut 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T2, T3>, arg6: bool, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            let v0 = Witness{dummy_field: false};
            let v1 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v0, 8, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T2, T3>>(arg5), true, arg9);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v1)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v1);
                return
            };
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v1);
            let v3 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
            0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v3, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(arg7, 0x2::coin::value<T2>(&v2)));
            let (v4, v5) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_base_for_quote<T2, T3>(arg2, arg3, arg4, arg5, v3, 0x2::coin::into_balance<T2>(v2), arg7, arg8, arg9);
            0x2::balance::destroy_zero<T2>(v5);
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v6, 0x2::coin::from_balance<T3>(v4, arg9));
        } else {
            let v7 = Witness{dummy_field: false};
            let v8 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v7, 8, 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T2, T3>>(arg5), false, arg9);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v8)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v8);
                return
            };
            let v9 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v8);
            let v10 = 0x1::vector::empty<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>();
            0x1::vector::push_back<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteFill>(&mut v10, 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::new_quote_fill(arg7, 0x2::coin::value<T3>(&v9)));
            let (v11, v12) = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::swap_exact_quote_for_base<T2, T3>(arg2, arg3, arg4, arg5, v10, 0x2::coin::into_balance<T3>(v9), arg7, arg8, arg9);
            0x2::balance::destroy_zero<T3>(v12);
            let v13 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v13, 0x2::coin::from_balance<T2>(v11, arg9));
        };
    }

    fun walk(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry, arg1: &vector<u8>, arg2: u64, arg3: bool, arg4: u64, arg5: u16) : (u64, bool) {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(arg0));
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v2 = 0x1::vector::empty<Layer>();
        let v3 = 0;
        while (v3 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v4 = Layer{
                price  : 0x2::bcs::peel_u128(&mut v0),
                depth  : 0x2::bcs::peel_u64(&mut v0),
                filled : 0x2::bcs::peel_u64(&mut v0),
            };
            0x1::vector::push_back<Layer>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = 0x2::bcs::peel_u32(&mut v0);
        let v6 = 0x2::bcs::peel_u16(&mut v0);
        let v7 = 0x2::bcs::peel_u64(&mut v0);
        let v8 = 0x2::bcs::peel_u64(&mut v0);
        let v9 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v9), 0);
        let v10 = if (&v1 != arg1) {
            true
        } else if (0x2::bcs::peel_bool(&mut v0)) {
            true
        } else if (0x2::bcs::peel_u64(&mut v0) >= v8) {
            true
        } else if (arg4 >= 0x2::bcs::peel_u64(&mut v0)) {
            true
        } else {
            arg2 < 0x2::bcs::peel_u64(&mut v0)
        };
        if (v10) {
            return (0, false)
        };
        let v11 = if (arg4 > v7) {
            arg4 - v7
        } else {
            0
        };
        let v12 = if (v6 == 0) {
            0
        } else {
            if (v5 == 0) {
                return (0, false)
            };
            0x1::u128::min((v11 as u128) * (v6 as u128) / (v5 as u128), (arg5 as u128))
        };
        let (v13, v14, v15) = walk_layers(&v2, arg2, arg3, v12);
        let v16 = if (arg3) {
            v14
        } else {
            v13
        };
        let v17 = v15 == 0 && (!0x2::bcs::peel_bool(&mut v0) || v13 == v8);
        (v16, v17)
    }

    fun walk_layers(arg0: &vector<Layer>, arg1: u64, arg2: bool, arg3: u128) : (u64, u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Layer>(arg0) && v0 > 0) {
            let v4 = 0x1::vector::borrow<Layer>(arg0, v3);
            let v5 = v4.depth - v4.filled;
            let v6 = if (arg2) {
                10000 - arg3
            } else {
                10000 + arg3
            };
            let v7 = v4.price * v6 / 10000;
            if (v5 > 0 && v7 > 0) {
                let (v8, v9) = if (arg2) {
                    let v10 = 0x1::u64::min(v0, v5);
                    (v10, (((v10 as u256) * (v7 as u256) / 1000000000000000000) as u64))
                } else {
                    let v11 = (v0 as u256) * 1000000000000000000 / (v7 as u256);
                    if (v11 < (v5 as u256)) {
                        ((v11 as u64), v0)
                    } else {
                        (v5, (((v5 as u256) * (v7 as u256) / 1000000000000000000) as u64))
                    }
                };
                if (v8 > 0) {
                    v1 = v1 + v8;
                    v2 = v2 + v9;
                    let v12 = if (arg2) {
                        v8
                    } else {
                        v9
                    };
                    v0 = v0 - v12;
                };
            };
            v3 = v3 + 1;
        };
        (v1, v2, v0)
    }

    // decompiled from Move bytecode v7
}

