module 0x3414b2ba2ee8787d68ddc0f1d4bdf0943c64e8efd971344e02b8e553b71600f4::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        if (arg0.version != 1) {
            abort 999
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &0x3414b2ba2ee8787d68ddc0f1d4bdf0943c64e8efd971344e02b8e553b71600f4::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

