module 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math {
    public fun decay(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x1f60d8eb2f2309216d13005e99817a9678942421d012e906e76b63916f2bbcc7::cash::decay(arg0, arg1, arg2, arg3)
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

