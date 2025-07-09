module 0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::version {
    struct VersionEvent has copy, drop, store {
        version: vector<u8>,
    }

    public fun emit_version() {
        let v0 = VersionEvent{version: b"1.0.0"};
        0x2::event::emit<VersionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

