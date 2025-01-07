module 0xe802bf3510876b88317e320af02257799070f04b1fa4407407d4af5ab7a9ec9c::utils {
    public fun day() : u64 {
        86400
    }

    public fun get_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun hour() : u64 {
        3600
    }

    public fun minute() : u64 {
        60
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = u128_mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= (18446744073709551615 as u128), 102);
        (v0 as u64)
    }

    public fun u128_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(arg2 > 0, 101);
        v0 / arg2 * v1 + v0 % arg2 * v1 / arg2
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

