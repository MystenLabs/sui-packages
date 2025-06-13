module 0xc262818c0beefc9144c84f9e4aaa8a9390c46d5b72cb396787db79c1bd334699::c {
    struct R has copy, drop {
        v: u64,
    }

    public fun c(arg0: &0x2::clock::Clock) {
        let v0 = R{v: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<R>(v0);
    }

    // decompiled from Move bytecode v6
}

