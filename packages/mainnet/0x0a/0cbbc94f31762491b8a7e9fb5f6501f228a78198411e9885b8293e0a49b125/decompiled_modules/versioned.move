module 0xa0cbbc94f31762491b8a7e9fb5f6501f228a78198411e9885b8293e0a49b125::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0xa0cbbc94f31762491b8a7e9fb5f6501f228a78198411e9885b8293e0a49b125::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned) {
        assert!(arg0.version < 1, 0xa0cbbc94f31762491b8a7e9fb5f6501f228a78198411e9885b8293e0a49b125::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

