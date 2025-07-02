module 0x75ff5c395edcae3b2f3dd503b8d611e692dd98bc43c0935d111b7a306f8df419::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0x75ff5c395edcae3b2f3dd503b8d611e692dd98bc43c0935d111b7a306f8df419::errors::err_version_deprecated());
    }

    public fun get_version(arg0: &Versioned) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x75ff5c395edcae3b2f3dd503b8d611e692dd98bc43c0935d111b7a306f8df419::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x75ff5c395edcae3b2f3dd503b8d611e692dd98bc43c0935d111b7a306f8df419::errors::err_invalid_version());
        arg0.version = 1;
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

