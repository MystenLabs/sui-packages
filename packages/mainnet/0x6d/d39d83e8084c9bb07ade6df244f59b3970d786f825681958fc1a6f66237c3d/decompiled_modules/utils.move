module 0x6dd39d83e8084c9bb07ade6df244f59b3970d786f825681958fc1a6f66237c3d::utils {
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
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

