module 0x202243e3fd973ec759466248ed0114af12e5fadee1601f449ffcc5ceb1625c84::math {
    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 1000000;
        if (v0 > 18446744073709551615) {
            abort 1
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

