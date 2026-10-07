module 0xbaa084e27ad9d54097ea6b3d7fbc5b36f4abf75b7bde876602ae8c6cbe59fb68::reader {
    struct Params has copy, drop, store {
        max_slippage_bps: u16,
        max_layers: u8,
    }

    struct AccessSample has copy, drop {
        ready: bool,
        fee_exact: bool,
        fee: u16,
        base: u64,
        quote: u64,
        now: u64,
        params_bcs: vector<u8>,
        quote_bcs: vector<u8>,
        hash: vector<u8>,
        signed_at: u64,
        expiry: u64,
        cancelled: bool,
        filled: u64,
        depth: u64,
    }

    struct Prepared has copy, drop, store {
        pool: 0x2::object::ID,
        config: 0x2::object::ID,
        now: u64,
        down: bool,
        hash: vector<u8>,
        inputs: vector<u128>,
        outputs: vector<u128>,
        prices: vector<u128>,
        inversion: bool,
        minimum: u128,
        native_minimum: u64,
        capacity: u128,
        reserve: u128,
        fee: u16,
        status: u8,
        fok: bool,
        total_depth: u64,
        filled: u64,
        quote_bytes: u64,
    }

    struct PreparedSample has copy, drop {
        prepared: Prepared,
        amount: u64,
        out: u64,
        consumed: u64,
        remaining: u64,
        status: u8,
    }

    public fun assert_binding<T0, T1>(arg0: &Prepared, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: bool) {
        let v0 = if (arg0.pool == 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg1)) {
            if (arg0.now == 0x2::clock::timestamp_ms(arg2)) {
                if (arg0.down == arg3) {
                    arg0.status == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
    }

    public fun fee<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker) : (bool, u16) {
        let v0 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_fee_override<T0, T1>(arg0);
        if (0x1::option::is_some<u16>(v0)) {
            return (true, *0x1::option::borrow<u16>(v0))
        };
        let v1 = 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::fee_override(arg1);
        if (0x1::option::is_some<u16>(v1)) {
            (true, *0x1::option::borrow<u16>(v1))
        } else {
            (false, 0)
        }
    }

    public fun hash(arg0: &Prepared) : vector<u8> {
        arg0.hash
    }

    public fun model(arg0: &Prepared) : (vector<u128>, vector<u128>, vector<u128>, bool, bool, u128, u128, u128, u64, bool) {
        (arg0.inputs, arg0.outputs, arg0.prices, arg0.down, arg0.inversion, arg0.minimum, arg0.capacity, arg0.reserve, (arg0.fee as u64), arg0.status == 0)
    }

    public fun params(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig) : Params {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::OrderBookParams>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::params(arg0)));
        0x2::bcs::peel_u16(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 1);
        Params{
            max_slippage_bps : 0x2::bcs::peel_u16(&mut v0),
            max_layers       : 0x2::bcs::peel_u8(&mut v0),
        }
    }

    public fun prepare<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &Params, arg6: bool, arg7: u16) : Prepared {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg3);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_mm_id<T0, T1>(arg0) == 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg1), 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (v1, v2) = fee<T0, T1>(arg0, arg1);
        let v3 = if (v1) {
            v2
        } else {
            arg7
        };
        let v4 = if (arg6) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_quote_value<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_base_value<T0, T1>(arg0)
        };
        let v5 = Prepared{
            pool           : 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg0),
            config         : 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig>(arg2),
            now            : v0,
            down           : arg6,
            hash           : b"",
            inputs         : vector[],
            outputs        : vector[],
            prices         : vector[],
            inversion      : false,
            minimum        : 0,
            native_minimum : 0,
            capacity       : 0,
            reserve        : (v4 as u128),
            fee            : v3,
            status         : 1,
            fok            : false,
            total_depth    : 0,
            filled         : 0,
            quote_bytes    : 0,
        };
        let v6 = if (v3 > 100) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_paused<T0, T1>(arg0)) {
            true
        } else if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::paused(arg1)) {
            true
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::paused(arg2)
        };
        if (v6) {
            return v5
        };
        let v7 = if (arg6) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg0)
        };
        if (0x1::option::is_none<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v7)) {
            return v5
        };
        let v8 = 0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v7);
        let v9 = if (0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_cancelled(v8)) {
            true
        } else if (v0 < 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_signed_at_ms(v8)) {
            true
        } else if (v0 >= 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_sig_expiry_ms(v8)) {
            true
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_cumulative_filled_in(v8) >= 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_total_depth(v8)
        };
        if (v9) {
            return v5
        };
        let v10 = 0x1::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v8);
        v5.quote_bytes = 0x1::vector::length<u8>(&v10);
        let v11 = 0x2::bcs::new(v10);
        v5.hash = 0x2::bcs::peel_vec_u8(&mut v11);
        let v12 = 0x2::bcs::peel_vec_length(&mut v11);
        assert!(v12 <= (arg5.max_layers as u64), 5);
        let v13 = vector[];
        let v14 = vector[];
        let v15 = 0;
        while (v15 < v12) {
            let v16 = 0x2::bcs::peel_u128(&mut v11);
            let v17 = 0x2::bcs::peel_u64(&mut v11);
            let v18 = 0x2::bcs::peel_u64(&mut v11);
            assert!(v16 > 0 && v18 <= v17, 6);
            0x1::vector::push_back<u128>(&mut v13, v16);
            0x1::vector::push_back<u64>(&mut v14, v17 - v18);
            v15 = v15 + 1;
        };
        let v19 = 0x2::bcs::peel_u32(&mut v11);
        let v20 = 0x2::bcs::peel_u16(&mut v11);
        0x2::bcs::peel_u64(&mut v11);
        v5.fok = 0x2::bcs::peel_bool(&mut v11);
        v5.native_minimum = 0x2::bcs::peel_u64(&mut v11);
        v5.minimum = (v5.native_minimum as u128);
        v5.filled = 0x2::bcs::peel_u64(&mut v11);
        v5.total_depth = 0x2::bcs::peel_u64(&mut v11);
        0x2::bcs::peel_bool(&mut v11);
        let v21 = 0x2::bcs::into_remainder_bytes(v11);
        assert!(0x1::vector::is_empty<u8>(&v21), 7);
        assert!(v20 == 0 || v19 > 0, 8);
        let v22 = if (v20 == 0) {
            0
        } else {
            0x1::u128::min(((v0 - 0x2::bcs::peel_u64(&mut v11)) as u128) * (v20 as u128) / (v19 as u128), (arg5.max_slippage_bps as u128))
        };
        let v23 = if (arg6) {
            10000 - v22
        } else {
            10000 + v22
        };
        v15 = 0;
        let v24 = 0;
        let v25 = 0;
        let v26 = 0;
        while (v15 < v12) {
            let v27 = (*0x1::vector::borrow<u64>(&v14, v15) as u128);
            let v28 = *0x1::vector::borrow<u128>(&v13, v15) * v23 / 10000;
            if (v27 > 0 && v28 > 0) {
                if (v26 > 0 && (arg6 && v28 > v26 || !arg6 && v28 < v26)) {
                    v5.inversion = true;
                };
                let v29 = if (arg6) {
                    v27
                } else {
                    ((((v27 as u256) * (v28 as u256) + (1000000000000000000 as u256) - 1) / (1000000000000000000 as u256)) as u128)
                };
                let v30 = if (arg6) {
                    (((v27 as u256) * (v28 as u256) / (1000000000000000000 as u256)) as u128)
                } else {
                    v27
                };
                0x1::vector::push_back<u128>(&mut v5.inputs, v29);
                0x1::vector::push_back<u128>(&mut v5.outputs, v30);
                0x1::vector::push_back<u128>(&mut v5.prices, v28);
                v5.capacity = v5.capacity + v29;
                let v31 = if (arg6) {
                    v29
                } else {
                    (((v27 as u256) * (v28 as u256) / (1000000000000000000 as u256)) as u128)
                };
                v25 = v25 + v31;
                v24 = v24 + v27;
            };
            v15 = v15 + 1;
        };
        if (v5.fok) {
            if (v5.filled != 0 || v24 != (v5.total_depth as u128)) {
                v5.status = 3;
                return v5
            };
            v5.minimum = 0x1::u128::max(v5.minimum, v5.capacity);
        };
        let v32 = if (v5.capacity == 0) {
            true
        } else if (v5.minimum > v5.capacity) {
            true
        } else if ((v5.native_minimum as u128) > v25) {
            true
        } else {
            v5.reserve == 0
        };
        if (v32) {
            return v5
        };
        v5.status = 0;
        v5
    }

    public fun prepare_unless_selected<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &Params, arg6: bool, arg7: u16, arg8: &vector<bool>) : Prepared {
        let v0 = true;
        if (!0x1::vector::contains<bool>(arg8, &v0)) {
            return prepare<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
        };
        Prepared{
            pool           : 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>>(arg0),
            config         : 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig>(arg2),
            now            : 0x2::clock::timestamp_ms(arg4),
            down           : arg6,
            hash           : b"",
            inputs         : vector[],
            outputs        : vector[],
            prices         : vector[],
            inversion      : false,
            minimum        : 0,
            native_minimum : 0,
            capacity       : 0,
            reserve        : 0,
            fee            : 0,
            status         : 1,
            fok            : false,
            total_depth    : 0,
            filled         : 0,
            quote_bytes    : 0,
        }
    }

    public fun probe<T0, T1>(arg0: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::Pool<T0, T1>, arg1: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker, arg2: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::GlobalConfig, arg3: &0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: bool) {
        0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::versioned::check_version(arg3);
        assert!(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_mm_id<T0, T1>(arg0) == 0x2::object::id<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::MarketMaker>(arg1), 2);
        let (v0, v1) = fee<T0, T1>(arg0, arg1);
        params(arg2);
        let v2 = if (arg5) {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_bid<T0, T1>(arg0)
        } else {
            0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_ask<T0, T1>(arg0)
        };
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let (v4, v5, v6, v7, v8, v9, v10) = if (0x1::option::is_some<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v2)) {
            let v11 = 0x1::option::borrow<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v2);
            (0x1::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::QuoteEntry>(v11), *0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_hash(v11), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_signed_at_ms(v11), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_sig_expiry_ms(v11), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_cancelled(v11), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_cumulative_filled_in(v11), 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::quote_total_depth(v11))
        } else {
            (b"", b"", 0, 0, false, 0, 0)
        };
        let v12 = if (v0) {
            if (v3 >= v6) {
                if (v3 < v7) {
                    if (!v8) {
                        if (v9 < v10) {
                            if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_paused<T0, T1>(arg0)) {
                                if (!0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::market_maker::paused(arg1)) {
                                    !0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::config::paused(arg2)
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v13 = AccessSample{
            ready      : v12,
            fee_exact  : v0,
            fee        : v1,
            base       : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_base_value<T0, T1>(arg0),
            quote      : 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::pool_quote_value<T0, T1>(arg0),
            now        : v3,
            params_bcs : 0x1::bcs::to_bytes<0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::OrderBookParams>(0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::orderbook::params(arg2)),
            quote_bcs  : v4,
            hash       : v5,
            signed_at  : v6,
            expiry     : v7,
            cancelled  : v8,
            filled     : v9,
            depth      : v10,
        };
        0x2::event::emit<AccessSample>(v13);
    }

    public fun quote(arg0: &Prepared, arg1: u64) : (u64, u64, u64, u8) {
        if (arg0.status != 0) {
            return (0, 0, arg1, arg0.status)
        };
        let v0 = (arg1 as u128);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&arg0.inputs) && v0 > 0) {
            let v4 = *0x1::vector::borrow<u128>(&arg0.prices, v3);
            let v5 = if (arg0.down) {
                *0x1::vector::borrow<u128>(&arg0.inputs, v3)
            } else {
                *0x1::vector::borrow<u128>(&arg0.outputs, v3)
            };
            let v6 = if (arg0.down) {
                v0
            } else {
                (((v0 as u256) * (1000000000000000000 as u256) / (v4 as u256)) as u128)
            };
            let v7 = 0x1::u128::min(v6, v5);
            let v8 = if (arg0.down) {
                v7
            } else if (v6 >= v5) {
                (((v7 as u256) * (v4 as u256) / (1000000000000000000 as u256)) as u128)
            } else {
                v0
            };
            let v9 = if (arg0.down) {
                (((v7 as u256) * (v4 as u256) / (1000000000000000000 as u256)) as u128)
            } else {
                v7
            };
            v0 = v0 - v8;
            v1 = v1 + v9;
            v2 = v2 + v7;
            v3 = v3 + 1;
        };
        let v10 = (arg1 as u128) - v0;
        if (v10 < (arg0.native_minimum as u128)) {
            return (0, 0, arg1, 4)
        };
        if (arg0.fok && v2 != (arg0.total_depth as u128)) {
            return (0, 0, arg1, 3)
        };
        if (v1 > arg0.reserve) {
            return (0, 0, arg1, 5)
        };
        let v11 = v1 - v1 * (arg0.fee as u128) / 10000;
        if (v11 == 0) {
            return (0, (v10 as u64), (v0 as u64), 6)
        };
        ((v11 as u64), (v10 as u64), (v0 as u64), 0)
    }

    public fun sample(arg0: &Prepared, arg1: u64) {
        let (v0, v1, v2, v3) = quote(arg0, arg1);
        let v4 = PreparedSample{
            prepared  : *arg0,
            amount    : arg1,
            out       : v0,
            consumed  : v1,
            remaining : v2,
            status    : v3,
        };
        0x2::event::emit<PreparedSample>(v4);
    }

    // decompiled from Move bytecode v7
}

