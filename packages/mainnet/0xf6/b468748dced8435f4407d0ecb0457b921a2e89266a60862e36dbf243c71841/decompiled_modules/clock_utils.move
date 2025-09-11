module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils {
    public(friend) fun timestamp_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

