module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::math {
    public fun ln(arg0: u64) : (u64, bool) {
        assert!(arg0 > 0, 0);
        assert!(arg0 >= 1000000000, 1);
        if (arg0 == 1000000000) {
            return (0, false)
        };
        let (v0, v1) = normalize(arg0);
        (v1 * 693147181 + ln_series(log_ratio(v0)), false)
    }

    fun ln_series(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v1 <= 13) {
            v0 = v0 + 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::div(arg0, v1 * 1000000000);
            arg0 = 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(arg0, 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(arg0, arg0));
            v1 = v1 + 2;
        };
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::mul(2000000000, v0)
    }

    fun log_ratio(arg0: u64) : u64 {
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::math::div(arg0 - 1000000000, arg0 + 1000000000)
    }

    fun normalize(arg0: u64) : (u64, u64) {
        let v0 = arg0;
        let v1 = 0;
        while (v0 >= 2000000000) {
            v0 = v0 / 2;
            v1 = v1 + 1;
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

