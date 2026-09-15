module 0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::dividends {
    public fun ragequit_forfeit(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 2;
        let v1 = 0x47d6fef306d19f55114b6264625d1229230e2879cc17583ebc6182a715c02a37::math::mul_div(v0, 6000, 10000);
        (arg0 - v0, v1, v0 - v1)
    }

    public fun weight(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (arg0 as u128) * (0x1::u64::min(arg1 / 86400000, 30) as u128) * (arg2 as u128)
    }

    // decompiled from Move bytecode v7
}

