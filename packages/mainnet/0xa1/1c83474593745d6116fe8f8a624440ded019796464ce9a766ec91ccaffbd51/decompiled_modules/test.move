module 0xa11c83474593745d6116fe8f8a624440ded019796464ce9a766ec91ccaffbd51::test {
    public fun get_clock(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    // decompiled from Move bytecode v6
}

