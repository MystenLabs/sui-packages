module 0xc1997c630ec588f8600efb6f983d509dc4c67b5aabc8bfd92e1d8d4bba22ec78::clock_utils {
    public(friend) fun timestamp_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

