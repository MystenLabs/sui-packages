module 0x6676c6d745b0ef672d44fb07b491087efe3990b3b79dd337dfe89a47ff0f346d::util {
    public fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun muldiv_round_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        let v1 = (arg2 as u128);
        if (v0 % v1 == 0) {
            ((v0 / v1) as u64)
        } else {
            ((v0 / v1 + 1) as u64)
        }
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

