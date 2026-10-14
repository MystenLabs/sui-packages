module 0x1f60d8eb2f2309216d13005e99817a9678942421d012e906e76b63916f2bbcc7::cash {
    public fun book_cost(arg0: 0x1::option::Option<u64>, arg1: u256, arg2: bool, arg3: u256, arg4: u256, arg5: u64) : (bool, u256) {
        if (0x1::option::is_none<u64>(&arg0) || arg1 == 0) {
            return (false, 0)
        };
        let v0 = (0x1::option::destroy_some<u64>(arg0) as u256);
        let v1 = if (arg2 && v0 > arg1) {
            (v0 - arg1) * 1000000000000000000 / arg1
        } else if (!arg2 && v0 < arg1) {
            (arg1 - v0) * 1000000000000000000 / arg1
        } else {
            0
        };
        if (v1 * (10000 as u256) > (arg5 as u256) * 1000000000000000000) {
            return (false, 0)
        };
        (true, (arg3 + v1) * arg4 / (10000 as u256))
    }

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

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun refill_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = mul_div(arg0, arg1, 10000);
        let v1 = if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        };
        let v2 = mul_div(arg0 - v0, arg3, 10000);
        let v3 = if (arg4 > v2) {
            arg4 - v2
        } else {
            0
        };
        0x1::u64::min(0x1::u64::min(v1, arg5), v3)
    }

    public fun venue_cost(arg0: u64, arg1: &vector<u64>, arg2: u64, arg3: &vector<u256>) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            v0 = v0 + (mul_div(arg0, *0x1::vector::borrow<u64>(arg1, v1), arg2) as u256) * *0x1::vector::borrow<u256>(arg3, v1) / 1000000000000000000;
            v1 = v1 + 1;
        };
        (0x1::u256::min(v0, (arg0 as u256)) as u64)
    }

    // decompiled from Move bytecode v7
}

