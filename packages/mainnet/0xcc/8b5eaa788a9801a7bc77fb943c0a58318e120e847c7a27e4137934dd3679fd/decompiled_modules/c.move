module 0xcc8b5eaa788a9801a7bc77fb943c0a58318e120e847c7a27e4137934dd3679fd::c {
    struct R has copy, drop {
        v: u64,
    }

    public fun c<T0>(arg0: &0x2::clock::Clock) {
        let v0 = R{v: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<R>(v0);
    }

    // decompiled from Move bytecode v6
}

