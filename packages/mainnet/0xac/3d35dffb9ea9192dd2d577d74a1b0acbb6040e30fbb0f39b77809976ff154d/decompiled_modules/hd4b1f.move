module 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::hd4b1f {
    struct H2226f has drop {
        h0ae7c: vector<u64>,
        hccaa9: vector<u64>,
        h50183: vector<u64>,
        hfbcb3: bool,
    }

    fun h0009d(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (!0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h177aa(arg0)) {
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

    public(friend) fun h8f41a(arg0: &mut H2226f, arg1: &vector<u64>) {
        assert!(0x1::vector::length<u64>(arg1) == 0x1::vector::length<u64>(&arg0.hccaa9), 501);
        arg0.hccaa9 = *arg1;
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

    fun hae607(arg0: u64, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u256) : u64 {
        hbecec(*0x1::vector::borrow<u64>(arg1, arg0), *0x1::vector::borrow<u64>(arg2, arg0), *0x1::vector::borrow<u64>(arg3, arg0), arg4, arg5, arg6, arg7)
    }

    public(friend) fun hb430b(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(0x1::vector::length<u64>(arg1) == v0, 501);
        assert!(0x1::vector::length<u64>(arg2) == v0, 501);
    }

    public(friend) fun hbb1ea(arg0: &vector<u64>, arg1: &vector<u64>, arg2: bool) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
            let v3 = 0x1::vector::length<u64>(&v0);
            while (v3 > 0) {
                let v4 = arg2 && *0x1::vector::borrow<u64>(arg1, *0x1::vector::borrow<u64>(&v0, v3 - 1)) < *0x1::vector::borrow<u64>(arg1, v2) || *0x1::vector::borrow<u64>(arg1, *0x1::vector::borrow<u64>(&v0, v3 - 1)) > *0x1::vector::borrow<u64>(arg1, v2);
                if (!v4) {
                    break
                };
                v3 = v3 - 1;
            };
            0x1::vector::insert<u64>(&mut v0, v2, v3);
        };
        v0
    }

    fun hbecec(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u256) : u64 {
        let v0 = h0009d(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 != 0) {
            return v0
        };
        if (arg6 > 0 && 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h9aa0e(arg1, arg0) < arg6) {
            return 507
        };
        0
    }

    public(friend) fun hbfc36() : H2226f {
        H2226f{
            h0ae7c : vector[],
            hccaa9 : vector[],
            h50183 : vector[],
            hfbcb3 : false,
        }
    }

    public(friend) fun hca436(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u64, arg5: u64, arg6: u64, arg7: u256, arg8: u64, arg9: &mut u256, arg10: u256, arg11: u64) : H2226f {
        assert!(0x1::vector::length<u64>(arg1) == 0x1::vector::length<u64>(arg0), 501);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(arg0)) {
            let v5 = *0x1::vector::borrow<u64>(arg0, v4);
            let v6 = *0x1::vector::borrow<u64>(arg1, v4);
            let v7 = *0x1::vector::borrow<u64>(arg2, v5);
            v4 = v4 + 1;
            if (v6 == 0) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(517, v5, arg11);
                0x1::vector::push_back<u64>(&mut v0, 517);
                0x1::vector::push_back<u64>(&mut v1, 0);
                0x1::vector::push_back<u64>(&mut v2, 0);
                continue
            };
            let v8 = h0009d(v6, v7, *0x1::vector::borrow<u64>(arg3, v5), arg4, arg5, arg6);
            let v9 = v8;
            let v10 = 0;
            if (v8 == 0) {
                if (*arg9 < arg10) {
                    v9 = 526;
                } else {
                    let v11 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h9aa0e(v7, arg8);
                    if (v11 <= *arg9) {
                        if (arg7 > 0 && v11 < arg7) {
                            v9 = 507;
                        } else {
                            v10 = v7;
                            *arg9 = *arg9 - v11;
                        };
                    } else {
                        let v12 = ((*arg9 / (arg8 as u256)) as u64) / arg6 * arg6;
                        *arg9 = 0;
                        if (v12 == 0 || arg7 > 0 && 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h9aa0e(v12, arg8) < arg7) {
                            v9 = 526;
                        } else {
                            v10 = v12;
                        };
                    };
                };
            };
            if (v9 != 0) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(v9, v5, arg11);
                v10 = 0;
            } else {
                v3 = true;
            };
            0x1::vector::push_back<u64>(&mut v0, v9);
            0x1::vector::push_back<u64>(&mut v1, v6);
            0x1::vector::push_back<u64>(&mut v2, v10);
        };
        H2226f{
            h0ae7c : v0,
            hccaa9 : v1,
            h50183 : v2,
            hfbcb3 : v3,
        }
    }

    public(friend) fun hcc276(arg0: &H2226f, arg1: &mut u64, arg2: u64) : vector<bool> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.h0ae7c)) {
            let v2 = if (h47e0e(arg0, v1)) {
                if (*arg1 > 0) {
                    arg2 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                0x1::vector::push_back<bool>(&mut v0, true);
                *arg1 = *arg1 - 1;
                arg2 = arg2 - 1;
            } else {
                0x1::vector::push_back<bool>(&mut v0, false);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun hde79f(arg0: &vector<u64>, arg1: bool, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: u256, arg9: &0x1::option::Option<u64>, arg10: &0x1::option::Option<u64>, arg11: &0x1::option::Option<u64>, arg12: u64, arg13: &mut u256, arg14: u64) : H2226f {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = false;
        let v3 = 0;
        let v4 = 0x1::option::is_some<u64>(arg11);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(arg0)) {
            let v6 = *0x1::vector::borrow<u64>(arg0, v5);
            v5 = v5 + 1;
            if (v3 != 0) {
                0x1::vector::push_back<u64>(&mut v0, v3);
                0x1::vector::push_back<u64>(&mut v1, 0);
                continue
            };
            let v7 = hae607(v6, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            let v8 = v7;
            if (v7 == 0) {
                let v9 = *0x1::vector::borrow<u64>(arg2, v6);
                if (v4 && h2b96a(arg1, v9, arg11)) {
                    v8 = 535;
                } else {
                    v4 = false;
                    let v10 = h5cc3a(arg1, v9, arg9, arg10);
                    v8 = v10;
                    if (v10 == 515 || v10 == 516) {
                        v3 = v10;
                    };
                };
            };
            let v11 = 0;
            if (v8 == 0) {
                let v12 = *0x1::vector::borrow<u64>(arg3, v6);
                let v13 = 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h9aa0e(v12, arg12);
                if (v13 <= *arg13) {
                    v11 = v12;
                    *arg13 = *arg13 - v13;
                } else {
                    let v14 = ((*arg13 / (arg12 as u256)) as u64) / arg7 * arg7;
                    *arg13 = 0;
                    if (v14 == 0 || arg8 > 0 && 0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h5a57f::h9aa0e(v14, *0x1::vector::borrow<u64>(arg2, v6)) < arg8) {
                        v8 = 526;
                    } else {
                        v11 = v14;
                    };
                };
            };
            if (v8 != 0) {
                0xac3d35dffb9ea9192dd2d577d74a1b0acbb6040e30fbb0f39b77809976ff154d::h1ec67::h67a26(v8, v6, arg14);
                v11 = 0;
            } else {
                v2 = true;
            };
            0x1::vector::push_back<u64>(&mut v0, v8);
            0x1::vector::push_back<u64>(&mut v1, v11);
        };
        H2226f{
            h0ae7c : v0,
            hccaa9 : vector[],
            h50183 : v1,
            hfbcb3 : v2,
        }
    }

    public(friend) fun he1855(arg0: &vector<u64>, arg1: u64) {
        assert!(0x1::vector::length<u64>(arg0) == arg1, 501);
        let v0 = 0;
        while (v0 < arg1) {
            assert!(*0x1::vector::borrow<u64>(arg0, v0) < 10000, 536);
            v0 = v0 + 1;
        };
    }

    public(friend) fun he29eb(arg0: &H2226f, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.hccaa9, arg1)
    }

    public(friend) fun hfbcb3(arg0: &H2226f) : bool {
        arg0.hfbcb3
    }

    // decompiled from Move bytecode v7
}

