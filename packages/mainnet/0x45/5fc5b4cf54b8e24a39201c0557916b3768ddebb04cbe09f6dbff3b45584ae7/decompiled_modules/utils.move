module 0x455fc5b4cf54b8e24a39201c0557916b3768ddebb04cbe09f6dbff3b45584ae7::utils {
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

