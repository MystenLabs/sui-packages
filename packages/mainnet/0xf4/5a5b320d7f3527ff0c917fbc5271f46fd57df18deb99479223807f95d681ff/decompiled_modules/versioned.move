module 0xf45a5b320d7f3527ff0c917fbc5271f46fd57df18deb99479223807f95d681ff::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 13906834294602530818);
    }

    public fun get_version(arg0: &Versioned) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0xf45a5b320d7f3527ff0c917fbc5271f46fd57df18deb99479223807f95d681ff::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834324667432964);
        arg0.version = 1;
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

