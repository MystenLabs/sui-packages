module 0xfadcfbce07264620d6f918645ca6d45853556df5b2c664e195663ad79b4d7a8f::reader {
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
                while (v6 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5)) {
                    let v7 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5, v6);
                    let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v7);
                    assert!(!0x1::option::is_some<u128>(&arg3.last) || v8 != *0x1::option::borrow<u128>(&arg3.last), 801);
                    arg3.last = 0x1::option::some<u128>(v8);
                    if (0x2::clock::timestamp_ms(arg1) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v7)) {
                        let v9 = checked_remaining(v7);
                        if (v9 > 0) {
                            let v10 = MakerEndpoint{
                                price : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v7),
                                base  : v9,
                            };
                            0x1::vector::push_back<MakerEndpoint>(&mut arg3.pending, v10);
                        };
                    };
                    v6 = v6 + 1;
                };
                let v11 = 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v5);
                v0 = v11;
                arg3.raw = arg3.raw + v11;
                let v12 = arg3.raw == 100 || !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v4);
                arg3.terminal = v12;
                0x1::vector::reverse<MakerEndpoint>(&mut arg3.pending);
            };
        };
        let v13 = vector[];
        let v14 = vector[];
        while (0x1::vector::length<u64>(&v14) < arg4 && !0x1::vector::is_empty<MakerEndpoint>(&arg3.pending)) {
            let MakerEndpoint {
                price : v15,
                base  : v16,
            } = 0x1::vector::pop_back<MakerEndpoint>(&mut arg3.pending);
            0x1::vector::push_back<u64>(&mut v13, v15);
            0x1::vector::push_back<u64>(&mut v14, v16);
        };
        let v17 = arg3.terminal && 0x1::vector::is_empty<MakerEndpoint>(&arg3.pending);
        (v13, v14, arg3.lot, arg3.minimum, !v17, arg3.fee, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(), v0, 0x1::vector::length<u64>(&v14), v17)
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

