module 0x28a20aa38cc9a3035c07bbcc11c0cb85bd6ec476ac5a709462d6220d3c55d16d::util {
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

