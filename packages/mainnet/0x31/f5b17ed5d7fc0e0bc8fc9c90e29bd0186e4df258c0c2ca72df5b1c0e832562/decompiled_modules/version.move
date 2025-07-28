module 0x31f5b17ed5d7fc0e0bc8fc9c90e29bd0186e4df258c0c2ca72df5b1c0e832562::version {
    struct VersionEvent has copy, drop, store {
        version: vector<u8>,
    }

    public fun emit_version() {
        let v0 = VersionEvent{version: b"1.0.0"};
        0x2::event::emit<VersionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

