module 0xf5e594f7e2e76de276549597a69ff4c78ffe15452ffe43d7a1356db7e1fff42f::reader {
    struct Current has drop {
        page: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::OrderPage>,
        price: u64,
        fee: u64,
    }

    struct SeedMaker has drop {
        last: 0x1::option::Option<u128>,
        base: u64,
        price: u64,
        more: bool,
    }

    struct WindowCursor has drop {
        last: 0x1::option::Option<u128>,
        raw: u64,
        terminal: bool,
        seed: 0x1::option::Option<SeedMaker>,
        lot: u64,
        minimum: u64,
        fee: u64,
    }

    public fun after_gate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64) : (vector<u64>, vector<u64>, u64, u64, bool, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::none<u64>(), arg3, arg2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)) {
            let v5 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v4);
            if (0x2::clock::timestamp_ms(arg1) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v5)) {
                let (v6, v7) = remaining(v5);
                if (v6 > 0) {
                    0x1::vector::push_back<u64>(&mut v2, v7);
                    0x1::vector::push_back<u64>(&mut v3, v6);
                };
            };
            v4 = v4 + 1;
        };
        let (_, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v11 = arg3 < 100 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v0);
        let (v12, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        (v2, v3, v9, v10, v11, v12, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling())
    }

    public fun after_gate_if<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: bool) : (vector<u64>, vector<u64>, u64, u64, bool, u64, u64) {
        if (!arg4) {
            return (vector[], vector[], 1, 1, false, 0, 1)
        };
        after_gate<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_from_current<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: &Current) : (WindowCursor, vector<u64>, vector<u64>, u64, u64, bool, u64, u64, u64, u64, bool, bool) {
        let (v0, v1) = if (arg5) {
            let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
            let _ = v2;
            (v3, v4)
        } else {
            let _ = 1;
            (1, 1)
        };
        let v6 = 0x1::option::none<SeedMaker>();
        if (arg5 && 0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::OrderPage>(&arg6.page)) {
            let v7 = 0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::OrderPage>(&arg6.page);
            let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(v7);
            let v9 = if (0x1::vector::is_empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8)) {
                0x1::option::none<u128>()
            } else {
                0x1::option::some<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8, 0)))
            };
            let v10 = if (0x1::vector::is_empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8)) {
                0
            } else {
                let v11 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v8, 0);
                if (0x2::clock::timestamp_ms(arg1) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v11)) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v11) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v11)
                } else {
                    0
                }
            };
            let v12 = SeedMaker{
                last  : v9,
                base  : v10,
                price : arg6.price,
                more  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(v7),
            };
            v6 = 0x1::option::some<SeedMaker>(v12);
        };
        let v13 = WindowCursor{
            last     : 0x1::option::none<u128>(),
            raw      : 0,
            terminal : false,
            seed     : v6,
            lot      : v0,
            minimum  : v1,
            fee      : arg6.fee,
        };
        let v14 = &mut v13;
        let (v15, v16, v17, v18, v19, v20, v21, v22, v23, v24) = continue_if<T0, T1>(arg0, arg1, arg2, v14, 0x1::u64::min(arg3, 1), arg4, arg5);
        let v25 = v16;
        let v26 = if (arg5) {
            let v27 = v24 && 0x1::vector::is_empty<u64>(&v25);
            !v27
        } else {
            false
        };
        (v13, v15, v25, v17, v18, v19, v20, v21, v22, v23, v24, v26)
    }

    public fun begin_from_current_fee<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: u64) : (WindowCursor, vector<u64>, vector<u64>, u64, u64, bool, u64, u64, u64, u64, bool, bool) {
        let v0 = Current{
            page  : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::OrderPage>(),
            price : 0,
            fee   : arg6,
        };
        begin_from_current<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v0)
    }

    public fun begin_if<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (WindowCursor, vector<u64>, vector<u64>, u64, u64, bool, u64, u64, u64, u64, bool, bool) {
        let v0 = if (arg5) {
            let (v1, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
            v1
        } else {
            0
        };
        begin_from_current_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v0)
    }

    public fun continue_if<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut WindowCursor, arg4: u64, arg5: u64, arg6: bool) : (vector<u64>, vector<u64>, u64, u64, bool, u64, u64, u64, u64, bool) {
        if (!arg6) {
            return (vector[], vector[], 1, 1, false, 0, 1, 0, 0, false)
        };
        let v0 = 0;
        let v1 = vector[];
        let v2 = vector[];
        loop {
            let v3 = if (0x1::vector::length<u64>(&v2) < arg4) {
                if (v0 < arg5) {
                    !arg3.terminal
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                if (0x1::option::is_some<SeedMaker>(&arg3.seed)) {
                    let SeedMaker {
                        last  : v4,
                        base  : v5,
                        price : v6,
                        more  : v7,
                    } = 0x1::option::extract<SeedMaker>(&mut arg3.seed);
                    let v8 = v4;
                    if (0x1::option::is_some<u128>(&v8)) {
                        v0 = v0 + 1;
                        arg3.raw = arg3.raw + 1;
                    };
                    if (v5 > 0) {
                        0x1::vector::push_back<u64>(&mut v1, v6);
                        0x1::vector::push_back<u64>(&mut v2, v5);
                    };
                    arg3.last = v8;
                    arg3.terminal = !v7;
                    continue
                };
                let v9 = if (0x1::option::is_some<u128>(&arg3.last) && !arg2) {
                    0x1::option::some<u128>(*0x1::option::borrow<u128>(&arg3.last) + 1)
                } else {
                    arg3.last
                };
                let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, v9, 0x1::option::none<u128>(), 0x1::option::none<u64>(), 0x1::u64::min(0x1::u64::min(arg4 - 0x1::vector::length<u64>(&v2), arg5 - v0), 100 - arg3.raw), arg2);
                let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v10);
                let v12 = 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v11);
                let v13 = 0;
                while (v13 < v12) {
                    let v14 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v11, v13);
                    if (0x2::clock::timestamp_ms(arg1) <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v14)) {
                        let (v15, v16) = remaining(v14);
                        if (v15 > 0) {
                            0x1::vector::push_back<u64>(&mut v1, v16);
                            0x1::vector::push_back<u64>(&mut v2, v15);
                        };
                    };
                    v13 = v13 + 1;
                };
                if (v13 > 0) {
                    arg3.last = 0x1::option::some<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v11, v13 - 1)));
                };
                v0 = v0 + v12;
                arg3.raw = arg3.raw + v12;
                let v17 = arg3.raw == 100 || !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::has_next_page(&v10);
                arg3.terminal = v17;
            } else {
                break
            };
        };
        (v1, v2, arg3.lot, arg3.minimum, !arg3.terminal, arg3.fee, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(), v0, 0x1::vector::length<u64>(&v2), arg3.terminal)
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

    public fun current_cached<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool) : (u64, u64, u64, Current) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::none<u64>(), 1, arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = if (0x1::vector::is_empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)) {
            0
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, 0))
        };
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v6 = Current{
            page  : 0x1::option::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::OrderPage>(v0),
            price : v2,
            fee   : v3,
        };
        (v2, v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(), v6)
    }

    public fun current_cached_unless_selected<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: &vector<bool>) : (u64, u64, u64, Current) {
        let v0 = true;
        if (0x1::vector::contains<bool>(arg2, &v0)) {
            let v1 = Current{
                page  : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::OrderPage>(),
                price : 0,
                fee   : 0,
            };
            return (0, 0, 1, v1)
        };
        current_cached<T0, T1>(arg0, arg1)
    }

    public fun current_unless_selected<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: &vector<bool>) : (u64, u64, u64) {
        let v0 = true;
        if (0x1::vector::contains<bool>(arg2, &v0)) {
            return (0, 0, 1)
        };
        current<T0, T1>(arg0, arg1)
    }

    fun remaining(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order) : (u64, u64) {
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(arg0) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(arg0))
    }

    public fun resume<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut WindowCursor, arg4: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: u64) {
        let (v0, v1, v2, v3) = 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_book_request(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v4 = v3;
        if (!v2) {
            return
        };
        let v5 = 0;
        let v6 = vector[];
        let v7 = vector[];
        let v8 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::book_read_demand_is_covered(&v4);
        loop {
            let v9 = if (0x1::vector::length<u64>(&v7) < v0) {
                if (v5 < v1) {
                    if (!arg3.terminal) {
                        !v8
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                let (v10, v11, _, _, _, _, _, v17, _, _) = continue_if<T0, T1>(arg0, arg1, arg2, arg3, 1, v1 - v5, true);
                let v20 = v11;
                let v21 = v10;
                v5 = v5 + v17;
                if (!0x1::vector::is_empty<u64>(&v20)) {
                    v8 = 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::book_read_demand_step(&mut v4, arg2, (*0x1::vector::borrow<u64>(&v21, 0) as u128), (*0x1::vector::borrow<u64>(&v20, 0) as u128), (arg3.lot as u128));
                    0x1::vector::append<u64>(&mut v6, v21);
                    0x1::vector::append<u64>(&mut v7, v20);
                };
            } else {
                break
            };
        };
        let _ = arg3.lot;
        let _ = arg3.minimum;
        let _ = arg3.fee;
        let _ = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling();
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_book_run(arg4, arg5, v6, v7, !arg3.terminal, v5, 0x1::vector::length<u64>(&v7), arg3.terminal, true);
    }

    // decompiled from Move bytecode v7
}

