module 0xda99bccc952ed900ddf73f89a4558ea21b8d254a0253be0152902f472ac6f802::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0xda99bccc952ed900ddf73f89a4558ea21b8d254a0253be0152902f472ac6f802::errors::err_version_deprecated());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0xda99bccc952ed900ddf73f89a4558ea21b8d254a0253be0152902f472ac6f802::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0xda99bccc952ed900ddf73f89a4558ea21b8d254a0253be0152902f472ac6f802::errors::err_invalid_version());
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

