module 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned {
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

    public fun upgrade(arg0: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

