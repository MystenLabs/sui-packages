module 0x84028aa46fd78f8f1079deb7fc11a874d5331cd3b676efd82eb597d0534eb10e::utils {
    fun is_valid_time<T0>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg0 + arg1 <= timestamp_sec(arg2)
    }

    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

