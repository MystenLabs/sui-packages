module 0x2e7958607c372640eeaecf31f91ea0ab2b1d3d1e9c6123e7cbd16fdf88726177::h5a57f {
    struct Hd5c55 has drop {
        h5db44: vector<u64>,
        hdc42c: bool,
    }

    public(friend) fun h0b187(arg0: bool, arg1: u64, arg2: u64) : u64 {
        let v0 = he25be(arg1, arg2);
        if (arg0) {
            if (arg1 + v0 < 9223372036854775808) {
                arg1 + v0
            } else {
                9223372036854775808 - 1
            }
        } else {
            arg1 - v0
        }
    }

    public fun h104d2(arg0: u128) : u64 {
        ((arg0 & (18446744073709551615 as u128)) as u64)
    }

    public(friend) fun h177aa(arg0: u64) : bool {
        arg0 > 0 && arg0 < 9223372036854775808
    }

    fun h2fc02(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (hf70c2(arg0, arg1, arg2)) {
            arg1
        } else {
            arg2
        }
    }

    public fun h321c0(arg0: u128) : u64 {
        if (he7a1a(arg0)) {
            ((arg0 >> 64 & (18446744073709551615 as u128)) as u64)
        } else {
            ((arg0 >> 64 & (18446744073709551615 as u128)) as u64) ^ 18446744073709551615
        }
    }

    fun h3fe72(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (hf70c2(arg0, arg1, arg2)) {
            arg2
        } else {
            arg1
        }
    }

    fun h4359f(arg0: bool, arg1: &vector<u64>, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            if (hf70c2(arg0, arg2, v1)) {
                return 0x1::option::some<u64>(v1)
            };
        };
        0x1::option::none<u64>()
    }

    public(friend) fun h5255e<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u256) : Hd5c55 {
        let (v0, v1) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::inspect_orders(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(arg0), !arg4, arg5, arg6, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::length<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v2);
        let v5 = v4 > 0 && (v4 >= arg2 || v4 >= 50);
        let v6 = Hd5c55{
            h5db44 : vector[],
            hdc42c : v5,
        };
        let v7 = 0;
        let v8 = v7;
        let v9 = 0;
        let v10 = 0;
        while (v10 < v4) {
            let (v11, v12, _, v14, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::as_parts(0x1::vector::borrow<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v2, v10));
            let v17 = v14;
            let v18 = h321c0(*0x1::vector::borrow<u128>(&v3, v10));
            v10 = v10 + 1;
            if (v18 != v7) {
                let v19 = &mut v6;
                h7653c(v19, v7, v9, arg7, arg8);
                v8 = v18;
                v9 = 0;
            };
            if (v11 != arg1 && hb57ae(&v17, arg3)) {
                v9 = v9 + (v12 as u256);
            };
        };
        let v20 = &mut v6;
        h7653c(v20, v8, v9, arg7, arg8);
        v6
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

    public(friend) fun h6c1ab(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (arg0) {
            arg1 - arg2
        } else {
            arg1 + arg2
        }
    }

    fun h7653c(arg0: &mut Hd5c55, arg1: u64, arg2: u256, arg3: u64, arg4: u256) {
        if (arg1 == 0 || arg2 == 0) {
            return
        };
        if (arg2 * (arg3 as u256) >= arg4) {
            0x1::vector::push_back<u64>(&mut arg0.h5db44, arg1);
        };
    }

    fun h7af1a(arg0: bool, arg1: &vector<u64>, arg2: u64, arg3: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            if (hf70c2(arg0, v1, arg3)) {
                continue
            };
            if (hdbab2(arg0, v1, arg2)) {
                return 0x1::option::some<u64>(v1)
            };
            return 0x1::option::none<u64>()
        };
        0x1::option::none<u64>()
    }

    public(friend) fun h85f29<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : (u64, u64, u256, u64) {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::tick_size(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::min_order_usd_value(v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::max_pending_orders(v0))
    }

    public(friend) fun h94f75(arg0: u64) : u64 {
        (9223372036854775808 - 1) / arg0 * arg0
    }

    public(friend) fun h9aa0e(arg0: u64, arg1: u64) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    fun hb24b4(arg0: bool, arg1: u64, arg2: u64) : u64 {
        if (arg0) {
            arg1 + arg2
        } else {
            arg1 - arg2
        }
    }

    fun hb57ae(arg0: &0x1::option::Option<u64>, arg1: u64) : bool {
        0x1::option::is_none<u64>(arg0) || *0x1::option::borrow<u64>(arg0) > arg1
    }

    public(friend) fun hc125e(arg0: bool, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<bool>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &Hd5c55, arg9: &0x1::option::Option<u64>) : vector<u64> {
        assert!(0x1::vector::length<u64>(arg2) == 0x1::vector::length<u64>(arg1), 538);
        assert!(0x1::vector::length<bool>(arg3) == 0x1::vector::length<u64>(arg1), 538);
        let v0 = 0x1::vector::length<u64>(arg1);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0x1::option::none<u64>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(arg1, v4);
            let v6 = *0x1::vector::borrow<u64>(arg2, v4);
            let v7 = v4 + 1;
            v4 = v7;
            if (v5 == 0) {
                0x1::vector::push_back<u64>(&mut v1, 0);
                0x1::vector::push_back<bool>(&mut v2, false);
                continue
            };
            let v8 = h0b187(arg0, v5, v6);
            let v9 = v8;
            if (0x1::option::is_some<u64>(&v3)) {
                v9 = h3fe72(arg0, v8, *0x1::option::borrow<u64>(&v3));
            };
            let v10 = v5;
            let v11 = if (!arg4 || v6 == 0) {
                0x1::option::none<u64>()
            } else {
                h7af1a(arg0, &arg8.h5db44, v5, v9)
            };
            let v12 = v11;
            if (0x1::option::is_some<u64>(&v12)) {
                let v13 = *0x1::option::borrow<u64>(&v12);
                if (!arg0 && v13 <= arg7 || arg0 && v13 >= h94f75(arg7)) {
                    v12 = 0x1::option::none<u64>();
                };
            };
            if (0x1::option::is_some<u64>(&v12)) {
                let v14 = hb24b4(arg0, 0x1::option::extract<u64>(&mut v12), arg7);
                v10 = v14;
                if (0x1::option::is_some<u64>(arg9)) {
                    let v15 = *0x1::option::borrow<u64>(arg9);
                    if (hdbab2(arg0, v14, v15)) {
                        v10 = h6c1ab(arg0, v15, arg7);
                    };
                };
                0x1::vector::push_back<bool>(&mut v2, true);
            } else {
                0x1::vector::push_back<bool>(&mut v2, false);
            };
            0x1::vector::push_back<u64>(&mut v1, v10);
            if (!*0x1::vector::borrow<bool>(arg3, v7 - 1)) {
                continue
            };
            let v16 = if (arg0) {
                if (v10 > 2 * arg7) {
                    v10 - 2 * arg7
                } else {
                    0
                }
            } else if (v10 < 18446744073709551615 - 2 * arg7) {
                v10 + 2 * arg7
            } else {
                18446744073709551615
            };
            v3 = 0x1::option::some<u64>(v16);
        };
        let v17 = 0x1::option::none<u64>();
        while (v0 > 0) {
            let v18 = v0 - 1;
            v0 = v18;
            let v19 = *0x1::vector::borrow<u64>(arg1, v18);
            if (v19 == 0) {
                continue
            };
            if (arg5 && !*0x1::vector::borrow<bool>(&v2, v18)) {
                let v20 = h4359f(arg0, &arg8.h5db44, v19);
                if (!arg8.hdc42c || 0x1::option::is_some<u64>(&v20)) {
                    let v21 = he6d7f(arg0, v19, arg6, arg7);
                    let v22 = v21;
                    if (0x1::option::is_some<u64>(&v20)) {
                        v22 = h2fc02(arg0, v21, hb24b4(arg0, 0x1::option::extract<u64>(&mut v20), arg7));
                    };
                    if (0x1::option::is_some<u64>(&v17)) {
                        v22 = h2fc02(arg0, v22, hb24b4(arg0, *0x1::option::borrow<u64>(&v17), arg7));
                    };
                    *0x1::vector::borrow_mut<u64>(&mut v1, v18) = h3fe72(arg0, v22, v19);
                };
            };
            if (*0x1::vector::borrow<bool>(arg3, v18)) {
                v17 = 0x1::option::some<u64>(*0x1::vector::borrow<u64>(&v1, v18));
            };
        };
        v1
    }

    public(friend) fun hcaf28(arg0: u64, arg1: u64) : bool {
        h177aa(arg0) && arg0 % arg1 == 0
    }

    fun hdbab2(arg0: bool, arg1: u64, arg2: u64) : bool {
        arg0 && arg1 >= arg2 || arg1 <= arg2
    }

    public(friend) fun he25be(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun he6d7f(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0) {
            (arg1 - he25be(arg1, arg2) + arg3 - 1) / arg3 * arg3
        } else {
            let v1 = (arg1 + he25be(arg1, arg2)) / arg3 * arg3;
            let v2 = h94f75(arg3);
            if (v1 < v2) {
                v1
            } else {
                v2
            }
        }
    }

    public fun he7a1a(arg0: u128) : bool {
        arg0 < 170141183460469231731687303715884105728
    }

    fun hf70c2(arg0: bool, arg1: u64, arg2: u64) : bool {
        arg0 && arg1 > arg2 || arg1 < arg2
    }

    public(friend) fun hfa5fc<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, false), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::best_price_u64<T0>(arg0, true))
    }

    // decompiled from Move bytecode v7
}

