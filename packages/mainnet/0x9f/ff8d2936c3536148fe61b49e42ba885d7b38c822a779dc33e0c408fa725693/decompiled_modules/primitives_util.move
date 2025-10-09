module 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

