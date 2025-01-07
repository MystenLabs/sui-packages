module 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::math {
    public fun div_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * (1000000000 as u128) % v1 == 0) {
            v2 = false;
        };
        (v2, ((v0 * (1000000000 as u128) / v1) as u64))
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    public fun mul_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * v1 % 1000000000 == 0) {
            v2 = false;
        };
        (v2, ((v0 * v1 / 1000000000) as u64))
    }

    // decompiled from Move bytecode v6
}

