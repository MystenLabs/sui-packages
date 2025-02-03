module 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Upgraded has copy, drop, store {
        previous_version: u64,
        new_version: u64,
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

    fun ugrade_internal(arg0: &mut Versioned) {
        let v0 = Upgraded{
            previous_version : arg0.version,
            new_version      : 1,
        };
        0x2::event::emit<Upgraded>(v0);
        arg0.version = 1;
    }

    public fun upgrade(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 1, 1000);
        ugrade_internal(arg1);
    }

    // decompiled from Move bytecode v6
}

