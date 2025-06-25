module 0x1483bb3a3b2f51de09f3d962f812b6b308950f224c66219fa41b26ff9b74f447::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0x1483bb3a3b2f51de09f3d962f812b6b308950f224c66219fa41b26ff9b74f447::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x1483bb3a3b2f51de09f3d962f812b6b308950f224c66219fa41b26ff9b74f447::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x1483bb3a3b2f51de09f3d962f812b6b308950f224c66219fa41b26ff9b74f447::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

