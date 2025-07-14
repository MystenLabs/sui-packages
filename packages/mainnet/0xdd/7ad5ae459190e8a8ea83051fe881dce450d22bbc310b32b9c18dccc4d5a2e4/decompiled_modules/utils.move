module 0xdd7ad5ae459190e8a8ea83051fe881dce450d22bbc310b32b9c18dccc4d5a2e4::utils {
    public fun check_is_over(arg0: u64, arg1: &0x2::clock::Clock) : bool {
        arg0 < 0x2::clock::timestamp_ms(arg1)
    }

    public fun check_is_valid(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return true
        };
        arg0 >= 0x2::clock::timestamp_ms(arg2) && arg1 >= arg0
    }

    public fun check_is_within(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return true
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0 <= v0 && v0 < arg1
    }

    public fun clock_object_id() : address {
        @0x6
    }

    public fun current_time(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    // decompiled from Move bytecode v6
}

