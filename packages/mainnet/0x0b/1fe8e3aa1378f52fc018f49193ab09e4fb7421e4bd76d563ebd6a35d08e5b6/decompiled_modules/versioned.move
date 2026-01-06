module 0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::versioned {
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

    public fun upgrade(arg0: &0xb1fe8e3aa1378f52fc018f49193ab09e4fb7421e4bd76d563ebd6a35d08e5b6::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 2, 1000);
        arg1.version = 2;
    }

    // decompiled from Move bytecode v6
}

