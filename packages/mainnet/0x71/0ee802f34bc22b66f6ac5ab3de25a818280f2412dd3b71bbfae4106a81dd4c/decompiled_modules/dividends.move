module 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::dividends {
    public fun ragequit_forfeit(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 2;
        let v1 = 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::math::mul_div(v0, 6000, 10000);
        (arg0 - v0, v1, v0 - v1)
    }

    public fun weight(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (arg0 as u128) * (0x1::u64::min(arg1 / 86400000, 30) as u128) * (arg2 as u128)
    }

    // decompiled from Move bytecode v7
}

