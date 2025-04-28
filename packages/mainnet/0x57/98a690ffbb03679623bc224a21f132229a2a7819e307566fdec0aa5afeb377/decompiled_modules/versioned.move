module 0x3b46851fbebc00db929b0a60b2b81161dbb5c4a485af5f5bd49b4644d996d85b::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0x3b46851fbebc00db929b0a60b2b81161dbb5c4a485af5f5bd49b4644d996d85b::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x3b46851fbebc00db929b0a60b2b81161dbb5c4a485af5f5bd49b4644d996d85b::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x3b46851fbebc00db929b0a60b2b81161dbb5c4a485af5f5bd49b4644d996d85b::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

