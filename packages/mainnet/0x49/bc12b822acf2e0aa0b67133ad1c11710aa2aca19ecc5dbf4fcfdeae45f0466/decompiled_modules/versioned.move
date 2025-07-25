module 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        if (arg0.version != 1) {
            abort 999
        };
    }

    public(friend) fun check_version_and_upgrade(arg0: &mut Versioned) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
        check_version(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

