module 0x5bc9da8f84c7ea0ae0d1d6be844d8298259e3c27a2aad704ea1dabebb790a53f::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0x5bc9da8f84c7ea0ae0d1d6be844d8298259e3c27a2aad704ea1dabebb790a53f::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x5bc9da8f84c7ea0ae0d1d6be844d8298259e3c27a2aad704ea1dabebb790a53f::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x5bc9da8f84c7ea0ae0d1d6be844d8298259e3c27a2aad704ea1dabebb790a53f::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

