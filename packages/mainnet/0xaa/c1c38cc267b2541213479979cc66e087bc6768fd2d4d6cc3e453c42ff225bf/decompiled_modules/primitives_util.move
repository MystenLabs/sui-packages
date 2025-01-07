module 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::primitives_util {
    public fun timestamp_sec(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

