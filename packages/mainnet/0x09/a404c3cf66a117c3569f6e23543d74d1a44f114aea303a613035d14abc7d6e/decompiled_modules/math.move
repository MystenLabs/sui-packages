module 0x9a404c3cf66a117c3569f6e23543d74d1a44f114aea303a613035d14abc7d6e::math {
    public fun bfgdvsd(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        btm36c(v0);
        (v0 as u64)
    }

    public fun btm36c(arg0: u128) {
        assert!(arg0 <= 18446744073709551615, 1);
    }

    public fun dcdc46(arg0: u64, arg1: u64) : u64 {
        dcdsm46(arg0, 1000000000, arg1)
    }

    public fun dcdsm46(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = v0 / (arg2 as u128);
        let v2 = if (v0 - v1 * (arg2 as u128) > 0) {
            v1 + 1
        } else {
            v1
        };
        btm36c(v2);
        (v2 as u64)
    }

    fun dcfcc(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::u128::sqrt((arg2 as u128) * (arg2 as u128) + 4 * ((1000000000 - arg0) as u128) * (arg0 as u128) * (arg1 as u128) / (1000000000 as u128) * (arg1 as u128) / (1000000000 as u128));
        btm36c(v0);
        (v0 as u64)
    }

    public fun dfdffdc(arg0: u64, arg1: u64) : u64 {
        smd64(arg0, 1000000000, arg1)
    }

    public fun dvcdcc(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : u64 {
        assert!(arg0 > 0, 2);
        let v0 = smd64(jiijnn(arg4, arg0), arg0, arg1);
        let v1 = v0;
        let v2 = jiijnn(1000000000 - arg4, arg1);
        let v3 = v2;
        if (arg3) {
            v3 = v2 + arg2;
        } else {
            v1 = v0 + arg2;
        };
        let v4 = if (v3 >= v1) {
            v3 = v3 - v1;
            true
        } else {
            v3 = v1 - v3;
            false
        };
        let v5 = if (v4) {
            v3 + dcfcc(arg4, arg0, v3)
        } else {
            dcfcc(arg4, arg0, v3) - v3
        };
        if (arg3) {
            dfdffdc(v5, bfgdvsd(1000000000 - arg4, 2))
        } else {
            dcdc46(v5, bfgdvsd(1000000000 - arg4, 2))
        }
    }

    public fun dvvdcv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        jiijnn(arg0, 1000000000 + dcdc46((0x1::u128::sqrt(((dcdc46(jiijnn(arg1, arg2) * 4, arg0) as u128) + (1000000000 as u128)) * (1000000000 as u128)) as u64) - 1000000000, bfgdvsd(arg1, 2)))
    }

    public fun jiijnn(arg0: u64, arg1: u64) : u64 {
        smd64(arg0, arg1, 1000000000)
    }

    public fun o7cs(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg0 > 0, 2);
        jiijnn(arg3, 1000000000 - arg4 + jiijnn(arg4, dcdc46(smd64(arg0, arg0, arg1), arg2)))
    }

    public fun smd64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        btm36c(v0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

