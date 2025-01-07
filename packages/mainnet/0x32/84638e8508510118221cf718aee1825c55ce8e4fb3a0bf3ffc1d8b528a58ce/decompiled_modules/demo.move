module 0x3284638e8508510118221cf718aee1825c55ce8e4fb3a0bf3ffc1d8b528a58ce::demo {
    struct Demo has store, key {
        id: 0x2::object::UID,
    }

    struct DEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DEMO>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : Demo {
        Demo{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

