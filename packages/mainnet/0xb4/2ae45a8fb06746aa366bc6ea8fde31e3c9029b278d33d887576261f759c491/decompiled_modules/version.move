module 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::version {
    struct VersionEvent has copy, drop, store {
        version: vector<u8>,
    }

    public fun emit_version() {
        let v0 = VersionEvent{version: b"1.0.2"};
        0x2::event::emit<VersionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

