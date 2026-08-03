module 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::hd4b1f {
    struct H2226f has drop {
        h0ae7c: vector<u64>,
        h4698d: vector<u64>,
        h50183: vector<u64>,
        hfbcb3: bool,
    }

    struct H5fd6f has drop {
        h8b8ea: vector<u128>,
        h5db44: vector<u64>,
        hf2776: vector<u64>,
        h78bcb: vector<0x1::option::Option<u64>>,
        h914ca: vector<bool>,
        hbdc54: vector<bool>,
    }

    fun h0009d(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg0 == 0 || arg0 >= 9223372036854775808) {
            return 502
        };
        if (arg1 == 0) {
            return 503
        };
        if (arg0 % arg4 != 0) {
            return 504
        };
        if (arg1 % arg5 != 0) {
            return 505
        };
        if (arg2 != 0 && arg2 <= arg3) {
            return 506
        };
        0
    }

    fun h2b96a(arg0: bool, arg1: u64, arg2: &0x1::option::Option<u64>) : bool {
        if (0x1::option::is_none<u64>(arg2)) {
            return false
        };
        arg0 && arg1 >= *0x1::option::borrow<u64>(arg2) || arg1 <= *0x1::option::borrow<u64>(arg2)
    }

    public(friend) fun h350bd(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::Orderbook, arg1: &mut vector<0x1::option::Option<u128>>) : H5fd6f {
        0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h21ed2(arg1);
        let v0 = H5fd6f{
            h8b8ea : vector[],
            h5db44 : vector[],
            hf2776 : vector[],
            h78bcb : 0x1::vector::empty<0x1::option::Option<u64>>(),
            h914ca : vector[],
            hbdc54 : vector[],
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<u128>>(arg1)) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<u128>>(arg1, v1);
            if (0x1::option::is_some<u128>(v2)) {
                let v3 = 0x1::option::extract<u128>(v2);
                let v4 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::get_order(arg0, v3);
                if (0x1::option::is_some<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::Order>(&v4)) {
                    let v5 = 0x1::option::extract<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::Order>(&mut v4);
                    let (_, v7, _, v9, _, _) = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::orderbook::as_parts(&v5);
                    0x1::vector::push_back<u128>(&mut v0.h8b8ea, v3);
                    0x1::vector::push_back<u64>(&mut v0.h5db44, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h321c0(v3));
                    0x1::vector::push_back<u64>(&mut v0.hf2776, v7);
                    0x1::vector::push_back<0x1::option::Option<u64>>(&mut v0.h78bcb, v9);
                    0x1::vector::push_back<bool>(&mut v0.h914ca, false);
                    0x1::vector::push_back<bool>(&mut v0.hbdc54, false);
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun h47e0e(arg0: &H2226f, arg1: u64) : bool {
        *0x1::vector::borrow<u64>(&arg0.h0ae7c, arg1) == 0
    }

    fun h5cc3a(arg0: bool, arg1: u64, arg2: &0x1::option::Option<u64>, arg3: &0x1::option::Option<u64>) : u64 {
        if (arg0) {
            if (0x1::option::is_none<u64>(arg3)) {
                return 515
            };
            if (arg1 < *0x1::option::borrow<u64>(arg3)) {
                return 516
            };
        } else {
            if (0x1::option::is_none<u64>(arg2)) {
                return 515
            };
            if (arg1 > *0x1::option::borrow<u64>(arg2)) {
                return 516
            };
        };
        0
    }

    public(friend) fun h5de86(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 509);
        assert!(arg1 > 0, 509);
    }

    public(friend) fun h60fb1(arg0: &mut H5fd6f, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: &0x1::option::Option<u64>, arg15: &0x1::option::Option<u64>, arg16: u64, arg17: &mut u256, arg18: &mut vector<u64>, arg19: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            let v2 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h8da4b(arg11, *0x1::vector::borrow<u64>(arg2, v1), arg12, arg14, arg15, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::he2d3a(arg6, v1), arg7);
            if (0x1::option::is_none<u64>(&v2)) {
                0x1::vector::push_back<u64>(arg18, v1);
                continue
            };
            let v3 = 0x1::option::extract<u64>(&mut v2);
            let v4 = *0x1::vector::borrow<u64>(arg3, v1);
            if (h0009d(v3, v4, *0x1::vector::borrow<u64>(arg4, v1), arg10, arg12, arg13) != 0) {
                0x1::vector::push_back<u64>(arg18, v1);
                continue
            };
            let v5 = false;
            let v6 = false;
            let v7 = 0;
            while (v7 < 0x1::vector::length<u128>(&arg0.h8b8ea)) {
                if (!*0x1::vector::borrow<bool>(&arg0.h914ca, v7) && !*0x1::vector::borrow<bool>(&arg0.hbdc54, v7)) {
                    let v8 = 0x1::option::is_none<u64>(0x1::vector::borrow<0x1::option::Option<u64>>(&arg0.h78bcb, v7)) || *0x1::option::borrow<u64>(0x1::vector::borrow<0x1::option::Option<u64>>(&arg0.h78bcb, v7)) > arg10 + arg9;
                    let v9 = (*0x1::vector::borrow<u64>(&arg0.hf2776, v7) as u128);
                    let v10 = v9 >= (v4 as u128) * ((100 - arg8) as u128) / 100 && v9 <= (v4 as u128) * ((100 + arg8) as u128) / 100;
                    let v11 = if (ha1d56(v3, *0x1::vector::borrow<u64>(&arg0.h5db44, v7)) <= *0x1::vector::borrow<u64>(arg5, v1)) {
                        if (v8) {
                            v10
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v11) {
                        let v12 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(*0x1::vector::borrow<u64>(&arg0.hf2776, v7), arg16);
                        if (v12 > *arg17) {
                            v6 = true;
                        } else {
                            *arg17 = *arg17 - v12;
                            *0x1::vector::borrow_mut<bool>(&mut arg0.h914ca, v7) = true;
                            v5 = true;
                            break
                        };
                    };
                };
                v7 = v7 + 1;
            };
            if (!v5) {
                if (v6) {
                    0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(531, v1, arg19);
                };
                0x1::vector::push_back<u64>(arg18, v1);
            };
        };
    }

    public(friend) fun h6fefe(arg0: &H2226f, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.h4698d, arg1)
    }

    public(friend) fun h78a5d(arg0: u64) : vector<bool> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun h8befd(arg0: &H2226f, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.h50183, arg1)
    }

    public(friend) fun h966c3(arg0: u64, arg1: &vector<u64>, arg2: &vector<u64>, arg3: u64) {
        assert!(0x1::vector::length<u64>(arg1) == arg0, 501);
        assert!(0x1::vector::length<u64>(arg2) == 0 || 0x1::vector::length<u64>(arg2) == arg0, 501);
        assert!(arg3 <= 100, 520);
    }

    public(friend) fun h9a7dc(arg0: &mut H5fd6f, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            v0 = v0 + 1;
            let v2 = *0x1::vector::borrow<u64>(arg2, v1);
            if (h0009d(v2, *0x1::vector::borrow<u64>(arg3, v1), *0x1::vector::borrow<u64>(arg4, v1), arg5, arg6, arg7) != 0) {
                continue
            };
            let v3 = 0;
            while (v3 < 0x1::vector::length<u128>(&arg0.h8b8ea)) {
                if (arg8 && v2 <= *0x1::vector::borrow<u64>(&arg0.h5db44, v3) || v2 >= *0x1::vector::borrow<u64>(&arg0.h5db44, v3)) {
                    *0x1::vector::borrow_mut<bool>(&mut arg0.hbdc54, v3) = true;
                };
                v3 = v3 + 1;
            };
            return
        };
    }

    public(friend) fun h9ef43(arg0: &vector<u64>, arg1: &mut vector<bool>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = *0x1::vector::borrow<u64>(arg0, v0);
            assert!(v1 < 0x1::vector::length<bool>(arg1), 508);
            let v2 = 0x1::vector::borrow_mut<bool>(arg1, v1);
            assert!(!*v2, 529);
            *v2 = true;
            v0 = v0 + 1;
        };
    }

    fun ha1d56(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    fun hae607(arg0: u64, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u256) : u64 {
        hbecec(*0x1::vector::borrow<u64>(arg1, arg0), *0x1::vector::borrow<u64>(arg2, arg0), *0x1::vector::borrow<u64>(arg3, arg0), arg4, arg5, arg6, arg7)
    }

    public(friend) fun hb430b(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(0x1::vector::length<u64>(arg1) == v0, 501);
        assert!(0x1::vector::length<u64>(arg2) == v0, 501);
    }

    fun hbecec(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256) : u64 {
        let v0 = h0009d(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 != 0) {
            return v0
        };
        if (arg6 > 0 && 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(arg1, arg0) < arg6) {
            return 507
        };
        0
    }

    public(friend) fun hca436(arg0: &vector<u64>, arg1: bool, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: u64, arg8: u64, arg9: u64, arg10: u256, arg11: &0x1::option::Option<u64>, arg12: &0x1::option::Option<u64>, arg13: u64, arg14: &mut u256, arg15: u256, arg16: u64) : H2226f {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(arg0)) {
            let v5 = *0x1::vector::borrow<u64>(arg0, v4);
            v4 = v4 + 1;
            let v6 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h8da4b(arg1, *0x1::vector::borrow<u64>(arg2, v5), arg8, arg11, arg12, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::he2d3a(arg5, v5), arg6);
            if (0x1::option::is_none<u64>(&v6)) {
                0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(517, v5, arg16);
                0x1::vector::push_back<u64>(&mut v0, 517);
                0x1::vector::push_back<u64>(&mut v1, 0);
                0x1::vector::push_back<u64>(&mut v2, 0);
                continue
            };
            let v7 = 0x1::option::extract<u64>(&mut v6);
            let v8 = h0009d(v7, *0x1::vector::borrow<u64>(arg3, v5), *0x1::vector::borrow<u64>(arg4, v5), arg7, arg8, arg9);
            let v9 = v8;
            let v10 = 0;
            if (v8 == 0) {
                if (*arg14 < arg15) {
                    v9 = 526;
                } else {
                    let v11 = *0x1::vector::borrow<u64>(arg3, v5);
                    let v12 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v11, arg13);
                    if (v12 <= *arg14) {
                        if (arg10 > 0 && v12 < arg10) {
                            v9 = 507;
                        } else {
                            v10 = v11;
                            *arg14 = *arg14 - v12;
                        };
                    } else {
                        let v13 = ((*arg14 / (arg13 as u256)) as u64) / arg9 * arg9;
                        *arg14 = 0;
                        if (v13 == 0 || arg10 > 0 && 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v13, arg13) < arg10) {
                            v9 = 526;
                        } else {
                            v10 = v13;
                        };
                    };
                };
            };
            if (v9 != 0) {
                0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(v9, v5, arg16);
                v10 = 0;
            } else {
                v3 = true;
            };
            0x1::vector::push_back<u64>(&mut v0, v9);
            0x1::vector::push_back<u64>(&mut v1, v7);
            0x1::vector::push_back<u64>(&mut v2, v10);
        };
        H2226f{
            h0ae7c : v0,
            h4698d : v1,
            h50183 : v2,
            hfbcb3 : v3,
        }
    }

    public(friend) fun hde79f(arg0: &vector<u64>, arg1: bool, arg2: bool, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: u64, arg7: u64, arg8: u64, arg9: u256, arg10: &0x1::option::Option<u64>, arg11: &0x1::option::Option<u64>, arg12: &0x1::option::Option<u64>, arg13: u64, arg14: &mut u256, arg15: u64) : H2226f {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = false;
        let v3 = 0;
        let v4 = 0x1::option::is_some<u64>(arg12);
        let v5 = if (arg1) {
            0x1::vector::length<u64>(arg3)
        } else {
            0x1::vector::length<u64>(arg0)
        };
        let v6 = 0;
        while (v6 < v5) {
            let v7 = if (arg1) {
                v6
            } else {
                *0x1::vector::borrow<u64>(arg0, v6)
            };
            v6 = v6 + 1;
            if (v3 != 0) {
                0x1::vector::push_back<u64>(&mut v0, v3);
                0x1::vector::push_back<u64>(&mut v1, 0);
                continue
            };
            let v8 = hae607(v7, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
            let v9 = v8;
            if (v8 == 0) {
                let v10 = *0x1::vector::borrow<u64>(arg3, v7);
                if (v4 && h2b96a(arg2, v10, arg12)) {
                    v9 = 535;
                } else {
                    v4 = false;
                    let v11 = h5cc3a(arg2, v10, arg10, arg11);
                    v9 = v11;
                    if (v11 == 515 || v11 == 516) {
                        v3 = v11;
                    };
                };
            };
            let v12 = 0;
            if (v9 == 0) {
                let v13 = *0x1::vector::borrow<u64>(arg4, v7);
                let v14 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v13, arg13);
                if (v14 <= *arg14) {
                    v12 = v13;
                    *arg14 = *arg14 - v14;
                } else {
                    let v15 = ((*arg14 / (arg13 as u256)) as u64) / arg8 * arg8;
                    *arg14 = 0;
                    if (v15 == 0 || arg9 > 0 && 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v15, *0x1::vector::borrow<u64>(arg3, v7)) < arg9) {
                        v9 = 526;
                    } else {
                        v12 = v15;
                    };
                };
            };
            if (v9 != 0) {
                0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h1ec67::h67a26(v9, v7, arg15);
                v12 = 0;
            } else {
                v2 = true;
            };
            0x1::vector::push_back<u64>(&mut v0, v9);
            0x1::vector::push_back<u64>(&mut v1, v12);
        };
        H2226f{
            h0ae7c : v0,
            h4698d : vector[],
            h50183 : v1,
            hfbcb3 : v2,
        }
    }

    public(friend) fun he3d6c(arg0: &H5fd6f, arg1: &mut vector<0x1::option::Option<u128>>, arg2: &mut vector<u128>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u128>(&arg0.h8b8ea)) {
            if (*0x1::vector::borrow<bool>(&arg0.h914ca, v0)) {
                0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h88a9c(arg1, *0x1::vector::borrow<u128>(&arg0.h8b8ea, v0));
            } else {
                0x1::vector::push_back<u128>(arg2, *0x1::vector::borrow<u128>(&arg0.h8b8ea, v0));
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun hecae9(arg0: &H5fd6f, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0.h8b8ea)) {
            v0 = v0 + 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(*0x1::vector::borrow<u64>(&arg0.hf2776, v1), arg1);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun hfbcb3(arg0: &H2226f) : bool {
        arg0.hfbcb3
    }

    // decompiled from Move bytecode v7
}

