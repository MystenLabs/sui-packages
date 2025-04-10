module 0x272b20a77a33151e2c8686e2fa0abe97ac48a676316a8f4a71cab00ae391aadf::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0x272b20a77a33151e2c8686e2fa0abe97ac48a676316a8f4a71cab00ae391aadf::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x272b20a77a33151e2c8686e2fa0abe97ac48a676316a8f4a71cab00ae391aadf::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x272b20a77a33151e2c8686e2fa0abe97ac48a676316a8f4a71cab00ae391aadf::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

