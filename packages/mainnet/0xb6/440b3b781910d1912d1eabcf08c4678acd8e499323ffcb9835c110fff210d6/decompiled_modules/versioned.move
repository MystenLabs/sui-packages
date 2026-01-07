module 0xb6440b3b781910d1912d1eabcf08c4678acd8e499323ffcb9835c110fff210d6::versioned {
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

    public fun upgrade(arg0: &0xb6440b3b781910d1912d1eabcf08c4678acd8e499323ffcb9835c110fff210d6::admin_cap::AdminCap, arg1: &mut Versioned) {
        assert!(arg1.version < 2, 1000);
        arg1.version = 2;
    }

    // decompiled from Move bytecode v6
}

