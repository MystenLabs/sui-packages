module 0xe7a121be15103ee5440bfb667af35008d85a13f302b5ec8508f55b35b69e8b3d::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0xe7a121be15103ee5440bfb667af35008d85a13f302b5ec8508f55b35b69e8b3d::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0xe7a121be15103ee5440bfb667af35008d85a13f302b5ec8508f55b35b69e8b3d::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0xe7a121be15103ee5440bfb667af35008d85a13f302b5ec8508f55b35b69e8b3d::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

