module 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::versioned {
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

    public fun upgrade(arg0: &0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

