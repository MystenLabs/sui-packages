module 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::math {
    public fun decay(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 > 0) {
            if (arg1 >= arg2) {
                arg1 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = (arg0 as u256) * 1000000000000 / (arg3 as u256);
        if (v1 >= 10 * 1000000000000) {
            return arg2
        };
        let v2 = 1000000000000;
        let v3 = 1000000000000;
        let v4 = 1;
        while (v4 <= 12) {
            v2 = v2 * v1 / 256 / 1000000000000 * v4;
            v3 = v3 + v2;
            v4 = v4 + 1;
        };
        let v5 = 1000000000000 * 1000000000000 / v3;
        v4 = 0;
        while (v4 < 8) {
            let v6 = v5 * v5;
            v5 = v6 / 1000000000000;
            v4 = v4 + 1;
        };
        let v7 = ((((arg1 as u256) * v5 + 1000000000000 - 1) / 1000000000000) as u64);
        if (v7 < arg2) {
            arg2
        } else {
            v7
        }
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = ((arg0 as u256) * (arg1 as u256) + (arg2 as u256) - 1) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        (((arg0 as u256) * (arg2 as u256) / ((arg1 as u256) + (arg0 as u256))) as u64)
    }

    public fun sqrt(arg0: u256) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        assert!(arg0 <= 18446744073709551615, 2);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v7
}

