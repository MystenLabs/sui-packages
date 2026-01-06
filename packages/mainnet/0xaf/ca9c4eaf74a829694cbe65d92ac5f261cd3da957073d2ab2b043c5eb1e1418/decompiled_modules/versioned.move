module 0xafca9c4eaf74a829694cbe65d92ac5f261cd3da957073d2ab2b043c5eb1e1418::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        if (arg0.version != 2) {
            abort 999
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &0xafca9c4eaf74a829694cbe65d92ac5f261cd3da957073d2ab2b043c5eb1e1418::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 2, 1000);
        arg1.version = 2;
    }

    // decompiled from Move bytecode v6
}

