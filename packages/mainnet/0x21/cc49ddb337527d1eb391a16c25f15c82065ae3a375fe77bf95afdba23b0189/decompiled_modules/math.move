module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::math {
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

