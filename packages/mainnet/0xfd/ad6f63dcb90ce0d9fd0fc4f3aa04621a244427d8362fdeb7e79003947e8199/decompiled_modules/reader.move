module 0xfdad6f63dcb90ce0d9fd0fc4f3aa04621a244427d8362fdeb7e79003947e8199::reader {
    struct MakerEndpoint has drop {
        price: u64,
        base: u64,
    }

    struct WindowCursor has drop {
        last: 0x1::option::Option<u128>,
        raw: u64,
        terminal: bool,
        pending: vector<MakerEndpoint>,
        lot: u64,
        minimum: u64,
        fee: u64,
    }

    public fun after_gate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64) : (vector<u64>, vector<u64>, u64, u64, bool, u64, u64) {
        assert!(arg3 > 0 && arg3 <= 100, 800);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::none<u64>(), arg3, arg2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)) {
            let v5 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v4);
            if (0x2::clock::timestamp_ms(arg1) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v5)) {
                let v6 = checked_remaining(v5);
                if (v6 > 0) {
                    0x1::vector::push_back<u64>(&mut v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v5));
                    0x1::vector::push_back<u64>(&mut v3, v6);
                };
            };
            v4 = v4 + 1;
        };
        let (_, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v10 = arg3 < 100 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v0);
        let (v11, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        (v2, v3, v8, v9, v10, v11, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling())
    }

    public fun after_gate_if<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: bool) : (vector<u64>, vector<u64>, u64, u64, bool, u64, u64) {
        if (!arg4) {
            return (vector[], vector[], 1, 1, false, 0, 1)
        };
        after_gate<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_from_current_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: u64) : (WindowCursor, vector<u64>, vector<u64>, u64, u64, bool, u64, u64, u64, u64, bool) {
        let (v0, v1) = if (arg5) {
            let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
            let _ = v2;
            (v3, v4)
        } else {
            let _ = 1;
            (1, 1)
        };
        let v6 = if (arg5) {
            arg6
        } else {
            0
        };
        let v7 = WindowCursor{
            last     : 0x1::option::none<u128>(),
            raw      : 0,
            terminal : false,
            pending  : 0x1::vector::empty<MakerEndpoint>(),
            lot      : v0,
            minimum  : v1,
            fee      : v6,
        };
        let v8 = &mut v7;
        let (v9, v10, v11, v12, v13, v14, v15, v16, v17, v18) = continue_if<T0, T1>(arg0, arg1, arg2, v8, arg3, arg4, arg5);
        (v7, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18)
    }

    public fun begin_if<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (WindowCursor, vector<u64>, vector<u64>, u64, u64, bool, u64, u64, u64, u64, bool) {
        let (v0, v1) = if (arg5) {
            let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
            let _ = v2;
            (v3, v4)
        } else {
            let _ = 1;
            (1, 1)
        };
        let v6 = if (arg5) {
            let (v7, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
            v7
        } else {
            0
        };
        let v10 = WindowCursor{
            last     : 0x1::option::none<u128>(),
            raw      : 0,
            terminal : false,
            pending  : 0x1::vector::empty<MakerEndpoint>(),
            lot      : v0,
            minimum  : v1,
            fee      : v6,
        };
        let v11 = &mut v10;
        let (v12, v13, v14, v15, v16, v17, v18, v19, v20, v21) = continue_if<T0, T1>(arg0, arg1, arg2, v11, arg3, arg4, arg5);
        (v10, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21)
    }

    fun checked_remaining(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(arg0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(arg0);
        assert!(v0 >= v1 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(arg0) > 0, 801);
        v0 - v1
    }

    public fun continue_if<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut WindowCursor, arg4: u64, arg5: u64, arg6: bool) : (vector<u64>, vector<u64>, u64, u64, bool, u64, u64, u64, u64, bool) {
        if (!arg6) {
            return (vector[], vector[], 1, 1, false, 0, 1, 0, 0, false)
        };
        let v0 = 0;
        let v1 = if (0x1::vector::is_empty<MakerEndpoint>(&arg3.pending)) {
            if (!arg3.terminal) {
                arg5 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = 0x1::u64::min(arg5, 100 - arg3.raw);
            if (v2 > 0) {
                let v3 = if (0x1::option::is_some<u128>(&arg3.last) && !arg2) {
                    0x1::option::some<u128>(*0x1::option::borrow<u128>(&arg3.last) + 1)
                } else {
                    arg3.last
                };
                let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, v3, 0x1::option::none<u128>(), 0x1::option::none<u64>(), v2, arg2);
                let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v4);
                let v6 = 0;
                if (v2 <= arg4) {
                    let v7 = vector[];
                    let v8 = vector[];
                    let v9 = 0x1::option::is_some<u128>(&arg3.last);
                    let v10 = v9;
                    let v11 = if (v9) {
                        *0x1::option::borrow<u128>(&arg3.last)
                    } else {
                        0
                    };
                    let v12 = v11;
                    while (v6 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5)) {
                        let v13 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5, v6);
                        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v13);
                        assert!(!v10 || v14 != v11, 801);
                        v12 = v14;
                        v10 = true;
                        if (0x2::clock::timestamp_ms(arg1) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v13)) {
                            let v15 = checked_remaining(v13);
                            if (v15 > 0) {
                                0x1::vector::push_back<u64>(&mut v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v13));
                                0x1::vector::push_back<u64>(&mut v8, v15);
                            };
                        };
                        v6 = v6 + 1;
                    };
                    if (v6 > 0) {
                        arg3.last = 0x1::option::some<u128>(v12);
                    };
                    let v16 = 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5);
                    arg3.raw = arg3.raw + v16;
                    let v17 = arg3.raw == 100 || !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v4);
                    arg3.terminal = v17;
                    return (v7, v8, arg3.lot, arg3.minimum, !arg3.terminal, arg3.fee, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(), v16, 0x1::vector::length<u64>(&v8), arg3.terminal)
                };
                while (v6 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5)) {
                    let v18 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5, v6);
                    let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v18);
                    assert!(!0x1::option::is_some<u128>(&arg3.last) || v19 != *0x1::option::borrow<u128>(&arg3.last), 801);
                    arg3.last = 0x1::option::some<u128>(v19);
                    if (0x2::clock::timestamp_ms(arg1) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v18)) {
                        let v20 = checked_remaining(v18);
                        if (v20 > 0) {
                            let v21 = MakerEndpoint{
                                price : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v18),
                                base  : v20,
                            };
                            0x1::vector::push_back<MakerEndpoint>(&mut arg3.pending, v21);
                        };
                    };
                    v6 = v6 + 1;
                };
                let v22 = 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5);
                v0 = v22;
                arg3.raw = arg3.raw + v22;
                let v23 = arg3.raw == 100 || !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v4);
                arg3.terminal = v23;
                0x1::vector::reverse<MakerEndpoint>(&mut arg3.pending);
            };
        };
        let v24 = vector[];
        let v25 = vector[];
        while (0x1::vector::length<u64>(&v25) < arg4 && !0x1::vector::is_empty<MakerEndpoint>(&arg3.pending)) {
            let MakerEndpoint {
                price : v26,
                base  : v27,
            } = 0x1::vector::pop_back<MakerEndpoint>(&mut arg3.pending);
            0x1::vector::push_back<u64>(&mut v24, v26);
            0x1::vector::push_back<u64>(&mut v25, v27);
        };
        let v28 = arg3.terminal && 0x1::vector::is_empty<MakerEndpoint>(&arg3.pending);
        (v24, v25, arg3.lot, arg3.minimum, !v28, arg3.fee, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(), v0, 0x1::vector::length<u64>(&v25), v28)
    }

    public fun current<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool) : (u64, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::none<u64>(), 1, arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = if (0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1) == 0) {
            0
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, 0))
        };
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        (v2, v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling())
    }

    public fun current_unless_selected<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: &vector<bool>) : (u64, u64, u64) {
        let v0 = true;
        if (0x1::vector::contains<bool>(arg2, &v0)) {
            return (0, 0, 1)
        };
        current<T0, T1>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

