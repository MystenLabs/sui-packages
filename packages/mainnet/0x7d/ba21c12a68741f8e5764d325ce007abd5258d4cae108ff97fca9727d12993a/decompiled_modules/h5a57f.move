module 0x7dba21c12a68741f8e5764d325ce007abd5258d4cae108ff97fca9727d12993a::h5a57f {
    public fun h104d2(arg0: u128) : u64 {
        ((arg0 & (18446744073709551615 as u128)) as u64)
    }

    public fun h321c0(arg0: u128) : u64 {
        if (he7a1a(arg0)) {
            ((arg0 >> 64 & (18446744073709551615 as u128)) as u64)
        } else {
            ((arg0 >> 64 & (18446744073709551615 as u128)) as u64) ^ 18446744073709551615
        }
    }

    public(friend) fun h51d57(arg0: &vector<u64>, arg1: u64, arg2: bool) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 == 0) {
            return 0
        };
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            if (arg2 && v2 >= arg1) {
                return v2
            };
            if (!arg2 && v2 <= arg1) {
                return v2
            };
        };
        0
    }

    public(friend) fun h646df(arg0: bool, arg1: u64, arg2: u64, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<u64>) : 0x1::option::Option<u64> {
        if (arg0) {
            if (0x1::option::is_some<u64>(arg4) && arg1 >= *0x1::option::borrow<u64>(arg4)) {
                let v0 = *0x1::option::borrow<u64>(arg4);
                if (v0 <= arg2) {
                    return 0x1::option::none<u64>()
                };
                return 0x1::option::some<u64>(v0 - arg2)
            };
        } else if (0x1::option::is_some<u64>(arg3) && arg1 <= *0x1::option::borrow<u64>(arg3)) {
            let v1 = *0x1::option::borrow<u64>(arg3);
            if (v1 > 18446744073709551615 - arg2) {
                return 0x1::option::none<u64>()
            };
            return 0x1::option::some<u64>(v1 + arg2)
        };
        0x1::option::some<u64>(arg1)
    }

    public(friend) fun h85f29<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : (u64, u64, u256, u64) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_pending_orders(v0))
    }

    public(friend) fun h8da4b(arg0: bool, arg1: u64, arg2: u64, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<u64>, arg5: u64, arg6: &vector<u64>) : 0x1::option::Option<u64> {
        let v0 = h646df(arg0, arg1, arg2, arg3, arg4);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0x1::option::extract<u64>(&mut v0);
        0x1::option::some<u64>(h93c4a(arg2, v1, arg0, arg3, arg4, arg5, h51d57(arg6, v1, arg0)))
    }

    public(friend) fun h93c4a(arg0: u64, arg1: u64, arg2: bool, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<u64>, arg5: u64, arg6: u64) : u64 {
        let v0 = arg1;
        if (arg2) {
            let v1 = if (arg6 > 0) {
                if (arg5 > 0) {
                    arg1 <= arg6
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                if (((arg6 - arg1) as u128) * (10000 as u128) <= (arg1 as u128) * (arg5 as u128)) {
                    let v2 = arg6 + arg0;
                    v0 = v2;
                    if (0x1::option::is_some<u64>(arg4)) {
                        let v3 = *0x1::option::borrow<u64>(arg4);
                        if (v2 >= v3 && v3 >= arg0) {
                            v0 = v3 - arg0;
                        };
                    };
                };
            };
        } else {
            let v4 = if (arg6 > 0) {
                if (arg5 > 0) {
                    if (arg6 > arg0) {
                        arg1 >= arg6
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                if (((arg1 - arg6) as u128) * (10000 as u128) <= (arg1 as u128) * (arg5 as u128)) {
                    let v5 = arg6 - arg0;
                    v0 = v5;
                    if (0x1::option::is_some<u64>(arg3)) {
                        let v6 = *0x1::option::borrow<u64>(arg3);
                        if (v5 <= v6 && v6 <= 18446744073709551615 - arg0) {
                            v0 = v6 + arg0;
                        };
                    };
                };
            };
        };
        v0
    }

    public(friend) fun h9aa0e(arg0: u64, arg1: u64) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public(friend) fun hae3b3<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : vector<u64> {
        let (v0, v1) = if (arg4) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::inspect_orders(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(arg0), false, 18446744073709551615, 0, arg2)
        } else {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::inspect_orders(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(arg0), true, 0, 18446744073709551615, arg2)
        };
        let v2 = v1;
        let v3 = v0;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v2)) {
            let (v6, _, _, v9, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::as_parts(0x1::vector::borrow<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v2, v5));
            let v12 = v9;
            if (v6 == arg1 && hb57ae(&v12, arg3)) {
                0x1::vector::push_back<u64>(&mut v4, h321c0(*0x1::vector::borrow<u128>(&v3, v5)));
            };
            v5 = v5 + 1;
        };
        v4
    }

    public(friend) fun hb3f96(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: &0x1::option::Option<u64>, arg5: &0x1::option::Option<u64>, arg6: u64, arg7: &vector<u64>) : u64 {
        let v0 = h8da4b(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::extract<u64>(&mut v0);
            if (v1 < 9223372036854775808) {
                return v1
            };
        };
        arg2
    }

    fun hb57ae(arg0: &0x1::option::Option<u64>, arg1: u64) : bool {
        0x1::option::is_none<u64>(arg0) || *0x1::option::borrow<u64>(arg0) > arg1
    }

    public(friend) fun he2d3a(arg0: &vector<u64>, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(arg0) == 0) {
            0
        } else {
            *0x1::vector::borrow<u64>(arg0, arg1)
        }
    }

    public fun he7a1a(arg0: u128) : bool {
        arg0 < 170141183460469231731687303715884105728
    }

    public(friend) fun hfa5fc<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, false), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, true))
    }

    // decompiled from Move bytecode v7
}

