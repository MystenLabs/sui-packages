module 0x2f3bfde0b46644deb1ba583b60c054965d485482e25ab3465526f6165e145f9b::stableswap {
    fun d_lt(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : bool {
        let (v0, v1) = d_sides(arg0, arg1, arg2, arg3);
        v0 < v1
    }

    fun d_ok(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : bool {
        let (v0, v1) = d_sides(arg0, arg1, arg2, arg3);
        v0 <= v1
    }

    fun d_sides(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : (u256, u256) {
        let v0 = 4 * arg0 * arg1;
        (arg3 * arg3 * arg3 + v0 * (4 * arg2 - 1) * arg3, 4 * arg2 * v0 * (arg0 + arg1))
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg4 < 10000, 5);
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg3 as u256);
        let v3 = (get_d(arg0, arg1, arg3) as u256);
        let v4 = if (d_lt(v0, v1, v2, v3)) {
            v3 + 1
        } else {
            v3
        };
        let v5 = v0 + (arg2 as u256);
        assert!(v5 <= 18446744073709551615, 6);
        if (!d_ok(v5, v1, v2, v4)) {
            0
        } else {
            let v7 = arg1 - get_y((v5 as u64), (v4 as u128), arg3);
            v7 - ((((v7 as u256) * (arg4 as u256) + 9999) / 10000) as u64)
        }
    }

    public fun get_d(arg0: u64, arg1: u64, arg2: u64) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 1);
        assert!(arg2 >= 1 && arg2 <= 1000000, 2);
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = 0;
        let v3 = v0 + v1;
        while (v2 < v3) {
            let v4 = v2 + (v3 - v2 + 1) / 2;
            if (d_ok(v0, v1, (arg2 as u256), v4)) {
                v2 = v4;
                continue
            };
            v3 = v4 - 1;
        };
        (v2 as u128)
    }

    public fun get_y(arg0: u64, arg1: u128, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg2 >= 1 && arg2 <= 1000000, 2);
        let v0 = (arg1 as u256);
        assert!(v0 < 73786976294838206464, 3);
        let v1 = (arg0 as u256);
        let v2 = (arg2 as u256);
        let v3 = 1;
        let v4 = 18446744073709551615;
        let v5 = v4;
        assert!(d_ok(v1, v4, v2, v0), 4);
        while (v3 < v5) {
            v5 = v3 + (v5 - v3) / 2;
            if (d_ok(v1, v5, v2, v0)) {
                continue
            };
            v3 = v5 + 1;
        };
        (v3 as u64)
    }

    // decompiled from Move bytecode v7
}

