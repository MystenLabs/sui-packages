module 0xe2ab9f62ed362bd8fda402c75266bf5e43853b4913b9b0317730f8c4a47d1010::m1 {
    public(friend) fun act_cancel() : u8 {
        2
    }

    public(friend) fun act_keep() : u8 {
        0
    }

    public(friend) fun act_replace() : u8 {
        1
    }

    public(friend) fun ad(arg0: u64, arg1: u64, arg2: u64) : (bool, u64) {
        if (arg0 == 0 || arg1 == 0) {
            return (false, 18446744073709551615)
        };
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            v0 - v1
        };
        let v3 = ((v2 * 10000 / v0) as u64);
        (v3 <= arg2, v3)
    }

    public(friend) fun ed(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        if (arg1 == 0 || arg2 == 0) {
            return (false, 0)
        };
        let v0 = if (arg0) {
            (arg1 as u128) * 10000 / (arg2 as u128)
        } else {
            (arg2 as u128) * 10000 / (arg1 as u128)
        };
        if (v0 <= 10000) {
            return (false, 0)
        };
        let v1 = v0 - 10000;
        let v2 = (arg3 as u128);
        if (v1 <= v2) {
            return (false, 0)
        };
        (true, ((v1 - v2) as u64))
    }

    public(friend) fun kind_backoff() : u8 {
        3
    }

    public(friend) fun kind_none() : u8 {
        0
    }

    public(friend) fun kind_offset() : u8 {
        1
    }

    public(friend) fun kind_touch() : u8 {
        2
    }

    public(friend) fun mkp(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u8) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg6 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else {
            arg4 <= arg3
        };
        if (v0) {
            return (0, 0)
        };
        let (v1, v2) = if (arg0) {
            if (arg4 <= arg6) {
                return (0, 0)
            };
            let v3 = arg3 + arg5 * arg6;
            let v4 = (((arg1 as u128) * 10000 / (10000 + (arg2 as u128))) as u64);
            let v5 = arg4 - arg6;
            let v6 = v3;
            let v7 = 1;
            if (v4 < v3) {
                v6 = v4;
                v7 = 3;
            };
            if (v5 < v6) {
                v6 = v5;
                v7 = 2;
            };
            let v8 = v6 - v6 % arg6;
            let (v9, v10) = if (v8 == 0) {
                (0, 0)
            } else {
                (v8, v7)
            };
            (v10, v9)
        } else {
            let v11 = if (arg4 > arg5 * arg6) {
                arg4 - arg5 * arg6
            } else {
                0
            };
            let v12 = ((((arg1 as u128) * (10000 + (arg2 as u128)) + 10000 - 1) / 10000) as u64);
            let v13 = arg3 + arg6;
            let v14 = v11;
            let v15 = 1;
            if (v11 == 0 || v12 > v11) {
                v14 = v12;
                v15 = 3;
            };
            if (v13 > v14) {
                v14 = v13;
                v15 = 2;
            };
            let v16 = v14 % arg6;
            let v17 = if (v16 == 0) {
                v14
            } else {
                v14 + arg6 - v16
            };
            let (v18, v19) = if (v17 == 0) {
                (0, 0)
            } else {
                (v17, v15)
            };
            (v19, v18)
        };
        (v2, v1)
    }

    public(friend) fun rqd(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : u8 {
        if (!arg0) {
            return if (arg2 == 0) {
                0
            } else {
                1
            }
        };
        if (arg3 && arg1 > arg4 || arg1 < arg4) {
            return if (arg2 == 0) {
                2
            } else {
                1
            }
        };
        if (arg2 == 0) {
            return 2
        };
        if (arg7 <= arg8 || arg7 - arg8 <= arg9) {
            return 1
        };
        let v2 = if (arg2 > arg1) {
            arg2 - arg1
        } else {
            arg1 - arg2
        };
        if (v2 >= arg5 * arg6) {
            1
        } else {
            0
        }
    }

    public(friend) fun tg(arg0: u64, arg1: u8, arg2: u64, arg3: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg1 == 0) {
            return arg0
        };
        let v0 = (arg2 as u128);
        let v1 = if (arg1 == 1) {
            (arg0 as u128) * (1000000000 + v0)
        } else {
            if (v0 >= 1000000000) {
                return 0
            };
            (arg0 as u128) * (1000000000 - v0)
        };
        let v2 = if (arg3) {
            (v1 + 1000000000 - 1) / 1000000000
        } else {
            v1 / 1000000000
        };
        if (v2 > 18446744073709551615) {
            0
        } else {
            (v2 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

