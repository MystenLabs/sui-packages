module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_math {
    public fun add_growth(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0, 1);
        arg0 + arg1
    }

    public fun amount(arg0: u256, arg1: u128, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 >> 128) * (arg1 as u256);
        let v1 = (arg0 & 340282366920938463463374607431768211455) * (arg1 as u256) >> 128;
        let v2 = ((18446744073709551615 - arg2) as u256);
        assert!(v0 <= v2, 3);
        assert!(v1 <= v2 - v0, 3);
        ((v0 + v1) as u64)
    }

    public fun fee_delta(arg0: u64, arg1: u128) : u256 {
        assert!(arg1 > 0, 0);
        ((arg0 as u256) << 128) / (arg1 as u256)
    }

    public fun growth_delta(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 <= arg0, 2);
        arg0 - arg1
    }

    public fun reward_delta(arg0: u128, arg1: u128) : u256 {
        assert!(arg1 > 0, 0);
        ((arg0 as u256) << 64) / (arg1 as u256)
    }

    // decompiled from Move bytecode v7
}

